# mssql-bacpac

Utilities to restore a `backpac` file from S3 into a SQLServer instance.

List available backups:

```bash
docker run --rm \
    --env AWS_ACCESS_KEY=xxx \
    --env AWS_ACCESS_SECRET=yyy \
    --env AWS_BUCKET_NAME=zzz \
    marcopeg/mssql-bacpac:1.0.0 list
```

Pull an image into cache:  
<small>(omit `.bacpac`) extension</small>

```bash
docker run --rm \
    --env AWS_ACCESS_KEY=xxx \
    --env AWS_ACCESS_SECRET=yyy \
    --env AWS_BUCKET_NAME=zzz \
    marcopeg/mssql-bacpac:1.0.0 pull fileName
```

Restore a bacpac by name:  
<small>(omit `.bacpac`) extension</small>

```bash
docker run --rm \
    --env AWS_ACCESS_KEY=xxx \
    --env AWS_ACCESS_SECRET=yyy \
    --env AWS_BUCKET_NAME=zzz \
    marcopeg/mssql-bacpac:1.0.0 restore fileName
```