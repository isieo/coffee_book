jQuery ->
  #$('#company_group_user').autocomplete
  #  source: $('#company_group_user').data('autocomplete-source')
    
	if $(".flash").text().length > 0
		$(".flash").slideDown().delay(4000).slideUp(1000)
