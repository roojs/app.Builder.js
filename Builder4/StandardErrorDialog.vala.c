/* StandardErrorDialog.vala.c generated by valac 0.20.1, the Vala compiler
 * generated from StandardErrorDialog.vala, do not modify */

/* -- to compile
valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0 --pkg libnotify --pkg gtksourceview-3.0  --pkg  libwnck-3.0 \
    /tmp/StandardErrorDialog.vala  -o /tmp/StandardErrorDialog
*/
/* -- to test class
static int main (string[] args) {
    Gtk.init (ref args);
    new Xcls_StandardErrorDialog();
    StandardErrorDialog.show_all();
     Gtk.main ();
    return 0;
}
*/

#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>
#include <gdk/gdk.h>
#include <stdlib.h>
#include <string.h>
#include <gobject/gvaluecollector.h>


#define TYPE_XCLS_STANDARDERRORDIALOG (xcls_standarderrordialog_get_type ())
#define XCLS_STANDARDERRORDIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), TYPE_XCLS_STANDARDERRORDIALOG, Xcls_StandardErrorDialog))
#define XCLS_STANDARDERRORDIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TYPE_XCLS_STANDARDERRORDIALOG, Xcls_StandardErrorDialogClass))
#define IS_XCLS_STANDARDERRORDIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TYPE_XCLS_STANDARDERRORDIALOG))
#define IS_XCLS_STANDARDERRORDIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TYPE_XCLS_STANDARDERRORDIALOG))
#define XCLS_STANDARDERRORDIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TYPE_XCLS_STANDARDERRORDIALOG, Xcls_StandardErrorDialogClass))

typedef struct _Xcls_StandardErrorDialog Xcls_StandardErrorDialog;
typedef struct _Xcls_StandardErrorDialogClass Xcls_StandardErrorDialogClass;
typedef struct _Xcls_StandardErrorDialogPrivate Xcls_StandardErrorDialogPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _xcls_standarderrordialog_unref0(var) ((var == NULL) ? NULL : (var = (xcls_standarderrordialog_unref (var), NULL)))
typedef struct _ParamSpecXcls_StandardErrorDialog ParamSpecXcls_StandardErrorDialog;

struct _Xcls_StandardErrorDialog {
	GTypeInstance parent_instance;
	volatile int ref_count;
	Xcls_StandardErrorDialogPrivate * priv;
	GtkMessageDialog* el;
};

struct _Xcls_StandardErrorDialogClass {
	GTypeClass parent_class;
	void (*finalize) (Xcls_StandardErrorDialog *self);
};

struct _ParamSpecXcls_StandardErrorDialog {
	GParamSpec parent_instance;
};


extern Xcls_StandardErrorDialog* StandardErrorDialog;
Xcls_StandardErrorDialog* StandardErrorDialog = NULL;
static gpointer xcls_standarderrordialog_parent_class = NULL;
static Xcls_StandardErrorDialog* xcls_standarderrordialog__this;
static Xcls_StandardErrorDialog* xcls_standarderrordialog__this = NULL;

gpointer xcls_standarderrordialog_ref (gpointer instance);
void xcls_standarderrordialog_unref (gpointer instance);
GParamSpec* param_spec_xcls_standarderrordialog (const gchar* name, const gchar* nick, const gchar* blurb, GType object_type, GParamFlags flags);
void value_set_xcls_standarderrordialog (GValue* value, gpointer v_object);
void value_take_xcls_standarderrordialog (GValue* value, gpointer v_object);
gpointer value_get_xcls_standarderrordialog (const GValue* value);
GType xcls_standarderrordialog_get_type (void) G_GNUC_CONST;
enum  {
	XCLS_STANDARDERRORDIALOG_DUMMY_PROPERTY
};
Xcls_StandardErrorDialog* xcls_standarderrordialog_new (void);
Xcls_StandardErrorDialog* xcls_standarderrordialog_construct (GType object_type);
static gboolean __lambda17_ (Xcls_StandardErrorDialog* self, GtkWidget* _self_, GdkEventAny* event);
static gboolean ___lambda17__gtk_widget_delete_event (GtkWidget* _sender, GdkEventAny* event, gpointer self);
static void __lambda18_ (Xcls_StandardErrorDialog* self, GtkDialog* _self_, gint response_id);
static void ___lambda18__gtk_dialog_response (GtkDialog* _sender, gint response_id, gpointer self);
void xcls_standarderrordialog_show (Xcls_StandardErrorDialog* self, const gchar* msg);
void xcls_standarderrordialog_show_all (Xcls_StandardErrorDialog* self);
static void xcls_standarderrordialog_finalize (Xcls_StandardErrorDialog* obj);


