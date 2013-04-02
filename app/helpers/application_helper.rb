module ApplicationHelper

    def approve_link_text(object)  
      object.status.downcase == 'approved'? 'Unapprove' : 'Approve'  
    end
		
		def send_edit(object)
			_send_action(object, 'edit')
		end
		
		def send_new(object)
			object.send('new_'+object.name.downcase+'_path')
		end
		
		def send_approve(object)
			_send_action(object, 'approve')
		end
		
		def _send_action(object, action)
			send(action+'_'+object.class.name.downcase+'_path', object)
		end
		
end
