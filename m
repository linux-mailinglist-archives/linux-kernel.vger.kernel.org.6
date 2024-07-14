Return-Path: <linux-kernel+bounces-251712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526B93088C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 07:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BE628205B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45836101CE;
	Sun, 14 Jul 2024 05:09:57 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D0DDC9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 05:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720933796; cv=none; b=ZWA+Vd/xO1ArPx06JPFAJ7QrPgdzodCV3/+gjKPBUuNgXrIbv/8vFcP4MLDvo9/aGCSHLJYxwq+vlr6G3+RQVEr1VQXDhJtYlBLO7oaJ5OZ+GGGjBEPoc4vnxrsDWnrEUJb9tdXTUhx7sJOeVgV1BpOJrtD6cCgB6JIUHrVh1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720933796; c=relaxed/simple;
	bh=4GqLVqQKXGxQwbGxixngbg8l0VCZislz9zabzAT2Ldc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyKX3CJIyvVgYhDetR6XF/yH/6RG9ShwWYQOciWHC4oq9ON0L79YzRqMsOjROozLhZhHMuDQt2ZpzQl7mGwXTsyjcfyvn0M37IlLCk9902yMN2BiPNDDXFJxjI+/ZcUylntLrwD800sp2RjE8ccPY/HKuW63+2bPLZkcazE0m0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 46E4vW9K029218;
	Sun, 14 Jul 2024 06:57:32 +0200
Date: Sun, 14 Jul 2024 06:57:32 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.11-rc1
Message-ID: <ZpNavC6aidKQCbKb@1wt.eu>
References: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
 <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>
 <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>

Hello Paul,

On Fri, Jul 12, 2024 at 08:16:13PM -0700, Paul E. McKenney wrote:
> On Sun, Jun 30, 2024 at 09:06:39AM -0700, Paul E. McKenney wrote:
> > On Sat, Jun 29, 2024 at 01:04:08PM +0200, Thomas Weißschuh wrote:
> > > Hi Paul,
> > > 
> > > The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:
> > > 
> > >   Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20240629-for-6.11-1
> > > 
> > > for you to fetch changes up to 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b:
> > > 
> > >   selftests: kselftest: also use strerror() on nolibc (2024-06-29 09:44:58 +0200)
> > 
> > Hearing no objections, I have pulled this in so that it will appear
> > in the next -next.  Here are the test results:
> > 
> > make run:
> > 195 test(s): 195 passed,   0 skipped,   0 failed => status: success
> > 
> > make run-user:
> > 195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
> > 
> > So looks good to me!
> 
> And please see below for my proposed signed tag.  Please let me know of
> any needed adjustments.
> 
> 							Thanx, Paul
> 
> ----------------------------------------------------------------
> 
> tag nolibc.2024.07.12a
> Tagger: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Jul 12 16:56:21 2024 -0700
> 
> nolibc updates for v6.11
> 
> o	Fix selftest printf format mismatch in expect_str_buf_eq()
> 
> o	Stop using brk() and sbrk() when testing against musl, which
> 	implements these two functions with ENOMEM.
> 
> o	Make tests us -Werror to force failure on compiler warnings.
                   ^^
s/us/use

> o	Add limits for the {u,}intmax_t, ulong and {u,}llong types.
> 
> o	Implement strtol() and friends.
> 
> o	Add facility to skip nolibc-specific tests when running against
> 	non-nolibc libraries.
> 
> o	Implement strerror().
> 
> o	Use strerror() unconditionally, instead of only when running
> 	against non-nolibc libraries.

All of this looks good to me.

Thank you!
Willy

