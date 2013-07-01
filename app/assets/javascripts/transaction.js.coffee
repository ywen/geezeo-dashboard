$(document).ready ->
  account_ids = $("#account-list ul li").map( ->
    return $(this).attr("id")
  ).get()
  page = 1
  hasNextPage = true
  url = "/transactions?account_ids=#{account_ids}"

  $.ajax(url,
    success: (data, textStatus, jqXHR)->
      $("#transaction-list").html(data)
      page = jqXHR.getResponseHeader("NextPage")
  )

  $("#transaction-list").on("click", "a", (event)->
    link = $(this).attr("href")
    url = "#{link}?page=#{page}&account_ids=#{account_ids}"
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
