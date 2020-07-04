module.exports = {
  shell: "zsh",
  updateChannel: "canary",
  config: {
    // default font size in pixels for all tabs
    fontSize: 14,
    windowSize: [1080, 720],
    fontFamily: '"Operator Mono", "Inconsolata for Powerline", monospace',
    cursorShape: "BLOCK",
    wickedBorder: false,
    padding: "16px",
    shell: "/bin/zsh",
    webGLRenderer: false,
    hypercwd: {
      initialWorkingDirectory: "~/projects",
    },
  },

  plugins: [
    "hyperterm-cobalt2-theme",
    "hypercwd",
    "hyper-statusline",
    "hyperborder",
    "hyper-history",
    "hyper-tab-icons",
  ],

  // in development, you can create a directory under
  // `~/.hyperterm_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  // localPlugins: ['hyperterm-cobalt2-theme'],
};
