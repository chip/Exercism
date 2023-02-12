import itertools
# solve <expr> = <value> as an alphametic equation
def solve(expr, value):
 
  # replace the words in expr with placeholders
  # (body, words) = replace_words(expr)
  # printf("body " + body)
  # printf("words " + words)
 
  # make an executable function from <body>
  # fn = eval("lambda <args>: <body>")
 
  # extract the letters in the words
  # letters = letters in words
  # printf("letters " + letters)
  
  # consider possible assignments for each letter
  for digits in itertools.permutations(range(0, 10), len("ASMO")):
      print("digits")
      print(digits)
 #  for digits in permutations(irange(0, 9), len(letters)):
 # 
 #      printf("digits " + digits)
 #    # map the words to numbers using the digits
 #    args = list((for letter in word) for word in words)
 #
 #    # compute the result of the expression
 #    result = fn(args)
 #
 #    # does the result match <value>
 #    solution = match(value, result)
 #    if solution:
 #      <output solution>

solve("AS + A", "MOM")
