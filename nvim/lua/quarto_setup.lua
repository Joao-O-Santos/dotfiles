local function optional(module)
  local ok, value = pcall(require, module)
  return ok and value or nil
end

local cmp = optional('cmp')
local cmp_lsp = optional('cmp_nvim_lsp')
local quarto = optional('quarto')
local otter = optional('otter')
local treesitter = optional('nvim-treesitter')

if cmp then
  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({ { name = 'nvim_lsp' } }, { { name = 'buffer' } }),
  })
end

if treesitter then
  pcall(treesitter.setup, {})
end
pcall(vim.treesitter.language.register, 'markdown', 'quarto')

if otter then
  pcall(otter.setup, {
    lsp = { diagnostic_update_events = { 'BufWritePost' } },
    buffers = { set_filetype = true, write_to_disk = false },
  })
end

if quarto then
  pcall(quarto.setup, {
    lspFeatures = {
      enabled = true,
      chunks = 'curly',
      languages = { 'r' },
      diagnostics = { enabled = true, triggers = { 'BufWritePost' } },
      completion = { enabled = true },
    },
  })
end

local capabilities = cmp_lsp and cmp_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
local r_air = vim.fn.exepath('r-air')
if r_air ~= '' then
  vim.lsp.config('r_air', {
    cmd = { r_air, 'language-server' },
    capabilities = capabilities,
    filetypes = { 'r' },
    root_markers = { '.git', 'DESCRIPTION', 'renv.lock', '_quarto.yml' },
  })
  vim.lsp.enable('r_air')
else
  vim.notify('r-air not found; R LSP disabled', vim.log.levels.WARN)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('quarto_lsp_attach', { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'LSP hover' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'LSP definition' }))
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'LSP rename' }))
  end,
})
