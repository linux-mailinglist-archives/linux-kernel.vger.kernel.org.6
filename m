Return-Path: <linux-kernel+bounces-251728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578719308F7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B211F216C9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58918C1A;
	Sun, 14 Jul 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hNx+onJQ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA41BF2B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720944559; cv=none; b=uawx4NFRIWZMuSow09GOCvEgXWrajbJrRm8Hg52xBYmAS6O59azaTGgU4r5ZC5HhFLOnzU1rkTiE5+qebXQtvtI/5kxUbjwBwICCrGTXs+p5tR4DYgTcdQz9iAuxjFqOGJdZfl6OKVzWYiSgW2IYqpqAPp4/TdaU4cz0ocVenzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720944559; c=relaxed/simple;
	bh=ZT57NUsMbQIL0mv4825+WOqgDF8OLdepTxJAz+XS4+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg41u4ryU4ehBJ5U337QDoa9dI/62vyy2DXO9E3xPQwa1Ru/OLdWu/7yZyEBLcuuThKPWitQZ9OVOyzb8HUemJYarUJGflp4KXZ6TpTkDQWGRRonzwqj2ofrxQyzSb/s998NAaxeHhggT9jL/lE0IvE4RFPHC5HKxeF0GpMj/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hNx+onJQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720944553;
	bh=ZT57NUsMbQIL0mv4825+WOqgDF8OLdepTxJAz+XS4+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNx+onJQMojiQ9O0M5ExZ8Y7rcqVs3eGXLoHxLQZnSQ+kjfticrEF55tjLA4WVYJK
	 ZiGjPfsXcDInD7xS9EKtWOQ1Q18A56juVoeFJG3aoB9A+c1GqqFlUzoXMCbh9SLWRB
	 UdGKr3fvMZLHCimTbJmSO40VS0MOhmqfvDBh3OLE=
Date: Sun, 14 Jul 2024 10:09:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.11-rc1
Message-ID: <ee43b1d5-3339-4a1c-9bac-c0d48f22167c@t-8ch.de>
References: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
 <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>
 <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>

On 2024-07-12 20:16:13+0000, Paul E. McKenney wrote:
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

For testing you can use "./run-tests.sh -m [user | system]" to run the
tests on all supported architectures via QEMU.

(On the first run you can use "-p" to download the toolchains)

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

Period at the end.

> 
> o	Stop using brk() and sbrk() when testing against musl, which
> 	implements these two functions with ENOMEM.
> 
> o	Make tests us -Werror to force failure on compiler warnings.
> 
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

Maybe mention that this is about kselftest and not nolibc itself.

Otherwise looks good, thanks!

> -----BEGIN PGP SIGNATURE-----
> 
> iQJHBAABCgAxFiEEbK7UrM+RBIrCoViJnr8S83LZ+4wFAmaRxC8THHBhdWxtY2tA
> a2VybmVsLm9yZwAKCRCevxLzctn7jCmDD/9dME6sIhlb7+Bm0V1PXH1YbrqBR8rA
> FRj620xKl2MMrpxxNDiRtv+5mI28fQklVD1wqZUB7tQV3yq6onFnA2C7QGZLn/kl
> 9smF6Jxad/ZHYKC4DfuECLLtA/vFutNvpRTrdMUyeTQDaUWZisByzMTSHrvqhHEz
> K98sL81uWIIovSM5mQA+RxMrmydT0ts683jfqXi56NPPOUaYSlERl8KZhvUaM+Rn
> gG+vULwS7d32/EOI1FJ5qyPVVTr7wC0sKueyKPmPcjfFTtNsip4EZFLsjS9lqezW
> m4PM0qCL3XkfgWPek3CIYqd8Y/mjPVYu6m0Mxji3PYboQjZjYON2E8r8EE/fw6Oi
> VLc0etIrycus7uVyBCw4LxJHhdINdpxnQG6Qji4OVilvbKCU+PA3ecepxUVGtlK+
> 3ffjanrwv841eGX7/glPElh3Cj9SJackRU5N5hXisJpWc8ode0NxVBI0g7dn6jF5
> sLtZO/JIEof+W+/Hj++3LMQKGi7OrQy0lBe64ENg+l7qhp6Aq3rxjwvZAnTVFtVq
> Dh86Wi3JD7Y6wovB1z9hlaAm1xtigxP7j0Gwr6RwSyPTNCrQvUUPOClfonjkqGN/
> B28gkbOAKBd4gbgt3d8UYGliaeiBuX23KTAR9tU2rnrJOudLeBlewlPyW09jFS98
> jdz8Ay8fuZp+Qw==
> =e/Ia
> -----END PGP SIGNATURE-----

