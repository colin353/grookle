# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	window.checkboxlistcontroller = new CheckboxListController()

class window.CheckboxListController
	constructor: ->
		@dom_element = $('.checkbox-list')
		@tasks = []
		# We expect to be able to read the data-task-ids as JSON:
		element_ids = JSON.parse @dom_element.attr('data-task-ids')
		assert element_ids instanceof Array, "Invaild data loaded"
		for id in element_ids
			t = new Task(id)
			t.parent = @
			@tasks.push t 

	onUpdate: ->
		# Update the HTML of the div with all of our elements.
		html = ""
		for t in @tasks
			html += t.render()
		@dom_element.html html

class window.Task
	constructor: (id) ->
		# If there is an ID, then we'll load from the database.
		if id?
			@load id
		# Otherwise we'll have to make a new one
		else 
			@new()

	render: ->
		"<label><input type='checkbox'>#{@text}</label>"

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
		@parent.onUpdate.call @parent
		@needsUpdate = yes