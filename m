Return-Path: <linux-kernel+bounces-300165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD0995DFB3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8C11F21CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F174879B87;
	Sat, 24 Aug 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="E7DUiLuL"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11525AD5B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724525597; cv=none; b=Yh1W0xRGAs3a+GHyonWp2vZFf+kPaw+MDGKN4Tp0tabv+olqR+/vmiQ8embzmsLtCnlFK7tkWcAyjfniRNDBWYFJBs8tSQbJ2zVWtgVZ7K3gMrCzEicMnbS+9Qifj7X8Bk8AAXrrzQp2UChNprNdyQ8ODdABrTupCN5smxwNcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724525597; c=relaxed/simple;
	bh=LQ5Lv/ZUni9z3KJh+yRAjo9nSvnqmiWd9fdb3N/kVSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rPYLBeJs/AyenmUSazlVLmW5PRJtuCtkC+xlErXVWxT4RcHWbPT76VYxLrRHQoTboPtv+SUV19O0ADvpI3jRmkobM5zRVQwdxt3GGbwPNuow4FLDClEKZuxvzWAM0nhkaV+0qr8v0tPp5cZYJj8kW3vh3LD8otSyncB2fWY2/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=E7DUiLuL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724525593;
	bh=LQ5Lv/ZUni9z3KJh+yRAjo9nSvnqmiWd9fdb3N/kVSM=;
	h=Date:From:To:Cc:Subject:From;
	b=E7DUiLuLH+EUfCk7xXO3gjl4oUqDJEG+GlbBkH1jYGnlTscOOludXr7bY/jKYV/tw
	 3sezUkBvbwI/4kx2IFSWC+4CwtqLiZSbiRy3DXVAIrrT/LWj82GZnwBO+jgncGBtRC
	 Io6xCdt/nf9PhvWu8viRWwWJ7rrCMI3fKE80Ud2Q=
Date: Sat, 24 Aug 2024 20:53:12 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] nolibc for 6.12-rc1
Message-ID: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Shuah,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-20240824-for-6.12-1

for you to fetch changes up to 25fb329a23c78d59a055a7b1329d18f30a2be92d:

  tools/nolibc: x86_64: use local label in memcpy/memmove (2024-08-16 17:23:13 +0200)

----------------------------------------------------------------
nolibc changes for 6.12

Highlights
----------

* Clang support (including LTO)

Other Changes
-------------

* stdbool.h support
* argc/argv/envp arguments for constructors
* Small #include ordering fix

----------------------------------------------------------------
Thomas Weißschuh (21):
      tools/nolibc: include arch.h from string.h
      tools/nolibc: add stdbool.h header
      tools/nolibc: pass argc, argv and envp to constructors
      tools/nolibc: arm: use clang-compatible asm syntax
      tools/nolibc: mips: load current function to $t9
      tools/nolibc: powerpc: limit stack-protector workaround to GCC
      tools/nolibc: compiler: introduce __nolibc_has_attribute()
      tools/nolibc: move entrypoint specifics to compiler.h
      tools/nolibc: compiler: use attribute((naked)) if available
      selftests/nolibc: report failure if no testcase passed
      selftests/nolibc: avoid passing NULL to printf("%s")
      selftests/nolibc: determine $(srctree) first
      selftests/nolibc: add support for LLVM= parameter
      selftests/nolibc: add cc-option compatible with clang cross builds
      selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
      selftests/nolibc: don't use libgcc when building with clang
      selftests/nolibc: use correct clang target for s390/systemz
      selftests/nolibc: run-tests.sh: allow building through LLVM
      tools/nolibc: crt: mark _start_c() as used
      tools/nolibc: stackprotector: mark implicitly used symbols as used
      tools/nolibc: x86_64: use local label in memcpy/memmove

 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/arch-aarch64.h          |  4 +--
 tools/include/nolibc/arch-arm.h              |  8 +++---
 tools/include/nolibc/arch-i386.h             |  4 +--
 tools/include/nolibc/arch-loongarch.h        |  4 +--
 tools/include/nolibc/arch-mips.h             |  8 ++++--
 tools/include/nolibc/arch-powerpc.h          |  6 ++--
 tools/include/nolibc/arch-riscv.h            |  4 +--
 tools/include/nolibc/arch-s390.h             |  4 +--
 tools/include/nolibc/arch-x86_64.h           |  8 +++---
 tools/include/nolibc/compiler.h              | 24 +++++++++++-----
 tools/include/nolibc/crt.h                   | 25 +++++++++--------
 tools/include/nolibc/nolibc.h                |  3 +-
 tools/include/nolibc/stackprotector.h        |  4 +--
 tools/include/nolibc/stdbool.h               | 16 +++++++++++
 tools/include/nolibc/string.h                |  1 +
 tools/testing/selftests/nolibc/Makefile      | 41 +++++++++++++++++++---------
 tools/testing/selftests/nolibc/nolibc-test.c |  9 +++---
 tools/testing/selftests/nolibc/run-tests.sh  | 16 ++++++++---
 19 files changed, 123 insertions(+), 67 deletions(-)
 create mode 100644 tools/include/nolibc/stdbool.h

Test results
------------

tools/testing/selftests/nolibc$ ./run-tests.sh           
i386:          195 test(s): 195 passed,   0 skipped,   0 failed => status: success
x86_64:        195 test(s): 195 passed,   0 skipped,   0 failed => status: success
arm64:         195 test(s): 195 passed,   0 skipped,   0 failed => status: success
arm:           195 test(s): 195 passed,   0 skipped,   0 failed => status: success
mips32le:      195 test(s): 194 passed,   1 skipped,   0 failed => status: warning
mips32be:      195 test(s): 194 passed,   1 skipped,   0 failed => status: warning
ppc:           195 test(s): 195 passed,   0 skipped,   0 failed => status: success
ppc64:         195 test(s): 195 passed,   0 skipped,   0 failed => status: success
ppc64le:       195 test(s): 195 passed,   0 skipped,   0 failed => status: success
riscv:         195 test(s): 195 passed,   0 skipped,   0 failed => status: success
s390:          195 test(s): 194 passed,   1 skipped,   0 failed => status: warning
loongarch:     195 test(s): 194 passed,   1 skipped,   0 failed => status: warning

tools/testing/selftests/nolibc$ ./run-tests.sh -m user
i386:          195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
x86_64:        195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
mips32le:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
mips32be:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
ppc64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
ppc64le:       195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
riscv:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
s390:          195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
loongarch:     195 test(s): 192 passed,   3 skipped,   0 failed => status: warning

tools/testing/selftests/nolibc$ ./run-tests.sh -m user -l
i386:          195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
x86_64:        195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
mips32le:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
mips32be:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc:           195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc64:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc64le:       195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
riscv:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
s390:          195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
loongarch:     195 test(s): 192 passed,   3 skipped,   0 failed => status: warning


Thomas

