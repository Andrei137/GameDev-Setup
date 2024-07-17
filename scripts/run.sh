build=false
clear=false

handle_options() {
  while [ $# -gt 0 ]; do
    case $1 in
      -b)
        build=true
        ;;
      -c)
        clear=true
        ;;
      -bc | -cb)
        build=true
        clear=true
        ;;
      *)
        exit 1
        ;;
    esac
    shift
  done
}

run() {
  cd ../bin
  ./Game
  cd ../scripts
}

handle_options "$@"

if [ "$build" = true ]; then
  if [ "$clear" = true ]; then
    clear && ./build.sh && clear && run
  else
    ./build.sh && run
  fi
else
  if [ "$clear" = true ]; then
    clear
  fi
  run
fi
