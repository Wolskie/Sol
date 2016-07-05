// The plugin:
private class MyPlugin : Object, IModuleInterface {
	public void registered (ModuleLoader loader) {
    	stdout.puts ("loaded\n");
	}

    public void activated () {
    	stdout.puts ("activate\n");
    }

    public void deactivated () {
    	stdout.puts ("deactivated\n");
    }
}

public Type register_plugin (Module module) {
    return typeof (MyPlugin);
}
