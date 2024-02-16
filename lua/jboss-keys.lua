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

function mvn_compile()
  return 'mvn clean package'
end

function mvn_wildfly_deploy()
  return 'mvn wildfy:deploy'
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

vim.keymap.set("n", "<F9>", function() run_compile() end)
vim.keymap.set("n", "<F10>", function() run_wildfly_deploy() end)
vim.keymap.set("n", "<F11>", function() run_compile_wildfly_deploy() end)

vim.keymap.set("n", "<leader>daq", ':lua attach_to_quarkus_debug()<CR>')
vim.keymap.set("n", "<leader>dab", ':lua attach_to_jboss_debug()<CR>')
