if [[ "$GIT_LFS_VERSION" ]]; then
    $DESTINATION/libexec/git-core/git-lfs --version
else
  echo "-- Skipped verifying Git LFS (set GIT_LFS_VERSION to include it in the bundle)"
fi
