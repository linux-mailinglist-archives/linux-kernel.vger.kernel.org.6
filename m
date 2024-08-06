Return-Path: <linux-kernel+bounces-276145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EEF948F11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2412B2817BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DAC1C460D;
	Tue,  6 Aug 2024 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4m0tszts";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wotMqU59"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF41C3F25
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947765; cv=none; b=nlIImDxU0QTAG5i7HegEX6QUjOMlHcSIizuaLqgiSqCoZaEtN50Sdu/sFtTRpdBo4SugIWcu9DbIDctV5M/A0TdcnU+bvPErP5CgfS3vdIResWHAW5RKXaVj6Pl2Iu2S1iBDHGVJlX7qCTJj1nmayqsP2I6X+X7w/yl8I+QaVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947765; c=relaxed/simple;
	bh=Q5ZNqxDbR4EwDeeBN89lQiVRPFwV9vl6BCMgkOcCKMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNIugn39Zod4o7T+MIVZtBEnG33WVE6qTzrFZdY/+uvuI2YSvlEVEZdWT6bSJZtPjFB9KwWz7MkBcyx/NiXA4uHFImUU8SYY8zneTPDkdWpalKhVuOF3aK3V6kPfhcOQPEG3kJOF+ND/sfsa9/LJr3IEyrPFrzaMy/7FHaBGJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4m0tszts; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wotMqU59; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 6 Aug 2024 14:36:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722947761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxRFPMssv0TbntD/eFDfQJABume4sd1MP+ymuPVXIMs=;
	b=4m0tsztsBPr+9mmrcnWxq/lZkoO8odl8CGs6qI25Z1zRNYgQoKXKr4ZaByl6dBrVhFzByu
	kzA5HK8d9DMIOtsKiVlrdcZO/8QWXdrbbKjYqqjOsCLbqdNa4KaD0fVY+45JiomSwJkueT
	z9cNVR8YYFIPCX1QATrLaeyWFJ920wDF1X1U4QwsyNd4TId6eOQmDrskXmTeAmvKoNmWid
	TY0AUs52gyd4bOmrCTMoq51FigtT2MDE9a8lE3nvlgfC/jvuMrcjP90VKpB1FGP4EiPciB
	N3LbMvHa0DE1NrFVpp5vB2n9BHncTWQsw7Vj5ajqlMt7L/jfM8dkyCyNtgwDEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722947761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxRFPMssv0TbntD/eFDfQJABume4sd1MP+ymuPVXIMs=;
	b=wotMqU59S88oaztq3MncD0BL4YuXzvYzxYh4qAO3DGWbQurB/e6HrSu55TBnCKXPBZA7aM
	OlapAP5nRhxhSTDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH] ASoC: meson: axg-fifo: fix irq scheduling issue with
 PREEMPT_RT
Message-ID: <20240806123600.uI5LeCdp@linutronix.de>
References: <20240806102707.3825703-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240806102707.3825703-1-jbrunet@baylibre.com>

On 2024-08-06 12:27:03 [+0200], Jerome Brunet wrote:
> With PREEMPT_RT enabled, spinlocks become preemptible.
With PREEMPT_RT enabled a spinlock_t becomes a sleeping lock.

> This is usually not a problem with spinlocks used in IRQ context since
> IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the upper half
> of a threaded irq handler won't be threaded and this causes scheduling
> problems if spinlocks are used in the upper half, like with regmap when
> '.fast_io' is set.

=E2=80=A6 However, if IRQF_ONESHOT is set, the primary handler won't be
force-threaded and runs always in hardirq context. This is a problem
because spinlock_t requires a preemptible context on PREEMPT_RT.=20

> In this particular instance, it is actually better to do everything in
> the bottom half and it solves the problem with PREEMPT_RT.

      threaded handler

The term "bottom half" is usually used with softirq. The IRQ part has a
primary handler and a threaded handler.

> Reported-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Closes: https://lore.kernel.org/linux-amlogic/20240729131652.3012327-1-av=
krasnov@salutedevices.com
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Fixes: b11d26660dff ("ASoC: meson: axg-fifo: use threaded irq to check pe=
riods")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  sound/soc/meson/axg-fifo.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>=20
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index 7e6090af720b..d0d05fa44d66 100644
> --- a/sound/soc/meson/axg-fifo.c
> +++ b/sound/soc/meson/axg-fifo.c
> @@ -251,8 +244,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *compo=
nent,
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
> -				   axg_fifo_pcm_irq_block_thread,
> +	/* Use the bottom half of a threaded irq with non-atomic links */

This requests only a threaded handler. There is no "bottom half of a
threaded IRQ".

> +	ret =3D request_threaded_irq(fifo->irq, NULL,
> +				   axg_fifo_pcm_irq_block,
>  				   IRQF_ONESHOT, dev_name(dev), ss);
>  	if (ret)
>  		return ret;

Sebastian

