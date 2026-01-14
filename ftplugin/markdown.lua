-- Buffer-local insert-mode keymaps for LaTeX/Markdown
local opts = { noremap = true, silent = true, buffer = true }

vim.g.mkdp_auto_close = 0

-- Math operators
vim.keymap.set("i", ";to", "\\;\\to\\;", opts)       -- → arrow
vim.keymap.set("i", ";im", "\\;\\implies\\;", opts) -- ⇒ implies
vim.keymap.set("i", ";iff", "\\;\\iff\\;", opts)    -- ⇔ iff
vim.keymap.set("i", ";sum", "\\sum", opts)          -- summation
vim.keymap.set("i", ";int", "\\int", opts)          -- integral
vim.keymap.set("i", ";prod", "\\prod", opts)        -- product
vim.keymap.set("i", ";sqrt", "\\sqrt{}", opts)      -- square root

-- Functions
vim.keymap.set("i", ";log", "\\log", opts)
vim.keymap.set("i", ";ln", "\\ln", opts)
vim.keymap.set("i", ";sin", "\\sin", opts)
vim.keymap.set("i", ";cos", "\\cos", opts)
vim.keymap.set("i", ";tan", "\\tan", opts)
vim.keymap.set("i", ";exp", "e^{x}", opts)

-- Greek letters
vim.keymap.set("i", ";a", "\\alpha", opts)
vim.keymap.set("i", ";b", "\\beta", opts)
vim.keymap.set("i", ";g", "\\gamma", opts)
vim.keymap.set("i", ";d", "\\delta", opts)
vim.keymap.set("i", ";pi", "\\pi", opts)
vim.keymap.set("i", ";th", "\\theta", opts)
vim.keymap.set("i", ";lam", "\\lambda", opts)

-- Formatting
vim.keymap.set("i", ";bf", "\\textbf{}", opts)   -- bold
vim.keymap.set("i", ";it", "\\textit{}", opts)   -- italics
vim.keymap.set("i", ";ul", "\\underline{}", opts) -- underline
vim.keymap.set("i", ";tt", "\\texttt{}", opts)   -- monospace
vim.keymap.set("i", ";q", "\\quad", opts)   -- monospace

-- Arrows
vim.keymap.set("i", ";ra", "&rarr;", opts)
vim.keymap.set("i", ";la", "&larr;", opts)
vim.keymap.set("i", ";ua", "&uarr;", opts)
vim.keymap.set("i", ";da", "&darr;", opts)
vim.keymap.set("i", ";map", "\\mapsto", opts)

-- Sets & logic
vim.keymap.set("i", ";in", "\\in", opts)
vim.keymap.set("i", ";notin", "\\notin", opts)
vim.keymap.set("i", ";subset", "\\subseteq", opts)
vim.keymap.set("i", ";forall", "\\forall", opts)
vim.keymap.set("i", ";exists", "\\exists", opts)
vim.keymap.set("i", ";empty", "\\emptyset", opts)

-- Fractions
vim.keymap.set("i", ";frac", "\\frac{}{}", opts)

-- Math / note-taking symbols
vim.keymap.set("i", ";def", "🟦 Definition:", opts)
vim.keymap.set("i", ";thm", "🟥 Theorem:", opts)
vim.keymap.set("i", ";lem", "🟩 Lemma:", opts)
vim.keymap.set("i", ";cor", "🟨 Corollary:", opts)
vim.keymap.set("i", ";prop", "🟪 Proposition:", opts)

vim.keymap.set("i", ";ex", "📘 Example:", opts)
vim.keymap.set("i", ";prob", "❓ Problem:", opts)
vim.keymap.set("i", ";sol", "📝 Solution:", opts)
vim.keymap.set("i", ";note", "📝 Note:", opts)
vim.keymap.set("i", ";rem", "💡 Remark:", opts)

vim.keymap.set("i", ";pf", "✏️ Proof:", opts)
vim.keymap.set("i", ";ued", "∎", opts) -- end of proof box

