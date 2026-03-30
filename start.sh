#!/bin/sh
set -eu

mkdir -p /data/plugins /data/trash /data/dbs
chmod 0777 /data/plugins /data/trash /data/dbs

# Render runtime config from template and fail fast if required secrets are missing.
python3 - <<'PY'
import os
import re
import sys

template_path = "/data/config.yaml.template"
output_path = "/data/config.yaml"

with open(template_path, "r", encoding="utf-8") as f:
    template = f.read()

missing = []

def replace_env(match):
    key = match.group(1)
    value = os.environ.get(key)
    if value is None or value == "":
        missing.append(key)
        return match.group(0)
    return value

rendered = re.sub(r"\$\{([A-Za-z_][A-Za-z0-9_]*)\}", replace_env, template)

if missing:
    keys = ", ".join(sorted(set(missing)))
    print(f"Missing required environment variables: {keys}", file=sys.stderr)
    sys.exit(1)

with open(output_path, "w", encoding="utf-8") as f:
    f.write(rendered)
PY

exec /opt/maubot/docker/run.sh
