;;; ekdosis.el --- AUCTeX style for `ekdosis.sty'
;; This file is part of the `ekdosis' package

;; ekdosis -- TEI xml compliant critical editions
;; Copyright (C) 2020--2021  Robert Alessi

;; Please send error reports and suggestions for improvements to Robert
;; Alessi <alessi@robertalessi.net>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see
;; <http://www.gnu.org/licenses/>.

(defvar LaTeX-ekdosis-preamble-options
  '(("parnotes" ("true" "false" "roman"))
    ("teiexport" ("true" "false" "tidy"))
    ("layout" ("float" "footins" "keyfloat" "fitapp"))
    ("divs" ("ekdosis" "latex"))
    ("poetry" ("verse"))
    ("parnotes" ("true" "false" "roman"))
    ("teiexport" ("true" "false" "tidy")))
  "Package options for the ekdosis package.")

(defun LaTeX-ekdosis-package-options ()
  "Prompt for package options for ekdosis package."
  (TeX-read-key-val t LaTeX-ekdosis-preamble-options))

(defun LaTeX-ekdosis-long-key-val (optional arg)
  (let ((crm-local-completion-map
	 (remove (assoc 32 crm-local-completion-map)
		 crm-local-completion-map))
	(minibuffer-local-completion-map
	 (remove (assoc 32 minibuffer-local-completion-map)
		 minibuffer-local-completion-map)))
    (TeX-argument-insert
     (TeX-read-key-val optional arg)
     optional)))

(defvar LaTeX-ekdosis-ekdsetup-options
  '(("showpagebreaks" ("true" "false"))
    ("spbmk")
    ("hpbmk"))
  "List of local options for ekdsetup macro.")

(defvar LaTeX-ekdosis-declarewitness-options
  '(("settlement")
    ("institution")
    ("repository")
    ("collection")
    ("idno")
    ("msName")
    ("origDate")
    ("locus"))
  "List of local options for DeclareWitness macro.")

(defvar LaTeX-ekdosis-declarehand-options
  '(("note"))
  "List of local options for DeclareHand macro.")

(defvar LaTeX-ekdosis-declarescholar-options
  '(("rawname")
    ("forename")
    ("surname")
    ("addname")
    ("note"))
  "List of local options for DeclareScholar macro.")

(defvar LaTeX-ekdosis-app-options
  '(("type"))
  "Local option for app|note macro.")

(defvar LaTeX-ekdosis-lem-options
  '(("wit")
    ("source")
    ("resp")
    ("alt")
    ("pre")
    ("post")
    ("prewit")
    ("postwit")
    ("sep")
    ("type")
    ("num")
    ("nonum")
    ("nolem" ("true" "false"))
    ("nosep" ("true" "false")))
  "Local options for lem macro")

(defvar LaTeX-ekdosis-rdg-options
  '(("wit")
    ("source")
    ("resp")
    ("alt")
    ("pre")
    ("post")
    ("prewit")
    ("postwit")
    ("type")
    ("nordg" ("true" "false")))
  "Local options for rdg macro.")

(defvar LaTeX-ekdosis-note-options
  '(("type")
    ("lem")
    ("labelb")
    ("labele")
    ("sep")
    ("nosep")
    ("num")
    ("nonum")
    ("pre")
    ("post"))
  "Local options for note macro.")

(defvar LaTeX-ekdosis-note-star-options
  '(("pre")
    ("post"))
  "Local options for note* macro.")

(defvar LaTeX-ekdosis-rdggrp-options
  '(("type"))
  "Local options for rdgGrp macro.")

(defvar LaTeX-ekdosis-setcritsymbols-options
  '(("suppbegin")
    ("suppend")
    ("delbegin")
    ("delend")
    ("sicbegin")
    ("sicend")
    ("gapmark"))
  "List of local options for setcritsymbols macro.")

(defvar LaTeX-ekdosis-sethooks-options
  '(("appfontsize")
    ("refnumstyle")
    ("postrefnum")
    ("lemmastyle")
    ("readingstyle")
    ("initialrule")
    ("noinitialrule")
    ("keyparopts")
    ("appheight")
    ("fitalgorithm" ("fontsize" "hybrid" "areasize" "squeeze")))
  "List of local options for sethooks macro.")

(defvar LaTeX-ekdosis-gap-options
  '(("reason")
    ("unit")
    ("quantity")
    ("extent"))
  "List of local options for gap macro.")

(defvar LaTeX-ekdosis-setapparatus-options
  '(("direction" ("LR" "RL"))
    ("sep")
    ("delim")
    ("bhook")
    ("ehook")
    ("rule")
    ("norule")
    ("lang")
    ("notelang"))
  "List of local options for setapparatus macro.")

