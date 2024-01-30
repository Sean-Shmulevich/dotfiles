-- Set leader key
vim.g.mapleader = ","
-- Rainbow brackets
vim.g.rainbow_active = 1
vim.o.smartcase = true
vim.o.ignorecase = true

-- Set encoding to UTF-8
vim.o.encoding = "UTF-8"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- offset when navigating
vim.o.scrolloff = 1

-- Enable termguicolors if supported
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true end


  -- Option 2: nvim lsp as LSP client
  -- Tell the server the capability of foldingRange,
  -- Neovim hasn't added foldingRange to default capabilities, users must add it manually

-- these mapping are for ,, and ,; to jump to the next and previous occurence of the character under the cursor
-- Implement - add a param before the leader key to specify how many times to jump, you should probably directly pass the param to 'f' and 'F' commands implement
local function jump_to_char(forward, count)
    local char = vim.fn.getline("."):sub(vim.fn.col('.'), vim.fn.col('.'))
    local cmd_fmt = forward and 'normal! %df%s' or 'normal! %dF%s'
    local cmd = string.format(cmd_fmt, count or 1, char)
    vim.cmd(cmd)
end

-- Keymap wrappers to handle the jump logic with dot repeat support
vim.api.nvim_set_keymap('n', '<leader>,', '', {
    noremap = true,
    silent = true,
    callback = function()
        jump_to_char(false, vim.v.count1)
    end
})
vim.api.nvim_set_keymap('n', '<leader>;', '', {
    noremap = true,
    silent = true,
    callback = function()
        jump_to_char(true, vim.v.count1)
    end
})


-- move visual selection up and down, note (better touch tool needed for this alt mapping to work)
-- Alt +j move down
-- Alt + k move up
vim.keymap.set("v", "<C-=><C-x>",":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-=><C-y>", ":m '>+1<CR>gv=gv")

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

require('gitsigns').setup()
require'colorizer'.setup()
require("toggleterm").setup{

    highlights = { -- highlights which map to a highlight group name and a table of it's values NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        Normal = {
            guibg = "NONE",
        },
        NormalFloat = {
            link = 'Normal'
        },
    },
    shade_terminals = false, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
}
-- Enable syntax and set colorscheme
vim.cmd [[
  set cursorline
  let g:vim_markdown_folding_disabled = 1
  colorscheme monokai_soda
]]

-- jk to exit insert mode, weird but lets see how it goes
vim.keymap.set("n", "<Down>", "<C-e>")
vim.keymap.set("n", "<Up>", "<C-y>")
vim.keymap.set("n", "gp", "`[v`]")

vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "<C-s>", "<C-x>s")
-- dont copy to register when deleting a char
vim.keymap.set("n", "x", '"_x')
-- excape works in terminal mode to exit terminal mode, default is ctrl + \ + ctrl + n
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- exit terminal mode and close terminal
vim.keymap.set("t", "<C-=><C-n>", "<C-\\><C-n>:ToggleTerm<CR>")
-- i need to make it so that in normal mode, this command only opens a terminal.and doesnt interfere with whatever else that command may do. this is so I can get my cmd+j working with better touch tool 
-- set a custom keymap in btt to send ctrl+= and ctrl+n when cmd+j is pressed
vim.keymap.set("n", "<C-=><C-n>", ":ToggleTerm<CR>")
-- insert mode same thing this one is werid because it toggles and may stop insertion 
vim.keymap.set("i", "<C-=><C-n>", "<ESC>:ToggleTerm<CR>")

vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

-- split
vim.keymap.set("n", "<leader>sv", '<C-w>v') -- split vertically
vim.keymap.set("n", "<leader>sh", '<C-w>s') -- split horizontally
vim.keymap.set("n", "<leader>se", '<C-w>=') -- make split windows equal width
vim.keymap.set("n", "<leader>sx", ':close<CR>') -- move to left split

-- There commands are kidn of game changing
vim.keymap.set("n", "<leader>yy", ':%y+<CR>') -- copy everything to clipboard
vim.keymap.set("v", "<leader>y", '"*y') -- copy visual selection to clipboard

