# gitpod-workspace-postgres

This image is heavily inspired by the official [workspace-postgres](https://github.com/gitpod-io/workspace-images/tree/master/postgres).

The main difference is that the `data` and `sockets` folders are moved under the
`/workspace` directory that provides data persistency to the workspace.