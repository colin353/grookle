class Task < ActiveRecord::Base
	attr_accessible :completed, :text
	after_initialize :default_values
	default_scope :order => 'created_at DESC'

	private
		# This function sets the default values of the parameters
		def default_values
			self.completed = false if self.completed.nil?
			self.text ||= "" 
		end
end
