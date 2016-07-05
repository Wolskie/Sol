public class ModuleLoader : Object {
	[CCode (has_target = false)]
	private delegate Type RegisterPluginFunction (Module module);

	private IModuleInterface[] plugins = new IModuleInterface[0];
	private ModuleInfo[] infos = new ModuleInfo[0];

	public IModuleInterface load (string path) throws ModuleError {
		if (Module.supported () == false) {
			throw new ModuleError.NOT_SUPPORTED ("Plugins are not supported");
		}

		Module module = Module.open (path, ModuleFlags.BIND_LAZY);
		if (module == null) {
			throw new ModuleError.FAILED (Module.error ());
		}

        void* function;
        module.symbol ("register_plugin", out function);
		if (function == null) {
			throw new ModuleError.NO_REGISTRATION_FUNCTION ("register_plugin () not found");
		}

        RegisterPluginFunction register_plugin = (RegisterPluginFunction) function;
		Type type = register_plugin (module);
		if (type.is_a (typeof (IModuleInterface)) == false) {
			throw new ModuleError.UNEXPECTED_TYPE ("Unexpected type");
		}

		ModuleInfo info = new ModuleInfo (type, (owned) module);
		infos += info;

		IModuleInterface plugin = (IModuleInterface) Object.new (type);
		plugins += plugin;
		plugin.registered (this);

		return plugin;
	}

	// ...
}
