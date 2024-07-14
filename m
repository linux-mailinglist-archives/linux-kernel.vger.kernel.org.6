Return-Path: <linux-kernel+bounces-251871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A2930AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C1D2819A0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA813BAC4;
	Sun, 14 Jul 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd56xohr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0113B582
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720975496; cv=none; b=FqcCh1uSglSAuevk60ymCKFYMgWmcBKLRESdbBx85o3Cvl9Cub+k6Fd0f+hH16BmiXFhcOY/6eNeVsmdmFwfmzEw0Vq+q3Calu2Q6E8HLJ+iJxBf3+4C0O/piBB3qigRA32aZLhnZHym6KJh9X01l1K7cP8lPCcFzw4lzRD3JyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720975496; c=relaxed/simple;
	bh=ua8KiCGTZHJ9kpXAoFQ6UUJlK/1b7Z/DruvjY+X5LAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcKISL9RdDouqdCtjjLc9x/k54uGEZEJ5TF7iUsJPmzC0RmwN4qk1imr2jCciCXU9XGhFbUrZUiQXMqjWl5iQh/cni/Fao7C6gg4H4O9V484m9CFk+skATQszZ00u12IAbU3nOmOH+sEQcG/Ig73V0nzQb7zjbz2pUL2CTLBrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd56xohr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F86C116B1;
	Sun, 14 Jul 2024 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720975496;
	bh=ua8KiCGTZHJ9kpXAoFQ6UUJlK/1b7Z/DruvjY+X5LAQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pd56xohrdgo9j7Pn9U667Dx51ixDx73UcTFh2+oQMHKJ3ZNO0EtXZpAkNEC3nAZxE
	 ikngFzxOWH+mfdCDCBsjv6O5tF9Dn62rNCwculY4AdCZAw+QRC8YU9W5x/QPyA7lLS
	 uDhVAS2F6jMykAhlvF8mh7mr0YTmIALnxEJ3SC6J8PF/U38recXau+q6c6A9rprFpH
	 BCvREFZsjGMTL+iOi5SYDHGQaVoYkzKhQrh3u05Oek2J05nvqih3c5xmrVRmiV4qjH
	 MA5uwqYZk8DGGSUyKJwM/0UmyE2aumdB3OJD5B4jSqW4vPavQJxmS8kAxXm3qIvW3j
	 bmKfYbsvfbe/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 990CCCE0B34; Sun, 14 Jul 2024 09:44:55 -0700 (PDT)
Date: Sun, 14 Jul 2024 09:44:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.11-rc1
Message-ID: <138b249a-8402-4a79-8c08-45bb9d888dc5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
 <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>
 <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>
 <ee43b1d5-3339-4a1c-9bac-c0d48f22167c@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee43b1d5-3339-4a1c-9bac-c0d48f22167c@t-8ch.de>

On Sun, Jul 14, 2024 at 10:09:13AM +0200, Thomas Weiﬂschuh wrote:
> On 2024-07-12 20:16:13+0000, Paul E. McKenney wrote:
> > On Sun, Jun 30, 2024 at 09:06:39AM -0700, Paul E. McKenney wrote:
> > > On Sat, Jun 29, 2024 at 01:04:08PM +0200, Thomas Weiﬂschuh wrote:
> > > > Hi Paul,
> > > > 
> > > > The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:
> > > > 
> > > >   Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20240629-for-6.11-1
> > > > 
> > > > for you to fetch changes up to 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b:
> > > > 
> > > >   selftests: kselftest: also use strerror() on nolibc (2024-06-29 09:44:58 +0200)
> > > 
> > > Hearing no objections, I have pulled this in so that it will appear
> > > in the next -next.  Here are the test results:
> > > 
> > > make run:
> > > 195 test(s): 195 passed,   0 skipped,   0 failed => status: success
> > > 
> > > make run-user:
> > > 195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
> > > 
> > > So looks good to me!
> 
> For testing you can use "./run-tests.sh -m [user | system]" to run the
> tests on all supported architectures via QEMU.
> 
> (On the first run you can use "-p" to download the toolchains)

Thank you for the info!

My near-term plan is that I do a smoke test on x86 (or whatever I am
running), and let you guys cover the various architectures.  Longer
term, I might get more into cross-architecture work.

