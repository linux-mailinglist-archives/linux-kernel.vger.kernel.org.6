Return-Path: <linux-kernel+bounces-251325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF0E93038D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 05:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AC51C20FF4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC0617591;
	Sat, 13 Jul 2024 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC4egGVS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879103232
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720840574; cv=none; b=mVg1Fklj80PqLGJf7ghBioSYgP3K9w4h1vog9KZRLLcAYHAJNxEy3Q/c7WVDv9Jbfrapu9pILahsSOvvyFqa3+2ruOKkO8hztDn7vzdAUaoNeGUGr2hN2TnhoMjPrmSdthpsqXN9MCxsnGM27sKgtIbM4rqqyADwESKS+DXrybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720840574; c=relaxed/simple;
	bh=EdQQaqDPYROWfoOyq8s5OxdRr4lCnQNCNDowjlLqjLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeBNyT8wem57tEtyGFbv1OnvjuXE+owp8XqckFqSs5eFajwYx56ZU+y06rejfdquLJsWvDsMjaGGuStQp/RxkBxHxlHz9/naumA9u2I+kccIEktw7i/Kyq4ANFolrk8soBlVIrKjoLUvoh1ZcO5q0he95TrTCuoMqRQF4zVJl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC4egGVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAF6C32782;
	Sat, 13 Jul 2024 03:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720840574;
	bh=EdQQaqDPYROWfoOyq8s5OxdRr4lCnQNCNDowjlLqjLQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KC4egGVSGuT19yJ+cw1Rzt1yLMmwY9xp+rtiAJTLjNj4vHCaxe5Wc0WYv3Y9KUV5m
	 hRPCqjY4Q26l/8cUTiCpGdWYWH5KK5C/aMJYW4gcet7Fuatxcrvbor5AL6GIeRBqUB
	 GSXmNcWwHaUEVEssZNF7XuOY7WL1E+k/oHhxTCbVCbLMV3Z/XkBQ5ReiwV5NDxw+64
	 Qe+ANF2AnXG1zDDvxJ3xa1aXXFZNGEX3xlWA+U41nO7jCZk1ylAKgLW3TWd1gJxC/e
	 CTuOs6m+lER1Q7W6sZOSo7dLRcQmWr+fXmljXIv2cn0j/B4Vyx9K8eYtRGNg4e5wGy
	 77BW3b/vOM84w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A4DF4CE09F8; Fri, 12 Jul 2024 20:16:13 -0700 (PDT)
Date: Fri, 12 Jul 2024 20:16:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.11-rc1
Message-ID: <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
 <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>

On Sun, Jun 30, 2024 at 09:06:39AM -0700, Paul E. McKenney wrote:
> On Sat, Jun 29, 2024 at 01:04:08PM +0200, Thomas Weißschuh wrote:
> > Hi Paul,
> > 
> > The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:
> > 
> >   Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20240629-for-6.11-1
> > 
> > for you to fetch changes up to 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b:
> > 
> >   selftests: kselftest: also use strerror() on nolibc (2024-06-29 09:44:58 +0200)
> 
> Hearing no objections, I have pulled this in so that it will appear
> in the next -next.  Here are the test results:
> 
> make run:
> 195 test(s): 195 passed,   0 skipped,   0 failed => status: success
> 
> make run-user:
> 195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
> 
> So looks good to me!

And please see below for my proposed signed tag.  Please let me know of
any needed adjustments.

							Thanx, Paul

----------------------------------------------------------------

tag nolibc.2024.07.12a
Tagger: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Jul 12 16:56:21 2024 -0700

nolibc updates for v6.11

o	Fix selftest printf format mismatch in expect_str_buf_eq()

o	Stop using brk() and sbrk() when testing against musl, which
	implements these two functions with ENOMEM.

o	Make tests us -Werror to force failure on compiler warnings.

o	Add limits for the {u,}intmax_t, ulong and {u,}llong types.

o	Implement strtol() and friends.

o	Add facility to skip nolibc-specific tests when running against
	non-nolibc libraries.

o	Implement strerror().

o	Use strerror() unconditionally, instead of only when running
	against non-nolibc libraries.
-----BEGIN PGP SIGNATURE-----

iQJHBAABCgAxFiEEbK7UrM+RBIrCoViJnr8S83LZ+4wFAmaRxC8THHBhdWxtY2tA
a2VybmVsLm9yZwAKCRCevxLzctn7jCmDD/9dME6sIhlb7+Bm0V1PXH1YbrqBR8rA
FRj620xKl2MMrpxxNDiRtv+5mI28fQklVD1wqZUB7tQV3yq6onFnA2C7QGZLn/kl
9smF6Jxad/ZHYKC4DfuECLLtA/vFutNvpRTrdMUyeTQDaUWZisByzMTSHrvqhHEz
K98sL81uWIIovSM5mQA+RxMrmydT0ts683jfqXi56NPPOUaYSlERl8KZhvUaM+Rn
gG+vULwS7d32/EOI1FJ5qyPVVTr7wC0sKueyKPmPcjfFTtNsip4EZFLsjS9lqezW
m4PM0qCL3XkfgWPek3CIYqd8Y/mjPVYu6m0Mxji3PYboQjZjYON2E8r8EE/fw6Oi
VLc0etIrycus7uVyBCw4LxJHhdINdpxnQG6Qji4OVilvbKCU+PA3ecepxUVGtlK+
3ffjanrwv841eGX7/glPElh3Cj9SJackRU5N5hXisJpWc8ode0NxVBI0g7dn6jF5
sLtZO/JIEof+W+/Hj++3LMQKGi7OrQy0lBe64ENg+l7qhp6Aq3rxjwvZAnTVFtVq
Dh86Wi3JD7Y6wovB1z9hlaAm1xtigxP7j0Gwr6RwSyPTNCrQvUUPOClfonjkqGN/
B28gkbOAKBd4gbgt3d8UYGliaeiBuX23KTAR9tU2rnrJOudLeBlewlPyW09jFS98
jdz8Ay8fuZp+Qw==
=e/Ia
-----END PGP SIGNATURE-----

