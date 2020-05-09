# jam-dockerimage
a docker image build script for [jamserve](https://github.com/ffalt/jamserve) & [jamberry](https://github.com/ffalt/jamberry)

### Build & Tag

```
docker build -t ffalt/jam .
docker tag ffalt/jam ffalt/jam:test
```
### Test Run

```
docker run --publish 4040:4040 --name jam ffalt/jam:test
```

open http://localhost:4040

**default login**

user: admin

password: admin

