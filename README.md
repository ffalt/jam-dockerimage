# jam-dockerimage

a docker image build script for [jamserve](https://github.com/ffalt/jamserve) & [jamberry](https://github.com/ffalt/jamberry)

Supported platforms: **AMD64**, **ARM64**

## Single platform build

```shell
docker build -t ffalt/jam-base ./base/
docker tag ffalt/jam-base ffalt/jam-base:test

docker build -t ffalt/jam ./jam/
docker tag ffalt/jam ffalt/jam:test
```

## Multi platform build

```shell
docker buildx build -t ffalt/jam-base ./base/
docker tag ffalt/jam-base ffalt/jam-base:test

docker buildx build -t ffalt/jam ./jam/
docker tag ffalt/jam ffalt/jam:test
```

## Run

```shell
docker run --publish 4040:4040 --name jam ffalt/jam:test
```

open <http://localhost:4040>

### default login

user: admin

password: admin
