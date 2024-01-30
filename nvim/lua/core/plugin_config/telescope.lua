local status_ok, builtin = pcall(require, "telescope.builtin")
local status_ok_setup, tel = pcall(require, "telescope")
local ok, previewers = pcall(require, "telescope.previewers")


if not status_ok or not status_ok_setup or not ok then
    return
end

tel.setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extensions = {
            -- Your extension configuration goes here:
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
            -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
            }
}
tel.load_extension('fzf')
local delta = previewers.new_termopen_previewer({
  get_command = function(entry)
    if entry.status == '??' or 'A ' then
      return { 'git', 'diff', entry.value }
    end

    return { 'git', 'diff', entry.value .. '^!' }
  end
})

-- find files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- find words
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- find buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- find help tags
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fp', ':lua require("telescope").extensions.neoclip.default()<CR>', {})
vim.keymap.set('n', '<leader>fs', ':symbolsoutline<cr>', {})
vim.keymap.set('n', '<leader>fu',':Telescope undo<CR>', {})
vim.keymap.set('n', '<leader>fr',':Telescope resume<CR>', {})
vim.keymap.set('n', '<leader>fj',':Telescope jumplist<CR>', {})
vim.keymap.set('n', '<leader>fm',':Telescope marks<CR>', {})
-- vim.keymap.set('n', '<leader>g',':Telescope git_status<CR>', {})
vim.keymap.set('n', '<leader>gc',':Telescope git_commits<CR>', {})
vim.keymap.set('n', '<leader>gd',':Gvdiffsplit<CR>', {})
vim.keymap.set('n', '<Leader>gg', function() builtin.git_status({ previewer = delta, layout_strategy = 'vertical' }) end)
-- this command is sick
vim.keymap.set('n', 'z=', ':Telescope spell_suggest<CR>', {})
vim.keymap.set('n', 'ZS', '1z=', {})
