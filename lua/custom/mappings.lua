local M = {}


M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require("dap.ui.widgets");
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open()
      end,
      "Openb debugging sidebar"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function ()
        require("crates").upgrade_all_crates() 
      end,
      "Update crates"
    }
  }
}
return M




