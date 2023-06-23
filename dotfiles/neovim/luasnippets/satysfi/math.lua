-- [[
-- snippet for greek alphabet and common math-commands
--
-- all snippets have prefix `;`
-- note:
--  `@` doesn't work well with satysfi-language-server
--
-- all snippets work only in math (not in inline_text)
-- ]]

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
local conds_expand = require("luasnip.extras.conditions.expand")

local util = require'nvim-treesitter.ts_utils'
function isinmath(_, _, _)
    print("isinmath invoked")
    local node = util.get_node_at_cursor()
    if not node then
        return false
    end
    while (node:type() and node:type() ~= 'block_text' and node:type() ~= 'inline_text' and node:type()) do
        if string.match(node:type(), 'math') then
            return true
        end
        node = node:parent()
        if not node then
            return false
        end
    end
    return false
end

function tisinmath(_, _, _)
    print("isinmath invoked")
    local node = util.get_node_at_cursor()
    if not node then
        return false
    end
    while (node:type() and node:type() ~= 'block_text' and node:type() ~= 'inline_text' and node:type()) do
        if string.match(node:type(), 'math') then
            return tostring(node:type())
        end
        node = node:parent()
        if not node then
            return tostring(node:type())
        end
    end
    return tostring(node:type())
end

local is_even_line = function()
  local line_number = vim.fn['line']('.')
  if ((line_number % 2) == 0) then  -- an even-numbered line
    return true
  else  -- an odd-numbered line
    return false
  end
end

