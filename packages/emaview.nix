{
  writeShellScriptBin,
  emanote,
  ungoogled-chromium,
  ...
}:
writeShellScriptBin "emaview" ''
  PORT=37890

  cleanup() {
      kill $(jobs -p)
  }

  cd $WIKI_HOME
  ${emanote}/bin/emanote run --port $PORT &
  ${ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/emaview --app="http://127.0.0.1:$PORT"

  trap cleanup EXIT
''
