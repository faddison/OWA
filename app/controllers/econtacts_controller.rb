class EcontactsController < ApplicationController
	def create
		@visitor = Visitor.find(params[:visitor_id])
		@econtact = @visitor.econtacts.create(params[:econtact])
		redirect_to visitor_path(@visitor)
	end
	def destroy
		@visitor = Visitor.find(params[:visitor_id])
		@econtact = @visitor.econtacts.find(params[:id])
		@econtact.destroy
		redirect_to visitor_path(@visitor)
	end
end
