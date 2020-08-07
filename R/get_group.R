#' Returns the member usernames from a given group
#'
#' @param groupname Valid discourse group name
#'
#' @export
get_group_members <- function(groupname){

  DISCOURSE_SERVER <- read_server_env_var()

  URL <- paste0(
    DISCOURSE_SERVER,
    "/groups/",
    groupname,
    "/members.json"
    )

  memoised_get <- memoise::memoise(
    httr::GET
  )

  response <- memoised_get(URL)

  if (httr::http_status(response)$category != "Success"){
    stop("Request was not successful. Please check the name and try aagin")
  }

  response_content <- httr::content(response)

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

