// Converts a react-icon name to an SVG string.
// Usage: node to-svg.mjs <IconName> <pkg-dir>

import { readdirSync, statSync, readFileSync, existsSync } from "fs";
import { join } from "path";

const SVG_ATTR_MAP = {
  viewBox: "viewBox",
  fillRule: "fill-rule",
  clipRule: "clip-rule",
  strokeWidth: "stroke-width",
  strokeLinecap: "stroke-linecap",
  strokeLinejoin: "stroke-linejoin",
  strokeMiterlimit: "stroke-miterlimit",
  strokeDasharray: "stroke-dasharray",
  strokeDashoffset: "stroke-dashoffset",
  fillOpacity: "fill-opacity",
  strokeOpacity: "stroke-opacity",
  xlinkHref: "xlink:href",
  xmlSpace: "xml:space",
  baseFrequency: "baseFrequency",
  stdDeviation: "stdDeviation",
};

function svgAttr(s) {
  return SVG_ATTR_MAP[s] ?? s;
}

function treeToSvg(node) {
  const attrs = Object.entries(node.attr || {})
    .map(([k, v]) => `${svgAttr(k)}="${v}"`)
    .join(" ");
  const children = (node.child || []).map(treeToSvg).join("");
  if (node.tag === "svg") {
    return `<svg xmlns="http://www.w3.org/2000/svg" ${attrs}>${children}</svg>`;
  }
  return `<${node.tag} ${attrs}>${children}</${node.tag}>`;
}

const name = process.argv[2];
const pkgDir = process.argv[3];
const base = join(pkgDir, "node_modules/react-icons");

const sets = readdirSync(base).filter((d) => {
  const p = join(base, d);
  return statSync(p).isDirectory() && d !== "lib" && d !== "node_modules";
});

for (const set of sets) {
  const file = join(base, set, "index.mjs");
  if (!existsSync(file)) continue;
  const src = readFileSync(file, "utf8");

  const re = new RegExp(
    `export function ${name}\\s*\\(props\\)\\s*\\{\\s*return GenIcon\\((\\{.*?\\})\\)\\(props\\)`,
    "s",
  );
  const m = src.match(re);
  if (m) {
    const tree = JSON.parse(m[1]);
    console.log(treeToSvg(tree));
    process.exit(0);
  }
}

process.exit(1);