-- the difference between buffers and tabs is 
-- buffers represent all files opened in any context, split or in other tabs etc.
-- tabs represent a groups of buffers that are open in a tab, so you can have two tabs with different buffers open on them in a different split basically

-- tab management
vim.keymap.set("n", "<leader>to", ':Tabnew<CR>') -- new tabtabnew
vim.keymap.set("n", "<leader>tx", ':tabclose<CR>') -- close tab
vim.keymap.set("n", "<leader>tn", ':tabn<CR>')
vim.keymap.set("n", "<leader>tp", ':tabp<CR>')
-- vim.keymap.set("n", "<leader>tb", ':bnext<CR>')
-- vim.keymap.set("n", "<leader>tB", ':bprevious<CR>')
vim.keymap.set("n", "<leader>d", ':bdelete<CR>')

vim.keymap.set("n", "<leader>j", ':ToggleTerm<CR>')

vim.keymap.set("n", "<leader>sm", ':MaximizerToggle<CR>') -- maximize window

local function isLeftWindowNvimTree()
    -- Check if the current window is not the first one
    if vim.fn.winnr() ~= 1 then
        -- Check if NvimTree is open in the first window
        local firstBuffer = vim.api.nvim_win_get_buf(vim.fn.win_getid(1))
        local firstFileType = vim.api.nvim_buf_get_option(firstBuffer, 'filetype')
        print(firstFileType)
        return firstFileType == 'NvimTree'
    end
    return false
end

function SetWindowWidthToFactor()
    vim.ui.input({prompt = "Set width (0-10): "}, function(input)
        if input then
            local factor = tonumber(input)
            if factor == 0 then
                -- Minimize the current window
                vim.api.nvim_win_set_width(0, 1)

                -- Determine the window layout
                local winnr = vim.fn.winnr()
                local totalWindows = vim.fn.winnr('$')

                if winnr == 1 and totalWindows > 1 then
                    -- If current window is the leftmost and not the only window, move right
                    vim.cmd('wincmd l')
                elseif totalWindows > 1 then
                    -- Otherwise, move left if possible
                    -- unless nvim tree is left
                    if isLeftWindowNvimTree() then
                        vim.cmd('wincmd l')
                    else
                        vim.cmd('wincmd h')
                    end
                end
            elseif factor and factor >= 1 and factor <= 10 then
                local screenWidth = vim.api.nvim_get_option('columns')
                local newWidth = math.floor(screenWidth * (factor * 0.1))
                newWidth = math.max(1, newWidth)
                vim.api.nvim_win_set_width(0, newWidth)
            else
                print("Invalid input. Please enter a number between 0 and 10.")
            end
        end
    end)
end

vim.api.nvim_set_keymap('n', '<leader>Z', ':lua SetWindowWidthToFactor()<CR>', {noremap = true, silent = true})

-- Enable spellcheck for markdown and text files
vim.api.nvim_create_autocmd("FileType", {
    -- tab management
    pattern = {"markdown", "text"},
    callback = function()
        vim.opt_local.spell = true
    end,
})

-- mhen you multiply negative numbers you end

-- Copilot settings vim.g.copilot_assume_mapped = true
    -- ctrl+space to be the completion for copilot so that I can use tab for something else
-- vim.api.nvim_set_keymap('i', '<C-Space>', 'copilot#Accept("<CR>")', {expr=true, silent=true})


-- Leader key mappings
-- Toggle NERDTree with <leader>f
-- vim.api.nvim_set_keymap('n', '<leader>f', ':NERDTreeToggle<CR>', {silent = true, noremap = true})
vim.cmd [[
    map <leader>b :NvimTreeToggle<CR>
    map <leader>B :NvimTreeFocus<CR>
]]

-- vim.cmd [[
--     autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
-- ]]

vim.api.nvim_set_keymap('n', 'g,', ',', {silent = true, noremap = true})

