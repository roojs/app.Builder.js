/* Palete.vala.c generated by valac 0.24.0, the Vala compiler
 * generated from Palete.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <gee.h>
#include <stdlib.h>
#include <string.h>


#define PALETE_TYPE_PALETE (palete_palete_get_type ())
#define PALETE_PALETE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), PALETE_TYPE_PALETE, PaletePalete))
#define PALETE_PALETE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PALETE_TYPE_PALETE, PaletePaleteClass))
#define PALETE_IS_PALETE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), PALETE_TYPE_PALETE))
#define PALETE_IS_PALETE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PALETE_TYPE_PALETE))
#define PALETE_PALETE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PALETE_TYPE_PALETE, PaletePaleteClass))

typedef struct _PaletePalete PaletePalete;
typedef struct _PaletePaleteClass PaletePaleteClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define PALETE_TYPE_GTK (palete_gtk_get_type ())
#define PALETE_GTK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), PALETE_TYPE_GTK, PaleteGtk))
#define PALETE_GTK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PALETE_TYPE_GTK, PaleteGtkClass))
#define PALETE_IS_GTK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), PALETE_TYPE_GTK))
#define PALETE_IS_GTK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PALETE_TYPE_GTK))
#define PALETE_GTK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PALETE_TYPE_GTK, PaleteGtkClass))

typedef struct _PaleteGtk PaleteGtk;
typedef struct _PaleteGtkClass PaleteGtkClass;
typedef struct _PaletePaletePrivate PaletePaletePrivate;
#define _g_free0(var) (var = (g_free (var), NULL))

#define JS_RENDER_TYPE_NODE (js_render_node_get_type ())
#define JS_RENDER_NODE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), JS_RENDER_TYPE_NODE, JsRenderNode))
#define JS_RENDER_NODE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), JS_RENDER_TYPE_NODE, JsRenderNodeClass))
#define JS_RENDER_IS_NODE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), JS_RENDER_TYPE_NODE))
#define JS_RENDER_IS_NODE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), JS_RENDER_TYPE_NODE))
#define JS_RENDER_NODE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), JS_RENDER_TYPE_NODE, JsRenderNodeClass))

typedef struct _JsRenderNode JsRenderNode;
typedef struct _JsRenderNodeClass JsRenderNodeClass;

typedef enum  {
	PALETE_ERROR_INVALID_TYPE,
	PALETE_ERROR_NEED_IMPLEMENTING
} PaleteError;
#define PALETE_ERROR palete_error_quark ()
struct _PaletePalete {
	GObject parent_instance;
	PaletePaletePrivate * priv;
	gchar* name;
};

struct _PaletePaleteClass {
	GObjectClass parent_class;
};


extern GeeHashMap* palete_cache;
GeeHashMap* palete_cache = NULL;
static gpointer palete_palete_parent_class = NULL;

GQuark palete_error_quark (void);
GType palete_palete_get_type (void) G_GNUC_CONST;
PaletePalete* palete_factory (const gchar* xtype);
PaleteGtk* palete_gtk_new (void);
PaleteGtk* palete_gtk_construct (GType object_type);
GType palete_gtk_get_type (void) G_GNUC_CONST;
enum  {
	PALETE_PALETE_DUMMY_PROPERTY
};
PaletePalete* palete_palete_new (void);
PaletePalete* palete_palete_construct (GType object_type);
gpointer js_render_node_ref (gpointer instance);
void js_render_node_unref (gpointer instance);
GParamSpec* js_render_param_spec_node (const gchar* name, const gchar* nick, const gchar* blurb, GType object_type, GParamFlags flags);
void js_render_value_set_node (GValue* value, gpointer v_object);
void js_render_value_take_node (GValue* value, gpointer v_object);
gpointer js_render_value_get_node (const GValue* value);
GType js_render_node_get_type (void) G_GNUC_CONST;
static gchar* palete_palete_guessName (PaletePalete* self, JsRenderNode* ar, GError** error);
static void palete_palete_finalize (GObject* obj);


GQuark palete_error_quark (void) {
	return g_quark_from_static_string ("palete_error-quark");
}


PaletePalete* palete_factory (const gchar* xtype) {
	PaletePalete* result = NULL;
	GeeHashMap* _tmp0_ = NULL;
	GeeHashMap* _tmp2_ = NULL;
	const gchar* _tmp3_ = NULL;
	gpointer _tmp4_ = NULL;
	PaletePalete* _tmp5_ = NULL;
	gboolean _tmp6_ = FALSE;
	const gchar* _tmp10_ = NULL;
	const gchar* _tmp11_ = NULL;
	GQuark _tmp13_ = 0U;
	static GQuark _tmp12_label0 = 0;
	GeeHashMap* _tmp19_ = NULL;
	const gchar* _tmp20_ = NULL;
	gpointer _tmp21_ = NULL;
	GError * _inner_error_ = NULL;
	g_return_val_if_fail (xtype != NULL, NULL);
	_tmp0_ = palete_cache;
	if (_tmp0_ == NULL) {
		GeeHashMap* _tmp1_ = NULL;
		_tmp1_ = gee_hash_map_new (G_TYPE_STRING, (GBoxedCopyFunc) g_strdup, g_free, PALETE_TYPE_PALETE, (GBoxedCopyFunc) g_object_ref, g_object_unref, NULL, NULL, NULL);
		_g_object_unref0 (palete_cache);
		palete_cache = _tmp1_;
	}
	_tmp2_ = palete_cache;
	_tmp3_ = xtype;
	_tmp4_ = gee_abstract_map_get ((GeeAbstractMap*) _tmp2_, _tmp3_);
	_tmp5_ = (PaletePalete*) _tmp4_;
	_tmp6_ = _tmp5_ != NULL;
	_g_object_unref0 (_tmp5_);
	if (_tmp6_) {
		GeeHashMap* _tmp7_ = NULL;
		const gchar* _tmp8_ = NULL;
		gpointer _tmp9_ = NULL;
		_tmp7_ = palete_cache;
		_tmp8_ = xtype;
		_tmp9_ = gee_abstract_map_get ((GeeAbstractMap*) _tmp7_, _tmp8_);
		result = (PaletePalete*) _tmp9_;
		return result;
	}
	_tmp10_ = xtype;
	_tmp11_ = _tmp10_;
	_tmp13_ = (NULL == _tmp11_) ? 0 : g_quark_from_string (_tmp11_);
	if (_tmp13_ == ((0 != _tmp12_label0) ? _tmp12_label0 : (_tmp12_label0 = g_quark_from_static_string ("Gtk")))) {
		switch (0) {
			default:
			{
				GeeHashMap* _tmp14_ = NULL;
				const gchar* _tmp15_ = NULL;
				PaleteGtk* _tmp16_ = NULL;
				PaleteGtk* _tmp17_ = NULL;
				_tmp14_ = palete_cache;
				_tmp15_ = xtype;
				_tmp16_ = palete_gtk_new ();
				_tmp17_ = _tmp16_;
				gee_abstract_map_set ((GeeAbstractMap*) _tmp14_, _tmp15_, (PaletePalete*) _tmp17_);
				_g_object_unref0 (_tmp17_);
				break;
				break;
			}
		}
	} else {
		switch (0) {
			default:
			{
				GError* _tmp18_ = NULL;
				_tmp18_ = g_error_new_literal (PALETE_ERROR, PALETE_ERROR_INVALID_TYPE, "invalid argument to Palete factory");
				_inner_error_ = _tmp18_;
				g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
				g_clear_error (&_inner_error_);
				return NULL;
			}
		}
	}
	_tmp19_ = palete_cache;
	_tmp20_ = xtype;
	_tmp21_ = gee_abstract_map_get ((GeeAbstractMap*) _tmp19_, _tmp20_);
	result = (PaletePalete*) _tmp21_;
	return result;
}


PaletePalete* palete_palete_construct (GType object_type) {
	PaletePalete * self = NULL;
	self = (PaletePalete*) g_object_new (object_type, NULL);
	return self;
}


PaletePalete* palete_palete_new (void) {
	return palete_palete_construct (PALETE_TYPE_PALETE);
}


static gchar* palete_palete_guessName (PaletePalete* self, JsRenderNode* ar, GError** error) {
	gchar* result = NULL;
	GError* _tmp0_ = NULL;
	GError * _inner_error_ = NULL;
	g_return_val_if_fail (self != NULL, NULL);
	g_return_val_if_fail (ar != NULL, NULL);
	_tmp0_ = g_error_new_literal (PALETE_ERROR, PALETE_ERROR_NEED_IMPLEMENTING, "xxx. guessName needs implimenting");
	_inner_error_ = _tmp0_;
	if (_inner_error_->domain == PALETE_ERROR) {
		g_propagate_error (error, _inner_error_);
		return NULL;
	} else {
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return NULL;
	}
	return result;
}


static void palete_palete_class_init (PaletePaleteClass * klass) {
	palete_palete_parent_class = g_type_class_peek_parent (klass);
	G_OBJECT_CLASS (klass)->finalize = palete_palete_finalize;
}


static void palete_palete_instance_init (PaletePalete * self) {
}


static void palete_palete_finalize (GObject* obj) {
	PaletePalete * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, PALETE_TYPE_PALETE, PaletePalete);
	_g_free0 (self->name);
	G_OBJECT_CLASS (palete_palete_parent_class)->finalize (obj);
}


GType palete_palete_get_type (void) {
	static volatile gsize palete_palete_type_id__volatile = 0;
	if (g_once_init_enter (&palete_palete_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (PaletePaleteClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) palete_palete_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (PaletePalete), 0, (GInstanceInitFunc) palete_palete_instance_init, NULL };
		GType palete_palete_type_id;
		palete_palete_type_id = g_type_register_static (G_TYPE_OBJECT, "PaletePalete", &g_define_type_info, 0);
		g_once_init_leave (&palete_palete_type_id__volatile, palete_palete_type_id);
	}
	return palete_palete_type_id__volatile;
}



