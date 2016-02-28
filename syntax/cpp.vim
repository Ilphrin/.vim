if exists("b:cpp_syntax")
  finish
endif

match Underlined /public\|protected\|private/

let b:cpp_syntax = "cpp"