vim.api.nvim_set_keymap('i', '{  ', "{}<Esc>ha", {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', "'  ", "''<Esc>ha", {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '"', '""<Esc>ha', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '`', '``<Esc>ha', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '(  ', '()<Esc>ha', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<  ', '<><Esc>ha', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '[  ', '[]<Esc>ha', {silent = true, noremap = true})

vim.api.nvim_set_keymap('n', '<leader>ss', ':setlocal spell! spelllang=en_us<CR>', {})

-- Disable search highlight when pressing Enter 
vim.api.nvim_set_keymap('n', '<leader>cc', ':noh<CR>', {silent=true})

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

-- Airline settings
-- vim.g.WebDevIconsNerdTreeBeforeGlyphPadding = ""
vim.g['airline#extensions#tabline#enabled'] = 0
vim.g.airline_powerline_fonts = 1

if vim.fn.has('gui_running') == 0 then
  vim.o.t_Co = "256"
end

-- Other settings
vim.o.background = "dark"
vim.o.backspace = "indent,eol,start"
vim.g.shades_of_purple_airline = 1
vim.g.airline_theme = 'shades_of_purple'
-- vim.g.webdevicons_conceal_nerdtree_brackets = 1

-- Disable unmatched folder and file icons having the same color as their labels (normally green and white),
-- if set by this plugin (it could have been set by some other plugin that you are using).
-- vim.g.WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
-- vim.g.WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

-- Enable line numbers and search highlighting
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.hlsearch = true

-- Set tab length to 4 spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- FZF default command
vim.g.FZF_DEFAULT_COMMAND = 'find . \\( -name node_modules -o -name .git \\) -prune -o -print'

-- Custom cursor movements
-- vim.api.nvim_set_keymap('n', 'g1', [[<Cmd>lua require'custom'.cursor(0, vim.fn.virtcol('$')/0)<CR>]], {})
-- ... (similarly for g2, g3, g4, g5)

-- Remove background color from Normal mode
vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
vim.cmd [[ hi LineNr guibg=NONE ]]
vim.cmd [[ hi LineNr guifg=#e0ccff ctermfg=grey ]]
vim.cmd [[ hi SignColumn guibg=NONE ctermbg=NONE ]]

vim.cmd [[ hi TelescopeNormal guibg=NONE ctermbg=NONE ]]
-- this one is a really cool color
vim.cmd [[ hi Visual guibg=#402b94 ctermbg=242 ]]
vim.cmd [[ hi Search ctermfg=NONE guifg=NONE guibg=#402b94 ctermbg=11 ]]
vim.cmd [[ hi Pmenu guibg=NONE guifg=gray ]]
vim.cmd [[ hi NvimTreeCursorLine guibg=#402b94 ctermbg=242 ]]
vim.cmd [[ hi BufferLineTab guibg=#151536 ctermbg=NONE ]]
vim.cmd [[ hi BufferLineFill guibg=NONE ctermbg=NONE ]]
vim.cmd [[ hi BufferLineTabSelected guifg=yellow guibg=NONE ctermbg=NONE ]]
vim.cmd [[ hi BufferLineTabSelected guifg=yellow guibg=NONE ctermbg=NONE ]]
vim.cmd [[ hi NormalFloat guibg=NONE ctermbg=NONE guifg=NONE]]
vim.cmd [[ hi CursorLineNr cterm=NONE guibg=NONE ctermbg=NONE guifg=yellow ctermfg=yellow ]]
-- vim.cmd [[ hi CursorLine cterm=NONE guibg=#272750 ctermbg=NONE guifg=NONE ctermfg=NONE ]]
vim.cmd [[ hi CursorLine cterm=NONE guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE ]]
vim.cmd [[ hi Folded cterm=NONE guibg=NONE ctermbg=NONE ctermfg=yellow ]]

-- vim.cmd [[ hi FoldColumn guibg=NONE ctermbg=NONE ctermfg=NONE guifg=NONE ]]

-- Set timeout settings
vim.o.ttimeout = true
vim.o.ttimeoutlen = 1
