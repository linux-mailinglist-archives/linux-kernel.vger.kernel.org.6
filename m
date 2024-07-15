Return-Path: <linux-kernel+bounces-253140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA4931D27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BA0B216B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154813CFA5;
	Mon, 15 Jul 2024 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDpzabdr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E620EB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082412; cv=none; b=cTZJ0Hg2bbrDa20vA2OM602Di6597vX5cuY2m+H21yXVbhkx4++5i1STS/hzViK6qVW8VL9emk/JYMPpFwcZke/EGmyZ8fQXYScsODs4dcqNup/Ivp1RaFcR/CDYhmzWp1po4c/HUq0SlGk28p4q/jMHOLf8X6Fkr/wz4gQjdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082412; c=relaxed/simple;
	bh=REL6mawUXWg9pJuCF0P7yIYPi7TSuPz0T6RHE6SXxAA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ODDDYJTd6FbcelczGuhQBAM7KABZhe/vMfn7i4r+hNsOOuT1SWMzgOC0kGqocyVEyBPTCN+XRFYDR7LJCKo8RhO49Rgsi83Udt1t+5xjVuhpdUdhMpgDDlVm5MYThlWWRRZh/ssefGu79IhcPnl77GAytaLrfiScNWIJ5Mz3yxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDpzabdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5AAC32782;
	Mon, 15 Jul 2024 22:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721082412;
	bh=REL6mawUXWg9pJuCF0P7yIYPi7TSuPz0T6RHE6SXxAA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=SDpzabdrpIZ9//lRJHglHyE+msdc/x0Cp18z9T+ME7YKCTAidhOb/dOS9CTPJ/Wqa
	 +oBoIY/gOxy1tJcP2hj0oUWdOIkOH4TzRBDVcoCv9LYegNNQjzNLtSlWL4cBEqLQFj
	 fmcX6vIP0fKB/wVIE5ffHnl4Sb4xFCP7jKV7w9+zjlfjOPKTIi+B7UDMthN+yK5Bqk
	 J/PdnhHp/f5eWzxj29oTssMCO3MzgAeblDAscw8zQ7WCibFju/LG/95N4gJLip0oow
	 6lDCyM+t0v7oxOFrbeKVMO1IoPcw1TVoWRS2yOgyrA/i13poPdU53ex5jQFRAqioJK
	 c6ZH+mhPAhoWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01A66CE134B; Mon, 15 Jul 2024 15:26:51 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:26:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu,
	linux@weissschuh.net, skhan@linuxfoundation.org
Subject: [GIT PULL] nolibc changes for v6.11
Message-ID: <db9eca51-1e0a-4bd4-8bdf-6f60f4bc91b7@paulmck-laptop>
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

Please please pull the latest nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2024.07.15a
  # HEAD: 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b: selftests: kselftest: also use strerror() on nolibc (2024-06-29 09:44:58 +0200)

----------------------------------------------------------------
nolibc updates for v6.11

o	Fix selftest printf format mismatch in expect_str_buf_eq().

o	Stop using brk() and sbrk() when testing against musl, which
	implements these two functions with ENOMEM.

o	Make tests use -Werror to force failure on compiler warnings.

o	Add limits for the {u,}intmax_t, ulong and {u,}llong types.

o	Implement strtol() and friends.

o	Add facility to skip nolibc-specific tests when running against
	non-nolibc libraries.

o	Implement strerror().

o	Also use strerror() on nolibc when running kselftests.

----------------------------------------------------------------
Thomas Weiﬂschuh (8):
      selftests/nolibc: fix printf format mismatch in expect_str_buf_eq()
      selftests/nolibc: disable brk()/sbrk() tests on musl
      selftests/nolibc: run-tests.sh: use -Werror by default
      tools/nolibc: add limits for {u,}intmax_t, ulong and {u,}llong
      tools/nolibc: implement strtol() and friends
      selftests/nolibc: introduce condition to run tests only on nolibc
      tools/nolibc: implement strerror()
      selftests: kselftest: also use strerror() on nolibc

 tools/include/nolibc/stdint.h                |  19 +++++
 tools/include/nolibc/stdio.h                 |  10 +++
 tools/include/nolibc/stdlib.h                | 109 +++++++++++++++++++++++++++
 tools/testing/selftests/kselftest.h          |   8 --
 tools/testing/selftests/nolibc/Makefile      |   2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 109 ++++++++++++++++++++++-----
 tools/testing/selftests/nolibc/run-tests.sh  |   9 ++-
 7 files changed, 238 insertions(+), 28 deletions(-)

