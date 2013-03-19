class ChildrenController < ApplicationController
	def create
		@visitor = Visitor.find(params[:visitor_id])
		@child = @visitor.children.create(params[:child])
		redirect_to visitor_path(@visitor)
	end
	def destroy
		@visitor = Visitor.find(params[:visitor_id])
		@child = @visitor.children.find(params[:id])
		@child.destroy
		redirect_to visitor_path(@visitor)
	end
end
