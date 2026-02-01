// Generates PNG previews for ALL react-icons.
// Usage: node build-all-previews.mjs <pkg-dir> <preview-dir>

import { readdirSync, statSync, readFileSync, existsSync, writeFileSync, mkdirSync } from "fs";
import { join } from "path";
import { execSync } from "child_process";

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

const pkgDir = process.argv[2];
const previewDir = process.argv[3];
const base = join(pkgDir, "node_modules/react-icons");

mkdirSync(previewDir, { recursive: true });

const sets = readdirSync(base).filter((d) => {
  const p = join(base, d);
  return statSync(p).isDirectory() && d !== "lib" && d !== "node_modules";
});

// Count total icons first for progress percentage
let totalIcons = 0;
for (const set of sets) {
  const file = join(base, set, "index.mjs");
  if (!existsSync(file)) continue;
  const src = readFileSync(file, "utf8");
  const matches = src.match(/export function \w+/g);
  if (matches) totalIcons += matches.length;
}

let processed = 0;
let generated = 0;
let skipped = 0;

for (const set of sets) {
  const file = join(base, set, "index.mjs");
  if (!existsSync(file)) continue;
  const src = readFileSync(file, "utf8");

  const re = /export function (\w+)\s*\(props\)\s*\{\s*return GenIcon\((\{.*?\})\)\(props\)/gs;
  let m;
  while ((m = re.exec(src))) {
    const name = m[1];
    const pngPath = join(previewDir, `${name}.png`);
    processed++;

    if (existsSync(pngPath)) {
      skipped++;
    } else {
      try {
        const tree = JSON.parse(m[2]);
        const svg = treeToSvg(tree);
        const svgPath = join(previewDir, `${name}.svg`);

        const hasStrokeWidth = /stroke-width/.test(svg);
        const styledSvg = svg
          .replace(/stroke="currentColor"/g, 'stroke="white"')
          .replace(/fill="currentColor"/g, 'fill="white"')
          .replace(/<svg /, `<svg color="white" fill="white" ${hasStrokeWidth ? 'stroke="white" ' : ''}`);

        writeFileSync(svgPath, styledSvg);
        execSync(`rsvg-convert -w 64 -h 64 "${svgPath}" -o "${pngPath}"`, { stdio: "ignore" });
        generated++;
      } catch {}
    }

    const pct = Math.floor((processed / totalIcons) * 100);
    const barWidth = 30;
    const filled = Math.round((processed / totalIcons) * barWidth);
    const bar = "█".repeat(filled) + "░".repeat(barWidth - filled);
    process.stdout.write(`\r${bar} ${pct}% (${processed}/${totalIcons}) icon set: ${set}   `);
  }
}

console.log(`\nDone! Generated ${generated} new previews, ${skipped} already cached.`);
