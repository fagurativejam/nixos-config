{ ... }:
{
  programs.nixvim = {
    extraConfigLua = ''
      --Track if Neovim has fully started (used by BufDelete logic)
      local started = false
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          started=true
        end
      })
      --Return to Alpha dashboard when last buffer is closed
      vim.api.nvim_create_autocmd("BufDelete", {
        callback = function()
          if not started then return end
          vim.defer_fn(function()
            local bufs = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_valid(buf)
                and vim.bo[buf].buflisted
                and vim.api.nvim_buf_get_name(buf) ~= ""
              end, vim.api.nvim_list_bufs())
            local count = 0
            for _ in pairs(bufs) do count = count + 1 end
            if count == 0 then
              vim.cmd("Alpha")
            end
          end, 10)
        end,
      })
      --Diagnostic signs
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "   ",
            [vim.diagnostic.severity.WARN]  = "   ",
            [vim.diagnostic.severity.HINT]  = "   ",
            [vim.diagnostic.severity.INFO]  = "   ",
          },
        },
      })
      --Persistent folds across sessions
      local fold_group = vim.api.nvim_create_augroup("AutoPersistentFolds", { clear = true })
        vim.api.nvim_create_autocmd({ "BufWinLeave", "BufLeave" }, {
          group = fold_group,
          pattern = "?*",
          command = "silent! mkview",
        })
        vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
          group = fold_group,
          pattern = "?*",
          command = "silent! loadview",
        })
      --Highlight yanked text
      vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight yanked text",
        group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
        callback = function()
          vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
        end,
      })
      --Auto-open images with external viewer instead of in nvim
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.png", "*.jpg", "*.jpeg", "*.webp", "*.gif", "*.svg" },
        callback = function()
          local file = vim.fn.expand("%:p")
          vim.cmd("bd!")
          vim.fn.jobstart({"xdg-open", file}, {detatch = true})
        end
      })
    '';
  };
}
