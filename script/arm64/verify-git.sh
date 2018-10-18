checkStaticLinking() {
  if [ -z "$1" ] ; then
    # no parameter provided, fail hard
    exit 1
  fi

  # ermagherd there's two whitespace characters between 'LSB' and 'executable'
  # when running this on Travis - why is everything so terrible?
  if file $1 | grep -q 'ELF 64-bit LSB'; then
    if readelf -d $1 | grep -q 'Shared library'; then
      echo "File: $file"
      # this is done twice rather than storing in a bash variable because
      # it's easier than trying to preserve the line endings
      readelf -d $1 | grep 'Shared library'
    fi
  fi
}

echo "-- Static linking research"
cd "$DESTINATION"
# check all files for ELF exectuables
find . -type f -print0 | while read -d $'\0' file
do
  checkStaticLinking $file
done
cd - > /dev/null
