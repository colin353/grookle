class HomeController < ApplicationController
	def index
		@tasks = Task.all
	end

	def get_task
		id = params[:id]
		
	end
end