return {
    s("trig", t("loaded!!")),
    s("testmath", f(tisinmath)),
    s(
        {trig = "@a", regTrig = true, show_condition = isinmath},
        {t("\\alpha")}
    ),
    s(
        {trig = ";a", show_condition = isinmath},
        {t("\\alpha")}
    ),
    -- s(
    --     {trig = "^@a", show_condition = isinmath},
    --     {t("\\alpha")}
    -- ),
    -- s(
    --     {trig = "@@@@a", show_condition = isinmath},
    --     {t("\\alpha")}
    -- ),
    -- s(
    --     {trig = "parti", show_condition = isinmath},
    --     {t("\\alpha")}
    -- ),
    -- s(
    --     {trig = "@aaaaaaaa", show_condition = isinmath},
    --     {t("\\alpha")}
    -- ),
    s(
        {trig = ";A", show_condition = isinmath},
        t("\\Alpha")
    ),
    s(
        {trig = ";b", show_condition = isinmath},
        t("\\beta")
    ),
    s(
        {trig = ";B", show_condition = isinmath},
        t("\\Beta")
    ),
    s(
        {trig = ";d", show_condition = isinmath},
        t("\\delta")
    ),
    s(
        {trig = ";D", show_condition = isinmath},
        t("\\Delta")
    ),
    s(
        {trig = ";g", show_condition = isinmath},
        t("\\gamma")
    ),
    s(
        {trig = ";G", show_condition = isinmath},
        t("\\Gamma")
    ),
    s(
        {trig = ";e", show_condition = isinmath},
        t("\\epsilon")
    ),
    s(
        {trig = ";ve", show_condition = isinmath},
        t("\\varepsilon")
    ),
    s(
        {trig = ";E", show_condition = isinmath},
        t("\\Epsilon")
    ),
    s(
        {trig = ";z", show_condition = isinmath},
        t("\\zeta")
    ),
    s(
        {trig = ";Z", show_condition = isinmath},
        t("\\Zeta")
    ),
    s(
        {trig = ";h", show_condition = isinmath},
        t("\\eta")
    ),
    s(
        {trig = ";H", show_condition = isinmath},
        t("\\Eta")
    ),
    s(
        {trig = ";q", show_condition = isinmath},
        t("\\theta")
    ),
    s(
        {trig = ";vq", show_condition = isinmath},
        t("\\vartheta")
    ),
    s(
        {trig = ";Q", show_condition = isinmath},
        t("\\Theta")
    ),
    s(
        {trig = ";i", show_condition = isinmath},
        t("\\iota")
    ),
    s(
        {trig = ";I", show_condition = isinmath},
        t("\\Iota")
    ),
    s(
        {trig = ";k", show_condition = isinmath},
        t("\\kappa")
    ),
    s(
        {trig = ";K", show_condition = isinmath},
        t("\\Kappa")
    ),
    s(
        {trig = ";l", show_condition = isinmath},
        t("\\lambda")
    ),
    s(
        {trig = ";L", show_condition = isinmath},
        t("\\Lambda")
    ),
    s(
        {trig = ";m", show_condition = isinmath},
        t("\\mu")
    ),
    s(
        {trig = ";M", show_condition = isinmath},
        t("\\Mu")
    ),
    s(
        {trig = ";n", show_condition = isinmath},
        t("\\nu")
    ),
    s(
        {trig = ";N", show_condition = isinmath},
        t("\\Nu")
    ),
    s(
        {trig = ";x", show_condition = isinmath},
        t("\\xi")
    ),
    s(
        {trig = ";X", show_condition = isinmath},
        t("\\Xi")
    ),
    s(
        {trig = ";p", show_condition = isinmath},
        t("\\pi")
    ),
    s(
        {trig = ";P", show_condition = isinmath},
        t("\\Pi")
    ),
    s(
        {trig = ";vp", show_condition = isinmath},
        t("\\varpi")
    ),
    s(
        {trig = ";r", show_condition = isinmath},
        t("\\rho")
    ),
    s(
        {trig = ";R", show_condition = isinmath},
        t("\\Rho")
    ),
    s(
        {trig = ";vr", show_condition = isinmath},
        t("\\varrho")
    ),
    s(
        {trig = ";s", show_condition = isinmath},
        t("\\sigma")
    ),
    s(
        {trig = ";S", show_condition = isinmath},
        t("\\Sigma")
    ),
    s(
        {trig = ";vs", show_condition = isinmath},
        t("\\varsigma")
    ),
    s(
        {trig = ";t", show_condition = isinmath},
        t("\\tau")
    ),
    s(
        {trig = ";T", show_condition = isinmath},
        t("\\Tau")
    ),
    s(
        {trig = ";u", show_condition = isinmath},
        t("\\upsilon")
    ),
    s(
        {trig = ";U", show_condition = isinmath},
        t("\\Upsilon")
    ),
    s(
        {trig = ";f", show_condition = isinmath},
        t("\\phi")
    ),
    s(
        {trig = ";F", show_condition = isinmath},
        t("\\Phi")
    ),
    s(
        {trig = ";vf", show_condition = isinmath},
        t("\\varphi")
    ),
    s(
        {trig = ";c", show_condition = isinmath},
        t("\\chi")
    ),
    s(
        {trig = ";C", show_condition = isinmath},
        t("\\Chi")
    ),
    s(
        {trig = ";y", show_condition = isinmath},
        t("\\psi")
    ),
    s(
        {trig = ";Y", show_condition = isinmath},
        t("\\Psi")
    ),
    s(
        {trig = ";o", show_condition = isinmath},
        t("\\omega")
    ),
    s(
        {trig = ";O", show_condition = isinmath},
        t("\\Omega")
    ),
    s(
        {trig = ";vo", show_condition = isinmath},
        t("\\varomega")
    ),
    s(
        {trig = ";6", show_condition = isinmath},
        t("\\partial")
    ),
    s(
        {trig = ";%", show_condition = isinmath},
        {t("\\frac{"), i(1), t("}{"), i(2), t("}")}
    ),
    s(
        {trig = ";/", show_condition = isinmath},
        {t("\\frac{"), i(1), t("}{"), i(2), t("}")}
    ),
    s(
        {trig = ";2", show_condition = isinmath},
        {t("\\sqrt{"), i(1), t("}")}
    ),
    s(
        {trig = ";,", show_condition = isinmath},
        t("\\nonumber")
    ),
    s(
        {trig = ";.", show_condition = isinmath},
        t("\\cdot")
    ),
    s(
        {trig = ";8", show_condition = isinmath},
        t("\\infty")
    ),
    s(
        {trig = ";^", show_condition = isinmath},
        {t("\\Hat{"), i(1), t("}")}
    ),
}
