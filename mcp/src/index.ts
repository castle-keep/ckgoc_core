#!/usr/bin/env node

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
    CallToolRequestSchema,
    ErrorCode,
    ListToolsRequestSchema,
    TextContent,
    Tool,
} from "@modelcontextprotocol/sdk/types.js";

import { fileURLToPath } from "url";
import { dirname, join } from "path";
import { readFileSync } from "fs";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load knowledge bases
const loadKnowledge = () => {
    const componentsPath = join(__dirname, "knowledge", "components.json");
    const tokensPath = join(__dirname, "knowledge", "tokens.json");
    const patternsPath = join(__dirname, "knowledge", "patterns.json");
    const brandsPath = join(__dirname, "knowledge", "brands.json");

    return {
        components: JSON.parse(readFileSync(componentsPath, "utf8")),
        tokens: JSON.parse(readFileSync(tokensPath, "utf8")),
        patterns: JSON.parse(readFileSync(patternsPath, "utf8")),
        brands: JSON.parse(readFileSync(brandsPath, "utf8")),
    };
};

const knowledge = loadKnowledge();

// Tool implementations
const tools = {
    getComponent: (name: string): string => {
        const component = knowledge.components.components[name as keyof typeof knowledge.components.components];
        if (!component) {
            return `Component "${name}" not found. Available components: ${Object.keys(knowledge.components.components).join(", ")}`;
        }
        return JSON.stringify(component, null, 2);
    },

    getTokens: (tokenType: string): string => {
        const typeKey = tokenType.toLowerCase() as keyof typeof knowledge.tokens;
        if (!knowledge.tokens[typeKey]) {
            return `Token type "${tokenType}" not found. Available types: colors, spacing, typography, radius, elevation, shadows, motion, opacity, breakpoints`;
        }
        return JSON.stringify(knowledge.tokens[typeKey], null, 2);
    },

    searchComponent: (keyword: string): string => {
        const query = keyword.toLowerCase();
        const results = Object.entries(knowledge.components.components)
            .filter(([name, comp]: [string, any]) => {
                return (
                    name.toLowerCase().includes(query) ||
                    comp.description?.toLowerCase().includes(query) ||
                    comp.category?.toLowerCase().includes(query)
                );
            })
            .map(([name, comp]: [string, any]) => ({
                name,
                category: comp.category,
                description: comp.description,
            }));

        if (results.length === 0) {
            return `No components found matching "${keyword}"`;
        }

        return JSON.stringify(results, null, 2);
    },

    generateCode: (componentName: string, variant?: string, props?: Record<string, string>): string => {
        const component = knowledge.components.components[componentName as keyof typeof knowledge.components.components];
        if (!component) {
            return `Component "${componentName}" not found`;
        }

        let code = component.import || `import 'package:ckgoc_core/ckcore_core.dart';`;
        code += "\n\n";

        if (variant && component.variants && component.variants[variant]) {
            code += component.variants[variant].usage || component.basicUsage;
        } else if (component.basicUsage) {
            code += component.basicUsage;
        } else if (component.examples && component.examples.length > 0) {
            code += component.examples[0];
        }

        return code;
    },

    getBrandConfig: (brandName: string): string => {
        const brand = knowledge.brands.brands[brandName.toLowerCase() as keyof typeof knowledge.brands.brands];
        if (!brand) {
            return `Brand "${brandName}" not found. Available brands: castleKeep, skyGo`;
        }
        return JSON.stringify(brand, null, 2);
    },

    getPattern: (patternName: string): string => {
        const pattern = knowledge.patterns.patterns[patternName as keyof typeof knowledge.patterns.patterns];
        if (!pattern) {
            return `Pattern "${patternName}" not found. Available patterns: ${Object.keys(knowledge.patterns.patterns).join(", ")}`;
        }
        return JSON.stringify(pattern, null, 2);
    },

    listComponents: (): string => {
        const components = Object.entries(knowledge.components.components).map(([name, comp]: [string, any]) => ({
            name,
            category: comp.category,
            description: comp.description,
        }));
        return JSON.stringify(components, null, 2);
    },

    listPatterns: (): string => {
        const patterns = Object.keys(knowledge.patterns.patterns);
        return JSON.stringify(patterns, null, 2);
    },
};

// MCP Server setup
const server = new Server(
    { name: "ckcore-ui-mcp", version: "0.1.0" },
    { capabilities: { tools: {} } },
);

