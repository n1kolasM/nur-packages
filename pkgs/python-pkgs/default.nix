{ callPackage, poetry }:

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
}
