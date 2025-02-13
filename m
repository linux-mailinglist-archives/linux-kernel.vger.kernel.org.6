Return-Path: <linux-kernel+bounces-513253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF3A34649
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037D1189788D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6478F30;
	Thu, 13 Feb 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBYTuc4d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aQsNIKk1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558326B0A5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459790; cv=none; b=dOwygd3lqhaOE8euqvrcTqDuKp6PuHziZwwpPenyE4wKFDaZwlpCO9Ev0hR0guHI0AqcM/3f1jCzOSF9/SxzMrwPF9na/DjIIbIgcvx5uiRFxpHc79bzc/XwAjpKYituNFPLx7Kc9NUMWUShxULgTkYbsGLDKFY1yX16yxt+ox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459790; c=relaxed/simple;
	bh=u1tycONx8xrIlRIwVEeLJ9RUkmtAWrxWBxjKd4EoMgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr0W88PcyRniFxnj/laN+eYI2qFJ706bm4IV5XoxOALo1jEM68MOO9HUL4S1Gr29JRGxxrfZsYWiyKLedUi751n+nDNJ+gC6fSSvfteGFhcI/v8kJjDNn7NUiaEaJ/n2Ngg250+ok1sGv63YGHsUeEHdlGBfqvcJdNcbwSOGDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBYTuc4d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aQsNIKk1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Feb 2025 16:16:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739459787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrn5daFneqsUrvUsze0qjYwxaGnN6y9LMP2YO22Sm3I=;
	b=KBYTuc4d2vjaLQ6gWz/ZgoE9AaJyQiNRcXi7O/6GrNPmObo72K1DHra2NjU7HZKgd68JVK
	+AfV8+rpflXa2kmnud9XSRsbSWSnCoAA72L8dG6qciGAhuYqxc6J7uQl+bilKnXOdY4jMq
	KBGHjPfmGCzFAcGFTKowrlKYEGyTvLRbxbfPZWKFKv16CdZ3NFOvU08dc43MrUU/CZH75B
	gfmkpn6LcxfApWMaBNUfRRzRy94HMaHM0tAPeUxRTPFkp/6xMTpicPx4lzG/FFipPjblZf
	dpzEUUeMRgJckbIvfx/PMj2oPFMxYLrsvu5G0V2B+OnsKFtxS01WdF9YJkIk2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739459787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrn5daFneqsUrvUsze0qjYwxaGnN6y9LMP2YO22Sm3I=;
	b=aQsNIKk1x6XH+n0xJAcZwMOp5arKtJDiEF10t+BK2Ts0b89qzfS4RTEKm/mRIpcqolm/e7
	+Asmjd5GS79/mJBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Simon Trimmer <simont@opensource.cirrus.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Remove usage of GFP_DMA
Message-ID: <20250213161059-a4c53711-fdf6-480c-af49-f9f36227ba42@linutronix.de>
References: <20250211-cs_dsp-gfp_dma-v1-0-afc346363832@linutronix.de>
 <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>
 <e93d1b72-43da-4e96-9523-e1bbf3853031@opensource.cirrus.com>
 <1e251815-5d58-436b-9120-e88f75a7ecaa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e251815-5d58-436b-9120-e88f75a7ecaa@sirena.org.uk>

On Thu, Feb 13, 2025 at 03:06:59PM +0000, Mark Brown wrote:
> On Thu, Feb 13, 2025 at 02:28:06PM +0000, Richard Fitzgerald wrote:
> > On 11/02/2025 5:21 pm, Richard Fitzgerald wrote:
> 
> > > > Not tested on real hardware.
> > > > This came up while porting kunit to mips64.
> > > > Apparently GFP_DMA does not work there, but IMO the usage of GFP_DMA by
> 
> > I would say that is a bug in mips64 that should be fixed in mips64.
> > It is not reasonable to expect generic drivers to have special cases for
> > platforms that don't handle GFP_DMA.

Indeed, I did that, too.

> What specifically is the issue?  If it's a build time issue I'd
> definitely agree that we should just be able to assume that platforms at
> least build.  IIRC there is a Kconfig you can depend on for DMA but it
> seems more trouble than it's worth to fix all users.

More details in [0], It's only a runtime issue.

I'm still wondering how all the on-stack buffers used with regmap_raw_read()
and regmap_raw_write() by cs_dsp are satisfying the DMA requirements.

[0] https://lore.kernel.org/lkml/20250212-kunit-mips-v1-1-eb49c9d76615@linutronix.de/

