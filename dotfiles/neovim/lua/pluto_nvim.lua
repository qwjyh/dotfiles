local job = require('plenary.job')
local M = {}

local NOTEBOOK_HEADER = "### A Pluto.jl notebook ###"
local BLOCK_START = "# ╔═╡ "
local CELLORDER_START = "# ╔═╡ Cell order:"
local CELLORDER_VISIBLE_BODY = "# ╠═"
local CELLORDER_HIDDEN_BODY = "# ╟─"

local function node_is_pluto_prefix(node)
    if node:type() ~= "line_comment" then
        return false
    end
    local row, col, _ = node:start()
    local comment_text = vim.api.nvim_buf_get_lines(0, row, row + 1, true)
    -- print("TEXT: ", comment_text[1])
    return nil ~= string.match(comment_text[1], BLOCK_START) and nil == string.match(comment_text[1], CELLORDER_START)
end

---Get iterator of TSnodes of cell prefix comments
---@return function
function M.get_cell_prefix_nodes()
    local curnode = vim.treesitter.get_node()
    local top_nodes = curnode:root():iter_children()
    return function()
        while true do
            local node = top_nodes()
            if node == nil then
                return nil
            end
            if node_is_pluto_prefix(node) then
                return node
            end
        end
    end
end

local function node_is_cell_order(node)
    if node:type() ~= "line_comment" then
        return false
    end
    local row, col, _ = node:start()
    local comment_text = vim.api.nvim_buf_get_lines(0, row, row + 1, true)
    -- print("TEXT: ", comment_text[1])
    return nil ~= string.match(comment_text[1], CELLORDER_START) or
        nil ~= string.match(comment_text[1], CELLORDER_VISIBLE_BODY) or
        nil ~= string.match(comment_text[1], CELLORDER_HIDDEN_BODY)
end

function M.get_cell_order_nodes()
    local curnode = vim.treesitter.get_node()
    local top_nodes = curnode:root():iter_children()
    return function()
        while true do
            local node = top_nodes()
            if node == nil then
                return nil
            end
            if node_is_cell_order(node) then
                return node
            end
        end
    end
end

---Get prefix TSNode of current cell
---@return TSNode?
local function get_current_cell_prefix_node()
    local curnode = vim.treesitter.get_node()
    if curnode == nil then
        print("Not in a cell")
        return nil
    end
    while curnode:parent():type() ~= "source_file" do
        print("curnode", curnode:range())
        curnode = curnode:parent()
    end
    local prefix_node
    if node_is_pluto_prefix(curnode) then
        prefix_node = curnode
    elseif curnode:prev_sibling() ~= nil and node_is_pluto_prefix(curnode:prev_sibling()) then
        prefix_node = curnode:prev_sibling()
    else
        print("Not a valid cell")
        print("current node", curnode:type(), curnode:range())
        return nil
    end
    return prefix_node
end

local function get_uuid(node)
    local row, col, _ = node:start()
    local comment_text = vim.api.nvim_buf_get_lines(0, row, row + 1, true)
    -- print("text", comment_text[1])
    local _, _, uuid = string.find(comment_text[1], "(%x+-%x+-%x+-%x+-%x+)")
    return uuid
end

---Get uuid of the current cell.
---@return string?
function M.get_current_cell_uuid()
    local prefix_node = get_current_cell_prefix_node()
    if prefix_node == nil then return nil end
    return get_uuid(prefix_node)
end

local function get_cellbody_node(uuid)
    for node in M.get_cell_prefix_nodes() do
        if uuid == get_uuid(node) then
            return node
        end
    end
end

---Generate uuid1 using Julia.
---@return string
local function uuid1()
    local generated
    job:new({
        command = "julia",
        args = { "-e", "using UUIDs; print(uuid1())" },
        on_exit = function(j, return_val)
            if return_val ~= 0 then
                print("error processing UUID", return_val, vim.inspect(j:result()))
            end
            generated = j:result()[1]
        end,
    }):sync()
    return generated