(defvar LaTeX-ekdosis-declareapparatus-options
  '(("direction" ("LR" "RL"))
    ("sep")
    ("delim")
    ("bhook")
    ("ehook")
    ("rule")
    ("norule")
    ("lang")
    ("notelang")
    ("maxentries"))
  "List of local options for declareapparatus macro.")

(defvar LaTeX-ekdosis-setlineation-options
  '(("lineation" ("page" "document" "none"))
    ("sep")
    ("modulo")
    ("modulonum")
    ("margin" ("right" "left" "inner" "outer"))
    ("numbers" ("elided" "full"))
    ("vlineation" ("page" "document"))
    ("vmodulo")
    ("vmargin" ("right" "left"))
    ("continuousvnum"))
  "List of local options for setlineation macro.")

(defvar LaTeX-ekdosis-ekddiv-options
  '(("type")
    ("n")
    ("head")
    ("barehead")
    ("depth" ("1" "2" "3" "4" "5" "6" "7" "8" "9"))
    ("toc" ("book" "part" "chapter" "section" "subsection"
	    "subsubsection" "paragraph" "subparagraph"))
    ("mark"))
  "List of local options for ekddiv macro.")

(defvar LaTeX-ekdosis-setteixmlexport-options
  '(("autopar" ("true" "false")))
  "List of local options for SetTEIxmlExport macro.")

(defvar LaTeX-ekdosis-alignment-key-val-options
  '(("tcols")
    ("lcols")
    ("texts")
    ("apparatus")
    ("flush" ("true" "false"))
    ("paired" ("true" "false"))
    ("lineation" ("page" "document")))
  "Local options for alignment env.")

(defvar LaTeX-ekdosis-ekdverse-key-val-options
  '(("width")
    ("type"))
  "Local options for ekdverse env.")

(defvar LaTeX-ekdosis-ekdstanza-key-val-options
  '(("type"))
  "Local options for ekdstanza env.")

