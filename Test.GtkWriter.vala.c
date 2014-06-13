/* Test.GtkWriter.vala.c generated by valac 0.24.0, the Vala compiler
 * generated from Test.GtkWriter.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>
#include <glib/gstdio.h>
#include <gee.h>
#include <gtk/gtk.h>


#define PROJECT_TYPE_PROJECT (project_project_get_type ())
#define PROJECT_PROJECT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), PROJECT_TYPE_PROJECT, ProjectProject))
#define PROJECT_PROJECT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PROJECT_TYPE_PROJECT, ProjectProjectClass))
#define PROJECT_IS_PROJECT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), PROJECT_TYPE_PROJECT))
#define PROJECT_IS_PROJECT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PROJECT_TYPE_PROJECT))
#define PROJECT_PROJECT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PROJECT_TYPE_PROJECT, ProjectProjectClass))

typedef struct _ProjectProject ProjectProject;
typedef struct _ProjectProjectClass ProjectProjectClass;

#define PROJECT_TYPE_GTK (project_gtk_get_type ())
#define PROJECT_GTK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), PROJECT_TYPE_GTK, ProjectGtk))
#define PROJECT_GTK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PROJECT_TYPE_GTK, ProjectGtkClass))
#define PROJECT_IS_GTK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), PROJECT_TYPE_GTK))
#define PROJECT_IS_GTK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PROJECT_TYPE_GTK))
#define PROJECT_GTK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PROJECT_TYPE_GTK, ProjectGtkClass))

typedef struct _ProjectGtk ProjectGtk;
typedef struct _ProjectGtkClass ProjectGtkClass;

#define JS_RENDER_TYPE_JS_RENDER (js_render_js_render_get_type ())
#define JS_RENDER_JS_RENDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), JS_RENDER_TYPE_JS_RENDER, JsRenderJsRender))
#define JS_RENDER_JS_RENDER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), JS_RENDER_TYPE_JS_RENDER, JsRenderJsRenderClass))
#define JS_RENDER_IS_JS_RENDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), JS_RENDER_TYPE_JS_RENDER))
#define JS_RENDER_IS_JS_RENDER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), JS_RENDER_TYPE_JS_RENDER))
#define JS_RENDER_JS_RENDER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), JS_RENDER_TYPE_JS_RENDER, JsRenderJsRenderClass))

typedef struct _JsRenderJsRender JsRenderJsRender;
typedef struct _JsRenderJsRenderClass JsRenderJsRenderClass;
typedef struct _ProjectProjectPrivate ProjectProjectPrivate;
#define _g_free0(var) (var = (g_free (var), NULL))
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define JS_RENDER_TYPE_LANGCLASS (js_render_langclass_get_type ())
#define JS_RENDER_LANGCLASS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), JS_RENDER_TYPE_LANGCLASS, JsRenderLang_Class))
#define JS_RENDER_LANGCLASS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), JS_RENDER_TYPE_LANGCLASS, JsRenderLang_ClassClass))
#define JS_RENDER_IS_LANGCLASS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), JS_RENDER_TYPE_LANGCLASS))
#define JS_RENDER_IS_LANGCLASS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), JS_RENDER_TYPE_LANGCLASS))
#define JS_RENDER_LANGCLASS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), JS_RENDER_TYPE_LANGCLASS, JsRenderLang_ClassClass))

typedef struct _JsRenderLang_Class JsRenderLang_Class;
typedef struct _JsRenderLang_ClassClass JsRenderLang_ClassClass;

#define TYPE_XCLS_MAINWINDOW (xcls_mainwindow_get_type ())
#define XCLS_MAINWINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), TYPE_XCLS_MAINWINDOW, Xcls_MainWindow))
#define XCLS_MAINWINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TYPE_XCLS_MAINWINDOW, Xcls_MainWindowClass))
#define IS_XCLS_MAINWINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TYPE_XCLS_MAINWINDOW))
#define IS_XCLS_MAINWINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TYPE_XCLS_MAINWINDOW))
#define XCLS_MAINWINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TYPE_XCLS_MAINWINDOW, Xcls_MainWindowClass))

typedef struct _Xcls_MainWindow Xcls_MainWindow;
typedef struct _Xcls_MainWindowClass Xcls_MainWindowClass;
#define _xcls_mainwindow_unref0(var) ((var == NULL) ? NULL : (var = (xcls_mainwindow_unref (var), NULL)))

struct _ProjectProject {
	GObject parent_instance;
	ProjectProjectPrivate * priv;
	gchar* id;
	gchar* fn;
	gchar* name;
	gchar* runhtml;
	GeeHashMap* paths;
	GeeHashMap* files;
	gchar* xtype;
};

struct _ProjectProjectClass {
	GObjectClass parent_class;
};

typedef enum  {
	JS_RENDER_ERROR_INVALID_FORMAT
} JsRenderError;
#define JS_RENDER_ERROR js_render_error_quark ()


void diff (const gchar* original, const gchar* data);
void testBuilderFile (const gchar* name, const gchar* test);
GType project_project_get_type (void) G_GNUC_CONST;
GType project_gtk_get_type (void) G_GNUC_CONST;
ProjectGtk* project_gtk_new (const gchar* path);
ProjectGtk* project_gtk_construct (GType object_type, const gchar* path);
void project_project_scanDirs (ProjectProject* self);
GType js_render_js_render_get_type (void) G_GNUC_CONST;
GQuark js_render_error_quark (void);
void js_render_js_render_loadItems (JsRenderJsRender* self, GError** error);
gchar* js_render_js_render_toJsonString (JsRenderJsRender* self);
gchar* js_render_js_render_toSource (JsRenderJsRender* self);
gchar* js_render_js_render_toValaSource (JsRenderJsRender* self, gboolean testcompile);
gint _vala_main (void);
JsRenderLang_Class* js_render_langclass_new (void);
JsRenderLang_Class* js_render_langclass_construct (GType object_type);
GType js_render_langclass_get_type (void) G_GNUC_CONST;
gpointer xcls_mainwindow_ref (gpointer instance);
void xcls_mainwindow_unref (gpointer instance);
GParamSpec* param_spec_xcls_mainwindow (const gchar* name, const gchar* nick, const gchar* blurb, GType object_type, GParamFlags flags);
void value_set_xcls_mainwindow (GValue* value, gpointer v_object);
void value_take_xcls_mainwindow (GValue* value, gpointer v_object);
gpointer value_get_xcls_mainwindow (const GValue* value);
GType xcls_mainwindow_get_type (void) G_GNUC_CONST;
Xcls_MainWindow* xcls_mainwindow_new (void);
Xcls_MainWindow* xcls_mainwindow_construct (GType object_type);
void xcls_mainwindow_show (Xcls_MainWindow* self);
static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func);
static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func);
static gint _vala_array_length (gpointer array);


/**
 * Test the writer code...


*/
void diff (const gchar* original, const gchar* data) {
	const gchar* _tmp0_ = NULL;
	gchar** spawn_args = NULL;
	gchar* _tmp1_ = NULL;
	gchar* _tmp2_ = NULL;
	gchar* _tmp3_ = NULL;
	const gchar* _tmp4_ = NULL;
	gchar* _tmp5_ = NULL;
	gchar* _tmp6_ = NULL;
	gchar** _tmp7_ = NULL;
	gint spawn_args_length1 = 0;
	gint _spawn_args_size_ = 0;
	gchar** spawn_env = NULL;
	gchar** _tmp8_ = NULL;
	gchar** _tmp9_ = NULL;
	gint spawn_env_length1 = 0;
	gint _spawn_env_size_ = 0;
	gint ls_status = 0;
	gchar** _tmp10_ = NULL;
	gint _tmp10__length1 = 0;
	gchar** _tmp11_ = NULL;
	gint _tmp11__length1 = 0;
	gint _tmp12_ = 0;
	GError * _inner_error_ = NULL;
#line 8 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	g_return_if_fail (original != NULL);
#line 8 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	g_return_if_fail (data != NULL);
#line 11 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp0_ = data;
#line 11 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	g_file_set_contents ("/tmp/test.out", _tmp0_, (gssize) (-1), &_inner_error_);
#line 11 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	if (_inner_error_ != NULL) {
#line 11 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
#line 11 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		g_clear_error (&_inner_error_);
#line 11 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		return;
#line 168 "Test.GtkWriter.vala.c"
	}
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp1_ = g_strdup ("diff");
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp2_ = g_strdup ("-w");
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp3_ = g_strdup ("-u");
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp4_ = original;
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp5_ = g_strdup (_tmp4_);
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp6_ = g_strdup ("/tmp/test.out");
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp7_ = g_new0 (gchar*, 5 + 1);
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp7_[0] = _tmp1_;
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp7_[1] = _tmp2_;
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp7_[2] = _tmp3_;
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp7_[3] = _tmp5_;
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp7_[4] = _tmp6_;
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	spawn_args = _tmp7_;
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	spawn_args_length1 = 5;
#line 12 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_spawn_args_size_ = spawn_args_length1;
#line 15 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp9_ = _tmp8_ = g_get_environ ();
#line 15 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	spawn_env = _tmp9_;
#line 15 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	spawn_env_length1 = _vala_array_length (_tmp8_);
#line 15 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_spawn_env_size_ = spawn_env_length1;
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp10_ = spawn_args;
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp10__length1 = spawn_args_length1;
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp11_ = spawn_env;
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp11__length1 = spawn_env_length1;
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	g_spawn_sync ("/", _tmp10_, _tmp11_, G_SPAWN_SEARCH_PATH, NULL, NULL, NULL, NULL, &_tmp12_, &_inner_error_);
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	ls_status = _tmp12_;
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	if (_inner_error_ != NULL) {
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		spawn_env = (_vala_array_free (spawn_env, spawn_env_length1, (GDestroyNotify) g_free), NULL);
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		spawn_args = (_vala_array_free (spawn_args, spawn_args_length1, (GDestroyNotify) g_free), NULL);
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		g_clear_error (&_inner_error_);
#line 17 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		return;
#line 232 "Test.GtkWriter.vala.c"
	}
