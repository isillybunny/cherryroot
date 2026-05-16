$path = "C:\Users\cereja\Documents\cherryroot\deploy\cherry-code.html"
$html = [System.IO.File]::ReadAllText($path)

# Map of lowercase keyword -> @(displayTerm, shortDef)
# Keywords ordered by length desc to avoid sub-matches
$terms = [ordered]@{}
$terms["compiler"]      = @("Compiler","Translates the entire source code to machine code before execution (Java, C, Go).")
$terms["interpreter"]   = @("Interpreter","Reads and executes code line by line at runtime (Python, JavaScript).")
$terms["programming"]   = @("Programming","Writing instructions a computer can execute, step by step.")
$terms["syntax"]        = @("Syntax","The strict grammar rules of a programming language.")
$terms["runtime"]       = @("Runtime","The phase when code is actually executing, after compilation/parsing.")
$terms["paradigm"]      = @("Paradigm","A style of programming - OOP, functional, procedural, etc.")
$terms["terminal"]      = @("Terminal","Text interface for running commands and programs.")
$terms["debug"]         = @("Debug","Finding and removing bugs from code, step by step.")
$terms["bug"]           = @("Bug","A flaw in code that makes it behave incorrectly.")
$terms["ide"]           = @("IDE","Integrated Development Environment - editor plus tools to write/run/debug code.")
$terms["variable"]      = @("Variable","A named container that holds a value you can read or change.")
$terms["constant"]      = @("Constant","A named value that cannot be reassigned after creation.")
$terms["scope"]         = @("Scope","The region of code where a variable is visible/usable.")
$terms["string"]        = @("String","A sequence of characters - text in quotes.")
$terms["integer"]       = @("Integer","A whole number, no decimal part.")
$terms["float"]         = @("Float","A number with a decimal point - fractional values.")
$terms["boolean"]       = @("Boolean","A true/false value.")
$terms["null"]          = @("Null","Represents 'no value' or 'nothing here'.")
$terms["array"]         = @("Array","An ordered list of values accessed by index.")
$terms["list"]          = @("List","An ordered, mutable sequence of items.")
$terms["tuple"]         = @("Tuple","An ordered, immutable sequence of items.")
$terms["dictionary"]    = @("Dictionary","Maps keys to values - like a real dictionary.")
$terms["dict"]          = @("Dict","Maps keys to values - like a real dictionary.")
$terms["set"]           = @("Set","A collection of unique values, no duplicates.")
$terms["stack"]         = @("Stack","LIFO - last in, first out. Push and pop.")
$terms["queue"]         = @("Queue","FIFO - first in, first out. Enqueue and dequeue.")
$terms["tree"]          = @("Tree","Hierarchical structure with a root and child nodes.")
$terms["graph"]         = @("Graph","Nodes connected by edges - can be cyclic or directed.")
$terms["hash table"]    = @("Hash Table","Stores key-value pairs with O(1) average lookup.")
$terms["function"]      = @("Function","A named, reusable block of code that performs a task.")
$terms["parameter"]     = @("Parameter","A named input declared in a function signature.")
$terms["argument"]      = @("Argument","The actual value passed to a function when calling it.")
$terms["return"]        = @("Return","Sends a value back from a function to the caller.")
$terms["recursion"]     = @("Recursion","A function that calls itself to solve smaller versions of a problem.")
$terms["closure"]       = @("Closure","A function that remembers variables from its outer scope.")
$terms["lambda"]        = @("Lambda","A short anonymous function expression.")
$terms["loop"]          = @("Loop","Repeats a block of code while/until a condition is met.")
$terms["while loop"]    = @("While Loop","Repeats while a condition is true.")
$terms["for loop"]      = @("For Loop","Iterates a known number of times or over a range.")
$terms["break"]         = @("Break","Exits the current loop immediately.")
$terms["continue"]      = @("Continue","Skips to the next iteration of the loop.")
$terms["if statement"]  = @("If Statement","Runs a block only when a condition is true.")
$terms["else"]          = @("Else","Runs when the previous if condition is false.")
$terms["ternary"]       = @("Ternary Operator","A one-line if/else expression: cond ? a : b.")
$terms["expression"]    = @("Expression","Code that evaluates to a value.")
$terms["statement"]     = @("Statement","A complete instruction the language can execute.")
$terms["operator"]      = @("Operator","A symbol that performs an operation on values: +, -, ==, etc.")
$terms["modulo"]        = @("Modulo","Returns the remainder of a division.")
$terms["class"]         = @("Class","A blueprint that defines attributes and methods for objects.")
$terms["object"]        = @("Object","An instance of a class - concrete data with behavior.")
$terms["instance"]      = @("Instance","A specific object created from a class.")
$terms["attribute"]     = @("Attribute","A piece of data attached to an object.")
$terms["method"]        = @("Method","A function attached to a class or object.")
$terms["constructor"]   = @("Constructor","Special method that runs when a new instance is created.")
$terms["inheritance"]   = @("Inheritance","A class deriving attributes/methods from a parent class.")
$terms["polymorphism"]  = @("Polymorphism","Same interface, different implementations.")
$terms["encapsulation"] = @("Encapsulation","Hiding internal state, exposing only what's needed.")
$terms["abstraction"]   = @("Abstraction","Hiding complexity behind a simple interface.")
$terms["interface"]     = @("Interface","A contract that classes can implement.")
$terms["exception"]     = @("Exception","An error event that disrupts normal execution.")
$terms["throw"]         = @("Throw","Raises an exception manually.")
$terms["raise"]         = @("Raise","Triggers an exception manually (Python's throw).")
$terms["stack trace"]   = @("Stack Trace","List of function calls leading to an error.")
$terms["breakpoint"]    = @("Breakpoint","A pause point in code, used by debuggers.")
$terms["debugger"]      = @("Debugger","A tool to pause and inspect a running program.")
$terms["linter"]        = @("Linter","A tool that flags suspicious or stylistic code issues.")
$terms["edge case"]     = @("Edge Case","An unusual input that breaks naive code (empty, max, null).")
$terms["refactor"]      = @("Refactor","Restructure code without changing behavior.")
$terms["testing"]       = @("Testing","Writing code that verifies your code works.")
$terms["version control"] = @("Version Control","System (like Git) that tracks changes to code over time.")
$terms["algorithm"]     = @("Algorithm","A finite series of steps that solves a problem.")
$terms["big o"]         = @("Big O","Notation describing how runtime/space grows with input size.")
$terms["index"]         = @("Index","A numeric position in an ordered collection (0-based).")
$terms["key"]           = @("Key","The lookup label in a dictionary/map.")
$terms["machine code"]  = @("Machine Code","The lowest-level binary instructions a CPU executes.")
$terms["concatenation"] = @("String Concatenation","Joining strings together with + or similar.")
$terms["casting"]       = @("Type Casting","Converting a value from one type to another.")
$terms["nested"]        = @("Nested Loops","A loop inside another loop.")
$terms["pure function"] = @("Pure Function","Same inputs always give same output, no side effects.")
$terms["side effect"]   = @("Side Effects","Anything a function does besides returning a value (I/O, mutation).")

