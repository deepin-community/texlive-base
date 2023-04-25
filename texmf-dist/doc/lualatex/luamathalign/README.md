# The `luamathalign` package for LuaLaTeX

With `amsmath`'s `align` environment simple equations can be aligned easily, e.g.

```tex
2  &=1+1\\
2-1&=1
```

but even just adding an underline makes this much more complicated. E.g.

```tex
2  &=1+1\\
\underline{2-1&=1}
```

is not allowed. Similarly alignment points surrounded by `\left` and `\right`
or points nested in other environments do not work.

For LuaLaTeX this can be solved with luamathalign. It adds a command `\AlignHere`
which behaves mustly like `&` except that it's allowed almost anywhere. E.g.

```
                      2 &= 1+1\\
\underline{2-1 \AlignHere= 1}
```


Licensed under the LPPL v1.3c or later.