(TeX-add-style-hook
 "ekdosis"
 (lambda ()
   ;; Folding features:
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("{1}" ("app"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("{7}||{6}||{5}||{4}||{3}||{2}||{1}" ("lem"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("[r]" ("rdg"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("[n]" ("note"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("[l]" ("linelabel"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("{{1}}" ("surplus"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("<{1}>" ("supplied"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("{1}" ("sic"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("[g]" ("gap"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("{1}" ("mbox"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("{1}" ("rdgGrp"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("[pb]" ("ekdpb"))
   		t)
   (add-to-list (make-local-variable 'LaTeX-fold-macro-spec-list)
   		'("[t]" ("teidirect"))
   		t)
   ;; This package relies on lualatex, so check for it:
   (TeX-check-engine-add-engines 'luatex)
   (TeX-add-symbols
    '("ekdsetup" (TeX-arg-key-val LaTeX-ekdosis-ekdsetup-options))
    '("DeclareWitness" "xml:id" "rendition" "description"
      [ LaTeX-ekdosis-long-key-val LaTeX-ekdosis-declarewitness-options ]
      0)
    '("DeclareHand" "xml:id" "base ms." "rendition"
      [ LaTeX-ekdosis-long-key-val LaTeX-ekdosis-declarehand-options ]
      0)
    '("DeclareSource" "xml:id" "rendition"
      0)
    '("DeclareScholar" "xml:id" "rendition"
      [ LaTeX-ekdosis-long-key-val LaTeX-ekdosis-declarescholar-options ]
      0)
    '("DeclareShorthand" "xml:id" "rendition" "csv-list of ids"
      0)
    '("getsiglum" "csv-list"
      0)
    '("SigLine" "unique id"
      0)
    '("linelabel" "label"
      0)
    '("app" [ TeX-arg-key-val LaTeX-ekdosis-app-options ]
      t)
    '("lem" [ LaTeX-ekdosis-long-key-val LaTeX-ekdosis-lem-options ]
      t)
    '("rdg" [ LaTeX-ekdosis-long-key-val LaTeX-ekdosis-rdg-options ]
      t)
    '("note" [ LaTeX-ekdosis-long-key-val LaTeX-ekdosis-note-options ]
      t)
    '("note*" [ LaTeX-ekdosis-long-key-val LaTeX-ekdosis-note-star-options ]
      t)
    '("rdgGrp" [ TeX-arg-key-val LaTeX-ekdosis-rdggrp-options ]
      t)
    '("SetCritSymbols" (TeX-arg-key-val LaTeX-ekdosis-setcritsymbols-options))
    '("supplied" "supplied text" 0)
    '("surplus" "surplus text" 0)
    '("gap" (TeX-arg-key-val LaTeX-ekdosis-gap-options))
    '("sic" "sic text" 0)
    '("SetAlignment"
      (TeX-arg-key-val LaTeX-ekdosis-alignment-key-val-options))
    '("columnratio" "fraction(s)" [ "fraction(s)" ] )
    '("setcolumnwidth" "width/gap" [ "width/gap" ] )
    '("marginparthreshold" "number of columns" [ "number of columns" ] )
    '("footnotelayout"
      (TeX-arg-eval completing-read
                    (TeX-argument-prompt nil nil "Layout")
                    '("c" "m" "p")))
    '("SetHooks" (TeX-arg-key-val LaTeX-ekdosis-sethooks-options))
    '("SetLTRapp" 0)
    '("SetRTLapp" 0)
    '("SetSeparator" "separator" 0)
    '("SetBeginApparatus" "chars|commands" 0)
    '("SetEndApparatus" "chars" 0)
    '("SetUnitDelimiter" "delimiter" 0)
    '("SetDefaultRule" "command" 0)
    '("SetApparatusLanguage" "lang name" 0)
    '("SetApparatusNoteLanguage" "lang name" 0)
    '("SetApparatus" (TeX-arg-key-val LaTeX-ekdosis-setapparatus-options))
    '("footnoteruletrue" 0)
    '("footnoterulefalse" 0)
    '("SetDefaultApparatus" "apparatus name" 0)
    '("DeclareApparatus" "apparatus name"
      [ TeX-arg-key-val LaTeX-ekdosis-declareapparatus-options ] 0)
    '("indentpattern" "pattern" 0)
    '("vin" 0)
    '("SetLineation" (TeX-arg-key-val LaTeX-ekdosis-setlineation-options))
    '("innerlinenumbers" 0)
    '("outerlinenumbers" 0)
    '("modulolinenumbers" [ "number" ] )
    '("resetlinenumber" [ "number" ] )
    '("resetvlinenumber" [ "number" ] )
    '("verselinenumfont" "commands" 0)
    '("SetLR" 0)
    '("SetRL" 0)
    '("MkBodyDivs" "div1" "div2" "div3" "div4" "div5" "div6" 0)
    '("ekddiv" (LaTeX-ekdosis-long-key-val LaTeX-ekdosis-ekddiv-options))
    '("FormatDiv" "number" "code before" "code after" 0)
    '("ekdmark" 0)
    '("endmark" 0)
    '("ekdprintmark"
      (TeX-arg-eval completing-read
                    (TeX-argument-prompt nil nil "selector")
                    '("HEL" "HEC" "HER" "HOL" "HOC" "HOR"
		      "FEL" "FEC" "FER" "FOL" "FOC" "FOR"))
      "signpost" 0 )
    '("ekdnohfmark" 0)
    '("ekdresethfmarks" 0)
    '("ekdpb" [ "page number" ] "line number" 0)
    '("ekdpb*")
    '("addentries" [ "layer" ] "number" 0)
    '("SetTEIFilename" "base name" 0)
    '("SetTEIxmlExport" (TeX-arg-key-val
			 LaTeX-ekdosis-setteixmlexport-options))
    '("TeXtoTEI" "csname" "TEI element" [ "TEI attributes" ] 0)
    '("EnvtoTEI" "env name" "TEI element" [ "TEI attributes" ] 0)
    '("EnvtoTEI*" "env name" "TEI element" [ "TEI attributes" ] 0)
    '("TeXtoTEIPat" "TeX pattern" "TEI pattern" 0)
    '("teidirect" [ "xml attributes" ] "xml element" "code" 0)
    '("AddxmlBibResource" "basename or name.xml" 0)
    )
 (LaTeX-add-environments
  "ekdosis"
  "edition"
  "translation"
  "edition*"
  "translation*"
  "patverse"
  "ekdpar"
  '("alignment" LaTeX-env-args
    [ TeX-arg-key-val LaTeX-ekdosis-alignment-key-val-options ] )
  '("ekdverse" LaTeX-env-args
    [ TeX-arg-key-val LaTeX-ekdosis-ekdverse-key-val-options ] )
  '("ekdstanza" LaTeX-env-args
    [ TeX-arg-key-val LaTeX-ekdosis-ekdstanza-key-val-options ] )
  )
 )
 LaTeX-dialect)

;;; ekdosis.el ends here
