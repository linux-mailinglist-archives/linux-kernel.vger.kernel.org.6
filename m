Return-Path: <linux-kernel+bounces-554768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5EA59C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9187A7A28BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E4823372F;
	Mon, 10 Mar 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYg2f0pL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B745233703
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626590; cv=none; b=NFhdWgGkbEy9qysVNE0664xDGgYQQY2Q0olC1v/6tPXLjRX0GqrlWMJpKF2tG3HyXeAfoYbXVeAWLUPzkPHzEtPHKpwyIxHZFxShci89CEDSE0EBx+Cdot3KHSO2CHUOkEsanPfm6cQxfwBLokN4j9poFxqSqBWXvzepYavfkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626590; c=relaxed/simple;
	bh=V2/kGVGcGPhKNAjba1UQQbZpOLm482KX9BKofFb5cw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h99AkJSl9B2DzPM82iQzGSgBBTffZyM21baxSIbTx+Fs9GdA/FBPvObOpTyR1VbHsjIqiy+AWdLxLmJDAqtIfxLfTTZf19Vqyzf9srPK1bb6uHChSkpy1HsPA0h7KYZQccdeF7XKyX0BEouS1HAsl/L2DWRgQZnX5Xv/ga8YOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYg2f0pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F125DC4CEE5;
	Mon, 10 Mar 2025 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741626590;
	bh=V2/kGVGcGPhKNAjba1UQQbZpOLm482KX9BKofFb5cw4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DYg2f0pLDu17xul03X0t7myCiZpStZ8CQQOblKpJ4eeteff6OxA0DYpL21Yc1hCyq
	 doSqqK1XA0vzO3XRC5xQAEOCteVGHxF8eDwQOydQW50jwuI8csSFK8D/wy1z/Mx90G
	 Ot7a8AicFdodAv3Y5PXClGH6RMknjgWLnVgynznMZ26K1m9h6YaxjuPZmazYtLQHv4
	 m/SoF8PpN2doP+OIwK4MTUIRzL1lOMmNVdTrw6+EQj7Py84LC5XfMx6a6KmDPHHLu/
	 hDbbDiF1vNddIc+GvcdW70aMF4Yf9t915A3MkmIBoqrIcLPl7DKH7z2+Op3MRHMqr2
	 FDX1rfOh0PEnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94DFDCE079A; Mon, 10 Mar 2025 10:09:49 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:09:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.15
Message-ID: <00c760a8-0075-486f-9456-63ae07ecb341@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <25e1c397-d554-4334-b344-56ec252564c1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25e1c397-d554-4334-b344-56ec252564c1@t-8ch.de>

On Sat, Mar 08, 2025 at 02:06:21PM +0100, Thomas Weißschuh wrote:
> Hi Paul,
> 
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20250308-for-6.15-1
> 
> for you to fetch changes up to bceb73904c855c78402dca94c82915f078f259dd:
> 
>   tools/nolibc: don't use asm/ UAPI headers (2025-03-08 13:18:27 +0100)

Thank you, I have pulled this in and will expose it to -next testing.

Results from "make run":

198 test(s): 198 passed,   0 skipped,   0 failed => status: success

Results from "make user":

198 test(s): 196 passed,   2 skipped,   0 failed => status: warning

I don't understand the "warning" given that the "run.out" file has all
"OK" aside from the two "SKIPPED" tests.  Or maybe I am just forgetting
how this works.  ;-)

							Thanx, Paul

