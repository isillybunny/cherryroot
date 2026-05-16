$path = "C:\Users\cereja\Documents\cherryroot\deploy\cherry-code.html"
$html = [System.IO.File]::ReadAllText($path)

$cherrySvg = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" style="display:inline-block;vertical-align:-2px;margin-right:.3rem"><circle cx="9" cy="18" r="4" stroke="currentColor" stroke-width="1.8"/><circle cx="16" cy="19" r="4" stroke="currentColor" stroke-width="1.8"/><path d="M9 14 Q11 7 14 5" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/><path d="M16 15 Q15 9 14 5" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/></svg>'

# Use Unicode box-drawing characters via [char] codes to avoid encoding issues
$T = [char]0x251C + [char]0x2500 + " "   # T-branch: ├─
$L = [char]0x2514 + [char]0x2500 + " "   # L-branch: └─
$V = [char]0x2502 + "  "                  # vertical:  │   (3 chars wide)
$S = "   "                                # spaces

$css = @'

/* MIND MAPS */
.mm-tree{font-family:"JetBrains Mono",monospace;font-size:.78rem;line-height:1.85;color:var(--ink2);background:var(--p50);border:1px solid var(--line);border-radius:10px;padding:1rem 1.1rem;overflow-x:auto;margin:.8rem 0;white-space:nowrap}
.mm-root{font-family:"Playfair Display",serif;font-size:1.05rem;font-weight:700;color:var(--p500);margin-bottom:.6rem;padding-bottom:.4rem;border-bottom:1.5px dashed var(--p200);white-space:normal}
.mm-line{display:block;white-space:nowrap}
.mm-pipe{color:var(--p300);font-weight:500}
.mm-cat{color:var(--p500);font-weight:700;text-transform:uppercase;font-size:.62rem;letter-spacing:.12em;background:var(--p100);padding:.12rem .5rem;border-radius:5px;border:1px solid var(--p200)}
.mm-leaf{color:var(--ink);cursor:pointer;transition:all .12s;padding:.05rem .15rem;border-radius:4px}
.mm-leaf:hover{background:var(--p100);color:var(--p500)}
.mm-note{color:var(--ink4);font-size:.7rem;font-style:italic}
.mm-master-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(160px,1fr));gap:.6rem;margin:.8rem 0}
.mm-master-card{background:linear-gradient(135deg,var(--p50),white);border:1.5px solid var(--p200);border-radius:11px;padding:.85rem .9rem;cursor:pointer;transition:all .15s}
.mm-master-card:hover{transform:translateY(-2px);box-shadow:0 6px 16px rgba(201,63,79,.12);border-color:var(--p400)}
.mm-master-num{font-family:"JetBrains Mono",monospace;font-size:.55rem;color:var(--p400);letter-spacing:.18em;text-transform:uppercase;font-weight:600;margin-bottom:.25rem}
.mm-master-title{font-family:"Playfair Display",serif;font-size:.92rem;font-weight:700;color:var(--ink);line-height:1.2;margin-bottom:.2rem}
.mm-master-meta{font-size:.7rem;color:var(--ink3);font-style:italic}
.bdiv-actions{display:flex;gap:.5rem;margin-top:.85rem;flex-wrap:wrap}
.bdiv-action-btn{font-family:"JetBrains Mono",monospace;font-size:.6rem;letter-spacing:.12em;text-transform:uppercase;padding:.45rem .8rem;border-radius:8px;border:1.5px solid var(--p300);background:white;color:var(--p500);cursor:pointer;transition:all .15s;font-weight:600;display:inline-flex;align-items:center;gap:.35rem}
.bdiv-action-btn:hover{background:var(--p100);border-color:var(--p400);transform:translateY(-1px)}
.bdiv-action-btn.primary{background:linear-gradient(135deg,var(--p400),var(--p500));color:white;border-color:var(--p500)}
.bdiv-action-btn.primary:hover{box-shadow:0 4px 12px rgba(201,63,79,.3)}
body.dark .mm-tree{background:#2a1219;border-color:#3d1a26;color:#fde0e0}
body.dark .mm-master-card{background:linear-gradient(135deg,#2a1219,#1a0a12);border-color:#3d1a26}
body.dark .mm-master-title{color:#fde0e0}

/* QUIZ */
.quiz-hub-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:.7rem;margin:.8rem 0}
.quiz-hub-card{background:white;border:1.5px solid var(--p200);border-radius:11px;padding:.85rem .9rem;transition:all .15s}
.quiz-hub-card:hover{border-color:var(--p400);box-shadow:0 4px 12px rgba(201,63,79,.1)}
.quiz-hub-block{font-family:"JetBrains Mono",monospace;font-size:.55rem;color:var(--p400);letter-spacing:.18em;text-transform:uppercase;font-weight:600;margin-bottom:.3rem}
.quiz-hub-title{font-family:"Playfair Display",serif;font-size:.95rem;font-weight:700;color:var(--ink);margin-bottom:.55rem;line-height:1.2}
.quiz-hub-btns{display:flex;gap:.4rem}
.quiz-hub-btn{flex:1;padding:.5rem .55rem;border-radius:7px;border:1.5px solid var(--p300);background:white;color:var(--p500);cursor:pointer;font-family:"JetBrains Mono",monospace;font-size:.6rem;letter-spacing:.08em;text-transform:uppercase;font-weight:600;transition:all .12s}
.quiz-hub-btn:hover{background:var(--p100);border-color:var(--p500)}
.quiz-hub-btn .qbest{display:block;font-size:.5rem;color:var(--ink4);letter-spacing:.1em;margin-top:.15rem;text-transform:none;font-weight:500}
.quiz-overlay{position:fixed;inset:0;background:rgba(28,12,20,.6);z-index:400;display:none;align-items:flex-start;justify-content:center;padding:1.5rem 1rem;overflow-y:auto}
.quiz-overlay.on{display:flex;animation:gfade .15s ease}
.quiz-modal{background:white;border-radius:14px;max-width:560px;width:100%;overflow:hidden;box-shadow:0 8px 40px rgba(201,63,79,.35);margin:auto}
.quiz-bar{height:5px;background:var(--p100);position:relative}
.quiz-bar-fill{position:absolute;left:0;top:0;height:100%;background:linear-gradient(90deg,var(--p400),var(--p500));transition:width .3s ease;width:0%}
.quiz-header{padding:.85rem 1.1rem;border-bottom:1px solid var(--line);display:flex;align-items:center;justify-content:space-between;background:var(--p50);gap:.5rem}
.quiz-header-info{font-family:"JetBrains Mono",monospace;font-size:.6rem;color:var(--p500);letter-spacing:.15em;text-transform:uppercase;font-weight:600;flex:1}
.quiz-header-progress{font-family:"JetBrains Mono",monospace;font-size:.7rem;color:var(--ink2);font-weight:600}
.quiz-close{background:none;border:none;cursor:pointer;color:var(--ink3);padding:.3rem;font-size:1.4rem;line-height:1}
.quiz-body{padding:1.1rem 1.2rem}
.quiz-q{font-family:"Playfair Display",serif;font-size:1.05rem;font-weight:700;color:var(--ink);line-height:1.35;margin-bottom:.9rem}
.quiz-q code{font-family:"JetBrains Mono",monospace;font-size:.85rem;background:var(--code-bg);color:var(--code-string);padding:.15rem .4rem;border-radius:4px;font-weight:500}
.quiz-q pre{font-family:"JetBrains Mono",monospace;font-size:.76rem;background:var(--code-bg);color:var(--code-text);padding:.7rem .85rem;border-radius:8px;line-height:1.6;margin:.55rem 0;overflow-x:auto;white-space:pre}
.quiz-options{display:flex;flex-direction:column;gap:.5rem;margin-bottom:.8rem}
.quiz-opt{padding:.7rem .9rem;background:var(--p50);border:1.5px solid var(--line);border-radius:9px;cursor:pointer;font-size:.85rem;color:var(--ink2);transition:all .15s;text-align:left;font-family:"DM Sans",sans-serif;line-height:1.4}
.quiz-opt:hover{background:var(--p100);border-color:var(--p300)}
.quiz-opt.selected{background:var(--p100);border-color:var(--p400);color:var(--ink)}
.quiz-opt.correct{background:var(--p500)!important;color:white!important;border-color:var(--p500)!important;font-weight:600}
.quiz-opt.wrong{opacity:.55;border-style:dashed;border-color:var(--p300);background:white;color:var(--ink3)}
.quiz-opt:disabled{cursor:default}
.quiz-expl{background:linear-gradient(135deg,var(--p100),var(--p50));border-left:3px solid var(--p500);border-radius:0 9px 9px 0;padding:.7rem .85rem;font-size:.82rem;color:var(--ink2);line-height:1.55;margin-bottom:.6rem;display:none}
.quiz-expl.on{display:block}
.quiz-expl-label{font-family:"JetBrains Mono",monospace;font-size:.55rem;color:var(--p500);letter-spacing:.18em;text-transform:uppercase;font-weight:600;margin-bottom:.25rem}
.quiz-footer{padding:.8rem 1.2rem 1rem;display:flex;justify-content:space-between;align-items:center;gap:.5rem;border-top:1px solid var(--line);background:var(--p50)}
.quiz-btn{padding:.55rem .9rem;border-radius:8px;cursor:pointer;font-family:"JetBrains Mono",monospace;font-size:.6rem;letter-spacing:.12em;text-transform:uppercase;border:1.5px solid;font-weight:600;transition:all .15s}
.quiz-btn-primary{background:linear-gradient(135deg,var(--p400),var(--p500));color:white;border-color:var(--p500)}
.quiz-btn-primary:hover{transform:translateY(-1px);box-shadow:0 4px 12px rgba(201,63,79,.3)}
.quiz-btn-primary:disabled{opacity:.4;cursor:not-allowed;transform:none;box-shadow:none}
.quiz-btn-ghost{background:white;color:var(--ink3);border-color:var(--line)}
.quiz-btn-ghost:hover{background:var(--p50);border-color:var(--p300)}
.quiz-result{text-align:center;padding:1.5rem 1rem}
.quiz-result-score{font-family:"Playfair Display",serif;font-size:3rem;font-weight:700;color:var(--p500);line-height:1;margin-bottom:.4rem}
.quiz-result-out{font-family:"JetBrains Mono",monospace;font-size:.7rem;color:var(--ink3);letter-spacing:.15em;text-transform:uppercase;margin-bottom:.8rem;font-weight:600}
.quiz-result-msg{font-size:.92rem;color:var(--ink2);line-height:1.5;margin-bottom:1rem;font-style:italic}
.quiz-result-best{display:inline-block;font-family:"JetBrains Mono",monospace;font-size:.62rem;background:var(--p100);color:var(--p500);padding:.35rem .7rem;border-radius:99px;letter-spacing:.1em;border:1.5px solid var(--p200);font-weight:600;margin-bottom:1rem}
body.dark .quiz-modal{background:#1a0a12;color:#fde0e0}
body.dark .quiz-header{background:#2a1219;border-color:#3d1a26}
body.dark .quiz-body{color:#fde0e0}
body.dark .quiz-q{color:#fde0e0}
body.dark .quiz-opt{background:#2a1219;color:#fde0e0;border-color:#3d1a26}
body.dark .quiz-footer{background:#2a1219;border-color:#3d1a26}
body.dark .quiz-hub-card{background:#1a0a12;border-color:#3d1a26}
body.dark .quiz-hub-title{color:#fde0e0}
'@

$html = $html -replace '(?s)(/\* Util \*/\s*\.center\{text-align:center\})', ($css + "`r`n`r`n" + '$1')

# Sidebar nav
$navEntries = @'
<div class="ndiv"></div>
<div class="ns">Mind Maps</div>
<div class="ni" onclick="go('mm-master',this)"><span class="cd">MAP</span>Master Map</div>
<div class="ni" onclick="go('mm-b1',this)"><span class="cd">M-1</span>Block 1 Map</div>
<div class="ni" onclick="go('mm-b2',this)"><span class="cd">M-2</span>Block 2 Map</div>
<div class="ni" onclick="go('mm-b3',this)"><span class="cd">M-3</span>Block 3 Map</div>
<div class="ni" onclick="go('mm-b4',this)"><span class="cd">M-4</span>Block 4 Map</div>
<div class="ni" onclick="go('mm-b5',this)"><span class="cd">M-5</span>Block 5 Map</div>
<div class="ni" onclick="go('mm-b6',this)"><span class="cd">M-6</span>Block 6 Map</div>
<div class="ni" onclick="go('mm-b7',this)"><span class="cd">M-7</span>Block 7 Map</div>
<div class="ni" onclick="go('mm-b8',this)"><span class="cd">M-8</span>Block 8 Map</div>
<div class="ni" onclick="go('mm-b9',this)"><span class="cd">M-9</span>Block 9 Map</div>
<div class="ndiv"></div>
<div class="ns">Quiz</div>
<div class="ni" onclick="go('quiz',this)"><span class="cd">QZ</span>Quiz Hub</div>

</nav>
'@

$html = $html -replace '\s*</nav>', ("`r`n" + $navEntries)

function MMPage($id, $blockNum, $blockTitle, $categories){
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine('<div class="pg" id="pg-mm-' + $id + '">')
  [void]$sb.AppendLine('<div class="ph">')
  [void]$sb.AppendLine('<div class="bc">cherry code <span>&rsaquo;</span> mind map <span>&rsaquo;</span> block ' + $blockNum + '</div>')
  [void]$sb.AppendLine('<div class="pt">Block ' + $blockNum + ' Mind Map</div>')
  [void]$sb.AppendLine('<div class="ps">' + $blockTitle + ' - terms grouped by theme.</div>')
  [void]$sb.AppendLine('</div>')
  [void]$sb.AppendLine('<div class="mm-tree">')
  [void]$sb.AppendLine('<div class="mm-root">' + $cherrySvg + ' Block ' + $blockNum + ' &middot; ' + $blockTitle + '</div>')
  $catCount = $categories.Count
  for($ci=0; $ci -lt $catCount; $ci++){
    $cat = $categories[$ci]
    $isLastCat = ($ci -eq $catCount - 1)
    $catPipe = if($isLastCat){ $L } else { $T }
    [void]$sb.AppendLine('<div class="mm-line"><span class="mm-pipe">' + $catPipe + '</span><span class="mm-cat">' + $cat.name + '</span></div>')
    $leaves = $cat.leaves
    for($li=0; $li -lt $leaves.Count; $li++){
      $leaf = $leaves[$li]
      $isLastLeaf = ($li -eq $leaves.Count - 1)
      $vert = if($isLastCat){ $S } else { $V }
      $branch = if($isLastLeaf){ $L } else { $T }
      $note = ''
      if($leaf.note -and $leaf.note.Length -gt 0){
        $note = ' <span class="mm-note">- ' + $leaf.note + '</span>'
      }
      [void]$sb.AppendLine('<div class="mm-line"><span class="mm-pipe">' + $vert + $branch + '</span><span class="mm-leaf gloss" onclick="go(' + "'" + $leaf.id + "'" + ')">' + $leaf.name + '</span>' + $note + '</div>')
    }
  }
  [void]$sb.AppendLine('</div>')
  [void]$sb.AppendLine('</div>')
  return $sb.ToString()
}

$b1 = MMPage 'b1' 1 'Fundamentals' @(
  @{name='Core Concepts'; leaves=@(
    @{id='f01';name='Programming';note='instructions for a computer'},
    @{id='f02';name='Code';note='the text of a program'},
    @{id='f04';name='Bug';note='a flaw in code'},
    @{id='f05';name='Debug';note='find and remove bugs'}
  )},
  @{name='Tooling'; leaves=@(
    @{id='f06';name='IDE';note='editor + tools'},
    @{id='f07';name='Terminal';note='text command interface'},
    @{id='f03';name='Compiler vs Interpreter';note='two ways to run code'}
  )},
  @{name='Meta'; leaves=@(
    @{id='f08';name='Syntax';note='language rules'},
    @{id='f09';name='Runtime';note='execution phase'},
    @{id='f10';name='Paradigm';note='style of programming'}
  )}
)

$b2 = MMPage 'b2' 2 'Types and Variables' @(
  @{name='Primitive Types'; leaves=@(
    @{id='t03';name='String';note='text'},
    @{id='t04';name='Integer';note='whole numbers'},
    @{id='t05';name='Float';note='decimals'},
    @{id='t06';name='Boolean';note='true / false'}
  )},
  @{name='Container Types'; leaves=@(
    @{id='t08';name='Array / List';note='ordered values'},
    @{id='t09';name='Dict / Object';note='key-value map'}
  )},
  @{name='Concepts'; leaves=@(
    @{id='t01';name='Variable';note='named container'},
    @{id='t10';name='Constant';note='cannot reassign'},
    @{id='t11';name='Scope';note='visibility region'},
    @{id='t12';name='Type Casting';note='convert types'},
    @{id='t07';name='Null / None';note='no value'},
    @{id='t02';name='Data Type';note='kind of value'}
  )}
)

$b3 = MMPage 'b3' 3 'Operators and Expressions' @(
  @{name='Math'; leaves=@(
    @{id='o01';name='Arithmetic Operators';note='plus minus times divide'},
    @{id='o06';name='Modulo Operator';note='remainder'},
    @{id='o07';name='Increment / Decrement';note='plus-plus, minus-minus'}
  )},
  @{name='Logic'; leaves=@(
    @{id='o02';name='Comparison Operators';note='equals, less, greater'},
    @{id='o03';name='Logical Operators';note='and, or, not'}
  )},
  @{name='Other'; leaves=@(
    @{id='o04';name='Assignment Operators';note='equals, plus-equals'},
    @{id='o05';name='String Concatenation';note='joining strings'},
    @{id='o08';name='Operator Precedence';note='order of ops'},
    @{id='o09';name='Expression vs Statement';note='value vs action'},
    @{id='o10';name='Side Effects';note='non-return changes'}
  )}
)

$b4 = MMPage 'b4' 4 'Control Flow' @(
  @{name='Branching'; leaves=@(
    @{id='c01';name='If Statement';note='condition is true'},
    @{id='c02';name='Else / Elif';note='other cases'},
    @{id='c03';name='Switch / Case';note='many branches'},
    @{id='c09';name='Ternary Operator';note='one-line if/else'}
  )},
  @{name='Loops'; leaves=@(
    @{id='c04';name='While Loop';note='repeat until false'},
    @{id='c05';name='For Loop';note='known count'},
    @{id='c06';name='For-Each Loop';note='iterate collection'},
    @{id='c10';name='Nested Loops';note='loop inside loop'}
  )},
  @{name='Control'; leaves=@(
    @{id='c07';name='Break';note='exit loop'},
    @{id='c08';name='Continue';note='skip iteration'}
  )}
)

$b5 = MMPage 'b5' 5 'Functions' @(
  @{name='Basics'; leaves=@(
    @{id='n01';name='Function';note='reusable code block'},
    @{id='n02';name='Parameter';note='declared input'},
    @{id='n03';name='Argument';note='value passed in'},
    @{id='n04';name='Return Value';note='output to caller'}
  )},
  @{name='Concepts'; leaves=@(
    @{id='n05';name='Pure Function';note='no side effects'},
    @{id='n06';name='Recursion';note='calls itself'},
    @{id='n07';name='Closure';note='captures outer scope'},
    @{id='n12';name='Higher-Order Functions';note='functions of functions'},
    @{id='n11';name='Function Scope';note='local variables'}
  )},
  @{name='Special'; leaves=@(
    @{id='n08';name='Lambda / Arrow';note='anonymous fn'},
    @{id='n09';name='Default Arguments';note='optional params'},
    @{id='n10';name='*args / **kwargs';note='variable args'}
  )}
)

$b6 = MMPage 'b6' 6 'Data Structures' @(
  @{name='Linear'; leaves=@(
    @{id='s01';name='Array';note='indexed sequence'},
    @{id='s02';name='List';note='mutable sequence'},
    @{id='s03';name='Tuple';note='immutable sequence'},
    @{id='s06';name='Stack';note='LIFO'},
    @{id='s07';name='Queue';note='FIFO'},
    @{id='s08';name='Linked List';note='node chain'}
  )},
  @{name='Map-based'; leaves=@(
    @{id='s04';name='Dictionary / Map';note='key-value'},
    @{id='s05';name='Set';note='unique values'},
    @{id='s11';name='Hash Table';note='O(1) lookup'}
  )},
  @{name='Hierarchical'; leaves=@(
    @{id='s09';name='Tree';note='root + children'},
    @{id='s10';name='Graph';note='nodes + edges'}
  )},
  @{name='Analysis'; leaves=@(
    @{id='s12';name='Big O Notation';note='growth rate'}
  )}
)

$b7 = MMPage 'b7' 7 'Object-Oriented Programming' @(
  @{name='Building Blocks'; leaves=@(
    @{id='p01';name='Class';note='blueprint'},
    @{id='p02';name='Object';note='thing with state'},
    @{id='p03';name='Instance';note='specific object'},
    @{id='p04';name='Attribute';note='object data'},
    @{id='p05';name='Method';note='object behavior'}
  )},
  @{name='Lifecycle'; leaves=@(
    @{id='p06';name='Constructor';note='creation method'},
    @{id='p12';name='this / self';note='current instance'}
  )},
  @{name='Principles'; leaves=@(
    @{id='p07';name='Inheritance';note='child from parent'},
    @{id='p08';name='Polymorphism';note='same name, many forms'},
    @{id='p09';name='Encapsulation';note='hide internals'},
    @{id='p11';name='Abstraction';note='simple interface'},
    @{id='p10';name='Interface';note='contract'}
  )}
)

$b8 = MMPage 'b8' 8 'Errors and Debugging' @(
  @{name='Errors'; leaves=@(
    @{id='e01';name='Exception';note='error event'},
    @{id='e10';name='Syntax vs Runtime Error';note='parse vs run'},
    @{id='e09';name='Edge Case';note='unusual input'}
  )},
  @{name='Handling'; leaves=@(
    @{id='e02';name='Try / Catch';note='catch errors'},
    @{id='e03';name='Throw / Raise';note='cause an error'},
    @{id='e04';name='Stack Trace';note='error call list'}
  )},
  @{name='Debugging'; leaves=@(
    @{id='e05';name='Breakpoint';note='pause point'},
    @{id='e08';name='Debugger';note='inspect tool'},
    @{id='e06';name='print / console.log';note='quick output'},
    @{id='e07';name='Linter';note='static checker'}
  )}
)

$b9 = MMPage 'b9' 9 'Best Practices' @(
  @{name='Code Quality'; leaves=@(
    @{id='b01';name='Naming Conventions';note='readable names'},
    @{id='b02';name='Indentation';note='visible structure'},
    @{id='b03';name='Comments';note='explain why'},
    @{id='b04';name='DRY Principle';note='do not repeat yourself'},
    @{id='b05';name='SOLID Principles';note='5 OOP guides'}
  )},
  @{name='Workflow'; leaves=@(
    @{id='b06';name='Refactor';note='restructure safely'},
    @{id='b07';name='Code Review';note='peer feedback'},
    @{id='b08';name='Version Control';note='track changes'},
    @{id='b09';name='Testing';note='verify code'},
    @{id='b10';name='Documentation';note='user-facing notes'}
  )}
)

$master = @'
<div class="pg" id="pg-mm-master">
<div class="ph">
<div class="bc">cherry code <span>&rsaquo;</span> mind maps</div>
<div class="pt">Mind Maps - Master</div>
<div class="ps">Jump to any block map. Each shows that block's terms grouped by theme.</div>
</div>
<div class="mm-master-grid">
<div class="mm-master-card" onclick="go('mm-b1')"><div class="mm-master-num">Block 1</div><div class="mm-master-title">Fundamentals</div><div class="mm-master-meta">10 terms - core concepts</div></div>
<div class="mm-master-card" onclick="go('mm-b2')"><div class="mm-master-num">Block 2</div><div class="mm-master-title">Types &amp; Variables</div><div class="mm-master-meta">12 terms - data basics</div></div>
<div class="mm-master-card" onclick="go('mm-b3')"><div class="mm-master-num">Block 3</div><div class="mm-master-title">Operators</div><div class="mm-master-meta">10 terms - expressions</div></div>
<div class="mm-master-card" onclick="go('mm-b4')"><div class="mm-master-num">Block 4</div><div class="mm-master-title">Control Flow</div><div class="mm-master-meta">10 terms - branch &amp; loop</div></div>
<div class="mm-master-card" onclick="go('mm-b5')"><div class="mm-master-num">Block 5</div><div class="mm-master-title">Functions</div><div class="mm-master-meta">12 terms - reusable blocks</div></div>
<div class="mm-master-card" onclick="go('mm-b6')"><div class="mm-master-num">Block 6</div><div class="mm-master-title">Data Structures</div><div class="mm-master-meta">12 terms - organize data</div></div>
<div class="mm-master-card" onclick="go('mm-b7')"><div class="mm-master-num">Block 7</div><div class="mm-master-title">OOP</div><div class="mm-master-meta">12 terms - classes &amp; objects</div></div>
<div class="mm-master-card" onclick="go('mm-b8')"><div class="mm-master-num">Block 8</div><div class="mm-master-title">Errors &amp; Debugging</div><div class="mm-master-meta">10 terms - find faults</div></div>
<div class="mm-master-card" onclick="go('mm-b9')"><div class="mm-master-num">Block 9</div><div class="mm-master-title">Best Practices</div><div class="mm-master-meta">10 terms - write well</div></div>
</div>
</div>
'@

$quizHub = @'
<div class="pg" id="pg-quiz">
<div class="ph">
<div class="bc">cherry code <span>&rsaquo;</span> quiz</div>
<div class="pt">Quiz Hub</div>
<div class="ps">9 blocks - 20 questions each (10 theory + 10 practice). 180 total.</div>
</div>
<div class="quiz-hub-grid" id="quizHubGrid"></div>
</div>
'@

$mmAll = $master + "`r`n" + $b1 + "`r`n" + $b2 + "`r`n" + $b3 + "`r`n" + $b4 + "`r`n" + $b5 + "`r`n" + $b6 + "`r`n" + $b7 + "`r`n" + $b8 + "`r`n" + $b9 + "`r`n" + $quizHub + "`r`n"

$quizOverlay = @'
<!-- QUIZ OVERLAY -->
<div class="quiz-overlay" id="quizOverlay" onclick="if(event.target.id===&#39;quizOverlay&#39;)closeQuiz()">
<div class="quiz-modal">
<div class="quiz-bar"><div class="quiz-bar-fill" id="quizBarFill"></div></div>
<div class="quiz-header">
<div class="quiz-header-info" id="quizHeaderInfo">Block 1 - Theory</div>
<div class="quiz-header-progress" id="quizHeaderProgress">1 / 10</div>
<button class="quiz-close" onclick="closeQuiz()">&times;</button>
</div>
<div class="quiz-body" id="quizBody"></div>
<div class="quiz-footer" id="quizFooter">
<button class="quiz-btn quiz-btn-ghost" onclick="closeQuiz()">Exit</button>
<button class="quiz-btn quiz-btn-primary" id="quizActionBtn" onclick="quizAction()" disabled>Submit</button>
</div>
</div>
</div>
'@

$html = $html -replace '\s*</main>', ("`r`n" + $mmAll + "`r`n</main>" + "`r`n" + $quizOverlay)

# Add Mind Map + Quiz buttons in each bdiv page
for($i=1; $i -le 9; $i++){
  $needle = '(?s)(<div class="pg" id="pg-bdiv' + $i + '">.*?<div class="bdiv-footer">.*?</div>)'
  $replacement = '$1' + "`r`n" + '<div class="bdiv-actions"><button class="bdiv-action-btn primary" onclick="go(' + "'mm-b$i'" + ')">Mind Map</button><button class="bdiv-action-btn" onclick="openQuiz(' + $i + ',' + "'theory'" + ')">Theory Quiz</button><button class="bdiv-action-btn" onclick="openQuiz(' + $i + ',' + "'practice'" + ')">Practice Quiz</button></div>'
  $html = [regex]::Replace($html, $needle, $replacement)
}

[System.IO.File]::WriteAllText($path, $html, [System.Text.UTF8Encoding]::new($false))
$mmCount = ([regex]::Matches($html, 'id="pg-mm-')).Count
$mmActions = ([regex]::Matches($html, 'class="bdiv-actions"')).Count
Write-Host "Mind map pages: $mmCount"
Write-Host "Block dividers updated: $mmActions"
