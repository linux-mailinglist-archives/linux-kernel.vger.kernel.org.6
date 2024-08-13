Return-Path: <linux-kernel+bounces-285075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8A9508EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B964B26825
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4E19EEB7;
	Tue, 13 Aug 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VJTBe3qh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyjWMK10"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4C368
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562568; cv=none; b=LjLNA/DT17GBeMUUGJcATu+HAv4nSiwwUHCNcHdT16e8EBrOV/XmAlt8jWP5hztIZQTrXVtfKg/RBttBa1UnHt6VX+5PeptkYBBzHORRee53P1+i/8IWe0nwza0ENp1q2929f8qxLtwruLwirnidzSzVm+/fIAyNUQ0H1fmQxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562568; c=relaxed/simple;
	bh=SCILEbD9383LEVKt7wlG2zqcA2/nxq5Pc5x9g0ZN3xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlHapLQsO6vde+cEa/TO6fFoZiAvyM6mD0tAs2pvgPrlelUMwpfJ/qhi/jSeK/iDfV8ONCip1GDgUY3RE/v124PurMADTjngyLzna5eTLDPtADcRdhHLLzfDnkY9klujO+AI+8ik4l3S7wG2b/1lsUnPaLBAFEaek5JrJmVP1R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VJTBe3qh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyjWMK10; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Aug 2024 17:22:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723562564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5/E7ZJ4wGcPnowXOcotLGIaNe6xlDkthLXxOfxn/IM=;
	b=VJTBe3qhTwmSyv+Ep8Zivpuql5YfALl0d/U7P1AMY7WCPIA5MnJ+zsEXrNlS7fHI16EGoF
	r9S7Qu/+dQXBUAEIQWwoiepOvs18fbWedjqFtEoaIkfpz2pubpdm41RHztQPWFzWpiI02S
	c2WylEwIkJLwB7nOezbEjnl+UX9DZ6jkydFdWl5it12EHofrb88wvdwCI2nJzGhdLwDcPq
	LYO1Srf5SU+SCqTG0zO08c8BVHfeKsj0l0tLKQF0tPPhsHk0aLWu6kAC2ss5oe1uUxmpD5
	/rwXbRmAf+FyeJH/cCxnBs+l8WenvM0sZMRTwwUH2V5vc0m/uC5C1cKbiPosXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723562564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5/E7ZJ4wGcPnowXOcotLGIaNe6xlDkthLXxOfxn/IM=;
	b=AyjWMK10XA1oBwhboOrf9Z46wxNRgkQKjVvE2863FVPVuOPdvctQMbo1SBvhbdxtkkzAg4
	8gFC0gzk/LbN4NCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH] ASoC: meson: axg-fifo: fix irq scheduling issue with
 PREEMPT_RT
Message-ID: <20240813152243.2H3-mnx5@linutronix.de>
References: <20240806102707.3825703-1-jbrunet@baylibre.com>
 <172356023429.57695.4053614993109219592.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <172356023429.57695.4053614993109219592.b4-ty@kernel.org>

On 2024-08-13 15:43:54 [+0100], Mark Brown wrote:
> On Tue, 06 Aug 2024 12:27:03 +0200, Jerome Brunet wrote:
> > With PREEMPT_RT enabled, spinlocks become preemptible.
> > This is usually not a problem with spinlocks used in IRQ context since
> > IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the upper half
> > of a threaded irq handler won't be threaded and this causes scheduling
> > problems if spinlocks are used in the upper half, like with regmap when
> > '.fast_io' is set.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT
>       commit: 5003d0ce5c7da3a02c0aff771f516f99731e7390

Didn't you already apply v2 of this?

Sebastian

