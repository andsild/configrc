{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix ./private.nix];

 boot.loader.grub.enable = true;
 boot.loader.grub.version = 2;
 boot.loader.grub.device = "/dev/sda";
 boot.kernelPackages = pkgs.linuxPackages_latest;

 networking = {
   networkmanager.enable = true;
   wireless.userControlled.enable = true;
 };

 security.sudo.enable = true;
 security.polkit.enable = true;

 i18n = {
   consoleFont = "Lat2-Terminus16";
   consoleKeyMap = "us";
   defaultLocale = "en_US.UTF-8";
 };

 time.timeZone = "Europe/Oslo";

 nixpkgs.config = {
   allowUnfree = true;
   chromium = {
     enablePepperFlash = true; 
     enablePepperPDF = true;
   };
   firefox = {
     enableGoogleTalkPlugin = true;
     enableAdobeFlash = true;
   };
   virtualbox.enableExtenstionPack = true;


 };

 hardware.pulseaudio.enable = true;
 hardware.pulseaudio.package = pkgs.pulseaudioFull;
 hardware.bluetooth.enable = true;

 fonts = {
   enableCoreFonts = true;
   enableFontDir = true;
   enableGhostscriptFonts = true;
   fonts = with pkgs; [
     dejavu_fonts
     inconsolata
   ];
 };

 environment.variables = rec {
   VISUAL  = "nvim";
   EDITOR  = VISUAL;
   BROWSER = "chromium-browser";
   SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
 };

 security.setuidPrograms = [ "slock" ];

 environment.systemPackages = 
 let
   nvim = pkgs.neovim.override {
     vimAlias = true;
   };
 in
 with pkgs; [
   acpitool
   aspell 
   aspellDicts.en
   aspellDicts.nb
   aspellDicts.nn
   astyle
   automake
   bash
   bc
   boost
   cabal-install
   chromium
   cmake
   cowsay
   ctags
   clang
   dmenu
   dpkg
   dzen2
   enlightenment.terminology
   file
   fortune
   gcc
   gcolor2
   gdb
   gdk_pixbuf
   git
   glibcInfo
   gnome3.cheese
   gnumake
   gnupg
   go
   google-drive-ocamlfuse
   gparted
   graphicsmagick
   graphviz
   haskellPackages.cabal-install
   haskellPackages.cabal2nix
   haskellPackages.ghc
   haskellPackages.ghc-mod
   haskellPackages.happy
   haskellPackages.hlint
   haskellPackages.hoogle
   hicolor_icon_theme
   htop
   imagemagick
   inotify-tools
   irssi
   liblapack
   links2
   llvmPackages.lldb
   lua
   man-pages
   manpages
   manpages
   mplayer
   msmtp
   ncurses
   neomutt
   networkmanagerapplet
   newsbeuter-dev
   nodejs
   nox
   ntfs3g
   nvim
   octaveFull
   openssl
   p7zip
   parted
   pavucontrol
   pdftk
   pkgconfig
   python
   python3
   python3Packages.ipython
   python3Packages.neovim
   python3Packages.pip
   python3Packages.scipy
   python3Packages.virtualenv
   pythonPackages.ipython
   pythonPackages.pip
   pythonPackages.scipy
   pythonPackages.neovim
   pythonPackages.virtualenv
   qalculate-gtk
   qemu
   rdesktop
   rsync
   ruby
   screen
   shellcheck
   shotwell
   silver-searcher
   simplescreenrecorder
   sl
   sloccount
   slock
   slop
   sqlite
   sshfs-fuse
   stack
   stdmanpages
   posix_man_pages
   sxiv
   telnet
   toilet
   tree
   unzip
   unzip
   valgrind
   vlc
   wget
   workrave
   xclip
   xdotool
   xfontsel
   xlsfonts
   xorg.xbacklight
   xorg.xev
   xorg.xgamma
   xorg.xmessage
   xpdf
   xscreensaver
   zathura
   zeal
   zip
   zlib

(texlive.combine {
          inherit (texlive)
            collection-basic
            collection-bibtexextra
            collection-binextra
            collection-context
            collection-fontsextra
            collection-fontsrecommended
            collection-fontutils
            collection-formatsextra
            collection-games
            collection-genericextra
            collection-genericrecommended
            collection-htmlxml
            collection-humanities
            collection-langafrican
            collection-langarabic
            collection-langchinese
            collection-langcjk
            collection-langcyrillic
            collection-langczechslovak
            collection-langenglish
            collection-langeuropean
            collection-langfrench
            collection-langgerman
            collection-langgreek
            collection-langindic
            collection-langitalian
            collection-langjapanese
            collection-langkorean
            collection-langother
            collection-langpolish
            collection-langportuguese
            collection-langspanish
            collection-latex
            collection-latexextra
            collection-latexrecommended
            collection-luatex
            collection-mathextra
            collection-metapost
            collection-music
            collection-omega
            collection-pictures
            collection-plainextra
            collection-pstricks
            collection-publishers
            collection-science
            collection-texworks
            collection-wintools
            collection-xetex

            metafont;
        })

 ];

 services = {
   acpid.enable = true;


 udev.extraRules = ''
# Leap Motion
ACTION!="add|change", GOTO="com_leapmotion_leap_end"
SUBSYSTEM=="usb", ATTRS{idVendor}=="f182", ATTRS{idProduct}=="0003", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="00f3", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="4720", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2936", ATTRS{idProduct}=="1001", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2936", ATTRS{idProduct}=="1002", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2936", ATTRS{idProduct}=="1003", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2936", ATTRS{idProduct}=="1004", MODE="666", GROUP="plugdev"
LABEL="com_leapmotion_leap_end"
 '';





   samba.enable = true;
   samba.securityType = "share";
   samba.extraConfig = ''
     workgroup = WORKGROUP
     server string = myServer
     netbios name = myServername
     #use sendfile = yes
     #max protocol = smb2
 
     interfaces = lo eth1 vboxnet0 vboxnet1
     bind interfaces only = yes
 
     [rw-files]
       comment = rw project files 
       path = /mnt/samba/
       read only = no
       writable = yes
       public = yes
       browsable = yes
   ''; 

   openssh.enable = true;
   locate.enable = true;
   locate.interval = "10min";
# is this a bad idea? I want my home directory indexed, but, I don't want every user
# to have access to the DB?
   locate.localuser = "nobody"; 
   locate.includeStore = true;

   offlineimap.enable = true;
   offlineimap.install = true;
   offlineimap.path = [ pkgs.python pkgs.notmuch pkgs.bash pkgs.sqlite ];
   offlineimap.onCalendar = "*:0/3"; # every three minutes

   printing.enable = true;

   xserver = {
     enable = true;
     layout = "us,no";
     xkbOptions = "eurosign:e,grp:switch,grp:alt_shift_toggle,grp_led:scroll us,no";
     exportConfiguration = true;
     windowManager.wmii.enable = true;
     windowManager.xmonad.enable = true;
     windowManager.xmonad.enableContribAndExtras = true;
     desktopManager.kde5.enable = true;
     displayManager = {
      sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
       slim = {
         enable = true;
         defaultUser = "andesil";
         theme = pkgs.fetchurl {
              url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
              sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
          };
       };
     };
     };
   };

   environment.etc."profile.local".text = ''
   if [ -e "$HOME/.bash_profile" ]
   then
   source "$HOME/.bash_profile"
   fi
   '';


   environment.etc."inputrc".text = ''
   set visible-stats on

   # set editing-mode vi
   $if mode=vi

   set blink-matching-paren on

   # Lines below specify for command mode
   set keymap vi-command
   "P":yank-last-arg
   "p":yank-last-arg

   Control-l: clear-screen

   # Command in insert mode
   set keymap vi-insert
   Control-l: clear-screen
   "\e[A": history-search-backward

   "jj": vi-movement-mode
   "\C-w": backward-kill-word
   "\C-p": history-search-backward
   $endif

   set completion-ignore-case on
   '';

   programs = {
     bash.enableCompletion = true; 
     ssh.startAgent = true;    
   };

   virtualisation.virtualbox.host.enable = true;


   users.extraUsers.andesil =
   { 
     isNormalUser = true;
     home = "/home/andesil";
     description = "Anders Sildnes";
     extraGroups = [ "netdev" "wheel" "networkmanager" "vboxusers" "audio" ];
   };

   sound.enableMediaKeys = true;

  system.stateVersion = "16.03";
}
