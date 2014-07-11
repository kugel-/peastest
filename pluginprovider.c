
#include <glib.h>
#include <peas-plugin-info-priv.h>

struct GeanyPluginInfo
{
    /* The name of the plugin. */
    const gchar	*name;
    /* The description of the plugin. */
    const gchar	*description;
    /* The version of the plugin. */
    const gchar	*version;
    /* The author of the plugin. */
    const gchar	*author;
};

gboolean
peasy_plugin_info(PeasPluginInfo *info,
                  const char *filename,
                  const gchar *module_dir,
                  const gchar *data_dir,
                  gpointer user_data)
{
    GModule *module;
    const gchar *module_name;

    struct GeanyPluginInfo _info;
    void (*set_info)(struct GeanyPluginInfo *info);

    /* BIND_LAZY here since all we care about is plugin_set_info() because
    * this function is really just about filling PeasPluginInfo.
    * The rest of plugin is loaded by the legacy loader at a later point, and
    * then BIND_LOCAL is more appropriate */
    module = g_module_open(filename, G_MODULE_BIND_LAZY);

    if (module == NULL)
    {
        g_warning ("Bad plugin file: '%s'", filename);
        goto error;
    }

    g_module_symbol(module, "plugin_set_info", (gpointer *)&set_info);

    if (set_info == NULL)
    {
        g_warning ("Bad plugin (description not available): '%s'", filename);
        goto error;
    }

    set_info(&_info);

    if (_info.name == NULL)
    {
        g_warning ("Plugin does not provide 'Name': '%s'", filename);
        goto error;
    }

    module_name = g_utf8_strrchr(filename, -1, '/');
    if (!module_name)
        module_name = filename;
    else
        module_name += 1;

    info->module_name = g_strdup(module_name);
    info->name = g_strdup(_info.name);

    /* The remaining fields are optional */
    if (_info.version)
        info->version = g_strdup (_info.version);

    if (_info.description)
        info->desc = g_strdup (_info.description);

    info->authors = g_new0 (gchar *, 1);
    if (_info.author)
        info->authors[0] = g_strdup (_info.author);

    info->dependencies = g_new0 (gchar *, 1);

    info->loader = g_strdup("geany");

    /* We're done for now */
    g_module_close(module);

    return TRUE;

error:
    if (module != NULL)
        g_module_close(module);
    g_free(info);

    return FALSE;
}

void *peasy_plugin_info_target = NULL;

void peasy_plugin_info_target_destroy_notify(gpointer data) { }
