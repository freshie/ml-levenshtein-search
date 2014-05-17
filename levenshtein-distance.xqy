let $queryText := "too mail dear"
let $terms :=
  for $token in cts:tokenize($queryText)
  where $token instance of cts:word
  return $token

let $AllWords := cts:words((), ("collation=http://marklogic.com/collation/en"))

for $term in $terms
return
(
  for $word in $AllWords
   let $distance := 
     try {
       spell:levenshtein-distance($term,$word)
       }
  catch ($exception) {
   99
  }
  where $distance eq 1
  return $word
)[1 to 100]