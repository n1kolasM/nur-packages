{ callPackage }:

rec {
  cognitive-complexity = callPackage ./cognitive-complexity {};
  stevedore = callPackage ./stevedore {};
  bandit = callPackage ./bandit { inherit stevedore; };
}
