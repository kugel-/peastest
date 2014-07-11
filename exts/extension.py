import gi

from gi.repository import GObject
from gi.repository import Peas

class PythonHelloPlugin2(GObject.Object, Peas.Geany):
    __gtype_name__ = 'PythonHelloPlugin2'

    #~ object = GObject.property(type=GObject.Object)

    def do_init(self, data):
        print("PythonHelloPlugin.do_activate\n")

    def do_version_check(self, abi):
        return 218

    def do_configure(self):
        pass

    def do_configure_single(self, widget):
        pass

    def do_help(self):
        pass

    def do_cleanup(self):
        pass

    def do_provides_method(self, which):
        return False


class PythonHelloPlugin(GObject.Object, Peas.Activatable):
    __gtype_name__ = 'PythonHelloPlugin'

    object = GObject.property(type=GObject.Object)

    def do_activate(self):
        print("activate")

    def do_deactivate(self):
        print("deactivate")

    def do_update_state(self):
        print("update_state")


#~ if __name__ == "__main__":
	#~ print ("hi")
	#~ print (gi.repository)
#	print (gi.repository)
	#~ c = PyGreeter()
	#~ c.greet()
#	c.greet

def __init__():
    print("foo")