> ----------------------------------------------------------------
> nolibc changes for 6.15
> 
> Changes
> -------
> 
> * 32bit s390 support
> * opendir()/readdir_r()/closedir() support
> * openat() support
> * sscanf() support
> * various cleanups
> 
> ----------------------------------------------------------------
> Louis Taylor (5):
>       tools/nolibc: add support for openat(2)
>       tools/nolibc: always use openat(2) instead of open(2)
>       tools/nolibc: process open() vararg as mode_t
>       tools/nolibc: drop outdated example from overview comment
>       selftests/nolibc: use O_RDONLY flag instead of 0
> 
> Thomas Weißschuh (21):
>       tools/nolibc: add prototypes for non-static functions
>       selftests/nolibc: ignore -Wmissing-prototypes
>       selftests/nolibc: enable -Wmissing-prototypes
>       tools/nolibc: make signature of ioctl() more flexible
>       selftests/nolibc: drop mips32be EXTRACONFIG
>       selftests/nolibc: drop call to prepare target
>       selftests/nolibc: drop call to mrproper target
>       selftests/nolibc: execute defconfig before other targets
>       selftests/nolibc: always keep test kernel configuration up to date
>       tools/nolibc: add support for sys_llseek()
>       tools/nolibc: add support for directory access
>       selftests/nolibc: split up architecture list in run-tests.sh
>       selftests/nolibc: only run constructor tests on nolibc
>       selftests/nolibc: rename s390 to s390x
>       tools/nolibc: add support for 32-bit s390
>       tools/nolibc: add support for [v]sscanf()
>       Revert "selftests: kselftest: Fix build failure with NOLIBC"
>       selftests/nolibc: explicitly enable ARM mode
>       selftests/nolibc: add armthumb configuration
>       selftests/nolibc: stop testing constructor order
>       tools/nolibc: don't use asm/ UAPI headers
> 
>  tools/include/nolibc/Makefile                      |   1 +
>  tools/include/nolibc/arch-mips.h                   |   1 +
>  tools/include/nolibc/arch-s390.h                   |   9 +-
>  tools/include/nolibc/arch.h                        |   2 +-
>  tools/include/nolibc/crt.h                         |   2 +
>  tools/include/nolibc/dirent.h                      |  98 +++++++++++++++
>  tools/include/nolibc/errno.h                       |   2 +-
>  tools/include/nolibc/nolibc.h                      |   4 +-
>  tools/include/nolibc/signal.h                      |   1 +
>  tools/include/nolibc/stackprotector.h              |   2 +
>  tools/include/nolibc/stdio.h                       |  98 +++++++++++++++
>  tools/include/nolibc/stdlib.h                      |   1 +
>  tools/include/nolibc/string.h                      |   4 +
>  tools/include/nolibc/sys.h                         |  83 +++++++++----
>  tools/testing/selftests/kselftest.h                |   5 -
>  tools/testing/selftests/nolibc/Makefile            |  30 +++--
>  .../testing/selftests/nolibc/nolibc-test-linkage.c |   6 +-
>  tools/testing/selftests/nolibc/nolibc-test.c       | 138 ++++++++++++++++++++-
>  tools/testing/selftests/nolibc/run-tests.sh        |  26 +++-
>  19 files changed, 457 insertions(+), 56 deletions(-)
>  create mode 100644 tools/include/nolibc/dirent.h
> 
> Test results:
> 
> $ ./run-tests.sh           
> i386:          198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> x86_64:        198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> arm64:         198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> arm:           198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> armthumb:      198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> mips32le:      198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
> mips32be:      198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
> ppc:           198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> ppc64:         198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> ppc64le:       198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> riscv32:       198 test(s): 183 passed,  15 skipped,   0 failed => status: warning
> riscv64:       198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> s390x:         198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
> s390:          198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
> loongarch:     198 test(s): 197 passed,   1 skipped,   0 failed => status: warning
> 
> $ ./run-tests.sh -m user -l                
> i386:          198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
> x86_64:        198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
> arm64:         198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
> arm:           198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
> armthumb:      198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
> mips32le:      198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
> mips32be:      198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
> ppc:           198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
> ppc64:         198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
> ppc64le:       198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
> riscv32:       198 test(s): 180 passed,  18 skipped,   0 failed => status: warning
> riscv64:       198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
> s390x:         198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
> s390:          Unsupported configuration
> loongarch:     198 test(s): 195 passed,   3 skipped,   0 failed => status: warning
> 
> Thanks,
> Thomas

