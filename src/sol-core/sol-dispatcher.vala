public class DispatcherThread : Object {
	private Dispatcher master;
	private int count = 0;

	public DispatcherThread (Dispatcher m) {
		this.master = m;
	}

	public void* run() {
		while(true) {
			this.count++;
			stdout.printf("%s: %i\n", "t", this.count);
			master.yar("we got incoming yarr!");
			Thread.usleep (Random.int_range (0, 2000000));
		}
	}

}
public class Dispatcher : GLib.Object {
	
	public signal void yar(string msg);

	public Dispatcher() {
	}

	public void start() {
	  var th = new DispatcherThread(this);
	  unowned Thread<void*> t = Thread.create<void*> (th.run, true);
	  t.join();
	}
}
