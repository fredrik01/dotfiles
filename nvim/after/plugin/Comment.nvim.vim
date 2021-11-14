lua << EOF
  require('Comment').setup()

  local lang = require('Comment.ft')
  lang.set('php', {'//%s', '/*%s*/'})
EOF
