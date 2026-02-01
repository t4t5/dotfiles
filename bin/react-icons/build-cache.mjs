// Extracts all icon names from the installed react-icons package.
// Usage: node build-cache.mjs <pkg-dir>

import { readdirSync, statSync, readFileSync, existsSync } from "fs";
import { join } from "path";

const pkgDir = process.argv[2];
const base = join(pkgDir, "node_modules/react-icons");

const sets = readdirSync(base).filter((d) => {
  const p = join(base, d);
  return statSync(p).isDirectory() && d !== "lib" && d !== "node_modules";
});

for (const set of sets) {
  const file = join(base, set, "index.mjs");
  if (!existsSync(file)) continue;
  const src = readFileSync(file, "utf8");
  const re = /export function (\w+)/g;
  let m;
  while ((m = re.exec(src))) {
    console.log(m[1]);
  }
}
