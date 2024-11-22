Return-Path: <linux-kernel+bounces-418735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 080289D64D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4E8B21E36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758C183CD5;
	Fri, 22 Nov 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZfrRAgU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADD1714BD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307016; cv=none; b=bf3JHgGLNx2sP+stoKVEhU32JRNwhy0vafD/5C6Vf1X9ZfdYQjGvroe92EE2rlEeynvZxLBkEOkQRaIGYU5QWmvJThU8ERflzwHCVMygH1B3PgPZ13m61tY44QyvAjlXECKBGylu/6XSsYERorkfLixJh/gtHGfle5EMuBIvBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307016; c=relaxed/simple;
	bh=q5BVTvv7YMvU/xqiQt3jmWvEpuGEAwgKC66AKXtSdkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jI+2tn7c7Y7JSd3/VziH+Q5324oz9A/zbQKBdvhO6BKT3wyLVWoDehFV34oyexLOEHgpRmyS+YVCtHfIwWt5a9/MgHoJIp3LkHJ6Y4M4o0vmmPwpnZ08cu69S1R2VhJAesEHjRLlUfiPIXixbLujaAvHRJ5IcG5B3S9x+fzZrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZfrRAgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CC0C4CECE;
	Fri, 22 Nov 2024 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732307014;
	bh=q5BVTvv7YMvU/xqiQt3jmWvEpuGEAwgKC66AKXtSdkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XZfrRAgUu064iEDdqa0AVvg5HKk9Fwl0Jo5rZqhV1OC8gDoDD9d+s0KQTG9VP/y38
	 gVWAjqN+9c2Iq4tLGHRj4Uwoqd8K8SzFzg1e1zbPdBEFLZFj7+dThAW9849jSncSJM
	 l9n5PRqWY8GoE/LLp170N8hVvwjP+9lL/w+DaezWIl7j0PSo4xlcGe+KouRLYg0KFl
	 JPeJtTL/AYvnYOvUNefFIX9aURa/8+98ivr9AU+he5EoNuyAxaDdJQabqd9gdjlNnt
	 ZUZxonR1DRB2inCo0+Eo66KcxyR3TOxlfDVjtgVcVwSrWFMolwVmAOp0KRTay1pgVZ
	 mShwgYCDxHF0g==
Date: Fri, 22 Nov 2024 21:23:31 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] HID for 6.13
In-Reply-To: <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
Message-ID: <4042p469-o208-q0qq-7p10-16no004o7s0q@xreary.bet>
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm> <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 22 Nov 2024, Linus Torvalds wrote:

> > please pull from
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024111801
> >
> > to receive HID subsystem queue for 6.13 merge window.
> 
> Hmm. There's something odd going on here. My mouse scroll-wheel
> stopped working (Logitech MX Anywhere 3), and this pull would look
> like the prime suspect.
> 
> The mouse otherwise works, so it's not that the mouse isn't found,
> it's literally just the scroll-wheel functionality that doesn't work.
> 
> Oddly enough, if I remove and re-insert the Logitech wireless dongle,
> the scroll wheel works again. So it's not some kind of complete
> breakage - but it also wasn't a one-time fluke thing, in that it
> happened twice in a row when rebooting into a new kernel.
> 
> Any ideas? Does this make anybody go "Hmm, maybe ..."

Interesting, in this round the only patch to the Logitech driver 
(fb6c0583a1435) should really be pretty much nop, so it might be something 
slightly more subtle.

How do 

	/proc/bus/input/devices
and 
	/sys/kernel/debug/hid/<device>/rdesc 

entries look like for this device in working and non-working case? Are 
they the same?

Does scrolling the wheel produce any output in

	cat /sys/kernel/debug/hid/<device>/events

?

Thanks,

-- 
Jiri Kosina
SUSE Labs


