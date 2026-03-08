-- DAP (Debug Adapter Protocol) configuration for C/C++ debugging
local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

-- Setup dap-ui
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
  controls = {
    icons = {
      pause = "⏸",
      play = "▶",
      run_last = "↻",
      step_back = "◀",
      step_into = "⏭",
      step_out = "⏮",
      step_over = "⏯",
      terminate = "⏹",
    },
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      position = "left",
      size = 40,
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      position = "bottom",
      size = 10,
    },
  },
})

-- Open dap-ui when debugging starts, close when it ends
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- C/C++ debug configuration
dap.configurations.c = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Attach to process",
    type = "codelldb",
    request = "attach",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
    end,
    pid = function()
      return tonumber(vim.fn.input("PID: "))
    end,
    cwd = "${workspaceFolder}",
  },
}

-- C++ uses the same configurations as C
dap.configurations.cpp = dap.configurations.c

-- Keymaps for debugging
local keymap = vim.keymap

keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "DAP: Toggle breakpoint" })

keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Set conditional breakpoint" })

keymap.set("n", "<leader>dL", function()
  dap.run_last()
end, { desc = "DAP: Run last" })

keymap.set("n", "<leader>dc", function()
  dap.continue()
end, { desc = "DAP: Continue" })

keymap.set("n", "<leader>do", function()
  dap.step_over()
end, { desc = "DAP: Step over" })

keymap.set("n", "<leader>di", function()
  dap.step_into()
end, { desc = "DAP: Step into" })

keymap.set("n", "<leader>dO", function()
  dap.step_out()
end, { desc = "DAP: Step out" })

keymap.set("n", "<leader>dq", function()
  dap.terminate()
end, { desc = "DAP: Terminate" })

keymap.set("n", "<leader>dr", function()
  dap.restart()
end, { desc = "DAP: Restart" })

keymap.set("n", "<leader>dp", function()
  dap.pause()
end, { desc = "DAP: Pause" })

keymap.set("n", "<leader>du", function()
  dapui.toggle()
end, { desc = "DAP: Toggle UI" })

keymap.set("n", "<leader>de", function()
  dapui.eval(nil, { enter = true })
end, { desc = "DAP: Evaluate expression" })
