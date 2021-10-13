lua << EOF
  require('Comment').setup()

  local lang = require('Comment.lang')
  lang.set('php', {'//%s', '/*%s*/'})
EOF
