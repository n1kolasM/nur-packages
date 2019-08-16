{ stdenv, rustPlatform, fetchFromGitHub, gtk3, gnome3, wrapGAppsHook, ... }:
rustPlatform.buildRustPackage rec {
  name = "neovim-gtk-unstable-${version}";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "daa84";
    repo = "neovim-gtk";
    rev = "6a7804c6e797142724548b09109cf2883cd6f08c";
    sha256 = "0idn0j41h3bvyhcq2k0ywwnbr9rg9ci0knphbf7h7p5fd4zrfb30";
  };

  cargoSha256 = "0rnmfqdc6nwvbhxpyqm93gp7zr0ccj6i94p9zbqy95972ggp02df";

  nativeBuildInputs = [ wrapGAppsHook ];
  buildInputs = [ gtk3 gnome3.vte ];

  meta = with stdenv.lib; {
    description = "GTK+ UI for Neovim";
    homepage = https://github.com/daa84/neovim-gtk;
    license = with licenses; [ gpl3 ];
    platforms = platforms.linux;
  };
}
