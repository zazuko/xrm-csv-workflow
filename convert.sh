#!/bin/sh

DUCKDB_BIN="${DUCKDB_BIN:-./bin/duckdb/duckdb}"
ONTOP_BIN="${ONTOP_BIN:-./bin/ontop/ontop}"

export DUCKDB_BIN
export ONTOP_BIN

npm install
npm run db:create
npm run xrm:sources
npm run rdf:create