server.setRequestHandler(ListToolsRequestSchema, async () => ({
    tools: [
        {
            name: "getComponent",
            description:
                "Get detailed information about a ckcore/ui component including props, variants, and usage examples",
            inputSchema: {
                type: "object" as const,
                properties: {
                    name: {
                        type: "string",
                        description: "Component name (e.g., CKButton, CKTextField, CKDataTable)",
                    },
                },
                required: ["name"],
            },
        },
        {
            name: "getTokens",
            description: "Get design tokens by type (colors, spacing, typography, radius, elevation, shadows, motion, opacity, breakpoints)",
            inputSchema: {
                type: "object" as const,
                properties: {
                    tokenType: {
                        type: "string",
                        description: "Type of tokens to retrieve: colors, spacing, typography, radius, elevation, shadows, motion, opacity, or breakpoints",
                    },
                },
                required: ["tokenType"],
            },
        },
        {
            name: "searchComponent",
            description: "Search for components by name, description, or category",
            inputSchema: {
                type: "object" as const,
                properties: {
                    keyword: {
                        type: "string",
                        description: "Search keyword (e.g., 'button', 'input', 'table')",
                    },
                },
                required: ["keyword"],
            },
        },
        {
            name: "generateCode",
            description: "Generate Dart code snippet for a component",
            inputSchema: {
                type: "object" as const,
                properties: {
                    componentName: {
                        type: "string",
                        description: "Component name (e.g., CKButton)",
                    },
                    variant: {
                        type: "string",
                        description: "Optional variant (e.g., primary, secondary, destructive)",
                    },
                    props: {
                        type: "object",
                        description: "Optional properties to customize the generated code",
                        additionalProperties: { type: "string" },
                    },
                },
                required: ["componentName"],
            },
        },
        {
            name: "getBrandConfig",
            description: "Get brand configuration, colors, and setup instructions",
            inputSchema: {
                type: "object" as const,
                properties: {
                    brandName: {
                        type: "string",
                        description: "Brand name: castleKeep or skyGo",
                    },
                },
                required: ["brandName"],
            },
        },
        {
            name: "getPattern",
            description: "Get common patterns and best practices for using ckcore/ui",
            inputSchema: {
                type: "object" as const,
                properties: {
                    patternName: {
                        type: "string",
                        description: "Pattern name (e.g., setupApp, form, dataTable, theming, responsiveLayout)",
                    },
                },
                required: ["patternName"],
            },
        },
        {
            name: "listComponents",
            description: "List all available components in ckcore/ui",
            inputSchema: {
                type: "object" as const,
                properties: {},
                required: [],
            },
        },
        {
            name: "listPatterns",
            description: "List all available patterns and best practices",
            inputSchema: {
                type: "object" as const,
                properties: {},
                required: [],
            },
        },
    ] as Tool[],
}));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
    const toolName = request.params.name;
    const args = request.params.arguments as Record<string, any>;

    let result: string;

    try {
        switch (toolName) {
            case "getComponent":
                result = tools.getComponent(args.name);
                break;
            case "getTokens":
                result = tools.getTokens(args.tokenType);
                break;
            case "searchComponent":
                result = tools.searchComponent(args.keyword);
                break;
            case "generateCode":
                result = tools.generateCode(args.componentName, args.variant, args.props as Record<string, string>);
                break;
            case "getBrandConfig":
                result = tools.getBrandConfig(args.brandName);
                break;
            case "getPattern":
                result = tools.getPattern(args.patternName);
                break;
            case "listComponents":
                result = tools.listComponents();
                break;
            case "listPatterns":
                result = tools.listPatterns();
                break;
            default:
                return {
                    content: [
                        {
                            type: "text",
                            text: `Unknown tool: ${toolName}`,
                        },
                    ],
                    isError: true,
                };
        }

        return {
            content: [
                {
                    type: "text",
                    text: result,
                } as TextContent,
            ],
        };
    } catch (error) {
        return {
            content: [
                {
                    type: "text",
                    text: `Error executing tool ${toolName}: ${error instanceof Error ? error.message : String(error)}`,
                } as TextContent,
            ],
            isError: true,
        };
    }
});

// Start server
const transport = new StdioServerTransport();
await server.connect(transport);

console.error("ckcore-ui MCP server running on stdio");
