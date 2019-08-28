@check_for_form_completion = ->
	if $('#speakerid').length && $('#outlineid').length && $('#congregationid').length
		# This is the outgoing speaker form.
		if $('#congregationid').val().length && $('#outlineid').val().length && $('#congregationid').val().length && $('#talk_date').val().length
			$('#create_talk').removeAttr('disabled')
		else
			$('#create_talk').attr('disabled', true)

	else
		
		if $('#speakerid').val().length && $('#outlineid').val().length && $('#talk_date').val().length
			$('#create_talk').removeAttr('disabled')
		else
			$('#create_talk').attr('disabled', true)
