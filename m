Return-Path: <linux-kernel+bounces-392974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5993A9B9A4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655FC1C213A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530B1E3775;
	Fri,  1 Nov 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tAPvw2zP"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8F487BE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497245; cv=none; b=ExefDClp18mHxXxNm7lJtj7GSq/Q1HbBT+oaGHjNkAkz3/E8U1vacbROpTkC3WvXPkHII0aqBDsKTgE/dMr5BYHgFs1qzrWjfaQmPpJH6fXZpCZUgCekUwPKZnJLVOXN1QsVDqceZEswbLu9lC+AcugI4+gf1aw93suFaaaYLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497245; c=relaxed/simple;
	bh=oF80iahe4vnM+k6iN3jR1ao3+51/yN1Mo4o0yamZzqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI2FAQkrBE98VBLQ0zY2sSM460UG0gXx+GUaHE2BbGh9FdjDsbNQE2iJZjQh5Mxnux3rsoOhchDYrsJmPeCL74co03IzMznnaVhQV0mzFv+jkmCRf53jpkjMvk20TPWA2UJM0PBKxdO9OZzuAWWYcCdmFi04YfHq99ZXxVyctZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tAPvw2zP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730497239;
	bh=oF80iahe4vnM+k6iN3jR1ao3+51/yN1Mo4o0yamZzqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tAPvw2zPNz+v4K3uQVVQ3GtdyTtKWwxuVHnaa3XQsQyqIYIjzpYsUo65b00XVl9dS
	 qj+KFc9eP31FP9eLw8nSKmBwAk4SMvhM4mk2Ulinj3KquqRZuWjDf71bpzSZfcYMRz
	 77B236hCm3zITlR+C7h/5eTTbD8aEIIvzU13ys4Q=
Date: Fri, 1 Nov 2024 21:40:34 +0000
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.13
Message-ID: <49905050-8bea-498a-9a69-bbf7e00f30c8@t-8ch.de>
References: <ba23217d-5eaf-4146-8ed7-27289cece364@t-8ch.de>
 <7bac1319-fe1c-454d-b96d-8344bdce3961@t-8ch.de>
 <f9d51d6b-f38e-48bb-be5a-97217fb503c1@paulmck-laptop>
 <ce65b110-259a-4edf-a84b-4015c6160f52@t-8ch.de>
 <20241101213314.GC15112@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101213314.GC15112@1wt.eu>

Hi Willy,

On 2024-11-01 22:33:14+0100, Willy Tarreau wrote:
> On Fri, Nov 01, 2024 at 09:23:48PM +0000, Thomas Weißschuh wrote:
> > Hi Paul,
> > 
> > On 2024-11-01 13:22:17-0700, Paul E. McKenney wrote:
> > > On Fri, Nov 01, 2024 at 02:22:13PM +0000, Thomas Weißschuh wrote:
> > > > (resend to add missing Cc: LKML)
> > > > 
> > > > 
> > > > Hi Paul,
> > > > 
> > > > The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> > > > 
> > > >   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20241101-for-6.13-1
> > > > 
> > > > for you to fetch changes up to ad0558f3883130954ca724697f2d19aef93967b3:
> > > > 
> > > >   selftests/nolibc: start qemu with 1 GiB of memory (2024-10-07 21:57:45 +0200)
> > > 
> > > Thank you!  I have pulled this into -rcu at signed tag nolibc.2024.11.01a,
> > > which copies from your signed tag.
> > 
> > Thanks!
> > 
> > > The usual "make run" and "make user" worked fine, but "make libc-test"
> > > gave me the build errors shown below.  Is there some setup step that
> > > I omitted?  Or is this not really a necessary test?
> > 
> > That test does not actually test nolibc but the nolibc test suite.
> > It uses your system libc and makes sure that the nolibc test
> > expectations match the behaviour of a "real" libc.
> > The missing strlcat() function was added to glibc only in 2.38, so I
> > guess you have an older version.
> > On my glibc 2.40 "make libc-test" works and the test itself succeeds.
> > 
> > I'll see if there is a reasonable to make libc-test work on older glibc.
> > But it shouldn't impact this cycle.
> 
> Maybe we could just enclose the test with:
> 
> #if !defined(__GLIBC__) || __GLIBC__ > 2 || __GLIBC_MINOR__ >= 40
>  ...
> #endif

This will mess up the test case numbers.
The test is actually only running on nolibc anyways, so we could also
stub out strlcat() with a dummy inline function.

> The real libc test is indeed not critical but it's important that we try
> to keep it working reasonably well over the long term as it reminds us
> not to diverge too much.

Agreed.

> > For better architecture coverage I would recommend ./run-tests.sh over
> > "make run/user". Speaking about this I remember the discussion from the
> > 6.12 PR where Willy proposed an improved run-tests.sh error message.
> > It seems he didn't push it as a commit, so let's add keep it in mind for
> > next cycle.
> 
> Oups, I vaguely remember proposing a trivial patch in an e-mail a while
> ago but I don't even remember what it was about. My mind is totally taken
> by the upcoming haproxy release these days :-/

It's at https://lore.kernel.org/lkml/ZtlQbpgpn9OQOPyI@1wt.eu/
No worries, I'll pick it up after 6.13-rc1.


Thomas

