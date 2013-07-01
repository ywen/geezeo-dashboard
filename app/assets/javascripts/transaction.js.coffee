$(document).ready ->
  page = 1
  hasNextPage = true
  base_url = "/transactions"

  $.ajax(base_url,
    success: (data, textStatus, jqXHR)->
      $("#transaction-list").html(data)
      page = jqXHR.getResponseHeader("NextPage")
  )

  $("#transaction-list").on("click", "a", (event)->
    url = "#{base_url}?page=#{page}"
    link = $(this)
    $.ajax(url).done((data, textStatus, jqXHR)->
      $("#transaction-list table").append(data)
      page = jqXHR.getResponseHeader("NextPage")
      hasNextPage = jqXHR.getResponseHeader("HasNextPage")
      if(hasNextPage == 'false')
        link.remove()
    )
    return false
  )
