module ApplicationHelper

    def approve_link_text(approvable)  
      approvable.status.downcase == 'approved'? 'Unapprove' : 'Approve'  
    end

end