# Find every <div class="defbox">...</div>, <div class="how">...</div>, <div class="rem">...</div>
# Apply substitutions: for each section, first-occurrence (case-insensitive, word-boundary) of each keyword wraps in gloss span
# Don't touch text inside HTML attributes or existing spans

$pattern = '(?s)(<div class="(?:defbox|how|rem)">)(.*?)(</div>)'

$count = 0

$callback = {
  param($match)
  $open = $match.Groups[1].Value
  $body = $match.Groups[2].Value
  $close = $match.Groups[3].Value

  # Track keywords already used in this section to apply only once each
  $used = @{}

  foreach($kw in $terms.Keys){
    if($used.ContainsKey($kw)){continue}
    $disp = $terms[$kw][0]
    $def  = $terms[$kw][1] -replace "'", "'"
    # Word boundary; case-insensitive; do not match inside an HTML tag or existing span
    # We split by tags to keep safe.
    # Build regex: match the keyword as a whole word, only in plain text (negative lookbehind/ahead won't suffice for full safety with .NET regex easily, so we use a tokenized approach).

    # Tokenize: walk through, find first match outside of tags and outside <span class="gloss"...>...</span>
    # Use a simpler approach: replace first match using regex with negative lookbehind for '>' word context
    # Strategy: split on tags, only operate on text segments

    $segments = [regex]::Split($body, '(<[^>]+>)')
    $inSpan = $false
    $kwRegex = '(?i)\b' + [regex]::Escape($kw) + '\b'
    $replaced = $false
    for($i=0; $i -lt $segments.Length; $i++){
      $seg = $segments[$i]
      if($seg.StartsWith('<')){
        if($seg -match '^<span\s+class="gloss"'){$inSpan = $true}
        elseif($seg -match '^</span'){$inSpan = $false}
        elseif($seg -match '^<code'){$inSpan = $true} # skip inside <code>
        elseif($seg -match '^</code'){$inSpan = $false}
        elseif($seg -match '^<strong'){} # allow
        continue
      }
      if($inSpan){continue}
      if($replaced){continue}
      if($seg -match $kwRegex){
        $first = [regex]::Match($seg, $kwRegex)
        $matchedText = $first.Value
        $repl = '<span class="gloss" onclick="gOpen(&#39;' + $disp + '&#39;,&#39;' + $def + '&#39;)">' + $matchedText + '</span>'
        $segments[$i] = $seg.Substring(0,$first.Index) + $repl + $seg.Substring($first.Index + $first.Length)
        $replaced = $true
        $used[$kw] = $true
      }
    }
    if($replaced){
      $body = -join $segments
    }
  }

  return $open + $body + $close
}

$matchEvaluator = [System.Text.RegularExpressions.MatchEvaluator]$callback
$regex = New-Object System.Text.RegularExpressions.Regex($pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
$newHtml = $regex.Replace($html, $matchEvaluator)

$glossCount = ([regex]::Matches($newHtml, 'class="gloss"')).Count
Write-Host "Inline gloss spans created: $glossCount"

[System.IO.File]::WriteAllText($path, $newHtml)
Write-Host "File saved: $path"
