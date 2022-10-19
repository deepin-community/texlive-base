# The `luaprogtable` package: programmatic table interface for `LuaLaTeX`

The LaTeX3 project provides LaTeX users with a handful of macros to interpret and  manipulate various types of objects (e.g. integers, floating point numbers, token lists, sequences, ...) However, there is few existing function that allows users to interact with tables in a programmatic fashion. For example, if a user needs to modify the content of the cell on 20th row and 8th column, he/she needs to navigate the correct cell location among a pile of `&`'s and `\\`'s, which is very inefficient and error-prone. It is very difficult for someone to modify a cell based on the content within it using LaTeX macros.

`luaprogtable` aims to tackle these problems by providing a series of *programmatic* interface for tables. The `\LPTGetCellData` and `\LPTSetCell` commands allow one to access and alter the content of a single cell. The `lptview` environment allows one to modify a small sub-view of a larger table.

**For more information, please refer to the [documentation](./luaprogtable-doc.pdf)**.



## License

This package adopts MIT license.