#!/bin/sh

DUCKDB_VERSION="1.4.4"
DUCKDB_JDBC_VERSION="1.4.4.0"
ONTOP_VERSION="5.5.0"

DUCKDB_ZIPFILE_URL="https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip"
DUCKDB_JDBC_JARFILE_URL="https://repo1.maven.org/maven2/org/duckdb/duckdb_jdbc/${DUCKDB_JDBC_VERSION}/duckdb_jdbc-${DUCKDB_JDBC_VERSION}.jar"

ONTOP_ZIPFILE_URL="https://github.com/ontop/ontop/releases/download/ontop-${ONTOP_VERSION}/ontop-cli-${ONTOP_VERSION}.zip"

mkdir -p bin/duckdb
curl -L $DUCKDB_ZIPFILE_URL -o duckdb_cli.zip
unzip duckdb_cli.zip -d bin/duckdb
rm duckdb_cli.zip

mkdir -p bin/ontop
curl -L $ONTOP_ZIPFILE_URL -o ontop_cli.zip
unzip ontop_cli.zip -d bin/ontop
rm ontop_cli.zip

mkdir -p bin/ontop/jdbc
curl -L $DUCKDB_JDBC_JARFILE_URL -o duckdb_jdbc.jar
mv duckdb_jdbc.jar bin/ontop/jdbc/
