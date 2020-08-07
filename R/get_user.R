#' Gets useful user information
#'
#' @param username A valid discourse username
#'
#' @export
get_user_info <- function(username){

  DISCOURSE_SERVER <- read_server_env_var()

  URL <- paste0(
    DISCOURSE_SERVER,
    "/users/",
    username,
    ".json"
  )

  memoised_get <- memoise::memoise(
    httr::GET
  )

  response <- memoised_get(URL)

  if (httr::http_status(response)$category != "Success"){
    stop("Request was not successful. Please check the username and try aagin")
  }

  response_content <- httr::content(response)

  user_data <- list(
    "id"            = response_content$user$id,
    "username"      = response_content$user$username,
    "name"          = response_content$user$name,
    "user_title"    = response_content$user$title,
    "is_moderator"  = response_content$user$moderator,
    "is_admin"      = response_content$user$admin,
    "primary_group" = response_content$user$primary_group_name,
    "website"       = response_content$user$website
  )
  user_data
}
