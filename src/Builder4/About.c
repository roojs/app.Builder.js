/* About.c generated by valac 0.26.1, the Vala compiler
 * generated from About.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>
#include <stdlib.h>
#include <string.h>
#include <gdk/gdk.h>


#define TYPE_ABOUT (about_get_type ())
#define ABOUT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), TYPE_ABOUT, About))
#define ABOUT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TYPE_ABOUT, AboutClass))
#define IS_ABOUT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TYPE_ABOUT))
#define IS_ABOUT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TYPE_ABOUT))
#define ABOUT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TYPE_ABOUT, AboutClass))

typedef struct _About About;
typedef struct _AboutClass AboutClass;
typedef struct _AboutPrivate AboutPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

struct _About {
	GObject parent_instance;
	AboutPrivate * priv;
	GtkAboutDialog* el;
};

struct _AboutClass {
	GObjectClass parent_class;
};

struct _AboutPrivate {
	About* _this;
};


extern About* _About;
About* _About = NULL;
static gpointer about_parent_class = NULL;

GType about_get_type (void) G_GNUC_CONST;
#define ABOUT_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), TYPE_ABOUT, AboutPrivate))
enum  {
	ABOUT_DUMMY_PROPERTY
};
About* about_singleton (void);
About* about_new (void);
About* about_construct (GType object_type);
static gboolean __lambda138_ (About* self, GtkWidget* _self_, GdkEventAny* event);
static gboolean ___lambda138__gtk_widget_delete_event (GtkWidget* _sender, GdkEventAny* event, gpointer self);
static void __lambda139_ (About* self, gint rid);
static void ___lambda139__gtk_dialog_response (GtkDialog* _sender, gint response_id, gpointer self);
void about_show_all (About* self);
static void about_finalize (GObject* obj);
static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func);
static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func);


static gpointer _g_object_ref0 (gpointer self) {
#line 13 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	return self ? g_object_ref (self) : NULL;
#line 66 "About.c"
}


About* about_singleton (void) {
	About* result = NULL;
	About* _tmp0_ = NULL;
	About* _tmp2_ = NULL;
	About* _tmp3_ = NULL;
#line 10 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp0_ = _About;
#line 10 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	if (_tmp0_ == NULL) {
#line 79 "About.c"
		About* _tmp1_ = NULL;
#line 11 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
		_tmp1_ = about_new ();
#line 11 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
		_g_object_unref0 (_About);
#line 11 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
		_About = _tmp1_;
#line 87 "About.c"
	}
#line 13 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp2_ = _About;
#line 13 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp3_ = _g_object_ref0 (_tmp2_);
#line 13 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	result = _tmp3_;
#line 13 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	return result;
#line 97 "About.c"
}


static gboolean __lambda138_ (About* self, GtkWidget* _self_, GdkEventAny* event) {
	gboolean result = FALSE;
	GtkAboutDialog* _tmp0_ = NULL;
#line 35 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	g_return_val_if_fail (_self_ != NULL, FALSE);
#line 35 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	g_return_val_if_fail (event != NULL, FALSE);
#line 36 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp0_ = self->el;
#line 36 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_widget_hide ((GtkWidget*) _tmp0_);
#line 37 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	result = TRUE;
#line 37 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	return result;
#line 116 "About.c"
}


static gboolean ___lambda138__gtk_widget_delete_event (GtkWidget* _sender, GdkEventAny* event, gpointer self) {
	gboolean result;
	result = __lambda138_ ((About*) self, _sender, event);
#line 35 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	return result;
#line 125 "About.c"
}


static void __lambda139_ (About* self, gint rid) {
	GtkAboutDialog* _tmp0_ = NULL;
#line 41 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp0_ = self->el;
#line 41 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_widget_hide ((GtkWidget*) _tmp0_);
#line 135 "About.c"
}


static void ___lambda139__gtk_dialog_response (GtkDialog* _sender, gint response_id, gpointer self) {
#line 40 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	__lambda139_ ((About*) self, response_id);
#line 142 "About.c"
}


About* about_construct (GType object_type) {
	About * self = NULL;
	About* _tmp0_ = NULL;
	GtkAboutDialog* _tmp1_ = NULL;
	GtkAboutDialog* _tmp2_ = NULL;
	GtkAboutDialog* _tmp3_ = NULL;
	GtkAboutDialog* _tmp4_ = NULL;
	gchar* _tmp5_ = NULL;
	gchar** _tmp6_ = NULL;
	gchar** _tmp7_ = NULL;
	gint _tmp7__length1 = 0;
	GtkAboutDialog* _tmp8_ = NULL;
	GtkAboutDialog* _tmp9_ = NULL;
	GtkAboutDialog* _tmp10_ = NULL;
	GtkAboutDialog* _tmp11_ = NULL;
	GtkAboutDialog* _tmp12_ = NULL;
#line 19 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	self = (About*) g_object_new (object_type, NULL);
#line 21 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp0_ = _g_object_ref0 (self);
#line 21 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_g_object_unref0 (self->priv->_this);
#line 21 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	self->priv->_this = _tmp0_;
#line 22 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp1_ = (GtkAboutDialog*) gtk_about_dialog_new ();
#line 22 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	g_object_ref_sink (_tmp1_);
#line 22 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_g_object_unref0 (self->el);
#line 22 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	self->el = _tmp1_;
#line 27 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp2_ = self->el;
#line 27 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_about_dialog_set_program_name (_tmp2_, "app.Builder.js");
#line 28 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp3_ = self->el;
#line 28 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_about_dialog_set_license (_tmp3_, "LGPL");
#line 29 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp4_ = self->el;
#line 29 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp5_ = g_strdup ("Alan Knowles");
#line 29 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp6_ = g_new0 (gchar*, 1 + 1);
#line 29 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp6_[0] = _tmp5_;
#line 29 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp7_ = _tmp6_;
#line 29 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp7__length1 = 1;
#line 29 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_about_dialog_set_authors (_tmp4_, _tmp7_);
#line 29 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp7_ = (_vala_array_free (_tmp7_, _tmp7__length1, (GDestroyNotify) g_free), NULL);
#line 30 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp8_ = self->el;
#line 30 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_about_dialog_set_website (_tmp8_, "http://www.akbkhome.com/blog.php");
#line 31 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp9_ = self->el;
#line 31 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_window_set_modal ((GtkWindow*) _tmp9_, TRUE);
#line 32 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp10_ = self->el;
#line 32 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_about_dialog_set_copyright (_tmp10_, "LGPL");
#line 35 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp11_ = self->el;
#line 35 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	g_signal_connect_object ((GtkWidget*) _tmp11_, "delete-event", (GCallback) ___lambda138__gtk_widget_delete_event, self, 0);
#line 40 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp12_ = self->el;
#line 40 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	g_signal_connect_object ((GtkDialog*) _tmp12_, "response", (GCallback) ___lambda139__gtk_dialog_response, self, 0);
#line 19 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	return self;
#line 224 "About.c"
}


About* about_new (void) {
#line 19 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	return about_construct (TYPE_ABOUT);
#line 231 "About.c"
}


void about_show_all (About* self) {
	GtkAboutDialog* _tmp0_ = NULL;
#line 46 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	g_return_if_fail (self != NULL);
#line 47 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_tmp0_ = self->el;
#line 47 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	gtk_widget_show_all ((GtkWidget*) _tmp0_);
#line 243 "About.c"
}


static void about_class_init (AboutClass * klass) {
#line 3 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	about_parent_class = g_type_class_peek_parent (klass);
#line 3 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	g_type_class_add_private (klass, sizeof (AboutPrivate));
#line 3 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	G_OBJECT_CLASS (klass)->finalize = about_finalize;
#line 254 "About.c"
}


static void about_instance_init (About * self) {
#line 3 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	self->priv = ABOUT_GET_PRIVATE (self);
#line 261 "About.c"
}


static void about_finalize (GObject* obj) {
	About * self;
#line 3 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, TYPE_ABOUT, About);
#line 5 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_g_object_unref0 (self->el);
#line 6 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	_g_object_unref0 (self->priv->_this);
#line 3 "/home/alan/gitlive/app.Builder.js/src/Builder4/About.vala"
	G_OBJECT_CLASS (about_parent_class)->finalize (obj);
#line 275 "About.c"
}


GType about_get_type (void) {
	static volatile gsize about_type_id__volatile = 0;
	if (g_once_init_enter (&about_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (AboutClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) about_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (About), 0, (GInstanceInitFunc) about_instance_init, NULL };
		GType about_type_id;
		about_type_id = g_type_register_static (G_TYPE_OBJECT, "About", &g_define_type_info, 0);
		g_once_init_leave (&about_type_id__volatile, about_type_id);
	}
	return about_type_id__volatile;
}


static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func) {
#line 5 "/home/alan/gitlive/app.Builder.js/src/JsRender/NodeToGtk.vala"
	if ((array != NULL) && (destroy_func != NULL)) {
#line 294 "About.c"
		int i;
#line 5 "/home/alan/gitlive/app.Builder.js/src/JsRender/NodeToGtk.vala"
		for (i = 0; i < array_length; i = i + 1) {
#line 5 "/home/alan/gitlive/app.Builder.js/src/JsRender/NodeToGtk.vala"
			if (((gpointer*) array)[i] != NULL) {
#line 5 "/home/alan/gitlive/app.Builder.js/src/JsRender/NodeToGtk.vala"
				destroy_func (((gpointer*) array)[i]);
#line 302 "About.c"
			}
		}
	}
}


static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func) {
#line 5 "/home/alan/gitlive/app.Builder.js/src/JsRender/NodeToGtk.vala"
	_vala_array_destroy (array, array_length, destroy_func);
#line 5 "/home/alan/gitlive/app.Builder.js/src/JsRender/NodeToGtk.vala"
	g_free (array);
#line 314 "About.c"
}



