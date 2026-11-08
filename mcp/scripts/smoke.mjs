#!/usr/bin/env node
// Smoke test: starts the built server (dist/index.js) over stdio, lists the
// tools, then calls every tool once with valid arguments and checks the
// answer. Run with `npm run build && npm run smoke`.
import { spawn } from "node:child_process";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const server = spawn("node", [join(root, "dist", "index.js")], {
    stdio: ["pipe", "pipe", "inherit"],
});

let buffer = "";
const pending = new Map();
server.stdout.on("data", (chunk) => {
    buffer += chunk;
    let nl;
    while ((nl = buffer.indexOf("\n")) >= 0) {
        const line = buffer.slice(0, nl).trim();
        buffer = buffer.slice(nl + 1);
        if (!line) continue;
        const msg = JSON.parse(line);
        if (msg.id !== undefined && pending.has(msg.id)) {
            pending.get(msg.id)(msg);
            pending.delete(msg.id);
        }
    }
});

let nextId = 1;
const send = (method, params) =>
    new Promise((resolve, reject) => {
        const id = nextId++;
        const timer = setTimeout(() => reject(new Error(`timeout waiting for ${method}`)), 10000);
        pending.set(id, (msg) => {
            clearTimeout(timer);
            resolve(msg);
        });
        server.stdin.write(JSON.stringify({ jsonrpc: "2.0", id, method, params }) + "\n");
    });

const failures = [];
const check = (label, ok, detail = "") => {
    if (!ok) failures.push(`${label}${detail ? `: ${detail}` : ""}`);
    console.log(`${ok ? "ok  " : "FAIL"} ${label}`);
};

const call = async (name, args) => {
    const res = await send("tools/call", { name, arguments: args });
    const text = res.result?.content?.[0]?.text ?? "";
    return { text, isError: Boolean(res.error || res.result?.isError) };
};

try {
    await send("initialize", {
        protocolVersion: "2024-11-05",
        capabilities: {},
        clientInfo: { name: "smoke", version: "1" },
    });
    server.stdin.write(JSON.stringify({ jsonrpc: "2.0", method: "notifications/initialized" }) + "\n");

    const list = await send("tools/list", {});
    const names = (list.result?.tools ?? []).map((t) => t.name).sort();
    const expected = [
        "generateCode",
        "getBrandConfig",
        "getComponent",
        "getPattern",
        "getTokens",
        "listComponents",
        "listPatterns",
        "searchComponent",
    ];
    check("tools/list exposes the 8 documented tools", JSON.stringify(names) === JSON.stringify(expected), names.join(","));

    let r = await call("getComponent", { name: "CKButton" });
    check("getComponent CKButton", !r.isError && r.text.includes("CKButton") && !r.text.includes("not found"));

    r = await call("getTokens", { tokenType: "spacing" });
    check("getTokens spacing", !r.isError && r.text.includes("xxs") && !r.text.includes("not found"));

    r = await call("getTokens", { tokenType: "designSpec" });
    check(
        "getTokens designSpec maps design values to code tokens",
        !r.isError && r.text.includes("codeToken") && r.text.includes("x2l") && !r.text.includes("not found"),
    );
    r = await call("getTokens", { tokenType: "nope" });
    check("getTokens unknown type lists the available types", r.text.includes("not found") && r.text.includes("designSpec"));

    r = await call("searchComponent", { keyword: "button" });
    check("searchComponent button", !r.isError && r.text.includes("CKButton"));

    r = await call("generateCode", { componentName: "CKButton" });
    check(
        "generateCode CKButton imports package:ckcoreui",
        !r.isError && r.text.includes("package:ckcoreui/") && !r.text.includes("ckgoc_core"),
        r.text.split("\n")[0],
    );

    for (const brand of ["castleKeep", "skyGo", "castlekeep", "SKYGO"]) {
        r = await call("getBrandConfig", { brandName: brand });
        check(`getBrandConfig ${brand}`, !r.isError && !r.text.includes("not found"), r.text.slice(0, 80));
    }
    r = await call("getBrandConfig", { brandName: "nope" });
    check("getBrandConfig unknown brand reports not found", r.text.includes("not found"));

    r = await call("getPattern", { patternName: "setupApp" });
    check("getPattern setupApp", !r.isError && !r.text.includes("not found"));

    r = await call("listComponents", {});
    let components = [];
    try {
        components = JSON.parse(r.text);
    } catch {}
    check("listComponents returns a non-empty list", Array.isArray(components) && components.length > 0);

    r = await call("listPatterns", {});
    check("listPatterns includes setupApp", !r.isError && r.text.includes("setupApp"));
} catch (e) {
    failures.push(String(e));
} finally {
    server.kill();
}

if (failures.length) {
    console.error(`\n${failures.length} check(s) failed:\n- ${failures.join("\n- ")}`);
    process.exit(1);
}
console.log("\nAll MCP smoke checks passed.");
