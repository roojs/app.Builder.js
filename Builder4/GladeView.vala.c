/* GladeView.vala.c generated by valac 0.20.1, the Vala compiler
 * generated from GladeView.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <gladeui/glade.h>
#include <stdlib.h>
#include <string.h>
#include <gtk/gtk.h>
#include <gdk/gdk.h>
#include <gdk-pixbuf/gdk-pixbuf.h>
#include <gee.h>
#include <gio/gio.h>


#define TYPE_XCLS_GLADEVIEW (xcls_gladeview_get_type ())
#define XCLS_GLADEVIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), TYPE_XCLS_GLADEVIEW, Xcls_GladeView))
#define XCLS_GLADEVIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TYPE_XCLS_GLADEVIEW, Xcls_GladeViewClass))
#define IS_XCLS_GLADEVIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TYPE_XCLS_GLADEVIEW))
#define IS_XCLS_GLADEVIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TYPE_XCLS_GLADEVIEW))
#define XCLS_GLADEVIEW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TYPE_XCLS_GLADEVIEW, Xcls_GladeViewClass))

typedef struct _Xcls_GladeView Xcls_GladeView;
typedef struct _Xcls_GladeViewClass Xcls_GladeViewClass;
typedef struct _Xcls_GladeViewPrivate Xcls_GladeViewPrivate;

#define JS_RENDER_TYPE_JS_RENDER (js_render_js_render_get_type ())
#define JS_RENDER_JS_RENDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), JS_RENDER_TYPE_JS_RENDER, JsRenderJsRender))
#define JS_RENDER_JS_RENDER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), JS_RENDER_TYPE_JS_RENDER, JsRenderJsRenderClass))
#define JS_RENDER_IS_JS_RENDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), JS_RENDER_TYPE_JS_RENDER))
#define JS_RENDER_IS_JS_RENDER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), JS_RENDER_TYPE_JS_RENDER))
#define JS_RENDER_JS_RENDER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), JS_RENDER_TYPE_JS_RENDER, JsRenderJsRenderClass))

typedef struct _JsRenderJsRender JsRenderJsRender;
typedef struct _JsRenderJsRenderClass JsRenderJsRenderClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))
typedef struct _JsRenderJsRenderPrivate JsRenderJsRenderPrivate;

#define PROJECT_TYPE_PROJECT (project_project_get_type ())
#define PROJECT_PROJECT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), PROJECT_TYPE_PROJECT, ProjectProject))
#define PROJECT_PROJECT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PROJECT_TYPE_PROJECT, ProjectProjectClass))
#define PROJECT_IS_PROJECT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), PROJECT_TYPE_PROJECT))
#define PROJECT_IS_PROJECT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PROJECT_TYPE_PROJECT))
#define PROJECT_PROJECT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PROJECT_TYPE_PROJECT, ProjectProjectClass))

typedef struct _ProjectProject ProjectProject;
typedef struct _ProjectProjectClass ProjectProjectClass;

#define JS_RENDER_TYPE_NODE (js_render_node_get_type ())
#define JS_RENDER_NODE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), JS_RENDER_TYPE_NODE, JsRenderNode))
#define JS_RENDER_NODE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), JS_RENDER_TYPE_NODE, JsRenderNodeClass))
#define JS_RENDER_IS_NODE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), JS_RENDER_TYPE_NODE))
#define JS_RENDER_IS_NODE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), JS_RENDER_TYPE_NODE))
#define JS_RENDER_NODE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), JS_RENDER_TYPE_NODE, JsRenderNodeClass))

typedef struct _JsRenderNode JsRenderNode;
typedef struct _JsRenderNodeClass JsRenderNodeClass;
#define _g_list_free0(var) ((var == NULL) ? NULL : (var = (g_list_free (var), NULL)))

#define JS_RENDER_TYPE_NODE_TO_GLADE (js_render_node_to_glade_get_type ())
#define JS_RENDER_NODE_TO_GLADE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), JS_RENDER_TYPE_NODE_TO_GLADE, JsRenderNodeToGlade))
#define JS_RENDER_NODE_TO_GLADE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), JS_RENDER_TYPE_NODE_TO_GLADE, JsRenderNodeToGladeClass))
#define JS_RENDER_IS_NODE_TO_GLADE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), JS_RENDER_TYPE_NODE_TO_GLADE))
#define JS_RENDER_IS_NODE_TO_GLADE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), JS_RENDER_TYPE_NODE_TO_GLADE))
#define JS_RENDER_NODE_TO_GLADE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), JS_RENDER_TYPE_NODE_TO_GLADE, JsRenderNodeToGladeClass))

typedef struct _JsRenderNodeToGlade JsRenderNodeToGlade;
typedef struct _JsRenderNodeToGladeClass JsRenderNodeToGladeClass;

struct _Xcls_GladeView {
	GObject parent_instance;
	Xcls_GladeViewPrivate * priv;
	GladeDesignView* el;
	JsRenderJsRender* file;
};

struct _Xcls_GladeViewClass {
	GObjectClass parent_class;
};

struct _Xcls_GladeViewPrivate {
	Xcls_GladeView* _this;
};

struct _JsRenderJsRender {
	GObject parent_instance;
	JsRenderJsRenderPrivate * priv;
	GeeArrayList* doubleStringProps;
	gchar* id;
	gchar* name;
	gchar* fullname;
	gchar* path;
	gchar* parent;
	gchar* region;
	gchar* title;
	gchar* permname;
	gchar* modOrder;
	gchar* xtype;
	guint64 webkit_page_id;
	ProjectProject* project;
	JsRenderNode* tree;
	GList* cn;
	gboolean hasParent;
};

struct _JsRenderJsRenderClass {
	GObjectClass parent_class;
	void (*loadItems) (JsRenderJsRender* self, GError** error);
	void (*save) (JsRenderJsRender* self);
	void (*saveHTML) (JsRenderJsRender* self, const gchar* html);
	gchar* (*toSource) (JsRenderJsRender* self);
	gchar* (*toSourcePreview) (JsRenderJsRender* self);
};


extern Xcls_GladeView* _GladeView;
Xcls_GladeView* _GladeView = NULL;
static gpointer xcls_gladeview_parent_class = NULL;

GType xcls_gladeview_get_type (void) G_GNUC_CONST;
GType js_render_js_render_get_type (void) G_GNUC_CONST;
#define XCLS_GLADEVIEW_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), TYPE_XCLS_GLADEVIEW, Xcls_GladeViewPrivate))
enum  {
	XCLS_GLADEVIEW_DUMMY_PROPERTY
};
Xcls_GladeView* xcls_gladeview_singleton (void);
Xcls_GladeView* xcls_gladeview_new (void);
Xcls_GladeView* xcls_gladeview_construct (GType object_type);
void xcls_gladeview_createThumb (Xcls_GladeView* self);
gchar* js_render_js_render_getIconFileName (JsRenderJsRender* self, gboolean return_default);
void xcls_gladeview_loadFile (Xcls_GladeView* self, JsRenderJsRender* file);
GType project_project_get_type (void) G_GNUC_CONST;
GType js_render_node_get_type (void) G_GNUC_CONST;
JsRenderNodeToGlade* js_render_node_to_glade_new (JsRenderNode* node, const gchar* pad);
JsRenderNodeToGlade* js_render_node_to_glade_construct (GType object_type, JsRenderNode* node, const gchar* pad);
GType js_render_node_to_glade_get_type (void) G_GNUC_CONST;
gchar* js_render_node_to_glade_munge (JsRenderNodeToGlade* self);
static void xcls_gladeview_finalize (GObject* obj);


static gpointer _g_object_ref0 (gpointer self) {
#line 13 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	return self ? g_object_ref (self) : NULL;
#line 147 "GladeView.vala.c"
}


Xcls_GladeView* xcls_gladeview_singleton (void) {
	Xcls_GladeView* result = NULL;
	Xcls_GladeView* _tmp0_;
	Xcls_GladeView* _tmp2_;
	Xcls_GladeView* _tmp3_;
#line 10 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp0_ = _GladeView;
#line 10 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	if (_tmp0_ == NULL) {
#line 160 "GladeView.vala.c"
		Xcls_GladeView* _tmp1_;
#line 11 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_tmp1_ = xcls_gladeview_new ();
#line 11 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (_GladeView);
#line 11 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_GladeView = _tmp1_;
#line 168 "GladeView.vala.c"
	}
#line 13 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp2_ = _GladeView;
#line 13 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp3_ = _g_object_ref0 (_tmp2_);
#line 13 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	result = _tmp3_;
#line 13 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	return result;
#line 178 "GladeView.vala.c"
}


Xcls_GladeView* xcls_gladeview_construct (GType object_type) {
	Xcls_GladeView * self = NULL;
	Xcls_GladeView* _tmp0_;
	GladeProject* _tmp1_;
	GladeProject* _tmp2_;
	GladeDesignView* _tmp3_;
#line 20 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	self = (Xcls_GladeView*) g_object_new (object_type, NULL);
#line 22 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp0_ = _g_object_ref0 (self);
#line 22 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (self->priv->_this);
#line 22 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	self->priv->_this = _tmp0_;
#line 23 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp1_ = glade_project_new ();
#line 23 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp2_ = _tmp1_;
#line 23 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp3_ = (GladeDesignView*) glade_design_view_new (_tmp2_);
#line 23 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	g_object_ref_sink (_tmp3_);
#line 23 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (self->el);
#line 23 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	self->el = _tmp3_;
#line 23 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (_tmp2_);
#line 26 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (self->file);
#line 26 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	self->file = NULL;
#line 20 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	return self;
#line 216 "GladeView.vala.c"
}


Xcls_GladeView* xcls_gladeview_new (void) {
#line 20 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	return xcls_gladeview_construct (TYPE_XCLS_GLADEVIEW);
#line 223 "GladeView.vala.c"
}


void xcls_gladeview_createThumb (Xcls_GladeView* self) {
	JsRenderJsRender* _tmp0_;
	JsRenderJsRender* _tmp1_;
	gchar* _tmp2_ = NULL;
	gchar* filename;
	GladeDesignView* _tmp3_;
	GdkWindow* _tmp4_ = NULL;
	GdkWindow* _tmp5_;
	GdkWindow* win;
	GdkWindow* _tmp6_;
	gint _tmp7_ = 0;
	gint width;
	GdkWindow* _tmp8_;
	gint _tmp9_ = 0;
	gint height;
	GdkWindow* _tmp10_;
	gint _tmp11_;
	gint _tmp12_;
	GdkPixbuf* _tmp13_ = NULL;
	GdkPixbuf* screenshot;
	GdkPixbuf* _tmp14_;
	const gchar* _tmp15_;
	GError * _inner_error_ = NULL;
#line 32 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	g_return_if_fail (self != NULL);
#line 35 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp0_ = self->file;
#line 35 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	if (_tmp0_ == NULL) {
#line 36 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		return;
#line 258 "GladeView.vala.c"
	}
#line 38 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp1_ = self->file;
#line 38 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp2_ = js_render_js_render_getIconFileName (_tmp1_, FALSE);
#line 38 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	filename = _tmp2_;
#line 40 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp3_ = self->el;
#line 40 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp4_ = gtk_widget_get_parent_window ((GtkWidget*) _tmp3_);
#line 40 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp5_ = _g_object_ref0 (_tmp4_);
#line 40 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	win = _tmp5_;
#line 41 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp6_ = win;
#line 41 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp7_ = gdk_window_get_width (_tmp6_);
#line 41 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	width = _tmp7_;
#line 42 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp8_ = win;
#line 42 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp9_ = gdk_window_get_height (_tmp8_);
#line 42 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	height = _tmp9_;
#line 44 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp10_ = win;
#line 44 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp11_ = width;
#line 44 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp12_ = height;
#line 44 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp13_ = gdk_pixbuf_get_from_window (_tmp10_, 0, 0, _tmp11_, _tmp12_);
#line 44 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	screenshot = _tmp13_;
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp14_ = screenshot;
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp15_ = filename;
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	gdk_pixbuf_save (_tmp14_, _tmp15_, "png", &_inner_error_, NULL);
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	if (_inner_error_ != NULL) {
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (screenshot);
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (win);
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_free0 (filename);
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		g_clear_error (&_inner_error_);
#line 46 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		return;
#line 316 "GladeView.vala.c"
	}
#line 47 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (screenshot);
#line 47 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (win);
#line 47 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_free0 (filename);
#line 47 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	return;
#line 326 "GladeView.vala.c"
}


void xcls_gladeview_loadFile (Xcls_GladeView* self, JsRenderJsRender* file) {
	JsRenderJsRender* _tmp0_;
	JsRenderJsRender* _tmp1_;
	GladeDesignView* _tmp2_;
	GladeProject* _tmp3_ = NULL;
	GladeProject* _tmp4_;
	GladeProject* p;
	GladeProject* _tmp5_;
	GList* _tmp6_ = NULL;
	GList* _tmp7_ = NULL;
	GList* li;
	JsRenderJsRender* _tmp18_;
	JsRenderNode* _tmp19_;
	JsRenderJsRender* _tmp20_;
	JsRenderNode* _tmp21_;
	JsRenderNodeToGlade* _tmp22_;
	JsRenderNodeToGlade* x;
	GFileIOStream* iostream = NULL;
	GFileIOStream* _tmp23_ = NULL;
	GFile* _tmp24_ = NULL;
	GFile* f;
	GFileIOStream* _tmp25_;
	GOutputStream* _tmp26_;
	GOutputStream* _tmp27_;
	GOutputStream* _tmp28_;
	GOutputStream* ostream;
	GOutputStream* _tmp29_;
	GDataOutputStream* _tmp30_;
	GDataOutputStream* dostream;
	GDataOutputStream* _tmp31_;
	JsRenderNodeToGlade* _tmp32_;
	gchar* _tmp33_ = NULL;
	gchar* _tmp34_;
	GladeDesignView* _tmp35_;
	GFile* _tmp36_;
	gchar* _tmp37_ = NULL;
	gchar* _tmp38_;
	GladeProject* _tmp39_;
	GFile* _tmp40_;
	gchar* _tmp41_ = NULL;
	gchar* _tmp42_;
	GError * _inner_error_ = NULL;
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	g_return_if_fail (self != NULL);
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	g_return_if_fail (file != NULL);
#line 70 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp0_ = file;
#line 70 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp1_ = _g_object_ref0 (_tmp0_);
#line 70 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (self->file);
#line 70 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	self->file = _tmp1_;
#line 75 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp2_ = self->el;
#line 75 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp3_ = glade_design_view_get_project (_tmp2_);
#line 75 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp4_ = _g_object_ref0 (_tmp3_);
#line 75 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	p = _tmp4_;
#line 76 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp5_ = p;
#line 76 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp6_ = glade_project_get_objects (_tmp5_);
#line 76 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp7_ = g_list_copy (_tmp6_);
#line 76 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	li = _tmp7_;
#line 400 "GladeView.vala.c"
	{
		gint i;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		i = 0;
#line 405 "GladeView.vala.c"
		{
			gboolean _tmp8_;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
			_tmp8_ = TRUE;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
			while (TRUE) {
#line 412 "GladeView.vala.c"
				gboolean _tmp9_;
				gint _tmp11_;
				GList* _tmp12_;
				guint _tmp13_ = 0U;
				GladeProject* _tmp14_;
				GList* _tmp15_;
				gint _tmp16_;
				gconstpointer _tmp17_ = NULL;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp9_ = _tmp8_;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				if (!_tmp9_) {
#line 425 "GladeView.vala.c"
					gint _tmp10_;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
					_tmp10_ = i;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
					i = _tmp10_ + 1;
#line 431 "GladeView.vala.c"
				}
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp8_ = FALSE;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp11_ = i;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp12_ = li;
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp13_ = g_list_length (_tmp12_);
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				if (!(((guint) _tmp11_) < _tmp13_)) {
#line 78 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
					break;
#line 445 "GladeView.vala.c"
				}
#line 79 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp14_ = p;
#line 79 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp15_ = li;
#line 79 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp16_ = i;
#line 79 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				_tmp17_ = g_list_nth_data (_tmp15_, (guint) _tmp16_);
#line 79 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
				glade_project_remove_object (_tmp14_, (GObject*) _tmp17_);
#line 457 "GladeView.vala.c"
			}
		}
	}
#line 82 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp18_ = file;
#line 82 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp19_ = _tmp18_->tree;
#line 82 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	if (_tmp19_ == NULL) {
#line 83 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_list_free0 (li);
#line 83 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (p);
#line 83 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		return;
#line 473 "GladeView.vala.c"
	}
#line 87 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp20_ = file;
#line 87 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp21_ = _tmp20_->tree;
#line 87 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp22_ = js_render_node_to_glade_new (_tmp21_, "");
#line 87 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	x = _tmp22_;
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp24_ = g_file_new_tmp ("tpl-XXXXXX.glade", &_tmp23_, &_inner_error_);
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (iostream);
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	iostream = _tmp23_;
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	f = _tmp24_;
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	if (_inner_error_ != NULL) {
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (iostream);
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (x);
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_list_free0 (li);
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (p);
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		g_clear_error (&_inner_error_);
#line 91 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		return;
#line 507 "GladeView.vala.c"
	}
#line 92 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp25_ = iostream;
#line 92 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp26_ = g_io_stream_get_output_stream ((GIOStream*) _tmp25_);
#line 92 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp27_ = _tmp26_;
#line 92 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp28_ = _g_object_ref0 (_tmp27_);
#line 92 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	ostream = _tmp28_;
#line 93 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp29_ = ostream;
#line 93 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp30_ = g_data_output_stream_new (_tmp29_);
#line 93 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	dostream = _tmp30_;
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp31_ = dostream;
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp32_ = x;
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp33_ = js_render_node_to_glade_munge (_tmp32_);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp34_ = _tmp33_;
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	g_data_output_stream_put_string (_tmp31_, _tmp34_, NULL, &_inner_error_);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_free0 (_tmp34_);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	if (_inner_error_ != NULL) {
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (dostream);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (ostream);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (f);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (iostream);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (x);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_list_free0 (li);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		_g_object_unref0 (p);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		g_clear_error (&_inner_error_);
#line 94 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
		return;
#line 559 "GladeView.vala.c"
	}
#line 95 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp35_ = self->el;
#line 95 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	gtk_widget_show ((GtkWidget*) _tmp35_);
#line 96 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp36_ = f;
#line 96 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp37_ = g_file_get_path (_tmp36_);
#line 96 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp38_ = _tmp37_;
#line 96 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	g_print ("LOADING %s\n", _tmp38_);
#line 96 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_free0 (_tmp38_);
#line 97 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp39_ = p;
#line 97 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp40_ = f;
#line 97 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp41_ = g_file_get_path (_tmp40_);
#line 97 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_tmp42_ = _tmp41_;
#line 97 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	glade_project_load_from_file (_tmp39_, _tmp42_);
#line 97 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_free0 (_tmp42_);
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (dostream);
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (ostream);
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (f);
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (iostream);
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (x);
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_list_free0 (li);
#line 66 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (p);
#line 601 "GladeView.vala.c"
}


static void xcls_gladeview_class_init (Xcls_GladeViewClass * klass) {
#line 3 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	xcls_gladeview_parent_class = g_type_class_peek_parent (klass);
#line 3 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	g_type_class_add_private (klass, sizeof (Xcls_GladeViewPrivate));
#line 3 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	G_OBJECT_CLASS (klass)->finalize = xcls_gladeview_finalize;
#line 612 "GladeView.vala.c"
}


static void xcls_gladeview_instance_init (Xcls_GladeView * self) {
#line 3 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	self->priv = XCLS_GLADEVIEW_GET_PRIVATE (self);
#line 619 "GladeView.vala.c"
}


static void xcls_gladeview_finalize (GObject* obj) {
	Xcls_GladeView * self;
#line 3 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, TYPE_XCLS_GLADEVIEW, Xcls_GladeView);
#line 5 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (self->el);
#line 6 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (self->priv->_this);
#line 17 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	_g_object_unref0 (self->file);
#line 3 "/home/alan/gitlive/app.Builder/Builder4/GladeView.vala"
	G_OBJECT_CLASS (xcls_gladeview_parent_class)->finalize (obj);
#line 635 "GladeView.vala.c"
}


GType xcls_gladeview_get_type (void) {
	static volatile gsize xcls_gladeview_type_id__volatile = 0;
	if (g_once_init_enter (&xcls_gladeview_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (Xcls_GladeViewClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) xcls_gladeview_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (Xcls_GladeView), 0, (GInstanceInitFunc) xcls_gladeview_instance_init, NULL };
		GType xcls_gladeview_type_id;
		xcls_gladeview_type_id = g_type_register_static (G_TYPE_OBJECT, "Xcls_GladeView", &g_define_type_info, 0);
		g_once_init_leave (&xcls_gladeview_type_id__volatile, xcls_gladeview_type_id);
	}
	return xcls_gladeview_type_id__volatile;
}