#line 8 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	spawn_env = (_vala_array_free (spawn_env, spawn_env_length1, (GDestroyNotify) g_free), NULL);
#line 8 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	spawn_args = (_vala_array_free (spawn_args, spawn_args_length1, (GDestroyNotify) g_free), NULL);
#line 238 "Test.GtkWriter.vala.c"
}


void testBuilderFile (const gchar* name, const gchar* test) {
	gchar* dir = NULL;
	gchar* _tmp0_ = NULL;
	ProjectGtk* proj = NULL;
	const gchar* _tmp1_ = NULL;
	ProjectGtk* _tmp2_ = NULL;
	ProjectGtk* _tmp3_ = NULL;
	JsRenderJsRender* tf = NULL;
	ProjectGtk* _tmp4_ = NULL;
	GeeHashMap* _tmp5_ = NULL;
	const gchar* _tmp6_ = NULL;
	gchar* _tmp7_ = NULL;
	gchar* _tmp8_ = NULL;
	const gchar* _tmp9_ = NULL;
	gchar* _tmp10_ = NULL;
	gchar* _tmp11_ = NULL;
	gchar* _tmp12_ = NULL;
	gchar* _tmp13_ = NULL;
	gpointer _tmp14_ = NULL;
	JsRenderJsRender* _tmp15_ = NULL;
	JsRenderJsRender* _tmp16_ = NULL;
	const gchar* _tmp17_ = NULL;
	const gchar* _tmp18_ = NULL;
	GQuark _tmp20_ = 0U;
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	static GQuark _tmp19_label0 = 0;
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	static GQuark _tmp19_label1 = 0;
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	static GQuark _tmp19_label2 = 0;
#line 272 "Test.GtkWriter.vala.c"
	GError * _inner_error_ = NULL;
#line 29 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	g_return_if_fail (name != NULL);
#line 29 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	g_return_if_fail (test != NULL);
#line 31 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp0_ = g_strdup ("/home/alan/gitlive/app.Builder.js/Builder4");
#line 31 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	dir = _tmp0_;
#line 32 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp1_ = dir;
#line 32 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp2_ = project_gtk_new (_tmp1_);
#line 32 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	proj = _tmp2_;
#line 33 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp3_ = proj;
#line 33 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	project_project_scanDirs ((ProjectProject*) _tmp3_);
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp4_ = proj;
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp5_ = ((ProjectProject*) _tmp4_)->files;
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp6_ = dir;
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp7_ = g_strconcat (_tmp6_, "/", NULL);
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp8_ = _tmp7_;
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp9_ = name;
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp10_ = g_strconcat (_tmp8_, _tmp9_, NULL);
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp11_ = _tmp10_;
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp12_ = g_strconcat (_tmp11_, ".bjs", NULL);
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp13_ = _tmp12_;
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp14_ = gee_abstract_map_get ((GeeAbstractMap*) _tmp5_, _tmp13_);
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp15_ = (JsRenderJsRender*) _tmp14_;
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_g_free0 (_tmp13_);
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_g_free0 (_tmp11_);
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_g_free0 (_tmp8_);
#line 36 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	tf = _tmp15_;
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp16_ = tf;
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	js_render_js_render_loadItems (_tmp16_, &_inner_error_);
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	if (_inner_error_ != NULL) {
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		_g_object_unref0 (tf);
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		_g_object_unref0 (proj);
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		_g_free0 (dir);
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		g_clear_error (&_inner_error_);
#line 37 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		return;
#line 342 "Test.GtkWriter.vala.c"
	}
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp17_ = test;
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp18_ = _tmp17_;
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp20_ = (NULL == _tmp18_) ? 0 : g_quark_from_string (_tmp18_);
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	if (_tmp20_ == ((0 != _tmp19_label0) ? _tmp19_label0 : (_tmp19_label0 = g_quark_from_static_string ("JSON")))) {
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		switch (0) {
#line 354 "Test.GtkWriter.vala.c"
			default:
			{
				const gchar* _tmp21_ = NULL;
				gchar* _tmp22_ = NULL;
				gchar* _tmp23_ = NULL;
				const gchar* _tmp24_ = NULL;
				gchar* _tmp25_ = NULL;
				gchar* _tmp26_ = NULL;
				gchar* _tmp27_ = NULL;
				gchar* _tmp28_ = NULL;
				JsRenderJsRender* _tmp29_ = NULL;
				gchar* _tmp30_ = NULL;
				gchar* _tmp31_ = NULL;
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp21_ = dir;
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp22_ = g_strconcat (_tmp21_, "/", NULL);
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp23_ = _tmp22_;
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp24_ = name;
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp25_ = g_strconcat (_tmp23_, _tmp24_, NULL);
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp26_ = _tmp25_;
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp27_ = g_strconcat (_tmp26_, ".bjs", NULL);
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp28_ = _tmp27_;
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp29_ = tf;
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp30_ = js_render_js_render_toJsonString (_tmp29_);
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp31_ = _tmp30_;
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				diff (_tmp28_, _tmp31_);
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp31_);
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp28_);
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp26_);
#line 40 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp23_);
#line 41 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_object_unref0 (tf);
#line 41 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_object_unref0 (proj);
#line 41 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (dir);
#line 41 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				return;
#line 408 "Test.GtkWriter.vala.c"
			}
		}
	} else if (_tmp20_ == ((0 != _tmp19_label1) ? _tmp19_label1 : (_tmp19_label1 = g_quark_from_static_string ("JS")))) {
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		switch (0) {
#line 414 "Test.GtkWriter.vala.c"
			default:
			{
				const gchar* _tmp32_ = NULL;
				gchar* _tmp33_ = NULL;
				gchar* _tmp34_ = NULL;
				const gchar* _tmp35_ = NULL;
				gchar* _tmp36_ = NULL;
				gchar* _tmp37_ = NULL;
				gchar* _tmp38_ = NULL;
				gchar* _tmp39_ = NULL;
				JsRenderJsRender* _tmp40_ = NULL;
				gchar* _tmp41_ = NULL;
				gchar* _tmp42_ = NULL;
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp32_ = dir;
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp33_ = g_strconcat (_tmp32_, "/", NULL);
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp34_ = _tmp33_;
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp35_ = name;
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp36_ = g_strconcat (_tmp34_, _tmp35_, NULL);
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp37_ = _tmp36_;
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp38_ = g_strconcat (_tmp37_, ".js", NULL);
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp39_ = _tmp38_;
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp40_ = tf;
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp41_ = js_render_js_render_toSource (_tmp40_);
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp42_ = _tmp41_;
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				diff (_tmp39_, _tmp42_);
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp42_);
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp39_);
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp37_);
#line 43 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp34_);
#line 44 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_object_unref0 (tf);
#line 44 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_object_unref0 (proj);
#line 44 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (dir);
#line 44 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				return;
#line 468 "Test.GtkWriter.vala.c"
			}
		}
	} else if (_tmp20_ == ((0 != _tmp19_label2) ? _tmp19_label2 : (_tmp19_label2 = g_quark_from_static_string ("VALA")))) {
#line 38 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
		switch (0) {
#line 474 "Test.GtkWriter.vala.c"
			default:
			{
				const gchar* _tmp43_ = NULL;
				gchar* _tmp44_ = NULL;
				gchar* _tmp45_ = NULL;
				const gchar* _tmp46_ = NULL;
				gchar* _tmp47_ = NULL;
				gchar* _tmp48_ = NULL;
				gchar* _tmp49_ = NULL;
				gchar* _tmp50_ = NULL;
				JsRenderJsRender* _tmp51_ = NULL;
				gchar* _tmp52_ = NULL;
				gchar* _tmp53_ = NULL;
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp43_ = dir;
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp44_ = g_strconcat (_tmp43_, "/", NULL);
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp45_ = _tmp44_;
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp46_ = name;
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp47_ = g_strconcat (_tmp45_, _tmp46_, NULL);
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp48_ = _tmp47_;
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp49_ = g_strconcat (_tmp48_, ".vala", NULL);
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp50_ = _tmp49_;
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp51_ = tf;
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp52_ = js_render_js_render_toValaSource (_tmp51_, FALSE);
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_tmp53_ = _tmp52_;
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				diff (_tmp50_, _tmp53_);
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp53_);
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp50_);
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp48_);
#line 46 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (_tmp45_);
#line 47 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_object_unref0 (tf);
#line 47 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_object_unref0 (proj);
#line 47 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				_g_free0 (dir);
#line 47 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
				return;
