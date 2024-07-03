{ lib
, rustPlatform
, fetchFromGitHub
, makeWrapper
, cargo
, inko
, llvm_16
, stdenv
, autoPatchelfHook
, ...
}:

rustPlatform.buildRustPackage rec {
  pname = "ivm";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "inko-lang";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-z0oo1JUZbX3iT8N9+14NcqUzalpARImcbtUiQYS4djA=";
  };

  cargoHash = "sha256-EP3fS4lAGOaXJXAM22ZCn4+9Ah8TM1+wvNerKCKByo0=";

  buildInputs = [
    stdenv.cc.cc.lib
    llvm_16.dev
  ];

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
    llvm_16.dev
  ];

  runtimeDependencies = [
    llvm_16.dev
  ];

  fixupPhase = ''
    runHook preFixup

    wrapProgram $out/bin/ivm \
      --prefix PATH : ${lib.makeBinPath [ cargo llvm_16.dev stdenv.cc ]} \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath inko.buildInputs}

    runHook postFixup
  '';
}
