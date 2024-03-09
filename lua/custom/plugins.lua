local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
        "rust-analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui"
    },
    config = function (_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")

    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end

  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require("rust-tools").setup(opts) 
    end

  },
  {
    "saecki/crates.nvim",
    ft = {"rust", "toml"},
    config = function (_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
        table.insert(M.sources, {name= "creates"})
      return M
    end
  },
  {
    "dreamsofcode-io/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope.vim"
    },
    config = function ()
      require("chatgpt").setup({
        async_api_key_cmd = "op item get chatgpt.nvim --fields label=credential"
      })
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  }
}

return plugins
