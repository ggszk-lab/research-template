## =====================================================================
## 論文ビルドの標準 Makefile（research-template 雛形）
##
## `make`        → ビルド（latex → bibtex → latex ×2）
## `make check`  → ビルド後に latexcheck.sh で機械検証（PASS/WARN/FAIL）
## `make clean`  / `make distclean`
##
## venue ごとにエンジン・bibtex・偶数頁制約だけ上部の変数で切り替える。
## 例:
##   - IPSJ/SIGMUS:  LATEX=platex  BIBTEX=pbibtex   CHECKOPTS=
##   - JSMPC(APA):   LATEX=platex  BIBTEX=upbibtex  CHECKOPTS=--even
##   - lualatex 系:  LATEX=lualatex（dvipdfmx 不要・下の pdf 規則を調整）
## =====================================================================

LATEX     = platex
BIBTEX    = pbibtex
DVIPDFMX  = dvipdfmx
TARGET    = main
CHECKOPTS =            # JSMPC 等の偶数頁制約があるなら --even

.PHONY: pdf check bib clean distclean

pdf: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).dvi
	$(DVIPDFMX) $(TARGET).dvi

$(TARGET).dvi: $(TARGET).tex
	$(LATEX) $(TARGET).tex
	-$(BIBTEX) $(TARGET)
	$(LATEX) $(TARGET).tex
	$(LATEX) $(TARGET).tex

## ビルド → 機械チェック（未定義引用/未解決参照/図欠落/overfull/bibtex/ページ数）
check: $(TARGET).dvi
	@sh latexcheck.sh $(TARGET) $(CHECKOPTS)

bib:
	$(BIBTEX) $(TARGET)

clean:
	rm -f $(TARGET).aux $(TARGET).log $(TARGET).bbl $(TARGET).blg $(TARGET).dvi $(TARGET).out $(TARGET).toc

distclean: clean
	rm -f $(TARGET).pdf
