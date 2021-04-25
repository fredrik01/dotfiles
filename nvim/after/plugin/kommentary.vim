lua << EOF
  require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = false,
  })
  require('kommentary.config').configure_language("php", {
    -- default does not work so...
    prefer_single_line_comments = true,
  })
EOF
