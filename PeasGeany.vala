using Gtk;

namespace Peas {

    [CCode (cheader_filename = "peas-geany.h")]
    public struct GeanyData {
        public void *info;
        public void *priv;
    }
    [CCode (cheader_filename = "peas-geany.h")]
    public interface Geany : GLib.Object
    {
        public abstract int         version_check    (int abi_ver);
        public abstract void        init             (Peas.GeanyData ?data);
        public abstract bool        provides_method  (int which);
        public abstract Gtk.Widget  configure        (Gtk.Dialog dialog);
        public abstract void        help             ();
        public abstract void        cleanup          ();
    }
}
