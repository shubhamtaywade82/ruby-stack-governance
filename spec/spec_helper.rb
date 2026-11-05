# frozen_string_literal: true

# Spec bootstrap: load the library directly — specs run with or without bundler.
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
