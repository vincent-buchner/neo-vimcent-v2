return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")

      -- Override go configurations to debug by package (not file)
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug test (current package)",
          request = "launch",
          mode = "test",
          program = "${fileDirname}",
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "${workspaceFolder}",
        },
        {
          type = "delve",
          name = "Debug test (current file)",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
      }
    end,
  },
}
