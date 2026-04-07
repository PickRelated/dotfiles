const { execSync } = require("child_process");
const fs = require("fs");

try {
  execSync("/opt/homebrew/bin/ctags -R .", { stdio: "inherit" });
} catch {
  execSync("ctags -R .", { stdio: "inherit" });
}

// Postprocess tags
let tags = fs.readFileSync("tags", "utf8").split("\n");
tags = tags.map((line) => {
  if (line.match(/^[^\.]+.js/)) {
    try {
      const folder = line
        .replace(/[^\t]+\t([^\t]+)\t.*/, '$1')
        .split("/")
        .slice(-2)[0]
      return line.replace("index", folder).replace('.js', '');
    } catch {
      console.error("Error processing line");
    }
  }
  return line;
});

fs.writeFileSync("tags", tags.join("\n"), "utf8");
console.log("Tags postprocessed successfully!");
