// The programm:
public static int main (string[] args) {
	if (args.length != 2) {
		stdout.printf ("Usage: %s PLUGIN-PATH\n", args[0]);
		return 0;
	}

	try {
		ModuleLoader loader = new ModuleLoader ();
		IModuleInterface plugin = loader.load (args[1]);
		plugin.activated ();
	} catch (ModuleError e) {
		stdout.printf ("Error: %s\n", e.message);
	}
	return 0;
}
