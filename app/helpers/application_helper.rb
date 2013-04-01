module ApplicationHelper

    def approve_link_text(object)  
      object.status.downcase == 'approved'? 'Unapprove' : 'Approve'  
    end
		
		def send_edit(object)
			send('edit_'+object.class.name.downcase+'_path', object)
		end
		
		def send_approve(object)
			send('approve_'+object.class.name.downcase+'_path', object)
		end
			
end
