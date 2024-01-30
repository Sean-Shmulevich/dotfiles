require("gp").setup{

	agents = {
		{
			name = "ChatGPT4",
			chat = true,
			command = false,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are a general AI assistant.\n\n"
				.. "The user provided the additional info about how they would like you to respond:\n\n"
				.. "- If you're unsure don't guess and say you don't know instead.\n"
				.. "- Ask question if you need clarification to provide better answer.\n"
				.. "- Think deeply and carefully from first principles step by step.\n"
				.. "- Zoom out first to see the big picture and then zoom in to details.\n"
				.. "- Use Socratic method to improve your thinking and coding skills.\n"
				.. "- Don't elide any code from your output if the answer requires coding.\n"
				.. "- Take a deep breath; You've got this!\n",
		},
        {
            name = "CodeGPT4",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor.\n\n"
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
            .. "START AND END YOUR ANSWER WITH:\n\n```",
        },
    },
    chat_user_prefix = "󰭹 ",
    	-- example hook functions (see Extend functionality section in the README)
	hooks = {
		InspectPlugin = function(plugin, params)
			local bufnr = vim.api.nvim_create_buf(false, true)
			local copy = vim.deepcopy(plugin)
			local key = copy.config.openai_api_key
			copy.config.openai_api_key = key:sub(1, 3) .. string.rep("*", #key - 6) .. key:sub(-3)
			local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(copy))
			local params_info = string.format("Command params:\n%s", vim.inspect(params))
			local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
			vim.api.nvim_win_set_buf(0, bufnr)
		end,

		-- GpImplement rewrites the provided selection/range based on comments in it
		Implement = function(gp, params)
			local template = "Having following from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please rewrite this according to the contained instructions."
				.. "\n\nRespond exclusively with the snippet that should replace the selection above."

			local agent = gp.get_command_agent()
			gp.info("Implementing selection with agent: " .. agent.name)

			gp.Prompt(
				params,
				gp.Target.rewrite,
				nil, -- command will run directly without any prompting for user input
				agent.model,
				template,
				agent.system_prompt
			)
		end,

		-- your own functions can go here, see README for more examples like
		-- :GpExplain, :GpUnitTests.., :GpTranslator etc.

		-- -- example of making :%GpChatNew a dedicated command which
		-- -- opens new chat with the entire current buffer as a context
		BufferChatNew = function(gp, _)
			-- call GpChatNew command in range mode on whole buffer
			vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
		end,

		-- -- example of adding command which opens new chat dedicated for translation
		-- Translator = function(gp, params)
		-- 	local agent = gp.get_command_agent()
		-- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
		-- 	gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
		-- end,

		-- -- example of adding command which writes unit tests for the selected code
		-- UnitTests = function(gp, params)
		-- 	local template = "I have the following code from {{filename}}:\n\n"
		-- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
		-- 		.. "Please respond by writing table driven unit tests for the code above."
		-- 	local agent = gp.get_command_agent()
		-- 	gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
		-- end,

		-- -- example of adding command which explains the selected code
		Explain = function(gp, params)
			local template = "I have the following code from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please respond by explaining the code above."
			local agent = gp.get_chat_agent()
			gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
		end,
	},
}

vim.keymap.set({"n", "v"}, '<leader>gn',':GpChatNew<CR>', {})

vim.keymap.set("n", '<leader>gt',':GpChatToggle<CR>', {})
vim.keymap.set("n", '<leader>gpt',':GpChatToggle<CR>', {})
vim.keymap.set("n", '<leader>gtv',':GpChatToggle vsplit<CR>', {})
vim.keymap.set("n", '<leader>gts',':GpChatToggle split<CR>', {})
vim.keymap.set("n", '<leader>gtt',':GpChatToggle tabnew<CR>', {})
vim.keymap.set("n", '<leader>gtp',':GpChatToggle popup<CR>', {})
vim.keymap.set({"n", "v"}, '<leader>gy',':GpChatPaste popup<CR>', {})

vim.keymap.set({"n", "v"}, '<leader>gr',':GpRewrite<CR>', {})
vim.keymap.set({"n", "v"}, '<leader>gta',':GpAppend<CR>', {})
vim.keymap.set({"n", "v"}, '<leader>gv',':GpVnew<CR>', {})
vim.keymap.set({"n", "v"}, '<leader>gi',':GpImplement<CR>', {})
