class Tweet < ActiveRecord::Base
  def strip_text
    text = EngTagger.new
                    .get_readable(self.text)
                    .split(" ")
                    .map { |tagged_words| tagged_words.split("/") }
                    .reject { |_, tag| tag == "JJ"  ||
                                       tag == "RB"  ||
                                       tag == "RBR" ||
                                       tag == "RBS" ||
                                       tag == "RP" }
                    .map { |word, _| word }
    acc = []

    text.each do |t|
      unless [".", ",", "?", "!"].include?(t)
        acc << t
      else
        last = acc.pop
        acc << (last + t)
      end
    end

    acc.join(" ")
  end
end
