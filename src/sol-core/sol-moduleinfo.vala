private class ModuleInfo : Object {
	public Module module;
	public Type gtype;

	public ModuleInfo (Type type, owned Module module) {
		this.module = (owned) module;
		this.gtype = type;
	}
}