> > And please see below for my proposed signed tag.  Please let me know of
> > any needed adjustments.
> > 
> > 							Thanx, Paul
> > 
> > ----------------------------------------------------------------
> > 
> > tag nolibc.2024.07.12a
> > Tagger: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Jul 12 16:56:21 2024 -0700
> > 
> > nolibc updates for v6.11
> > 
> > o	Fix selftest printf format mismatch in expect_str_buf_eq()
> 
> Period at the end.

Good eyes, thank you, fixed.

> > o	Stop using brk() and sbrk() when testing against musl, which
> > 	implements these two functions with ENOMEM.
> > 
> > o	Make tests us -Werror to force failure on compiler warnings.
> > 
> > o	Add limits for the {u,}intmax_t, ulong and {u,}llong types.
> > 
> > o	Implement strtol() and friends.
> > 
> > o	Add facility to skip nolibc-specific tests when running against
> > 	non-nolibc libraries.
> > 
> > o	Implement strerror().
> > 
> > o	Use strerror() unconditionally, instead of only when running
> > 	against non-nolibc libraries.
> 
> Maybe mention that this is about kselftest and not nolibc itself.
> 
> Otherwise looks good, thanks!

Thank you for looking this over, and does the updated version below
cover this?  If I am still off, please suggest updates.

						Thanx, Paul

------------------------------------------------------------------------

tag nolibc.2024.07.14a
Tagger: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Jul 14 09:07:29 2024 -0700

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

o	Use strerror() unconditionally, instead of only when running
	kselftest.
-----BEGIN PGP SIGNATURE-----

iQJHBAABCgAxFiEEbK7UrM+RBIrCoViJnr8S83LZ+4wFAmaT98oTHHBhdWxtY2tA
a2VybmVsLm9yZwAKCRCevxLzctn7jHc0D/9chhJo+QQ+2V+xQEKT8n1MKiJaf55X
EUhIlKHoejrF7rZukqv1tcqMNP0wGzwKyttbFkX+72OHrxSuNr0MbvBjQi6cFcFo
2QNg/ZEVIZKeMJzRXwUOOrg47hwLoGgFrt5cgSCMeYSm0E25oAx752/WbmQgQBlU
2dOTomrxF7pyDQoJwPU3CNAk/fFZHuBX9Hjp0LPaXmKDq9BLWqUWoJZAOAfcxm2Q
F8A/HnOTEp5F5qwJLr0GStNxR44xH/GU/3KEdryzllEFj6PTLDAeP4oNdMK30q9F
YGrcpON3hjw1+XKQBTLJ/UIqQ3EeA/bo2yDOLsFZObU7aKrb7ewtxTq/DWUfoj4x
jfFCOc6JpsmAAlwm2zXn+MLDLxSF3QhTalpl1o4thrNgxhm/Eou+uz/1k2EREp/r
4PfHC+i0YjGA9sJ12u1hUoPkxHXY0GKx+gHL9uwB5C2je7HyStzBRvDWEjUJw+uI
Z9+RkvSQFV82tIvczGzGuLkMM1of+M+VROGeDXyP9tzyjD3GrqDwwdcXFz/dVnhF
ktFiQeoMlfDcSjbcXztRaD4eRSM/EzK6aNL7eocK+s9EWn10Xvg6c+7IeYxMgy32
w9Q9WRFN/Gzmeawb0rNNiYdhEq/ufBpfN1+Un4XrpqPukydbv2JpaiG/VZBzldkw
UMepC/mpRx8HPw==
=yaww
-----END PGP SIGNATURE-----

commit 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b
Author: Thomas Weiﬂschuh <linux@weissschuh.net>
Date:   Fri Apr 26 13:08:58 2024 +0200

    selftests: kselftest: also use strerror() on nolibc
    
    nolibc gained an implementation of strerror() recently.
    Use it and drop the ifdeffery.
    
    Acked-by: Shuah Khan <skhan@linuxfoundation.org>
    Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 76c2a6945d3e..b8967b6e29d5 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -168,15 +168,7 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
 
 static inline void ksft_perror(const char *msg)
 {
-#ifndef NOLIBC
 	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
-#else
-	/*
-	 * nolibc doesn't provide strerror() and it seems
-	 * inappropriate to add one, just print the errno.
-	 */
-	ksft_print_msg("%s: %d)\n", msg, errno);
-#endif
 }
 
 static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)

