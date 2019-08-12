default:
	yarn build
	ocamlfind ppx_tools/rewriter lib/bs/native/Reaml_Ppx.native tests/Tests.ml | tee tests/Tests.ml.stdout
