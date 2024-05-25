# Wordle solver how-to:
1. Replace "REPLACE WITH DIRECTORY" with the path to your directory
2. Enter in your parameters to the function
3. Press run!

Example:

```
searcher.printList(searcher.filterWords(
wordLength: 5, 
includes: <Letters to include>, 
excludes: <Letters to exclude>, 
includesSpecific: <Array of wordLength where the letter corosponds to the location in the word you want it to appear>["","","","",""], 
excludesSpecific: <Array of wordLength where the letter corosponds to the location in the word you want it to not appear>["","","","",""]
))
