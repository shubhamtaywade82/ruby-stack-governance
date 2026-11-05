# frozen_string_literal: true

# Ruby Stack Governance task entrypoint: loads every namespaced task file.
$LOAD_PATH.unshift File.expand_path("lib", __dir__)

Dir["lib/tasks/*.rake"].sort.each { |task_file| import task_file }
