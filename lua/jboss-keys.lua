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

function run_quarkus_dev(debug)
  vim.cmd('term ' .. mvn_quarkus_dev())
end

vim.keymap.set("n", "<F9>", function() run_quarkus_dev(true) end)

