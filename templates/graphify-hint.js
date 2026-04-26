#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const graphReport = path.join(process.cwd(), 'graphify-out', 'GRAPH_REPORT.md');

if (fs.existsSync(graphReport)) {
    process.stderr.write(
        'graphify: Knowledge graph exists. Read graphify-out/GRAPH_REPORT.md for god nodes and community structure before searching raw files.\n'
    );
}
// No graph → silent passthrough
