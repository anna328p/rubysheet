{ stdenv
, bundix
, ruby_3_2
, bundlerEnv
, pkg-config
, libadwaita
, gtk4, cairo
, pcre, pcre2, libdatrie
, xorg, util-linux
, libthai
, libselinux, libsepol
, defaultGemConfig
}:

let
	env = bundlerEnv {
		name = "rubysheet-env";
		ruby = ruby_3_2;
		gemdir = ./.;

		gemConfig = defaultGemConfig // {
			gdk4 = oa: {
				dependencies = (oa.dependencies or []) ++ [ "glib2" ];
				buildInputs = [ gtk4 ];
				nativeBuildInputs = [ pkg-config ];

				preInstall = (oa.preInstall or "") + ''
					env
					pkg-config --libs gtk4
				'';
			};

			gtk4 = oa: {
				buildInputs = [
					cairo gtk4
					pcre pcre2 libdatrie
					xorg.libXdmcp util-linux
					libthai
					libselinux libsepol
				];

				nativeBuildInputs = [ pkg-config ];
			};

			adwaita = oa: {
				buildInputs = [ libadwaita ];
				nativeBuildInputs = [ pkg-config ];
			};
		};
	};

in stdenv.mkDerivation {
	pname = "TODO";
	version = "TODO";
	
	src = ./.;

	nativeBuildInputs = [
		bundix env.wrappedRuby
	];

	buildInputs = [
		env
	];

	dontBuild = true;

	installPhase = ''
		install -d "$out"
	'';
}
