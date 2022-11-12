{ config, pkgs, ... }:

{
  programs.qutebrowser = {
    enable = true;

    extraConfig = ''
      # Stick tabs on the left
      c.tabs.position = 'left'
      c.tabs.padding = {'bottom': 9, 'left': 5, 'right': 5, 'top': 9}
      c.tabs.favicons.scale = 1.0

      # Restyle tabs for higher contrast ratio
      c.tabs.width = 300
      c.fonts.tabs.selected = '8pt Helvetica'
      c.fonts.tabs.unselected = '8pt Helvetica'
      c.colors.tabs.even.bg = '#595959'
      c.colors.tabs.odd.bg = '#3D3D3D'
      c.colors.tabs.even.fg = '#FFFFFF'
      c.colors.tabs.indicator.start = '#0000aa'

      # Status bar
      c.fonts.default_family = "Inconsolata"
      c.fonts.statusbar = "6pt Inconsolata"
      c.fonts.completion.category = "6pt Inconsolata"
      c.fonts.completion.entry = "6pt Inconsolata"

      # Configure external editor and content signing.
      # c.editor.command = ['/usr/local/bin/mvim', '-f', '{}']
      # c.editor.encoding = 'utf-8'

      # Misc config stuffff
      c.downloads.location.prompt = False
      c.hints.chars = 'qsefthuko;vbn'
      c.scrolling.smooth = True
      c.spellcheck.languages = ['en-US']

      config.bind('<Ctrl-j>', 'tab-move +')
      config.bind('<Ctrl-k>', 'tab-move -')

    '';
  };
}