static gpointer _xcls_standarderrordialog_ref0 (gpointer self) {
#line 32 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return self ? xcls_standarderrordialog_ref (self) : NULL;
#line 89 "StandardErrorDialog.vala.c"
}


static gboolean __lambda17_ (Xcls_StandardErrorDialog* self, GtkWidget* _self_, GdkEventAny* event) {
	gboolean result = FALSE;
	GtkMessageDialog* _tmp0_;
#line 42 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_val_if_fail (_self_ != NULL, FALSE);
#line 42 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_val_if_fail (event != NULL, FALSE);
#line 43 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp0_ = self->el;
#line 43 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	gtk_widget_hide ((GtkWidget*) _tmp0_);
#line 44 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	result = TRUE;
#line 44 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return result;
#line 108 "StandardErrorDialog.vala.c"
}


static gboolean ___lambda17__gtk_widget_delete_event (GtkWidget* _sender, GdkEventAny* event, gpointer self) {
	gboolean result;
	result = __lambda17_ (self, _sender, event);
#line 42 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return result;
#line 117 "StandardErrorDialog.vala.c"
}


static void __lambda18_ (Xcls_StandardErrorDialog* self, GtkDialog* _self_, gint response_id) {
	GtkMessageDialog* _tmp0_;
#line 47 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_if_fail (_self_ != NULL);
#line 48 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp0_ = self->el;
#line 48 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	gtk_widget_hide ((GtkWidget*) _tmp0_);
#line 129 "StandardErrorDialog.vala.c"
}


static void ___lambda18__gtk_dialog_response (GtkDialog* _sender, gint response_id, gpointer self) {
#line 47 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	__lambda18_ (self, _sender, response_id);
#line 136 "StandardErrorDialog.vala.c"
}


Xcls_StandardErrorDialog* xcls_standarderrordialog_construct (GType object_type) {
	Xcls_StandardErrorDialog* self = NULL;
	GtkMessageDialog* _tmp0_;
	Xcls_StandardErrorDialog* _tmp1_;
	Xcls_StandardErrorDialog* _tmp2_;
	GtkMessageDialog* _tmp3_;
	GtkMessageDialog* _tmp4_;
	GtkMessageDialog* _tmp5_;
	GtkMessageDialog* _tmp6_;
#line 29 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	self = (Xcls_StandardErrorDialog*) g_type_create_instance (object_type);
#line 31 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp0_ = (GtkMessageDialog*) gtk_message_dialog_new (NULL, GTK_DIALOG_MODAL, GTK_MESSAGE_ERROR, GTK_BUTTONS_OK, "fixme");
#line 31 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_object_ref_sink (_tmp0_);
#line 31 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_g_object_unref0 (self->el);
#line 31 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	self->el = _tmp0_;
#line 32 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp1_ = _xcls_standarderrordialog_ref0 (self);
#line 32 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_xcls_standarderrordialog_unref0 (xcls_standarderrordialog__this);
#line 32 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	xcls_standarderrordialog__this = _tmp1_;
#line 33 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp2_ = _xcls_standarderrordialog_ref0 (self);
#line 33 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_xcls_standarderrordialog_unref0 (StandardErrorDialog);
#line 33 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	StandardErrorDialog = _tmp2_;
#line 38 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp3_ = self->el;
#line 38 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	gtk_window_set_modal ((GtkWindow*) _tmp3_, TRUE);
#line 39 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp4_ = self->el;
#line 39 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_object_set (_tmp4_, "use-markup", TRUE, NULL);
#line 42 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp5_ = self->el;
#line 42 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_signal_connect ((GtkWidget*) _tmp5_, "delete-event", (GCallback) ___lambda17__gtk_widget_delete_event, self);
#line 47 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp6_ = self->el;
#line 47 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_signal_connect ((GtkDialog*) _tmp6_, "response", (GCallback) ___lambda18__gtk_dialog_response, self);
#line 29 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return self;
#line 189 "StandardErrorDialog.vala.c"
}


