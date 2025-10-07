#
# Copyright (C) 2025 Indraj Gandham <support@indraj.net>
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
#


DC := gdc
DEBUG := -g -fdebug -fbounds-check=on
RELEASE := -s -fno-assert \
-fbounds-check=on \
-fno-invariants \
-fno-postconditions \
-fno-preconditions \
-fno-switch-errors

ELF_HARDEN := -fPIE
SO_HARDEN := -fPIC -shared

AMD64_HARDEN := -fcf-protection=full
AARCH64_HARDEN := -mbranch-protection=standard

HARDEN := -fstack-clash-protection \
-fstack-protector-strong

LD_HARDEN := -pie \
-Wl,-z,nodlopen \
-Wl,-z,noexecstack \
-Wl,-z,relro \
-Wl,-z,now \
-Wl,--as-needed \
-Wl,--no-copy-dt-needed-entries

DFLAGS := -O2 -Werror

ELF_AMD64_HARDEN := $(ELF_HARDEN) \
$(AMD64_HARDEN) \
$(HARDEN)

ELF_AARCH64_HARDEN := $(ELF_HARDEN) \
$(AARCH64_HARDEN) \
$(HARDEN)

SO_AMD64_HARDEN := $(SO_HARDEN) \
$(AMD64_HARDEN) \
$(HARDEN) \

SO_AARCH64_HARDEN := $(SO_HARDEN) \
$(AARCH64_HARDEN) \
$(HARDEN) \

LDFLAGS := -lsodium
OUT := a.out
CONFIG := $(DFLAGS) $(RELEASE) $(ELF_AMD64_HARDEN)

OBJS := $(patsubst src/%.d, obj/%.o, $(wildcard src/*.d))

.PHONY: all clean
all: $(OUT)

clean:
	rm -rf $(OUT) obj/*

$(OUT): $(OBJS)
	$(DC) $(CONFIG) $(LD_HARDEN) -o $(OUT) $(OBJS) $(LDFLAGS)

obj/main.o: src/main.d | src/sodium.c
	$(DC) $(CONFIG) -I src -c src/main.d -o obj/main.o
