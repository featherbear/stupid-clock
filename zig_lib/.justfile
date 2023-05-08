@_default:
    just --list

@build:
    zig build

@test:
    zig build test