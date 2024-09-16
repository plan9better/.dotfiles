{ config, pkgs, ... }:
{
	home.username = "spike";
	home.homeDirectory = "/home/spike";

	home.packages = with pkgs; [
		# neofetch lmao
		neofetch

		# apps
		chromium
		spotify

		# games
		# minecraft # temporarily broken
		
		# archives
		zip
		xz
		unzip
		p7zip

		# utils
		ripgrep
		terminator
		jq
		fzf
		python3
		gh

		# networking
		nmap

		# misc
		file
		which
		tree
		gnused
		gnutar
	        gawk
	        zstd
	        gnupg
		tmux

		# nix related
		nix-output-monitor

		# system
		btop
		iotop
		iftop
		strace
		ltrace
		lsof
		sysstat
		lm_sensors
		ethtool
		pciutils
		usbutils
	];
	imports = [
		./nvim.nix
	];
	programs.git = {
		enable = true;
		userName = "p9b";
		userEmail = "pewuka2005@wp.pl";
	};

	programs.bash = {
		enable = true;
		enableCompletion = true;

		bashrcExtra = ''
		    export PS1='\[\e[96;3m\]\u\[\e[0m\]@\w\[\e[92m\]\$\[\e[0m\] '

		'';
		shellAliases = {
		      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";	
		      serve = "python3 -m http.server 8080";
		};
			
	};
	programs.tmux = {
		enable = true;
		clock24 = true;
		plugins = with pkgs.tmuxPlugins; [
			sensible
			yank
			{
				plugin = dracula;
				extraConfig = ''
					set -g @dracula-show-battery false
					set -g @dracula-show-powerline true
					set -g @dracula-refresh-rate 10
				'';
			}
		];

		extraConfig = ''
			set -g mouse on
		'';
	};

	home.stateVersion = "24.11";
	programs.home-manager.enable = true;
}
