Return-Path: <linux-kernel+bounces-315977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1AD96C965
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8CC1F22CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD06C2F2;
	Wed,  4 Sep 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ewoIzGC3"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B138DD1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484391; cv=none; b=CxdRFhsY2cnFsuHBzRINNcxEOQEKU1VjqFaaQ47fpWziSNZU3CInQNIc61nr0ZkhBvbgm9pF/ao/M7B/0CmGdoB5QoyXMggubRfuoVpbIvPfyzszjA+Dv6eKjdYMImqtWRUKT3tesBr4dX3TV9YuWlGl/jydxn7EUckOmXfsEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484391; c=relaxed/simple;
	bh=EZnl5uYlNHiDJu+WCgGj2ZNQ90JoBB2sDAjgz23XqWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUsKGe5zDK+/HYO1AiH+y5CAV3X95pDQvpXZJTghp8E2bJZDqzCRLYDwyudx2/oihuwHojbgAW/cdhJVVWQWVOoviaPYTW1hveS+LostJdPww72D30Yp8bPN8ZwwhfRVTmbrKg3DbszwH9NtKfv4RXKVNzCWNSRmFdeSi/pLhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ewoIzGC3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725484386;
	bh=EZnl5uYlNHiDJu+WCgGj2ZNQ90JoBB2sDAjgz23XqWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewoIzGC30tt1IuZk5t/bbwE5016o3F34leLHZctzARyaswH7XztlHw5+i5tShJrTY
	 WZ3VX1URl4rUR9Kj0xfOr5vd0DHDIhYkq6Xem6KKtG4HZ0LIZ2qq5x5vZ3z+wmSclE
	 i712HUO94KkpLZa6WQlL2/Ft2TBQXkxrMyE6yp5I=
Date: Wed, 4 Sep 2024 23:13:06 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
Message-ID: <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>

On 2024-09-04 15:04:35+0000, Shuah Khan wrote:
> On 8/27/24 06:56, Shuah Khan wrote:
> > On 8/24/24 12:53, Thomas Weißschuh wrote:
> > > Hi Shuah,
> > > 
> > > The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> > > 
> > >    Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-20240824-for-6.12-1
> > > 
> > > for you to fetch changes up to 25fb329a23c78d59a055a7b1329d18f30a2be92d:
> > > 
> > >    tools/nolibc: x86_64: use local label in memcpy/memmove (2024-08-16 17:23:13 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > nolibc changes for 6.12
> > > 
> > > Highlights
> > > ----------
> > > 
> > > * Clang support (including LTO)
> > > 
> > > Other Changes
> > > -------------
> > > 
> > > * stdbool.h support
> > > * argc/argv/envp arguments for constructors
> > > * Small #include ordering fix
> > > 
> > 
> > Thank you Thomas.
> > 
> > Pulled and pushed to linux-kselftest nolibc branch for Linux 6.12-rc1
> > 
> 
> I am running sanity tests and getting this message:
> 
> $HOME/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory

This indicates you are using 'run-tests.sh'.
Pass "-p" to let it download the toolchain automatically.

> I tried setting TOOLCHAIN_BASE to the directory I installed gcc-13.2.0-nolibc

Not sure where this variable comes from, but I have never seen it.

> Something changed since the last time I did the pull request handling.

In the test setup not much has changed.
Maybe you cleaned out your ~/.cache?
Or it's the first PR with run-tests.sh?

> Any help is much appreciated.

Hope this helped.


Thomas

