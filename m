Return-Path: <linux-kernel+bounces-235269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A7391D297
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDA728170C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CCE154444;
	Sun, 30 Jun 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em7d6qSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566415350B
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719763600; cv=none; b=gdCjNPSZCEDxNHwYfvaCU/NmIhgELmhOL3fQFUBYcjIrWvjr/6JZTVggnLoA8d7d20KIG53EOtSasErkJ2m3776hzRIqTIuE6xKpehyHPaUNUzX307A7rUtlocys0PyXVaII3hLoQR8UnfxQkqD9o7y60vUhkIWTlgpMBucieaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719763600; c=relaxed/simple;
	bh=fFlqthzAcVP9jkMkm5ZoWrhxxLnlgyoxL1MEOycMckg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdI65NFiJbdT8L/eRsikj9YbV3OLyP9IGolMy1lpAZTIixLdnqWQ4+fmT9sXhzYh44R/MvgiTGJNlWuPF2ZkqakRdDVJXnEl0qvsgqs0DlA8lYNVFAZHZr6o7MDoBs5+uib5qK//piZzWvafgphNg3EJILkb73WtsumZ5TJiwxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em7d6qSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA243C2BD10;
	Sun, 30 Jun 2024 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719763599;
	bh=fFlqthzAcVP9jkMkm5ZoWrhxxLnlgyoxL1MEOycMckg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=em7d6qSFks6TWpjTKPMLGNJlp0LCHbT23kTPsbPdsAdl+l0dlKL6t+qTtbNOQvMKa
	 p6ZfLrepQrOhWas8/rZFle0QbJngAfGqh5s4sVjs0M2Kq7MjaO5WRbO4tSvVoxa4Xa
	 +60Q9YJ4lcmx+hPVqMvUhOdDQIo7AFsUsieTLFjc8Fok/pi08GmPQUc8580PCgrtVZ
	 t5HrOBwa4NCBr2kAKhPB7YX4RPBq9ATy6EmqC+Yzzf30Jn9hUepZtKwOa687TSRa+8
	 +q9E3bJZak6EW91AniEmkreEk1Ri51EMtmjm2eTtb7IorP0CPq7bI+prp4wBQIIRNh
	 VxMewyce7bhNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 78BBFCE0414; Sun, 30 Jun 2024 09:06:39 -0700 (PDT)
Date: Sun, 30 Jun 2024 09:06:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.11-rc1
Message-ID: <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>

On Sat, Jun 29, 2024 at 01:04:08PM +0200, Thomas Weißschuh wrote:
> Hi Paul,
> 
> The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:
> 
>   Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20240629-for-6.11-1
> 
> for you to fetch changes up to 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b:
> 
>   selftests: kselftest: also use strerror() on nolibc (2024-06-29 09:44:58 +0200)

Hearing no objections, I have pulled this in so that it will appear
in the next -next.  Here are the test results:

make run:
195 test(s): 195 passed,   0 skipped,   0 failed => status: success

make run-user:
195 test(s): 193 passed,   2 skipped,   0 failed => status: warning

So looks good to me!

							Thanx, Paul

> ----------------------------------------------------------------
> Thomas Weißschuh (8):
>       selftests/nolibc: fix printf format mismatch in expect_str_buf_eq()
>       selftests/nolibc: disable brk()/sbrk() tests on musl
>       selftests/nolibc: run-tests.sh: use -Werror by default
>       tools/nolibc: add limits for {u,}intmax_t, ulong and {u,}llong
>       tools/nolibc: implement strtol() and friends
>       selftests/nolibc: introduce condition to run tests only on nolibc
>       tools/nolibc: implement strerror()
>       selftests: kselftest: also use strerror() on nolibc
> 
>  tools/include/nolibc/stdint.h                |  19 +++++
>  tools/include/nolibc/stdio.h                 |  10 +++
>  tools/include/nolibc/stdlib.h                | 109 +++++++++++++++++++++++++++
>  tools/testing/selftests/kselftest.h          |   8 --
>  tools/testing/selftests/nolibc/Makefile      |   2 +-
>  tools/testing/selftests/nolibc/nolibc-test.c | 109 ++++++++++++++++++++++-----
>  tools/testing/selftests/nolibc/run-tests.sh  |   9 ++-
>  7 files changed, 238 insertions(+), 28 deletions(-)
> 
> 
> Thanks,
> Thomas

