#!/usr/bin/env bash

BIN=/usr/bin
MAN=/usr/share/man/man1

BVER=11
MVER=11.1

PRIORITY=210


update-alternatives --install $BIN/clang clang $BIN/clang-$BVER $PRIORITY \
	--slave $MAN/clang.gz clang.gz $MAN/clang-$MVER.gz
update-alternatives --install $BIN/clang++ clang++ $BIN/clang++-$BVER $PRIORITY
update-alternatives --install $BIN/asan_symbolize asan_symbolize $BIN/asan_symbolize-$BVER $PRIORITY

update-alternatives --install $BIN/clang-tidy clang-tidy $BIN/clang-tidy-$BVER $PRIORITY \
	--slave $MAN/clang-tidy.gz clang-tidy.gz $MAN/clang-tidy-$MVER.gz

update-alternatives --install $BIN/clangd clangd $BIN/clangd-$BVER $PRIORITY \
	--slave $MAN/clangd.gz clangd.gz $MAN/clangd-$MVER.gz

update-alternatives --install $BIN/lld lld $BIN/lld-$BVER $PRIORITY
