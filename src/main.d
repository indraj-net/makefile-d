/*
 * Copyright (C) 2025 Indraj Gandham <support@indraj.net>
 *
 * Copying and distribution of this file, with or without modification,
 * are permitted in any medium without royalty provided the copyright
 * notice and this notice are preserved.  This file is offered as-is,
 * without any warranty.
 */


import std.stdio;
import std.exception;
import sodium;

void main()
{
        enforce(sodium_init() >= 0, "failed to initialise libsodium");
        writeln("Hello world");
        return;
}
