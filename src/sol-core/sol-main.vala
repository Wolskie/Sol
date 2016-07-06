// The programm:
public static int main (string[] args) {
	if (args.length != 2) {
		stdout.printf ("Usage: %s PLUGIN-PATH\n", args[0]);
		return 0;
	}

	try {
		Dispatcher d = new Dispatcher();
		ModuleLoader loader = new ModuleLoader (d);
		IModuleInterface plugin = loader.load (args[1]);
		plugin.activated ();
		d.start();
	} catch (ModuleError e) {
		stdout.printf ("Error: %s\n", e.message);
	}
	return 0;
}
