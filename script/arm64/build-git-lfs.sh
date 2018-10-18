
if [[ "$GIT_LFS_VERSION" ]]; then
    echo "-- Building Git LFS"
    go get github.com/git-lfs/git-lfs
    GOPATH=`go env GOPATH`
    cd $GOPATH/src/github.com/git-lfs/git-lfs
    git checkout "v${GIT_LFS_VERSION}"
    # Make the 'mangen' target first, without setting GOOS/GOARCH.
    make mangen
    make GOARCH=arm64 GOOS=linux
    GIT_LFS_OUTPUT_DIR=$GOPATH/src/github.com/git-lfs/git-lfs/bin/

    echo "-- Bundling Git LFS"
    GIT_LFS_FILE=$GIT_LFS_OUTPUT_DIR/git-lfs
    SUBFOLDER="$DESTINATION/libexec/git-core"
    cp $GIT_LFS_FILE $SUBFOLDER
else
  echo "-- Skipped bundling Git LFS (set GIT_LFS_VERSION to include it in the bundle)"
fi
