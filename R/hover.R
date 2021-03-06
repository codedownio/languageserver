hover_reply <- function(id, uri, workspace, document, position) {
    line <- position$line
    character <- position$character

    if (!check_scope(uri, document, line)) {
        return(Response$new(id))
    }

    hover_result <- detect_hover(document, line, character)
    hover <- hover_result$text

    logger$info("hover: ", hover)

    matches <- stringr::str_match(
        hover, "(?:([a-zA-Z][a-zA-Z0-9.]+)(:::?))?([a-zA-Z0-9_.]*)$")

    contents <- tryCatch(
        workspace$get_help(matches[4], matches[2]),
        error = function(e) list())

    if (is.null(contents)) {
        Response$new(id)
    } else {
        range <- list(
            start = list(line = line, character = hover_result$begin),
            end = list(line = line, character = hover_result$end)
        )
        logger$info("range", range)
        Response$new(
            id,
            result = list(
                contents = contents,
                range = range
            )
        )
    }
}
