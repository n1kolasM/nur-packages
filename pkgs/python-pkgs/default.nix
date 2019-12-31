{ isort, toml, callPackage, poetry }:

let
  isPackageBroken = package: builtins.hasAttr "broken" package.meta && package.meta.broken;
in rec {
  cognitive-complexity = callPackage ./cognitive-complexity {};
  stevedore = callPackage ./stevedore {};
  bandit = callPackage ./bandit { inherit stevedore; };
  darglint = callPackage ./darglint {};
  flake8-annotations-complexity = callPackage ./flake8-annotations-complexity {};
  flake8-bandit = callPackage ./flake8-bandit { inherit bandit; };
  flake8-broken-line = if !isPackageBroken poetry then
    callPackage ./flake8-broken-line {}
  else
    callPackage ./flake8-broken-line/without-poetry.nix {};
  flake8-bugbear = callPackage ./flake8-bugbear {};
  flake8-builtins = callPackage ./flake8-builtins {};
  flake8-coding = callPackage ./flake8-coding {};
  flake8-commas = callPackage ./flake8-commas {};
  flake8-comprehensions = callPackage ./flake8-comprehensions {};
  flake8-docstrings = callPackage ./flake8-docstrings {};
  flake8-eradicate = callPackage ./flake8-eradicate {};
  flake8-executable = callPackage ./flake8-executable {};
  flake8-isort = callPackage ./flake8-isort {
    isort = isort.overrideAttrs (oldAttrs: rec {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ toml ];
    });
  };
  flake8-logging-format = callPackage ./flake8-logging-format {};
  flake8-pep3101 = callPackage ./flake8-pep3101 {};
  flake8-print = callPackage ./flake8-print {};
  flake8-quotes = callPackage ./flake8-quotes {};
  flake8-rst-docstrings = callPackage ./flake8-rst-docstrings {};
  flake8-string-format = callPackage ./flake8-string-format {};
  mando = callPackage ./mando {};
  pep8-naming = callPackage ./pep8-naming {};
  radon = callPackage ./radon { inherit mando; };
  wemake-python-styleguide = callPackage ./wemake-python-styleguide {
    inherit cognitive-complexity flake8-builtins;
    inherit flake8-commas flake8-quotes flake8-comprehensions;
    inherit flake8-docstrings flake8-string-format flake8-coding;
    inherit flake8-bugbear flake8-pep3101 flake8-isort flake8-eradicate;
    inherit flake8-bandit flake8-logging-format flake8-broken-line;
    inherit flake8-print flake8-annotations-complexity flake8-rst-docstrings;
    inherit flake8-executable pep8-naming radon darglint;
  };
  returns = if !isPackageBroken poetry then
    callPackage ./returns {}
  else
    callPackage ./returns/without-poetry.nix {};
}