Xcls_StandardErrorDialog* xcls_standarderrordialog_new (void) {
#line 29 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return xcls_standarderrordialog_construct (TYPE_XCLS_STANDARDERRORDIALOG);
#line 196 "StandardErrorDialog.vala.c"
}


void xcls_standarderrordialog_show (Xcls_StandardErrorDialog* self, const gchar* msg) {
	GtkMessageDialog* _tmp0_;
	const gchar* _tmp1_;
	GtkMessageDialog* _tmp2_;
#line 67 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_if_fail (self != NULL);
#line 67 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_if_fail (msg != NULL);
#line 69 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp0_ = self->el;
#line 69 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp1_ = msg;
#line 69 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_object_set (_tmp0_, "text", _tmp1_, NULL);
#line 70 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_tmp2_ = self->el;
#line 70 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	gtk_widget_show_all ((GtkWidget*) _tmp2_);
#line 218 "StandardErrorDialog.vala.c"
}


void xcls_standarderrordialog_show_all (Xcls_StandardErrorDialog* self) {
#line 72 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_if_fail (self != NULL);
#line 73 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	xcls_standarderrordialog_show (self, "TEST");
#line 227 "StandardErrorDialog.vala.c"
}


static void value_xcls_standarderrordialog_init (GValue* value) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	value->data[0].v_pointer = NULL;
#line 234 "StandardErrorDialog.vala.c"
}


static void value_xcls_standarderrordialog_free_value (GValue* value) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (value->data[0].v_pointer) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		xcls_standarderrordialog_unref (value->data[0].v_pointer);
#line 243 "StandardErrorDialog.vala.c"
	}
}


static void value_xcls_standarderrordialog_copy_value (const GValue* src_value, GValue* dest_value) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (src_value->data[0].v_pointer) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		dest_value->data[0].v_pointer = xcls_standarderrordialog_ref (src_value->data[0].v_pointer);
#line 253 "StandardErrorDialog.vala.c"
	} else {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		dest_value->data[0].v_pointer = NULL;
#line 257 "StandardErrorDialog.vala.c"
	}
}


static gpointer value_xcls_standarderrordialog_peek_pointer (const GValue* value) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return value->data[0].v_pointer;
#line 265 "StandardErrorDialog.vala.c"
}


static gchar* value_xcls_standarderrordialog_collect_value (GValue* value, guint n_collect_values, GTypeCValue* collect_values, guint collect_flags) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (collect_values[0].v_pointer) {
#line 272 "StandardErrorDialog.vala.c"
		Xcls_StandardErrorDialog* object;
		object = collect_values[0].v_pointer;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		if (object->parent_instance.g_class == NULL) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
			return g_strconcat ("invalid unclassed object pointer for value type `", G_VALUE_TYPE_NAME (value), "'", NULL);
#line 279 "StandardErrorDialog.vala.c"
		} else if (!g_value_type_compatible (G_TYPE_FROM_INSTANCE (object), G_VALUE_TYPE (value))) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
			return g_strconcat ("invalid object type `", g_type_name (G_TYPE_FROM_INSTANCE (object)), "' for value type `", G_VALUE_TYPE_NAME (value), "'", NULL);
