vim.lsp.config.yamlls = {
    settings = {
        yaml = {
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                    "docker-compose*.yml",
                    "docker-compose*.yaml",
                },
            },
            validate = true,
            completion = true,
            hover = true,
        },
    },
}
