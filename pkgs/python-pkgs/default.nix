{ callPackage }:

rec {
  cognitive-complexity = callPackage ./cognitive-complexity {};
  stevedore = callPackage ./stevedore {};
  bandit = callPackage ./bandit { inherit stevedore; };
  darglint = callPackage ./darglint {};
  flake8-annotations-complexity = callPackage ./flake8-annotations-complexity {};
}
