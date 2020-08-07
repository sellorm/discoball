read_server_env_var <- function(){
  DISCOURSE_SERVER <- Sys.getenv("DISCOURSE_SERVER", unset = NA)
  if (is.na(DISCOURSE_SERVER)){
    stop("DISCOURSE_SERVER environment variable not set", call. = FALSE)
  }
  DISCOURSE_SERVER
}
