# New features

pgf-pie now wraps the entire pie into a \scope environment and additionally
defers lookup of unknown /pgfpie keys to the /pgf and /tikz namespaces. This
paves the way for all kinds of improvements such as easy setting of global pie
options like font or placement on the background layer. Further is allows
referring to the pie as a node via local bounding box and moving the pie around
on the canvas using the shift key.

# Bug fixes

pgf-pie tokenizes its arguments which led to breakage when used with babel.
For now, babel functionality is simply disabled for the entire pie.

