require('mini.sessions').setup()
local save_session = function()
  vim.ui.input({ prompt = "Session to save: " }, function(input)
    if (input == nil) then
      return
    end
    MiniSessions.write(input)
    vim.cmd("echon ' '")
    print("Session created: " .. input)
    if vim.bo.filetype == 'ministarter' then
      MiniStarter.refresh()
    end
  end)
end
local delete_session = function()
  vim.ui.input({ prompt = "Session to delete: " }, function(input)
    if (input == nil) then
      return
    end
    MiniSessions.delete(input)
    vim.cmd("echon ' '")
    print("Session deleted: " .. input)
    if vim.bo.filetype == 'ministarter' then
      MiniStarter.refresh()
    end    
  end)
end
vim.keymap.set("n", "<leader>w", "", {desc = "Manage sessions"})
vim.keymap.set("n", "<leader>ww", save_session, {desc = "Save the session"})
vim.keymap.set("n", "<leader>wd", delete_session, {desc = "Delete a session"})
vim.keymap.set("n", "<leader>wo", MiniSessions.select, {desc = "Open a session"})
