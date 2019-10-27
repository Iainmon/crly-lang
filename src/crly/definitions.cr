module Crly
  SINGLE_REPLACEMENT = {
    ";" => "\n",
    " {" => ";# \{",
    "} " => ";",
    "\n}" => ";end",
    " }" => ";end",
    "()=>{" => "do;",
    "this." => "@",
    "//" => "#",
    "func " => "def ",
    "let " => "",
    "var " => "property ",
    "}_" => "}"
  }


  COMPLEX_MODIFICATIONS = {
    /(new *[A-Z].*.\()/ => ->(line : String) { # gets a line containing "new ClassName(" => "ClassName.new("

    }
  }
end