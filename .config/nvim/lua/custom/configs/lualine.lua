local function xcodebuild_device()
  if vim.g.xcodebuild_platform == "macOS" then
    return " macOS"
  end

  if vim.g.xcodebuild_os then
    return " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
  end

  return " " .. vim.g.xcodebuild_device_name
end

------

lualine_x = {
  { "' ' .. vim.g.xcodebuild_last_status", color = { fg = "Gray" } },
  { "'󰙨 ' .. vim.g.xcodebuild_test_plan", color = { fg = "#a6e3a1", bg = "#161622" } },
  { xcodebuild_device, color = { fg = "#f9e2af", bg = "#161622" } },
}
