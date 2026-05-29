# jam-dockerimage

a docker image build script for [jamserve](https://github.com/ffalt/jamserve) & [jamberry](https://github.com/ffalt/jamberry)

Supported platforms: **AMD64**, **ARM64**

## Single platform build

```shell
docker build -t ffalt/jam ./jam/
docker tag ffalt/jam ffalt/jam:test
```

## Multi platform build

```shell
docker buildx build -t ffalt/jam ./jam/
docker tag ffalt/jam ffalt/jam:test
```

## Test image build

```shell
docker buildx build -t ffalt/jam-test ./test/
docker tag ffalt/jam-test ffalt/jam-test:test
```

## Usage
see <https://github.com/ffalt/jam-docker> for usage