#line 283 "StandardErrorDialog.vala.c"
		}
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		value->data[0].v_pointer = xcls_standarderrordialog_ref (object);
#line 287 "StandardErrorDialog.vala.c"
	} else {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		value->data[0].v_pointer = NULL;
#line 291 "StandardErrorDialog.vala.c"
	}
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return NULL;
#line 295 "StandardErrorDialog.vala.c"
}


static gchar* value_xcls_standarderrordialog_lcopy_value (const GValue* value, guint n_collect_values, GTypeCValue* collect_values, guint collect_flags) {
	Xcls_StandardErrorDialog** object_p;
	object_p = collect_values[0].v_pointer;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (!object_p) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		return g_strdup_printf ("value location for `%s' passed as NULL", G_VALUE_TYPE_NAME (value));
#line 306 "StandardErrorDialog.vala.c"
	}
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (!value->data[0].v_pointer) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		*object_p = NULL;
#line 312 "StandardErrorDialog.vala.c"
	} else if (collect_flags & G_VALUE_NOCOPY_CONTENTS) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		*object_p = value->data[0].v_pointer;
#line 316 "StandardErrorDialog.vala.c"
	} else {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		*object_p = xcls_standarderrordialog_ref (value->data[0].v_pointer);
#line 320 "StandardErrorDialog.vala.c"
	}
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return NULL;
#line 324 "StandardErrorDialog.vala.c"
}


GParamSpec* param_spec_xcls_standarderrordialog (const gchar* name, const gchar* nick, const gchar* blurb, GType object_type, GParamFlags flags) {
	ParamSpecXcls_StandardErrorDialog* spec;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_val_if_fail (g_type_is_a (object_type, TYPE_XCLS_STANDARDERRORDIALOG), NULL);
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	spec = g_param_spec_internal (G_TYPE_PARAM_OBJECT, name, nick, blurb, flags);
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	G_PARAM_SPEC (spec)->value_type = object_type;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return G_PARAM_SPEC (spec);
#line 338 "StandardErrorDialog.vala.c"
}


gpointer value_get_xcls_standarderrordialog (const GValue* value) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_val_if_fail (G_TYPE_CHECK_VALUE_TYPE (value, TYPE_XCLS_STANDARDERRORDIALOG), NULL);
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return value->data[0].v_pointer;
#line 347 "StandardErrorDialog.vala.c"
}


void value_set_xcls_standarderrordialog (GValue* value, gpointer v_object) {
	Xcls_StandardErrorDialog* old;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_if_fail (G_TYPE_CHECK_VALUE_TYPE (value, TYPE_XCLS_STANDARDERRORDIALOG));
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	old = value->data[0].v_pointer;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (v_object) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		g_return_if_fail (G_TYPE_CHECK_INSTANCE_TYPE (v_object, TYPE_XCLS_STANDARDERRORDIALOG));
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		g_return_if_fail (g_value_type_compatible (G_TYPE_FROM_INSTANCE (v_object), G_VALUE_TYPE (value)));
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		value->data[0].v_pointer = v_object;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		xcls_standarderrordialog_ref (value->data[0].v_pointer);
#line 367 "StandardErrorDialog.vala.c"
	} else {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		value->data[0].v_pointer = NULL;
#line 371 "StandardErrorDialog.vala.c"
	}
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (old) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		xcls_standarderrordialog_unref (old);
#line 377 "StandardErrorDialog.vala.c"
	}
}


