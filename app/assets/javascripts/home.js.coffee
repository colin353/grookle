# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	yes

class window.Task
	constructor: (id) ->
		# If there is an ID, then we'll load from the database.
		if id?
			@load id
		# Otherwise we'll have to make a new one
		else 
			@new()

	render: ->
		"p"

	# Load myself from the database.
	load: (id) ->
		me = @
		$.get '/api/get_task', { id: id }, (r) ->
			# Make sure the data is sensible.
			assert r.id?, 'Illegal or invalid Task loaded'
			# List of fields we care about
			for k in ['id','text']
				if r[k]? 
					me[k] = r[k]
			# Since things were loaded, let's call update
			me.onUpdate.call me

	new: ->
		@text = "New task"

	save: ->
		me = @
		data = {}
		for k in ['id', 'text']
			if @[k]?
				data[k] = me[k]
		$.get '/api/save_task', data
		return me

	onUpdate: ->
		@needsUpdate = yes