end

---Get row number of the cell order entry which corresponds to the current cell
---@param curuuid string
---@return integer?
local function get_cell_order_node(curuuid)
    local ordernode_row
    for ordernode in M.get_cell_order_nodes() do
        local srow, scol, erow, ecol = ordernode:range()
        local str = vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {})
        local _, _, ordernode_uuid = string.find(str[1], "(%x+-%x+-%x+-%x+-%x+)")
        if ordernode_uuid == curuuid then
            -- print("Matched: ", curuuid, srow, erow)
            ordernode_row = srow
        end
    end
    return ordernode_row
end

function M.insert_cell_below()
    local curuuid = M.get_current_cell_uuid()
    if curuuid == nil then
        return nil
    end
    local newuuid = uuid1()
    local ordernode_row = get_cell_order_node(curuuid)
    vim.api.nvim_buf_set_lines(0, ordernode_row + 1, ordernode_row + 1, true, {
        CELLORDER_VISIBLE_BODY .. newuuid
    })
    local prefix_node = get_current_cell_prefix_node()
    if prefix_node == nil then
        return nil
    end
    local _, _, end_row, _ = prefix_node:next_sibling():range()
    vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, true, {
        "",
        BLOCK_START .. newuuid,
        "",
    })
    vim.api.nvim_win_set_cursor(0, { end_row + 4, 0 })
end

function M.goto_cellorder_entry()
    local curuuid = M.get_current_cell_uuid()
    if not curuuid then return nil end
    local ordernode_row = get_cell_order_node(curuuid)
    vim.cmd("norm! m`")
    vim.api.nvim_win_set_cursor(0, { ordernode_row + 1, 0 })
end

function M.goto_cell_body()
    local line_str = vim.api.nvim_get_current_line()
    local _, _, uuid = string.find(line_str, "(%x+-%x+-%x+-%x+-%x+)")
    if uuid == nil then
        print("This line doesn't have valid id")
        return nil
    end
    local body_node = get_cellbody_node(uuid)
    local start_row, _, _, _ = body_node:range()
    vim.cmd("norm! m`")
    vim.api.nvim_win_set_cursor(0, { start_row + 2, 0 })
end

function M.toggle_visibility()
    local curuuid = M.get_current_cell_uuid()
    if not curuuid then return nil end
    local ordernode_row = get_cell_order_node(curuuid)
    local ordernode_text = vim.api.nvim_buf_get_lines(0, ordernode_row, ordernode_row + 1, true)[1]
    if string.find(ordernode_text, CELLORDER_VISIBLE_BODY) then
        vim.api.nvim_buf_set_text(0, ordernode_row, 0, ordernode_row, 4, { CELLORDER_HIDDEN_BODY })
    elseif string.find(ordernode_text, CELLORDER_HIDDEN_BODY) then
        vim.api.nvim_buf_set_text(0, ordernode_row, 0, ordernode_row, 4, { CELLORDER_VISIBLE_BODY })
    end
end

function M.setup(opts)
    vim.api.nvim_create_user_command('PlutoGoToCellOrder', M.goto_cellorder_entry, {
        nargs = 0,
        desc = "Go to the cell order entry which corresponds to the current cell",
    })
    vim.api.nvim_create_user_command('PlutoGoToCellBody', M.goto_cell_body, {
        nargs = 0,
        desc = "Go to the cell body which corresponds to the current order entry",
    })
    vim.api.nvim_create_user_command('PlutoToggleVisibility', M.toggle_visibility, {
        nargs = 0,
        desc = "Toggle visiblity of the current cell",
    })
    -- require('nvim-treesitter.configs').setup {
    --     textobjects = {
    --         select = {
    --             enable = true,
    --             keymaps = {
    --                 ["ac"] = "@cell.outer",
    --             },
    --         },
    --     },
    -- }
end

return M
