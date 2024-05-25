# Wordle solver how-to:
1. Replace "REPLACE WITH DIRECTORY" with the path to the directory you have the program in
2. Enter in your parameters to the function
3. Press run!

## Example:
```
searcher.printList(searcher.filterWords(
wordLength: <Word length>, 
includes: <Letters to include>, 
excludes: <Letters to exclude>, 
includesSpecific: <Array of wordLength filled with strings where the letter corosponds to the location in the word should appear>, 
excludesSpecific: <Array of wordLength filled with strings where the letter corosponds to the location in the word should not appear>
))
```
# Explanation:
The program guesses solutions for the Wordle puzzle in order to solve it in the quickest manner. The program takes in all the info you have gotten from your Wordle game (ex. Letter does not go here, or word includes this letter etc.) and searches a list of 333 thousand words. It filters out words that could not be the answer based on your previous guesses. Then it ranks the remaining words by unique number of vowels, then by least repeated letters, then by word popularity (number of times it showed up in the source content), and finally the most frequently used letters.
