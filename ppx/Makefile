default:
	esy install
	esy build
	esy x ocamlfind ppx_tools/rewriter '_esy/default/build/default/.ppx/Reaml_Ppx_Bin.lib/ppx.exe --as-ppx' -impl tests/Tests.ml | tee tests/Tests.ml.stdout
