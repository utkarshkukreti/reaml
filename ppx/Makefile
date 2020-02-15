default:
	esy install
	esy build
	esy x ocamlfind ppx_tools/rewriter '_esy/default/build/default/bin/Reaml_Ppx_Bin.exe --as-ppx' -impl tests/Tests.ml | tee tests/Tests.ml.stdout
