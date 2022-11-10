# Get settings from settings.json

# Get list from hosts.txt over Hyper-v clusters to check.

# Connect to each cluster and query each node in the cluster for all VM:s

# Query each VM if it has any Checkpoints (snapshots)

# If checkpoint exist on VM, check it's date.

# If checkpoint is older than 6 hours write event 3006 in WeblandLogWriter log source in the application log.
# If checkpoint is older than 12 hours write event 3012 in WeblandLogWriter log source in the application log and send a email.