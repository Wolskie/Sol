public interface IModuleInterface : Object {
	public abstract void registered (ModuleLoader loader);
    public abstract void activated ();
    public abstract void deactivated ();

	// get_desctiption (), get_name (), ...
}
