const fs = require('fs')
const path = require('path')
const os = require('os')

const output = ({ full_text, color = '#333333' }) => {
  console.log(JSON.stringify({ full_text, color }))
}

const TODAY = new Date().toISOString().slice(0, 10) // "YYYY-MM-DD"

const projectsDir = path.join(os.homedir(), '.claude', 'projects')

const totals = {
  input_tokens: 0,
  output_tokens: 0,
  cache_creation_input_tokens: 0,
  cache_read_input_tokens: 0,
}

// Get prices here https://raw.githubusercontent.com/BerriAI/litellm/main/model_prices_and_context_window.json

// Deduplicate by message uuid so the same assistant turn isn't counted twice
// even if it appears in multiple files or the file is scanned multiple times.
const seen = new Set()

for (const project of fs.readdirSync(projectsDir)) {
  const projectPath = path.join(projectsDir, project)
  if (!fs.statSync(projectPath).isDirectory()) continue

  for (const file of fs.readdirSync(projectPath)) {
    if (!file.endsWith('.jsonl')) continue

    const filePath = path.join(projectPath, file)
    const lines = fs.readFileSync(filePath, 'utf8').split('\n')

    for (const line of lines) {
      if (!line.trim()) continue

      let entry
      try {
        entry = JSON.parse(line)
      } catch {
        continue
      }

      if (entry.type !== 'assistant') continue
      if (!entry.timestamp?.startsWith(TODAY)) continue

      const uuid = entry.uuid
      if (!uuid || seen.has(uuid)) continue
      seen.add(uuid)

      // Top-level usage is already the sum of iterations — don't also add iterations.
      const u = entry.message?.usage
      if (!u) continue

      totals.input_tokens += u.input_tokens ?? 0
      totals.output_tokens += u.output_tokens ?? 0
      totals.cache_creation_input_tokens += u.cache_creation_input_tokens ?? 0
      totals.cache_read_input_tokens += u.cache_read_input_tokens ?? 0
    }
  }
}

// Input: $3.00 / 1M tokens
// Output: $15.00 / 1M tokens
// Cache creation: $3.75 / 1M tokens (1.25x input price)
// Cache read: $0.30 / 1M tokens (10% of input price)

const grandTotal =
  totals.input_tokens +
  totals.output_tokens +
  totals.cache_creation_input_tokens +
  totals.cache_read_input_tokens

const grandTotalTokens = (grandTotal / 1_000_000).toFixed(1)

const grandTotalUSD = (
  (totals.input_tokens / 1_000_000) * 3 +
  (totals.output_tokens / 1_000_000) * 15 +
  (totals.cache_creation_input_tokens / 1_000_000) * 3.75 +
  (totals.cache_read_input_tokens / 1_000_000) * 0.3
).toFixed(2)

if (grandTotalTokens) {
  output({ full_text: `${grandTotalTokens}M/${grandTotalUSD}$` })
}
