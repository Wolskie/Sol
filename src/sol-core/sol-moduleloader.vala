/**
 * Control module loading.
 */
public class ModuleLoader : Object {
    [CCode (has_target = false)]
    private delegate Type RegisterPluginFunction (Module module);
    public signal void module_registered(ModuleInfo module);

    public Dispatcher m_dispatcher;
    public GenericArray<ModuleInfo> m_modules;
    public GenericArray<IModuleInterface> m_loaded;

    /**
     * Construct.
     */
    public ModuleLoader(Dispatcher dispatcher) {
        m_dispatcher =  dispatcher;
        m_modules = new GenericArray<ModuleInfo>();
        m_loaded = new GenericArray<IModuleInterface>();
    }

    /**
     * Return a list of loaded modules.
     */
    public GenericArray get_loaded_modules() {
        return m_loaded;
    }

    /**
     * Return a list of module information.
     */
    public GenericArray get_module_info() {
        return m_modules;
    }

    /**
     * Load a module specified by _path_.
     *
     * == Paramaters
     *   path::
     *      Path to loadable module.
     *
     * == Returns
     *  IModuleInterface
     */
    public IModuleInterface load (string path) throws ModuleError {

        /* Check if this Vala installation supports modules */
        if (Module.supported () == false) {
            throw new ModuleError.NOT_SUPPORTED ("Plugins are not supported");
        }

        /* Open the module */
        Module module = Module.open (path, ModuleFlags.BIND_LAZY);
        if (module == null) {
            throw new ModuleError.FAILED (Module.error ());
        }

        /* Check if the module impliments the correct signature */
        void* function;
        module.symbol ("register_plugin", out function);
        if (function == null) {
            throw new ModuleError.NO_REGISTRATION_FUNCTION ("register_plugin () not found");
        }

        /* Check if the module impliments IModuleInterface */
        RegisterPluginFunction register_plugin = (RegisterPluginFunction) function;
        Type type = register_plugin (module);
        if (type.is_a (typeof (IModuleInterface)) == false) {
            throw new ModuleError.UNEXPECTED_TYPE ("Unexpected type");
        }

        /* Create new instance of the module and associated information */
        ModuleInfo module_info = new ModuleInfo (type, (owned) module);
        IModuleInterface module_loaded = (IModuleInterface) Object.new (type);

        m_loaded.add(module_loaded);
        m_modules.add(module_info);

        /* Signal to other modules we have loaded */
        module_registered(module_info);
        module_loaded.registered (this, m_dispatcher);

        return module_loaded;
    }

    // ...
}
