const fs = require("fs");
const path = require("path");
const os = require("os");

const output = ({ full_text, color = "#333333" }) => {
  console.log(JSON.stringify({ full_text, color }));
};

const fetchUsage = async () => {
  const credentialsFilePath = path.resolve(
    os.homedir(),
    ".claude/.credentials.json"
  );
  if (!fs.existsSync(credentialsFilePath)) {
    throw new Error("CC no config file");
  }

  const credentials = require(credentialsFilePath);
  const token = credentials.claudeAiOauth.accessToken;

  const response = await fetch("https://api.anthropic.com/api/oauth/usage", {
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error("CC response error");
  }

  try {
    const data = await response.json();
    return data;
  } catch {
    throw new Error("CC parse error");
  }
};

fetchUsage()
  .then((res) => {
    const resetsAt = new Date(res.five_hour.resets_at);
    output({
      full_text: `${res.five_hour.utilization}% 󰑐 ${resetsAt.getHours()}:${resetsAt.getMinutes()}`,
    });
  })
  .catch((e) => {
    output({ full_text: e.message, color: "#FF0000" });
  });
