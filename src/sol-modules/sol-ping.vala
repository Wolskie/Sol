// The plugin:
private class PingModule : Object, IModuleInterface {

    private Dispatcher d;

    public void registered (ModuleLoader loader, Dispatcher d) {
        stdout.puts ("PingModule#registered: [ENTRY]\n");

        this.d = d;

        loader.module_registered.connect((module) => {
            stdout.puts ("PingModule#registered: Recieved module_registered signal\n");
        });

        stdout.puts ("PingModule#registered: [EXIT]\n");
    }

    public void activated () {
        d.yar.connect((msg) => {
            stdout.puts ("PingModule#registered: YAR $msg\n");
        });
    }

    public void deactivated () {
        stdout.puts ("deactivated\n");
    }
}

public Type register_plugin (Module module) {
    return typeof (PingModule);
}
