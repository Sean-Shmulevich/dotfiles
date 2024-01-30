-- local config = {
--     cmd = {

--         -- 💀
--         '/Library/Java/JavaVirtualMachines/openjdk-17.jd/Contents/Home/bin/java', -- or '/path/to/java17_or_newer/bin/java'
--         -- depends on if `java` is in your $PATH env variable and if it points to the right version.

--         '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--         '-Dosgi.bundles.defaultStartLevel=4',
--         '-Declipse.product=org.eclipse.jdt.ls.core.product',
--         '-Dlog.protocol=true',
--         '-Dlog.level=ALL',
--         '-Xmx1g',
--         '--add-modules=ALL-SYSTEM',
--         '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--         '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

--         -- 💀
--         '-jar', '/Users/shmul/jdt-language-server-1.31.0-202401111522/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
--         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--         -- Must point to the                                                     Change this to
--         -- eclipse.jdt.ls installation                                           the actual version


--         -- 💀
--         '-configuration', '/Users/shmul/jdt-language-server-1.31.0-202401111522/config_mac_arm',
--         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--         -- Must point to the                      Change to one of `linux`, `win` or `mac`
--         -- eclipse.jdt.ls installation            Depending on your system.


--         -- 💀
--         -- See `data directory configuration` section in the README
--         '-data', '/Users/shmul/data'
--     },
--     settings = {
--         java = {
--             configuration = {
--                 -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--                     -- And search for `interface RuntimeOption`
--                     -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
--                     runtimes = {
--                         {
--                             name = "JavaSE-11",
--                             path = "/Library/Java/JavaVirtualMachines/temurin-11.jdk",
--                         },
--                         {
--                             name = "JavaSE-17",
--                             path = "/Library/Java/JavaVirtualMachines/openjdk-17.jd",
--                         },
--                     }
--             }
--         }
--     },

--     root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
-- }

-- require('jdtls').start_or_attach(config)

