SOL_MODULE = OpenStruct.new({
	compiler: "valac",
	output: "-o dist/lib/libmodule.dll",
	deps: [
		"--pkg=gmodule-2.0"
	],
	cflags: [
		"--shared",
		"-fPIC"
	],
	vflags: [
		"-H dist/include/libmodule.h",
		"--library=dist/vapi/libmodule"
	],
	sources: [
		"src/sol-core/sol-module.vala",
		"src/sol-core/sol-moduleinfo.vala",
		"src/sol-core/sol-moduleloader.vala",
		"src/sol-core/sol-moduleerror.vala"
	]
})

SOL_CORE = OpenStruct.new({
	compiler: "valac",
	output: "-o dist/bin/Sol.exe",
	deps:    [ "--pkg=gmodule-2.0" ],
	cflags:  [ 
		"-I./dist/include",
		"-L./dist/lib",
		"-llibmodule"
	],
	vflags:   [
		"--vapidir=dist/vapi/",
		"--includedir=dist/include"
	],
	sources: [
		"dist/vapi/libmodule.vapi",
		"src/sol-core/sol-main.vala"
	]
})

desc "Build Sol module loader"
task :sol_modules do
	sh  "#{SOL_MODULE.compiler      } " +
		"#{SOL_MODULE.output        } " +
		"#{flags(SOL_MODULE.deps)   } " +
 		"#{flags(SOL_MODULE.vflags) } " +
		"#{flags(SOL_MODULE.sources)} " + 
		"#{cflags(SOL_MODULE.cflags)} "
		
end

task :sol_core => ["sol_modules"] do
	sh  "#{SOL_CORE.compiler      } " +
		"#{SOL_CORE.output        } " +
		"#{flags(SOL_CORE.deps)   } " +
		"#{flags(SOL_CORE.vflags) } " +
		"#{flags(SOL_CORE.sources)} " +
		"#{cflags(SOL_CORE.cflags)} " 
end


#valac -o dist/bin/Sol.exe --pkg=gmodule-2.0 --vapidir=dist/vapi/ --includedir=dist/include dist/vapi/libmodule.vapi src/sol-core/sol-main.vala --Xcc="-I dist/include" --Xcc="-L dist/lib" --Xcc="-l libmodule.dll"