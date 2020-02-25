default:
	esy install
	esy build
	esy cp '#{self.target_dir}/install/default/bin/Reaml_Ppx_Bin' ./
	mv Reaml_Ppx_Bin.exe Reaml_Ppx_Bin || true
	esy x ocamlfind ppx_tools/rewriter Reaml_Ppx_Bin -impl tests/Tests.ml | tee tests/Tests.ml.stdout
	rake
