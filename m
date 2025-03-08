Return-Path: <linux-kernel+bounces-552487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11621A57A53
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AE018916C9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B481B6D01;
	Sat,  8 Mar 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pnPl6fN6"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F344AD4B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741439196; cv=none; b=uPRwJ8mQF61Mu5f2UF5gqSlhnsE3jHKpa7pOAbZnsYf2bxJeMUXChvQk87meDyR6hV6E82Klu1oduGorBz45nQ6TEcE+LxcCv5cz3PEhwvvgkHoJpWhQkXLqecowPGDM6R2y0T56nhHSFltCTkcN54qeB6uTTOi94NYKRDQKX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741439196; c=relaxed/simple;
	bh=4R2RDIybbuBqATxHtgqbp8bDz484ngM4c08HSIRq7E8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O+pGxNyrPX7NSgQD/hZ25CkpAloniB/MK7AclqMENEX1tVSZsZT/GECg8I8izJVXByNP/oGPAO+dEih9Zs1hFRM7pST41L5vUUSsCFuaa6fhePOrY8BGm0e/otwfUOPNF6qZxvOI7IUJ+pxQq4cdEx8zupqijoNVPQ/cLvsXxUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pnPl6fN6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741439182;
	bh=4R2RDIybbuBqATxHtgqbp8bDz484ngM4c08HSIRq7E8=;
	h=Date:From:To:Cc:Subject:From;
	b=pnPl6fN6Gw961xGVUOUXxQdgJpAOIsGzM5rl4lu/GanO7cDhqQNhA7tlPAJCNwKQo
	 lbWZyM9qwPsaqhooNhSj5DeTqz2FhWEAZDOOVPfOalQ0KE4vakkkUoCImX6jxyuSLN
	 7k/bs2auNH/rdcjtYOrPMK2AghE7hX8mk+jJGVtA=
Date: Sat, 8 Mar 2025 14:06:21 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] nolibc changes for v6.15
Message-ID: <25e1c397-d554-4334-b344-56ec252564c1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Paul,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20250308-for-6.15-1

for you to fetch changes up to bceb73904c855c78402dca94c82915f078f259dd:

  tools/nolibc: don't use asm/ UAPI headers (2025-03-08 13:18:27 +0100)

----------------------------------------------------------------
nolibc changes for 6.15

Changes
-------

* 32bit s390 support
* opendir()/readdir_r()/closedir() support
* openat() support
* sscanf() support
* various cleanups

----------------------------------------------------------------
Louis Taylor (5):
      tools/nolibc: add support for openat(2)
      tools/nolibc: always use openat(2) instead of open(2)
      tools/nolibc: process open() vararg as mode_t
      tools/nolibc: drop outdated example from overview comment
      selftests/nolibc: use O_RDONLY flag instead of 0

Thomas Weißschuh (21):
      tools/nolibc: add prototypes for non-static functions
      selftests/nolibc: ignore -Wmissing-prototypes
      selftests/nolibc: enable -Wmissing-prototypes
      tools/nolibc: make signature of ioctl() more flexible
      selftests/nolibc: drop mips32be EXTRACONFIG
      selftests/nolibc: drop call to prepare target
      selftests/nolibc: drop call to mrproper target
      selftests/nolibc: execute defconfig before other targets
      selftests/nolibc: always keep test kernel configuration up to date
      tools/nolibc: add support for sys_llseek()
      tools/nolibc: add support for directory access
      selftests/nolibc: split up architecture list in run-tests.sh
      selftests/nolibc: only run constructor tests on nolibc
      selftests/nolibc: rename s390 to s390x
      tools/nolibc: add support for 32-bit s390
      tools/nolibc: add support for [v]sscanf()
      Revert "selftests: kselftest: Fix build failure with NOLIBC"
      selftests/nolibc: explicitly enable ARM mode
      selftests/nolibc: add armthumb configuration
      selftests/nolibc: stop testing constructor order
      tools/nolibc: don't use asm/ UAPI headers

 tools/include/nolibc/Makefile                      |   1 +
 tools/include/nolibc/arch-mips.h                   |   1 +
 tools/include/nolibc/arch-s390.h                   |   9 +-
 tools/include/nolibc/arch.h                        |   2 +-
 tools/include/nolibc/crt.h                         |   2 +
 tools/include/nolibc/dirent.h                      |  98 +++++++++++++++
 tools/include/nolibc/errno.h                       |   2 +-
 tools/include/nolibc/nolibc.h                      |   4 +-
 tools/include/nolibc/signal.h                      |   1 +
 tools/include/nolibc/stackprotector.h              |   2 +
 tools/include/nolibc/stdio.h                       |  98 +++++++++++++++
 tools/include/nolibc/stdlib.h                      |   1 +
 tools/include/nolibc/string.h                      |   4 +
 tools/include/nolibc/sys.h                         |  83 +++++++++----
 tools/testing/selftests/kselftest.h                |   5 -
 tools/testing/selftests/nolibc/Makefile            |  30 +++--
 .../testing/selftests/nolibc/nolibc-test-linkage.c |   6 +-
 tools/testing/selftests/nolibc/nolibc-test.c       | 138 ++++++++++++++++++++-
 tools/testing/selftests/nolibc/run-tests.sh        |  26 +++-
 19 files changed, 457 insertions(+), 56 deletions(-)
 create mode 100644 tools/include/nolibc/dirent.h

Test results:

$ ./run-tests.sh           
i386:          198 test(s): 198 passed,   0 skipped,   0 failed => status: success
x86_64:        198 test(s): 198 passed,   0 skipped,   0 failed => status: success
arm64:         198 test(s): 198 passed,   0 skipped,   0 failed => status: success
arm:           198 test(s): 198 passed,   0 skipped,   0 failed => status: success
armthumb:      198 test(s): 198 passed,   0 skipped,   0 failed => status: success
mips32le:      198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
mips32be:      198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
ppc:           198 test(s): 198 passed,   0 skipped,   0 failed => status: success
ppc64:         198 test(s): 198 passed,   0 skipped,   0 failed => status: success
ppc64le:       198 test(s): 198 passed,   0 skipped,   0 failed => status: success
riscv32:       198 test(s): 183 passed,  15 skipped,   0 failed => status: warning
riscv64:       198 test(s): 198 passed,   0 skipped,   0 failed => status: success
s390x:         198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
s390:          198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
loongarch:     198 test(s): 197 passed,   1 skipped,   0 failed => status: warning

$ ./run-tests.sh -m user -l                
i386:          198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
x86_64:        198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
arm64:         198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
arm:           198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
armthumb:      198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
mips32le:      198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
mips32be:      198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
ppc:           198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
ppc64:         198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
ppc64le:       198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
riscv32:       198 test(s): 180 passed,  18 skipped,   0 failed => status: warning
riscv64:       198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
s390x:         198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
s390:          Unsupported configuration
loongarch:     198 test(s): 195 passed,   3 skipped,   0 failed => status: warning

Thanks,
Thomas

