function mvn_quarkus_dev()
  --local debug_param = ""
  --if debug then
  --  debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  --end

  --local profile_param = ""
  --if profile then
  --  profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  --end
  return 'mvn compile quarkus:dev'
end


function run_wildfly_deploy_using_current_buffer_file()
  local dir = vim.fn.expand("%:h") -- Get the current file name
  print(dir)
  --local pom = vim.fn.expand("%:p") -- Get the fullpath
  vim.cmd('term ' .. "mvn wildfly:deploy -f"  .. dir .. '/' .. 'pom.xml')
end

function run_wildfly_undeploy_using_current_buffer_file()
  local dir = vim.fn.expand("%:h") -- Get the current file name
  print(dir)
  --local pom = vim.fn.expand("%:p") -- Get the fullpath
  vim.cmd('term ' .. "mvn wildfly:undeploy -f"  .. dir .. '/' .. 'pom.xml')
end

function mvn_compile()
  return 'mvn clean package'
end

function mvn_wildfly_deploy()
  return 'mvn wildfly:deploy'
end

function mvn_compile_wildfly_deploy()
  return 'mvn clean package wildfly:deploy'
end
function run_quarkus_dev(debug)
  vim.cmd('term ' .. mvn_quarkus_dev())
end

function run_compile()
  vim.cmd('term ' .. mvn_compile())
end

function run_wildfly_deploy()
  vim.cmd('term ' .. mvn_wildfly_deploy())
end

function run_compile_wildfly_deploy()
  vim.cmd('term ' .. mvn_compile_wildfly_deploy())
end

function run_mv_depend_tree()
  vim.cmd('term ' .. 'mvn dependency:tree')
end

function attach_to_quarkus_debug()
  local dap = require('dap')
  dap.configurations.java = {
    {
      type = 'java';
      request = 'attach';
      name = "Attach to the process";
      port = '5005';
    },
  }
  dap.continue()
end

function attach_to_jboss_debug()
  local dap = require('dap')
  dap.configurations.java = {
    {
      type = 'java';
      request = 'attach';
      name = "Attach to the process";
      port = '8787';
    },
  }
  dap.continue()
end

vim.keymap.set("n", "<F11>", function() run_compile() end)
vim.keymap.set("n", "<F12>", function() run_wildfly_deploy() end)
vim.keymap.set("n", "<leader>rmd", function() run_wildfly_deploy_using_current_buffer_file() end)
vim.keymap.set("n", "<leader>rmu", function() run_wildfly_undeploy_using_current_buffer_file() end)
vim.keymap.set("n", "<leader>rmt", function() run_mv_depend_tree() end)

-- attach
vim.keymap.set("n", "<leader>daq", ':lua attach_to_quarkus_debug()<CR>')
vim.keymap.set("n", "<leader>daj", ':lua attach_to_jboss_debug()<CR>')
