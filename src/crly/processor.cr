require "./definitions.cr"

module Crly
  # SINGLE_REPLACEMENTS = {
  #   '{' => ';',
  #   '}' => ";end",
  # }

  def self.preprocess(input : String) : String

    if !input.lines.first.includes?("#crly!")
      input = input.insert(0, "#crly~\n")
    else
      input = input.sub('!', '~')
    end

    return input
  end

  def self.process(input : String) : String

    input = self.preprocess(input)

    input = input.gsub(/\([a-z]*[.]*\).*=>.*{/) do |sample|
      sample = sample.gsub(' ', "")
      if sample[1] != ')'
        sample = sample.gsub('(', "do |")
        sample = sample.gsub(")=>{", "|;")
      else
        sample = sample.gsub("()=>{", "do;")
      end
    end

    SINGLE_REPLACEMENT.each do |key, value|
      input = input.gsub(key, value)
    end

    #input = input.gsub(/} |{/, "")
    #input = input.gsub(SINGLE_REPLACEMENTS)
    return input
  end
end
