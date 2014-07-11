
namespace Peasy
{

public interface Greeter : GLib.Object {

    public abstract void greet();
}

public class CGreeter : GLib.Object, Greeter {

    /**
     * Print test
     */
    public virtual void greet()
    {
        stdout.printf("Hello World\n");
    }
}

}
