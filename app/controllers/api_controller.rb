class ApiController < ApplicationController
	def get_task
		id = params[:id]
		# Return the task as a JSON object
		render json: Task.find(id)
	end

	def save_task
		id = params[:id] 
		# Find the actual task (or make a new one)
		if id.nil? 
			task = Task.new
		else 
			task = Task.find id
		end
		# Now we'll selectively load the keys we care about
		for k in [:id, :text]
			task[k] = params[k] if !params[k].nil?
		end
		# Save and blow up if it fails
		task.save!
		# I guess it didn't fail!
		render json: { :success => true }
	end
end
