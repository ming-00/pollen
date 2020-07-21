require 'differ'

module CorrectionsHelper
    def getDiff (text1, text2, num)
        Differ.format = :html
        if num == 3 || num == 7
            diff = Differ.diff_by_char(text1, text2)
        else 
            diff = Differ.diff_by_word(text1, text2)
        end
    end
end
