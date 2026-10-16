#!/bin/sh
set -eu

DUCKDB_VERSION="1.5.6"
DUCKDB_JDBC_VERSION="1.5.6.0"
ONTOP_VERSION="5.5.0"

OS=$(uname -s)
ARCH=$(uname -m)

if [ "$OS" = "Darwin" ]; then
  DUCKDB_PLATFORM="osx-universal"
elif [ "$OS" = "Linux" ]; then
  if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    DUCKDB_PLATFORM="linux-aarch64"
  else
    DUCKDB_PLATFORM="linux-amd64"
  fi
else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo "Detected platform: $OS/$ARCH (duckdb: $DUCKDB_PLATFORM)"

DUCKDB_ZIPFILE_URL="https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-${DUCKDB_PLATFORM}.zip"
DUCKDB_JDBC_JARFILE_URL="https://repo1.maven.org/maven2/org/duckdb/duckdb_jdbc/${DUCKDB_JDBC_VERSION}/duckdb_jdbc-${DUCKDB_JDBC_VERSION}.jar"
ONTOP_ZIPFILE_URL="https://github.com/ontop/ontop/releases/download/ontop-${ONTOP_VERSION}/ontop-cli-${ONTOP_VERSION}.zip"

mkdir -p bin/duckdb
curl -fL $DUCKDB_ZIPFILE_URL -o duckdb_cli.zip
unzip -o duckdb_cli.zip -d bin/duckdb
rm duckdb_cli.zip

rm -rf bin/ontop
mkdir -p bin/ontop
curl -fL $ONTOP_ZIPFILE_URL -o ontop_cli.zip
unzip -o ontop_cli.zip -d bin/ontop
rm ontop_cli.zip

mkdir -p bin/ontop/jdbc
curl -fL $DUCKDB_JDBC_JARFILE_URL -o duckdb_jdbc.jar
mv duckdb_jdbc.jar bin/ontop/jdbc/

echo ""
echo "Done. Binaries installed to bin/duckdb and bin/ontop."
