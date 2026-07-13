# CkgocDataTable — Component Guide & Migration Plan

## Overview

`CkgocDataTable` is a fully-themed, stateless data table for the Company design system. It renders UI and emits callbacks only — it never owns repositories, makes network calls, or mutates data.

---

## Quick Start

```dart
CkgocDataTable(
  columns: [
    const CkgocTableColumn(key: 'name', label: 'Name',
        type: CkgocColumnType.avatarText, flex: 2, sortable: true),
    const CkgocTableColumn(key: 'email', label: 'Email', flex: 2),
    CkgocTableColumn(
      key: 'role', label: 'Role', width: 120,
      type: CkgocColumnType.badge,
      badgeVariantBuilder: (v) => v == 'Admin'
          ? BadgeVariant.primary : BadgeVariant.outline,
    ),
  ],
  rows: _rows,        // List<Map<String, dynamic>>
  rowKey: 'id',
  title: 'Users',
  subtitle: '${_total} records',
  totalCount: _total,
  currentPage: _page,
  pageSize: 20,
  onPageChanged: (p) => setState(() => _page = p),
  selectionMode: TableSelectionMode.multiple,
  selectedKeys: _selected,
  onSelectionChanged: (s) => setState(() => _selected = s),
  sortColumnKey: _sortKey,
  sortAscending: _sortAsc,
  onSortChanged: (k, asc) => setState(() { _sortKey = k; _sortAsc = asc; }),
  searchQuery: _search,
  searchHint: 'Search users…',
  onSearchChanged: (v) => setState(() { _search = v; _page = 1; }),
)
```
