public interface IModuleInterface : Object {

    /* Abstract methods all plugins must impliment */
    public abstract void registered (ModuleLoader loader, Dispatcher dispatcher);
    public abstract void activated ();
    public abstract void deactivated ();
}
