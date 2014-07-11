using Peas;
using PeasGtk;
using Gtk;

namespace Peasy
{
    [CCode (cheader_filename="pluginprovider.h")]
    extern Peas.PluginInfoProvider plugin_info;

class HelloWorld : GLib.Object {

    public static int main(string[] args) {

        Gtk.init (ref args);
        var greeter = new CGreeter();

        greeter.greet();

        var e = Engine.get_default();
        e.install_provider("so", (owned) plugin_info);
        e.enable_loader("python");
        e.enable_loader("geany");
        e.add_search_path("exts", "exts_data");
//~         e.add_search_path("/home/kugel/dev/geany.git/dest/lib/geany", "exts_data");
        unowned List<PluginInfo> list = e.get_plugin_list();
        list.foreach ((entry) => {
            stdout.printf ("%s: %s %d\n", entry.get_name(), entry.get_module_name(), entry.is_available() ? 1:0);
            e.try_load_plugin(entry);
            if (e.provides_extension(entry, typeof(Peas.Activatable)))
            {
                stdout.printf("Provides activatable\n");

                var py = e.create_extension(entry, typeof(Peas.Activatable)) as Peas.Activatable;
                py.activate();
            }
//~             if (e.provides_extension(entry, typeof(Peasy.Greeter)))
//~             {
//~                 stdout.printf("yes\n");

//~                 var py = e.create_extension(entry, typeof(Peasy.Greeter)) as Peasy.Greeter;
//~                 py.greet();
//~             }
//~             if (e.provides_extension(entry, typeof(Peas.Geany)))
//~             {
//~                 stdout.printf("Provides geany\n");
//~                 var py = e.create_extension(entry, typeof(Peas.Geany)) as Peas.Geany;
//~                 py.init(null);
//~                 py.cleanup();
//~             }
        });

        if (args.length < 2 || args[1] != "cli")
        {
            var window = new Window ();
            window.title = "First GTK+ Program";
            window.border_width = 10;
            window.window_position = WindowPosition.CENTER;
            window.set_default_size (350, 70);
            window.destroy.connect (Gtk.main_quit);

            var manager = new PluginManager(e);

            window.add (manager);
            window.show_all ();

            Gtk.main ();
        }
        return 0;
    }
}

}
