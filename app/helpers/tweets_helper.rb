module TweetsHelper
  def redact(tagged)
    text = tagged.split(" ")
                 .map { |tagged_words| tagged_words.split("/") }
                 .map { |word, tag|
                        unless tag == "JJ"  ||
                               tag == "RB"  ||
                               tag == "RBR" ||
                               tag == "RBS" ||
                               tag == "RP"
                          word
                        else
                          "<span style=\"background-color:black;color:black\">#{word}</span>"
                        end}
    reduce(text, [])
  end

  def strip(tagged)
    text = tagged.split(" ")
                 .map { |tagged_words| tagged_words.split("/") }
                 .reject { |_, tag| tag == "JJ"  ||
                                    tag == "RB"  ||
                                    tag == "RBR" ||
                                    tag == "RBS" ||
                                    tag == "RP" }
                 .map { |word, _| word }

    reduce(text, [])
  end

  private

  def reduce(text, acc)
    acc = []

    text.each do |t|
      unless [".", ",", "?", "!"].include?(t)
        acc << t
      else
        last = acc.pop
        acc << (last + t)
      end
    end

    acc.join(" ").html_safe
  end
end
