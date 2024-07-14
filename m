Return-Path: <linux-kernel+bounces-251851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565D930AA2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 17:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5361F21472
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9313A275;
	Sun, 14 Jul 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoQgIBlv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77237F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720972659; cv=none; b=drEGWNlyWxg7JOpruVUhIvIhs1ST+8QcZNs5D+Dnp3UJqQAp5BW0kOocnPZvB5tCrMGHTavcw4+7E/uhXOiYEh1sSgi1J+tT+i9n63J/dldmAog22nU0vulAsE9wf10mXa0TWYdqXoBC63ISvnyRwXLODC6qwHnZjRDZob1Vh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720972659; c=relaxed/simple;
	bh=FhlcMa+m1dTVs3qOm2gpT7jpu8ayPQ2Df61MA7QXjuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PezDwGAcxtB/ac1ZGrZvP1U6F56ectJN4vUYDOJTJQstvdt1ppAzxj2uaGFMFGkgDH4898Y26jAK+orGs0nS68mJdrS+5wMwMJeG/ftjU2fur4EM7mp/oBuxoU3YZ/0szu4DARvIyRO2PrqGlpbqRPm6l3IxvrE/xxNWd12WlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoQgIBlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36418C116B1;
	Sun, 14 Jul 2024 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720972659;
	bh=FhlcMa+m1dTVs3qOm2gpT7jpu8ayPQ2Df61MA7QXjuU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZoQgIBlv3mEw4vXkkJHc7k1L0mGFN57ghAtVCSGlxbVrSgLDymd5wYoQjjsb25O/S
	 gPta8rehcO2EbhYFY0LEeP6WYXld0h+6hjpXDcmW8qmIpn3rB46ksRutIBgZxgUtNc
	 a0EHTyFt3v5aCvHFi/mRn5/pKEiBnpIyMNzRLxz3dOEjM0pG1qmHckea8IncJ0R83n
	 DUFSQogh5hePdlOLK7Fcr4WPSRt4SlsXhAIhikyvKpjWRIKsn8YU9aU3k1KVDrJ97Y
	 sKSQ2np4XhsvUcQSZCUta1YVNIxrF7EatRj6ODVqeNrz+dOj1VNlhug6liSA7WVel+
	 SX0xR2pzpeZww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0B00CE0B34; Sun, 14 Jul 2024 08:57:38 -0700 (PDT)
Date: Sun, 14 Jul 2024 08:57:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.11-rc1
Message-ID: <78703063-7b61-4cfb-9c8f-ec5040c064e3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
 <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>
 <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>
 <ZpNavC6aidKQCbKb@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpNavC6aidKQCbKb@1wt.eu>

On Sun, Jul 14, 2024 at 06:57:32AM +0200, Willy Tarreau wrote:
> Hello Paul,
> 
> On Fri, Jul 12, 2024 at 08:16:13PM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 30, 2024 at 09:06:39AM -0700, Paul E. McKenney wrote:
> > > On Sat, Jun 29, 2024 at 01:04:08PM +0200, Thomas Weißschuh wrote:
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
> > 
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
> > 
> > o	Stop using brk() and sbrk() when testing against musl, which
> > 	implements these two functions with ENOMEM.
> > 
> > o	Make tests us -Werror to force failure on compiler warnings.
>                    ^^
> s/us/use

Good catch, fixed, thank you!

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
> All of this looks good to me.

Thank you for looking it over!

							Thanx, Paul

