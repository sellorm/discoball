#' Returns the member usernames from a given group
#'
#' @param groupname Valid discourse group name
#' @param paged Boolean that controls whether we fetch additional pages is required
#' @param offset int number of records to offset the query - only applicable if paged = TRUE
#'
#' @export
get_group_members <- function(groupname, paged = FALSE, offset = 0){

  DISCOURSE_SERVER <- read_server_env_var()

  if (paged == TRUE){
    offset_query <- paste0("?offset=", offset)
  } else {
    offset_query <- ""
  }

  URL <- paste0(
    DISCOURSE_SERVER,
    "/groups/",
    groupname,
    "/members.json",
    offset_query
    )

  memoised_get <- memoise::memoise(
    httr::GET
  )

  response <- memoised_get(URL)

  response_content <- httr::content(response)

  if (httr::http_status(response)$category != "Success"){
    stop("Request was not successful. ", response_content$errors[[1]])
  }

  if ( response_content$meta$total > response_content$meta$limit && paged == FALSE){
    URL <- paste0(URL, "?limit=", response_content$meta$total)
    response <- memoised_get(URL)
    response_content <- httr::content(response)
  }

  num_members <- length(response_content$members)

  total_members <- 1:num_members

  members <- unlist(
    lapply(
      total_members,
      function(x){
        response_content$members[[x]]$username
        }
      )
    )

  members
}

