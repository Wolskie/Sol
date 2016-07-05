require 'ostruct'

def flags(args)
	args.join(' ')
end
def cflags(args)
	args.map { |a| "--Xcc=\"" + a + "\"" }.join(" ")
end

desc "Build Sol project by running all tasks."
task :build => ["setup", "sol_core", "sol_modules"] do
	puts "Building Sol project."
end

desc "Setup build environment"
task :setup do
	 mkdir_p("dist/") unless Dir.exist?("dist/")
	 mkdir_p("dist/bin") unless Dir.exist?("dist/bin")
	 mkdir_p("dist/lib") unless Dir.exist?("dist/lib")
	 mkdir_p("dist/vapi") unless Dir.exist?("dist/vapi")
	 mkdir_p("dist/include") unless Dir.exist?("dist/include")
end

desc "Remove temporary files."
task :clean do
  rm_rf "dist/" if Dir.exist?("dist/")
  Dir["**/**/*.c", "**/**/*.o", "**/**/*.h", "**/**/*.vapi"].each do |file_name|
	rm_rf file_name 
  end
end


import "src/sol-core/build_task.rake"
#import "src/sol-modules/build_task.rake"