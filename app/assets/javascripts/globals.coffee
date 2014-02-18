window.assert = (statement, error) ->
	if !statement
		throw error
	