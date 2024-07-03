{ lib
, rustPlatform
, fetchFromGitHub
, llvm_17
, libffi
, libz
, libxml2
, ncurses
, stdenv
, makeWrapper
, ...
}:

rustPlatform.buildRustPackage rec {
  pname = "inko";
  version = "0.15.0";

  src = fetchFromGitHub {
    owner = "inko-lang";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Iojv8pTyILYpLFnoTlgUGmlfWWH0DgsGBRxzd3oRNwA=";
  };

  buildInputs = [
    libffi
    libz
    libxml2
    ncurses
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    llvm_17
    makeWrapper
  ];

  preBuild = ''
    export INKO_STD=$out/lib
    export INKO_RT=$out/lib/runtime
  '';

  fixupPhase = ''
    runHook preFixup

    wrapProgram $out/bin/inko \
      --prefix PATH : ${lib.makeBinPath [ stdenv.cc ]}

    runHook postFixup
  '';

  postInstall = ''
    mkdir -p $out/lib/runtime
    mv $out/lib/*.a $out/lib/runtime/
    cp -r std/src/* $out/lib/
  '';

  cargoHash = "sha256-PaZD7wwcami6EWvOHLislNkwQhCZItN9XZkPSExwo0U=";
}
