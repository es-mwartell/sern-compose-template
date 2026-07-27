# Katalyst Just command runner
# This file imports the bundled action recipes from the parent repo's taxonomy
# (sern-compose-template is registered as its own system within the hack
# workspace's .global/taxonomy, one directory up).
# Add project-specific recipes below the import line.
export LAYER_DIR := invocation_directory()
export STACK_DIR := parent_directory(invocation_directory())

import "../.global/taxonomy/actions/just/stack.just"
