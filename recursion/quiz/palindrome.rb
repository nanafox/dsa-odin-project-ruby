# frozen_string_literal: true

# Checks if a word is a palindrome or not
def palindrome(word)
  return true if word.empty? || word.length == 1

  word = word.downcase

  return false if word[0] != word[-1]

  palindrome(word[1..-2])
end
