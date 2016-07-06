SOL_MODULE = OpenStruct.new({
    compiler: "valac",
    output: "-o dist/lib/libmodule" + LIB_EXT,
    deps: [
        "--pkg=gmodule-2.0"
    ],
    cflags: [
        "-I./dist/include",
        "-L./dist/lib",
        "-ldispatch",
        "--shared",
        "-fPIC",
        "-Wall"
    ],
    vflags: [
        "-H dist/include/libmodule.h",
        "--library=dist/vapi/libmodule"
    ],
    sources: [
        "dist/vapi/libdispatch.vapi",
        "src/sol-core/sol-module.vala",
        "src/sol-core/sol-moduleinfo.vala",
        "src/sol-core/sol-moduleloader.vala",
        "src/sol-core/sol-moduleerror.vala"
    ]
})

SOL_DISPATCHER = OpenStruct.new({
    compiler: "valac",
    output: "-o dist/lib/libdispatch" + LIB_EXT,
    deps: [
        "--pkg=gmodule-2.0"
    ],
    cflags: [
        "--shared",
        "-Wall",
        "-fPIC"
    ],
    vflags: [
        "-H dist/include/libdispatch.h",
        "--library=dist/vapi/libdispatch"
    ],
    sources: [
        "src/sol-core/sol-dispatcher.vala",
    ]
})

SOL_CORE = OpenStruct.new({
    compiler: "valac",
    output: "-o dist/bin/Sol" + BIN_EXT,
    deps:    [ "--pkg=gmodule-2.0" ],
    cflags:  [
        "-Wall",
        "-I./dist/include",
        "-L./dist/lib",
        "-lmodule",
        "-ldispatch"
    ],
    vflags:   [
        "--vapidir=dist/vapi/",
        "--includedir=dist/include"
    ],
    sources: [
        "dist/vapi/libdispatch.vapi",
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

desc "Build Sol dispatcher"
task :sol_dispatcher do
    sh  "#{SOL_DISPATCHER.compiler      } " +
        "#{SOL_DISPATCHER.output        } " +
        "#{flags(SOL_DISPATCHER.deps)   } " +
        "#{flags(SOL_DISPATCHER.vflags) } " +
        "#{flags(SOL_DISPATCHER.sources)} " +
        "#{cflags(SOL_DISPATCHER.cflags)} "

end

desc "build Sol core application"
task :sol_core => ["sol_dispatcher", "sol_modules"] do
    sh  "#{SOL_CORE.compiler      } " +
        "#{SOL_CORE.output        } " +
        "#{flags(SOL_CORE.deps)   } " +
        "#{flags(SOL_CORE.vflags) } " +
        "#{flags(SOL_CORE.sources)} " +
        "#{cflags(SOL_CORE.cflags)} "
end


#valac -o dist/bin/Sol.exe --pkg=gmodule-2.0 --vapidir=dist/vapi/ --includedir=dist/include dist/vapi/libmodule.vapi src/sol-core/sol-main.vala --Xcc="-I dist/include" --Xcc="-L dist/lib" --Xcc="-l libmodule.dll"