#line 528 "Test.GtkWriter.vala.c"
			}
		}
	}
#line 49 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	g_print ("invalid test?\n");
#line 29 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_g_object_unref0 (tf);
#line 29 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_g_object_unref0 (proj);
#line 29 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_g_free0 (dir);
#line 540 "Test.GtkWriter.vala.c"
}


gint _vala_main (void) {
	gint result = 0;
	JsRenderLang_Class* _tmp0_ = NULL;
	JsRenderLang_Class* _tmp1_ = NULL;
	Xcls_MainWindow* w = NULL;
	Xcls_MainWindow* _tmp2_ = NULL;
#line 53 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp0_ = js_render_langclass_new ();
#line 53 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp1_ = _tmp0_;
#line 53 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_g_object_unref0 (_tmp1_);
#line 54 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	g_log_set_always_fatal (G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL);
#line 60 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_tmp2_ = xcls_mainwindow_new ();
#line 60 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	w = _tmp2_;
#line 61 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	xcls_mainwindow_show (w);
#line 63 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	gtk_main ();
#line 67 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	result = 0;
#line 67 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	_xcls_mainwindow_unref0 (w);
#line 67 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	return result;
#line 572 "Test.GtkWriter.vala.c"
}


int main (int argc, char ** argv) {
#if !GLIB_CHECK_VERSION (2,35,0)
	g_type_init ();
#endif
#line 52 "/home/alan/gitlive/app.Builder.js/Test.GtkWriter.vala"
	return _vala_main ();
#line 582 "Test.GtkWriter.vala.c"
}


static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	if ((array != NULL) && (destroy_func != NULL)) {
		int i;
		for (i = 0; i < array_length; i = i + 1) {
			if (((gpointer*) array)[i] != NULL) {
				destroy_func (((gpointer*) array)[i]);
			}
		}
	}
}


static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	_vala_array_destroy (array, array_length, destroy_func);
	g_free (array);
}


static gint _vala_array_length (gpointer array) {
	int length;
	length = 0;
	if (array) {
		while (((gpointer*) array)[length]) {
			length++;
		}
	}
	return length;
}



