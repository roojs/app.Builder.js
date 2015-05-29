 
using Gtk;

// not sure why - but extending Gtk.SourceCompletionProvider seems to give an error..
namespace Palete {

    public class CompletionProvider : Object, SourceCompletionProvider
    {
		Editor editor; 
		WindowState windowstate;
 		//public List<Gtk.SourceCompletionItem> filtered_proposals;

		public CompletionProvider(Editor editor)
		{
		    this.editor  = editor;
		    this.windowstate = null; // not ready until the UI is built.
		    
 		}

		public string get_name ()
		{
		  return  "test";
		}

		public int get_priority ()
		{
		  return 1;
		}

		public bool match (SourceCompletionContext context)
		{
		
			return true;
		}

		public void populate (SourceCompletionContext context)
		{
			if (this.windowstate == null) {
				this.windowstate = this.editor.window.windowstate;
			}
			
			
			var buffer = context.completion.view.buffer;
			var  mark = buffer.get_insert ();
			TextIter end;

			buffer.get_iter_at_mark (out end, mark);
			var endpos = end;
			
			var searchpos = endpos;
			
			searchpos.backward_find_char(is_space, null);
			searchpos.forward_char();
			var search = endpos.get_text(searchpos);
			print("got search %s\n", search);
			
			if (search.length < 2) {
				return;
			}
			// now do our magic..
			var filtered_proposals = this.windowstate.file.palete().suggestComplete(
				this.windowstate.file,
				this.editor.node,
				this.editor.ptype,
				this.editor.key,
				search
			);
			filtered_proposals.sort((a, b) => {
				return ((string)(a.text)).collate((string)(b.text));
			});
			 
			context.add_proposals (this, filtered_proposals, true);
		}



		public bool activate_proposal (SourceCompletionProposal proposal, TextIter iter)
		{
			var istart = iter;
			istart.backward_find_char(is_space, null);
			istart.forward_char();

		//    var search = iter.get_text(istart);	    
		
			var buffer = iter.get_buffer();
			buffer.delete(ref istart, ref iter);
			buffer.insert(ref istart, proposal.get_text(), -1);
		
			return true;
		}

		public SourceCompletionActivation get_activation ()
		{
			//if(SettingsManager.Get_Setting("complete_auto") == "true"){
				return SourceCompletionActivation.INTERACTIVE | SourceCompletionActivation.USER_REQUESTED;
			//} else {
			//	return Gtk.SourceCompletionActivation.USER_REQUESTED;
			//}
		}

		public int get_interactive_delay ()
		{
			return -1;
		}

		public bool get_start_iter (SourceCompletionContext context, SourceCompletionProposal proposal, out TextIter iter)
		{
			return false;
		}

		public void update_info (SourceCompletionProposal proposal, SourceCompletionInfo info)
		{

		}

		private bool is_space(unichar space){
			return space.isspace() || space.to_string() == "";
		}
		
		private bool is_forward_space(unichar space){
			return !(
				space.to_string() == " "
				||
				space.to_string() == ""
				||
				space.to_string() == "\n"
				||
				space.to_string() == ")"
				||
				space.to_string() == "("
				
			);
		}
	}


} 
