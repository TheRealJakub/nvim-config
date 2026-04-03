return {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
    pyright = {
      disableOrganizeImports = true, -- Ruff handles this
    },
  },
}

