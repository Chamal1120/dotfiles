return {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = {
        {
            -- By loading as a dependency, we ensure rzls is available to set
            -- the handlers for Roslyn
            "tris203/rzls.nvim",
            config = true,
        },
    },
    config = function()
        -- Command composition for mason installation
        local mason_registry = require("mason-registry")
        local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")

        local cmd = {
            "roslyn",
            "--stdio",
            "--logLevel=Information",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
            "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
            "--razorDesignTimePath=" ..
            vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
            "--extension",
            vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
        }

        -- Alternative command for manual installation (uncomment if needed)
        -- local roslyn_base_path = vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn")
        -- local rzls_base_path = vim.fs.joinpath(vim.fn.stdpath("data"), "rzls")
        -- local cmd = {
        --     "dotnet",
        --     vim.fs.joinpath(roslyn_base_path, "Microsoft.CodeAnalysis.LanguageServer.dll"),
        --     "--stdio",
        --     "--logLevel=Information",
        --     "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        --     "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_base_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        --     "--razorDesignTimePath=" .. vim.fs.joinpath(rzls_base_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
        -- }

        vim.lsp.config("roslyn", {
            cmd = cmd,
            handlers = require("rzls.roslyn_handlers"), -- This is the key integration point
            settings = {
                ["csharp|inlay_hints"] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                    csharp_enable_inlay_hints_for_types = true,
                    dotnet_enable_inlay_hints_for_indexer_parameters = true,
                    dotnet_enable_inlay_hints_for_literal_parameters = true,
                    dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                    dotnet_enable_inlay_hints_for_other_parameters = true,
                    dotnet_enable_inlay_hints_for_parameters = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                },
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                },
            },
        })

        vim.lsp.enable("roslyn")
    end,
    init = function()
        -- Add Razor file types before the plugin loads
        vim.filetype.add({
            extension = {
                razor = "razor",
                cshtml = "razor",
            },
        })
    end,
}
