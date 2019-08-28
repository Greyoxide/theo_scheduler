$( document ).on 'turbolinks:load', ->
	if $('#talk_date').length
		$('#talk_date').change ->
			check_for_form_completion()