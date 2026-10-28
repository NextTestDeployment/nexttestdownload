#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v java >/dev/null 2>&1; then
    echo "[ERROR] Java 17+ is required but was not found in PATH." >&2
    exit 1
fi

VERSION="1.0.0"
if [ -f "${SCRIPT_DIR}/version.v" ]; then
    VERSION="$(tr -d '[:space:]' < "${SCRIPT_DIR}/version.v")"
fi

TARGET_JAR="${SCRIPT_DIR}/nexttest-desktop-v${VERSION}.jar"
ALIAS_JAR="${SCRIPT_DIR}/nexttest-desktop.jar"

if [ -f "$TARGET_JAR" ]; then
    EXEC_JAR="$TARGET_JAR"
elif [ -f "$ALIAS_JAR" ]; then
    EXEC_JAR="$ALIAS_JAR"
else
    echo "[INFO] First run: Assembling nexttest-desktop-v${VERSION}.jar from 30MB chunks..."
    CHUNKS_DIR="${SCRIPT_DIR}/chunks"
    if [ ! -d "$CHUNKS_DIR" ]; then
        CHUNKS_DIR="${SCRIPT_DIR}/bin/chunks"
    fi
    cat "${CHUNKS_DIR}"/nexttest-desktop-v${VERSION}.part* > "$TARGET_JAR"
    cp -f "$TARGET_JAR" "$ALIAS_JAR" 2>/dev/null || true
    echo "[INFO] Assembly complete. Subsequent runs will use the merged JAR directly."
    EXEC_JAR="$TARGET_JAR"
fi

if [ $# -eq 0 ]; then
    java -jar "$EXEC_JAR" &
else
    java -jar "$EXEC_JAR" "$@"
fi
