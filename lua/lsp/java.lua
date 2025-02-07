local home = os.getenv('HOME')
local jdtls = require('jdtls')
local root_markers = {'gradlew', 'pom.xml','mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home .. "/.local/share/nvim-java/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local remap = require("me.util").remap
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = 'auto' })
  jdtls.setup.add_commands()

  -- Default keymaps
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  require("lsp.defaults").on_attach(client, bufnr)

  -- Java extensions
  remap("n", "<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  remap("n", "<leader>vc", jdtls.test_class, bufopts, "Test class (DAP)")
  remap("n", "<leader>vm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
  remap("n", "<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  remap("n", "<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  remap("v", "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], bufopts, "Extract method")
end

function get_libs()
    local jars_lookup_dir = vim.fn.getenv("JDTLS_JARS_LOOKUP_DIR")
    if jars_lookup_dir == vim.NIL  then
       return {}
    else
       return vim.split(vim.fn.globpath(jars_lookup_dir, '/**/*.jar'), "\n")
    end
end

local bundles = {
  vim.fn.glob(home .. '/.local/share/nvim-java/projects/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
  home .. '/.local/share/nvim-java/projects/dg-jdt-ls-decompiler/dg.jdt.ls.decompiler.cfr-0.0.3.jar',
  home .. '/.local/share/nvim-java/projects/dg-jdt-ls-decompiler/dg.jdt.ls.decompiler.common-0.0.3.jar',
  home .. '/.local/share/nvim-java/projects/dg-jdt-ls-decompiler/dg.jdt.ls.decompiler.fernflower-0.0.3.jar',
  home .. '/.local/share/nvim-java/projects/dg-jdt-ls-decompiler/dg.jdt.ls.decompiler.procyon-0.0.3.jar',
}
--vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/nvim-java/projects/vscode-java-test/server/*.jar'), "\n"))

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    bundles = bundles
  },
  root_dir = root_dir,
  settings = {
    java = {
      format = {
        settings = {
          url = "/.local/share/nvim-java/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      eclipse = {
          downloadSources = true,
      },
      maven = {
          downloadSources = true,
      },
      implementationsCodeLens = {
          enabled = true,
      },
      referencesCodeLens = {
          enabled = true,
      },
      references = {
          includeDecompiledSources = true,
      },
      inlayHints = {
          parameterNames = {
              enabled = "all",
          },
      },
      contentProvider = {
          preferred = 'fernflower'
      },
      project = {
        referencedLibraries = get_libs() ,
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk",
          },
          {
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-1.8.0-openjdk"
          },
        }
      }
    },
    signatureHelp = { enabled = true },
    extendedClientCapabilities = extendedClientCapabilities,
  },
  cmd = {
    "/usr/lib/jvm/java-17-openjdk/bin/java",
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Dhttp.proxyHost=172.19.0.3',
    '-Dhttp.proxyPort=8080',
    '-Dhttps.proxyHost=172.19.0.3',
    '-Dhttps.proxyPort=8080',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim-java/eclipse/lombok.jar',
    '-jar',  home .. '/.local/share/nvim-java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', home .. '/.local/share/nvim-java/jdtls/config_linux',
    '-data', workspace_folder,
  },
}

local M = {}
function M.make_jdtls_config()
  return config
end


function get_libs()
   return {}
end
return M
