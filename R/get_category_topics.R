#' Returns the topics for a given category
#'
#' @param category Valid discourse category name
#'
#' @export
get_category_topics <- function(category) {
  DISCOURSE_SERVER <- read_server_env_var()

  URL <- paste0(DISCOURSE_SERVER,
                "/c/",
                category,
                ".json")

  memoised_get <- memoise::memoise(httr::GET)

  response <- memoised_get(URL)

  if (httr::http_status(response)$category != "Success") {
    stop("Request was not successful. Please check the name and try aagin")
  }

  response_content <- httr::content(response)

  num_topics <- length(response_content$topic_list)

  total_topics <- 1:num_topics

  topics <- unlist(
    lapply(
      total_topics,
      function(x) {
        response_content$topic_list$topics[[x]]$title
        }
      )
    )

  topic_last_posted <- unlist(
    lapply(
      total_topics,
      function(x) {
        response_content$topic_list$topics[[x]]$last_posted_at
        }
      )
    )

  topic_url <- unlist(
    lapply(
      total_topics,
      function(x) {
        paste0(DISCOURSE_SERVER,
               "/t/",
               response_content$topic_list$topics[[x]]$slug
              )
        }
      )
    )


  topics <- tibble::tibble(topic       = topics,
                           last_posted = topic_last_posted,
                           url         = topic_url)

  topics
}
