Return-Path: <linux-kernel+bounces-572093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB7A6C661
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C613BD73F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA131E2852;
	Fri, 21 Mar 2025 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrBlte5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AC20C019
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599147; cv=none; b=cg7zQaejrhdWKTYP1lRqw2CSTeHrlgIN0uv8QdhEuw33q8N1C5h5Hdq4OPXq48QjhmMwE6kXVvJ6JkBI4MldUNmcNL00hMwYGbBNn/v9tkfArLfJfbgMcRMMKj/w9oLlTUJpIABfA4qxXgbjLvK1r4L2KNNSSv+l+SUiqRrLFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599147; c=relaxed/simple;
	bh=PQwu67NN7SBu/vgOhDhukka15Co2iZcZX4FljPzQtAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rw9KRHy5gAJKexbgBq8knUW+VrklUnrhjuKHcSdGDFoiXNAsgBGZiCaroXK7z2vZPPhgDifdokfP5UzI9S27XkvVCmxpjyTJHUavZPTrsOzc3mzi3qsVws93V0U5tlrbJovNKcAENl333M+DmJz7LB5nBn79i2vlLfFw9CABeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrBlte5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03156C4CEE3;
	Fri, 21 Mar 2025 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742599147;
	bh=PQwu67NN7SBu/vgOhDhukka15Co2iZcZX4FljPzQtAU=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=CrBlte5hGNctkPkca5wZqigvKWEhgL8QVFDDoOH7xG8J/rr4HA8nPMfWF1wISiQm5
	 lArWqlswLYDPERWhJF+X//gEqF0ByMq8ZeBLICQIorDFrqwBKazm1mQzyEvH0cDCfx
	 NN6tJj4FjwxzC9Fd+DhxTYHv1lUTIW6oLnfh6a5CD15v/9y4dJ5TymCnqFp6NWPDn0
	 iTGtxU2szgkPFpkEXPFmjRZ6QwHglS4Zgsv0/oCkSEmQVhu5fuZCkp8/8uFdYqKHfO
	 zLegF+nt8jDrSP+JvOVJgqPDzyDpgUpCeiznmLE/C/Gk+EruA0S20YklNNIiclCaEt
	 NKIzcFbSWgCCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A00FDCE0D1D; Fri, 21 Mar 2025 16:19:06 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:19:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu,
	linux@weissschuh.net, skhan@linuxfoundation.org, louis@kragniz.eu
Subject: [GIT PULL] nolibc changes for v6.15
Message-ID: <bd17eb5b-bdd0-46cf-85fe-2c4f2aade82d@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, Linus,

Once the v6.15 merge window opens, please pull the latest nolibc
changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/nolibc-20250308-for-6.15-1
  # HEAD: bceb73904c855c78402dca94c82915f078f259dd: tools/nolibc: don't use asm/ UAPI headers (2025-03-08 13:18:27 +0100)

----------------------------------------------------------------
nolibc changes for 6.15

Changes
-------

* 32bit s390 support
* opendir() and friends
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

Thomas Weiﬂschuh (21):
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

