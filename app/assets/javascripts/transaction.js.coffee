$(document).ready ->
  account_ids = $("#account-list ul li").map( ->
    return $(this).attr("id")
  ).get()
  url = "/transactions?account_ids=#{account_ids}"

  $.ajax(url,
    success: (data, textStatus, jqXHR)->
      $("#transaction-list").html(data)
  )

  $("#transaction-list").on("click", "a", (event)->
    alert "aaa"
    link = $(this).attr("href")
    url = "#{link}&account_ids=#{account_ids}"
    $.ajax(url,
      success: (data, textStatus, jqXHR)->
        $("#transaction-list table").append(data)
    )
    return false
  )
