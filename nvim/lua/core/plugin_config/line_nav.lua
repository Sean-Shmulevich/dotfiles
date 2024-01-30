function CustomTabNew(args)
    if args.args ~= nil and args.args ~= '' then
        -- If there are arguments, use the default `:tabnew` behavior
        vim.cmd('tabnew ' .. args.args)
    else
        -- Custom behavior when no arguments are given
        if vim.fn.bufexists('#') == 1 then
            vim.cmd('tabnew #')
        elseif vim.fn.getreg('#') ~= '' then
            vim.cmd('tabnew %')
        else
            vim.cmd('tabnew')
        end
    end
end
vim.api.nvim_create_user_command('Tabnew', CustomTabNew, {nargs='*'})

local function moveToMiddleAndShift(count, direction)
    local line = vim.api.nvim_get_current_line()
    local midCol = math.floor(vim.fn.strdisplaywidth(line) / 2)
    local totalWidth = vim.fn.strdisplaywidth(line)
    local actualCol = 0
    local index = 1

    -- the default is 1 so when 1 is specified move 2
    count = count + 1

    -- Check if the line is empty or contains only whitespace
    if totalWidth == 0 then
        -- Move to the start of the line
        vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), 0})
        return
    end

    while actualCol < midCol and index <= #line do
        actualCol = actualCol + vim.fn.strdisplaywidth(line:sub(index, index))
        index = index + 1
    end

    vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), index - 2})

    if count ~= 0 then
        pcall(vim.api.nvim_feedkeys, string.rep(direction, math.abs(count)), 'n', false)
    end
end


function MoveToFractionOfLine(count)
    local line = vim.fn.getline('.')
    local totalWidth = vim.fn.strdisplaywidth(line)

    -- Find the first non-blank character in the line
    local firstNonBlank = vim.fn.match(line, "\\S")
    if firstNonBlank == -1 then firstNonBlank = 0 end

    local effectiveWidth = totalWidth - firstNonBlank

    local fraction = 0.5 -- Default to half

    if count == 1 then
        vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), firstNonBlank})
        return
    elseif count == 2 then
        fraction = 0.25
    elseif count == 3 then
        fraction = 0.75
    elseif count == 4 then
        fraction = 1
    end

    local targetCol = math.ceil(effectiveWidth * fraction) + firstNonBlank
    local actualCol = 0
    local index = 1

    -- Adjust targetCol to not exceed the line length
    targetCol = math.min(targetCol, #line)

    -- Navigate to the target column
    while actualCol < targetCol and index <= #line do
        actualCol = actualCol + vim.fn.strdisplaywidth(line:sub(index, index))
        index = index + 1
    end

    -- Ensuring the column index does not exceed the line length
    index = math.min(index - 1, #line)

    -- Sets the cursor position in the current window
    vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), index})
end

function _G.MoveToFractionOfLineWrapper()
    MoveToFractionOfLine(vim.v.count)
end

vim.keymap.set('n', '<Space>', ':lua MoveToFractionOfLineWrapper()<CR>', {noremap = true, silent = true})

-- gM - goto middle of line and end of word (backward)
-- set gm to space bar and make values 1,2,3,4 (quarter, half, 3/4, end) 
-- set gM and gm to be word wise always

function MoveBackwardFromMiddle(count) moveToMiddleAndShift(count or 0, 'b') end function MoveForwardFromMiddle(count)
    moveToMiddleAndShift(count or 0, 'w')
end

function MoveBackwardFromMiddleB(count)
    moveToMiddleAndShift(count or 0, 'B')
end

function MoveForwardFromMiddleW(count)
    moveToMiddleAndShift(count or 0, 'W')
end

vim.api.nvim_set_keymap('n', 'gM', ':lua MoveBackwardFromMiddle(vim.v.count)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gm', ':lua MoveForwardFromMiddle(vim.v.count)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gM', ':lua MoveBackwardFromMiddleB(vim.v.count)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gm', ':lua MoveForwardFromMiddleW(vim.v.count)<CR>', {noremap = true, silent = true})
