const { execSync } = require("child_process");
const fs = require("fs");

execSync("ctags -R .", { stdio: "inherit" });

// Postprocess tags
let tags = fs.readFileSync("tags", "utf8").split("\n");
tags = tags.map((line) => {
  if (line.match(/^index.js/)) {
    try {
      const folder = line
        .match(/^index.js[ \t ]+(.+)\/index\.js/)[1]
        .split("/")
        .pop();
      return line.replace("index.js", folder);
    } catch {
      console.error("Error processing line");
    }
  }
  return line;
});

fs.writeFileSync("tags", tags.join("\n"), "utf8");
console.log("Tags postprocessed successfully!");
