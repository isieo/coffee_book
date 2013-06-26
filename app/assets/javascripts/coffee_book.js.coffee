jQuery ->
  $('#company_group_user').autocomplete
    source: $('#company_group_user').data('autocomplete-source')
