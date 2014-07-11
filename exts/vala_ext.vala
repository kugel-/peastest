
using Peasy;

public class ExtGreeter : GLib.Object, Greeter {

    /**
     * Print test
     */
    public virtual void greet()
    {
        stdout.printf("Hello World from Vala extension\n");
    }
}

namespace Peas {
    void register_types(ObjectModule module) {
        module.register_extension_type(typeof(Peasy.Greeter), typeof(ExtGreeter));
    }
}