-- Logic / math reasoning markers
vim.keymap.set("i", ";warn", "⚠️", opts)
vim.keymap.set("i", ";star", "⭐", opts)
vim.keymap.set("i", ";eye", "👁️", opts)
vim.keymap.set("i", ";check", "✔️ ", opts)
vim.keymap.set("i", ";x", "❌", opts)
vim.keymap.set("i", ";hammer", "🛠️", opts)
vim.keymap.set("i", ";crown", "👑", opts)
vim.keymap.set("i", ";doric", "🏛️", opts)
vim.keymap.set("i", ";target", "🎯", opts)
vim.keymap.set("i", ";hat", "🎓", opts)
vim.keymap.set("i", ";tophat", "🎩", opts)
vim.keymap.set("i", ";phoenix", "🐦‍🔥", opts)

-- Color Squares
vim.keymap.set("i", ";bluesqr", "🟦", opts)
vim.keymap.set("i", ";redsqr", "🟥", opts)
vim.keymap.set("i", ";greensqr", "🟩", opts)
vim.keymap.set("i", ";orangesqr", "🟨", opts)
vim.keymap.set("i", ";purplesqr", "🟪", opts)

-- Progress markers
vim.keymap.set("i", ";todo", "☐ To do", opts)
vim.keymap.set("i", ";done", "✅ Done", opts)
vim.keymap.set("i", ";prog", "🔄 In progress", opts)

-- Logic
vim.keymap.set("i", ";tf", "∴", opts)   -- therefore
vim.keymap.set("i", ";bc", "∵", opts)   -- because
vim.keymap.set("i", ";im", "⇒", opts)   -- implies
vim.keymap.set("i", ";iff", "⇔", opts)  -- iff
vim.keymap.set("i", ";not", "¬", opts)

-- Sets
vim.keymap.set("i", ";in", "∈", opts)
vim.keymap.set("i", ";nin", "∉", opts)
vim.keymap.set("i", ";sub", "⊂", opts)
vim.keymap.set("i", ";sbe", "⊆", opts)
vim.keymap.set("i", ";emp", "∅", opts)

-- Quantifiers
vim.keymap.set("i", ";fa", "∀", opts)
vim.keymap.set("i", ";ex", "∃", opts)

-- Operators
vim.keymap.set("i", ";sum", "∑", opts)
vim.keymap.set("i", ";prod", "∏", opts)
vim.keymap.set("i", ";int", "∫", opts)
vim.keymap.set("i", ";inf", "∞", opts)
vim.keymap.set("i", ";del", "∆", opts)
vim.keymap.set("i", ";nab", "∇", opts)

-- Backgrounds
vim.keymap.set("i", ";greybg", function()
  return [[
<div style="background: #1f1f1f; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";cyanbg", function()
  return [[
<div style="background: #013642; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";bluebg", function()
  return [[
<div style="background: #000240; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";purplebg", function()
  return [[
<div style="background: #260040; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";pinkbg", function()
  return [[
<div style="background: #40003d; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";redbg", function()
  return [[
<div style="background: #400000; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";orangebg", function()
  return [[
<div style="background: #402400; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";yellowbg", function()
  return [[
<div style="background: #404000; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";greenbg", function()
  return [[
<div style="background: #064000; padding: 0px; border-radius: 6px;">

</div>
]]
end, { noremap = true, expr = true })

-- Layouts
vim.keymap.set("i", ";row2", function()
  return [[
<div style="display: flex; justify-content: space-between;">
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";row3", function()
  return [[
<div style="display: flex; justify-content: space-between;">
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
</div>
]]
end, { noremap = true, expr = true })
vim.keymap.set("i", ";row4", function()
  return [[
<div style="display: flex; justify-content: space-between;"><F12>
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
<div style="flex: 1; text-align: left; padding: 10px;">

</div>
</div>
]]
end, { noremap = true, expr = true })

-- Image
vim.keymap.set("i", ";img", function()
  return [[
<img src="./images/" style="">
]]
end, { noremap = true, expr = true })



