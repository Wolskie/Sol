SOL_PING = OpenStruct.new({
	compiler: "valac",
	output: "-o dist/lib/libping.dll",
	deps: [
		"--pkg=gmodule-2.0"
	],
	cflags:  [ 
		"-fPIC",
		"--shared",
		"-I./dist/include",
		"-L./dist/lib",
		"-llibmodule"
	],
	vflags:   [
		"-H dist/include/libping.h",
		"--library=dist/vapi/libping",
		"--vapidir=dist/vapi/",
		"--includedir=dist/include"
	],
	sources: [
		"dist/vapi/libmodule.vapi",
		"src/sol-modules/sol-ping.vala"
	]
})

task :sol_ping => ["sol_modules"] do
	sh  "#{SOL_PING.compiler      } " +
		"#{SOL_PING.output        } " +
		"#{flags(SOL_PING.deps)   } " +
		"#{flags(SOL_PING.vflags) } " +
		"#{flags(SOL_PING.sources)} " +
		"#{cflags(SOL_PING.cflags)} " 
end
