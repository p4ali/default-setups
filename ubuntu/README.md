# ubuntu-install
A repository with all the initial tools I need upon installing a new ubuntu machine

## What has to be done manually
1. Start vagrant
2. run install.sh once vagrant vm up
3. map envoy source to /envoy/envoy
4. follow [Quick start Bazel build for developers](https://github.com/envoyproxy/envoy/blob/bac1a5100303ad3794eb155d1e27c79dbf1fd778/bazel/README.md#quick-start-bazel-build-for-developers) to prepare toolchain
5. follow [envoyproxy ](https://github.com/envoyproxy/envoy/blob/bac1a5100303ad3794eb155d1e27c79dbf1fd778/bazel/README.md) to build envoy
6. the out put should be envoy-bin