void value_take_xcls_standarderrordialog (GValue* value, gpointer v_object) {
	Xcls_StandardErrorDialog* old;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_return_if_fail (G_TYPE_CHECK_VALUE_TYPE (value, TYPE_XCLS_STANDARDERRORDIALOG));
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	old = value->data[0].v_pointer;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (v_object) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		g_return_if_fail (G_TYPE_CHECK_INSTANCE_TYPE (v_object, TYPE_XCLS_STANDARDERRORDIALOG));
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		g_return_if_fail (g_value_type_compatible (G_TYPE_FROM_INSTANCE (v_object), G_VALUE_TYPE (value)));
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		value->data[0].v_pointer = v_object;
#line 396 "StandardErrorDialog.vala.c"
	} else {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		value->data[0].v_pointer = NULL;
#line 400 "StandardErrorDialog.vala.c"
	}
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (old) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		xcls_standarderrordialog_unref (old);
#line 406 "StandardErrorDialog.vala.c"
	}
}


static void xcls_standarderrordialog_class_init (Xcls_StandardErrorDialogClass * klass) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	xcls_standarderrordialog_parent_class = g_type_class_peek_parent (klass);
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	XCLS_STANDARDERRORDIALOG_CLASS (klass)->finalize = xcls_standarderrordialog_finalize;
#line 416 "StandardErrorDialog.vala.c"
}


static void xcls_standarderrordialog_instance_init (Xcls_StandardErrorDialog * self) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	self->ref_count = 1;
#line 423 "StandardErrorDialog.vala.c"
}


static void xcls_standarderrordialog_finalize (Xcls_StandardErrorDialog* obj) {
	Xcls_StandardErrorDialog * self;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, TYPE_XCLS_STANDARDERRORDIALOG, Xcls_StandardErrorDialog);
#line 22 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	_g_object_unref0 (self->el);
#line 433 "StandardErrorDialog.vala.c"
}


GType xcls_standarderrordialog_get_type (void) {
	static volatile gsize xcls_standarderrordialog_type_id__volatile = 0;
	if (g_once_init_enter (&xcls_standarderrordialog_type_id__volatile)) {
		static const GTypeValueTable g_define_type_value_table = { value_xcls_standarderrordialog_init, value_xcls_standarderrordialog_free_value, value_xcls_standarderrordialog_copy_value, value_xcls_standarderrordialog_peek_pointer, "p", value_xcls_standarderrordialog_collect_value, "p", value_xcls_standarderrordialog_lcopy_value };
		static const GTypeInfo g_define_type_info = { sizeof (Xcls_StandardErrorDialogClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) xcls_standarderrordialog_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (Xcls_StandardErrorDialog), 0, (GInstanceInitFunc) xcls_standarderrordialog_instance_init, &g_define_type_value_table };
		static const GTypeFundamentalInfo g_define_type_fundamental_info = { (G_TYPE_FLAG_CLASSED | G_TYPE_FLAG_INSTANTIATABLE | G_TYPE_FLAG_DERIVABLE | G_TYPE_FLAG_DEEP_DERIVABLE) };
		GType xcls_standarderrordialog_type_id;
		xcls_standarderrordialog_type_id = g_type_register_fundamental (g_type_fundamental_next (), "Xcls_StandardErrorDialog", &g_define_type_info, &g_define_type_fundamental_info, 0);
		g_once_init_leave (&xcls_standarderrordialog_type_id__volatile, xcls_standarderrordialog_type_id);
	}
	return xcls_standarderrordialog_type_id__volatile;
}


gpointer xcls_standarderrordialog_ref (gpointer instance) {
	Xcls_StandardErrorDialog* self;
	self = instance;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	g_atomic_int_inc (&self->ref_count);
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	return instance;
#line 458 "StandardErrorDialog.vala.c"
}


void xcls_standarderrordialog_unref (gpointer instance) {
	Xcls_StandardErrorDialog* self;
	self = instance;
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
	if (g_atomic_int_dec_and_test (&self->ref_count)) {
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		XCLS_STANDARDERRORDIALOG_GET_CLASS (self)->finalize (self);
#line 20 "/home/alan/gitlive/app.Builder.js/Builder4/StandardErrorDialog.vala"
		g_type_free_instance ((GTypeInstance *) self);
#line 471 "StandardErrorDialog.vala.c"
	}
}



