build :
	jbuilder build @install

uninstall :
	ocamlfind remove amf

test :
	jbuilder runtest

clean :
	jbuilder clean

doc :
	jbuilder build @doc

_coverage/bisect0001.out :
	mkdir -p _coverage
	rm -rf _coverage/*
	jbuilder clean
	env BISECT_ENABLE=YES jbuilder build test/test.exe
	env BISECT_FILE=_coverage/bisect ./_build/default/test/test.exe

coverage/index.html : _coverage/bisect0001.out
	mkdir -p coverage
	rm -rf coverage/*
	bisect-ppx-report -I src/ -I src/amf/ -I test/ -html coverage/ _coverage/*

github.io-docs : doc coverage/index.html
	rm -rf docs/*

	cp -r ./_build/default/_doc/* docs
	cp -r coverage docs

.PHONY : clean test doc build uninstall
