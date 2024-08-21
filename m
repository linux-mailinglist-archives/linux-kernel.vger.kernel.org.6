Return-Path: <linux-kernel+bounces-294863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFA959384
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C280C1C2140B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9639F1586C0;
	Wed, 21 Aug 2024 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="iz4Pgecd";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="SQDvBKGe"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2E3D8E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724213050; cv=none; b=KQ7hQRrze8Du4iFQvveb/uKYzXqDPYtKu21Mynq7/WYN3DLLfW2muf1crb+DFlC7a0yHuVQVrAAPFxfseLhdyTaBVXnaD6N5+uvPrctXB9fczfnvU+sRRhXC88JCnyqiloC5tP1ZtfXKsLdKD02iGPgs2BrrOG/aidkHvCih4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724213050; c=relaxed/simple;
	bh=iRH6vm3f+qvme31wvecI88/Rqtmvlts9o6HozktikAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJP/iDPEppcHTL48uAmj5AAbxoJRJ/jKbNauYLSJpwjSpPcT8I83Q3romN9l1T6GLjcUWQHZak+PBlTVrQDoxQspvQave+tU4saiBn+4+xENQormK1gsjKe0kqVj+VXvI/yF1hIXwjzg2eq8QzG++IwY+Ugby/0AjK5WNQKdozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=iz4Pgecd; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=SQDvBKGe; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1724212683;
	bh=iRH6vm3f+qvme31wvecI88/Rqtmvlts9o6HozktikAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iz4PgecdpbUrvyd4gw8XXc9uXIomOwIADrN6X00sQd4TR0jiKxHenFzb5ndyBbuLF
	 rKxSLronsPTJyXCXkjeZg05IoDhp40+VrhYfrF5ckNx7zIeyES8qZF61fdZS6JvgCx
	 WSuAkRtxNxYMamcb6lp9axAA5G/GDJTxypCBAlLpGxk/Z18KaBPqZ3UdN4LAtdLHq9
	 J93j/MPzFnlPKpsOlRAQQGmDhTiefpbM/xZVbymlycFj8sYzq+7BjjXoEkFDCPRQ7k
	 7jV4cELlGG7fszPDiL4dppNVqzLu6iSv1pJ1VkwcExiuq4I1JtMENEkmeS3T/ValmI
	 rCqlOx2f3SZZw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id CCD189ED
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:58:03 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=SQDvBKGe;
	dkim-atps=neutral
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 7BE33A16
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:57:59 +0900 (JST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3bd8a0be3so5184525a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1724212678; x=1724817478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+qnGxy5w3VX94K4aj4lv3e2rRMZae3o2HZnHPaaqtQ=;
        b=SQDvBKGePBilRbJqBKvXGN21FcDd5vc29abDCoFscF3HTDibB/4PClSDkGZUKka7iI
         bYdJ344hQuYMdBSRG4lEpg3csG8WEmFapc3/8L+GMAFu3hN/4Dki108yVmQiDdPz+5aZ
         GTET/gU+rkc/2TRmqjN+yNOdUItT5UOjEtuvpT+TUmZAbEaZhIyGxQi2GRXAlvOvEwMv
         6Xe5xxEZQ47TfJukuzPE+BXba5IusYi4nqSAcsYwEorXxFEw8Kxt+9hLP3R4gm/yK5KU
         0Qs+QwtbwTp5Kx6y/gEv4zpaFPQoN45BEWe2qI7nWW8JZbmw4USRK9sF40P56ftcbFv/
         uYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724212678; x=1724817478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+qnGxy5w3VX94K4aj4lv3e2rRMZae3o2HZnHPaaqtQ=;
        b=dB5Z2vYHLhW9yd5WI2m9LNTQLbaCW6ZNxB1jqrph+9z5/01kr6tI0gbD/DuFLKm3N0
         vbpNhOqFVF9eV77se4Lqm2N+vz912EPNjdGPrxlAbs7nQwgx8y8GNFbvU2gx9af8tkhm
         furdHir73bSu6EGcFbSCLTXmgjSftM50+xrkvbFcSl7TcJOMp1zmY+vMkWn/qiXVBBE5
         /EPFnqku/vAqdYx7X8xKX9XroKOvejh3Lohhl0dzvit9G1j+9MX50EKa6v3qI/kOuBtV
         5ZglMcKRNXceEk3xF5NPcKbVhtoQi+Mh53Y1wj0Mdh92GNyRCjk3AcmNb1kTXxd8Eepl
         xKQg==
X-Forwarded-Encrypted: i=1; AJvYcCXRz7R4ArpaAClX2cEAcRmKOy/u+R0v4HTjKsYLpgEOLsY6M6j533W006M38SzV+sMYccejG51bEOI0rhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01QGHvhOPofgkuDn88SwMCqlEANwycofb/7++V9KgxGCkQZQM
	T071mFy6F8rtRaztlDoSabX327DYDm6ZMjYSM5Drh9G4i1h2Uj34oQm/JsfsG5xT/4g1WPrCSFJ
	AhArk178BcBAcWr9IjfOG6cXEf11Zo87lHKKMax3A7KsgS17/ldhL1vDIsZQmn14=
X-Received: by 2002:a17:90b:1e50:b0:2d3:d8c9:780e with SMTP id 98e67ed59e1d1-2d5e9a1c42bmr1083909a91.20.1724212677609;
        Tue, 20 Aug 2024 20:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVIiKdohXScz0/LgmYJB0F0NSJGU/plj9oicFpDF0zuctdGMznMuiv+lGTxqm9jYAS6FVvyw==
X-Received: by 2002:a17:90b:1e50:b0:2d3:d8c9:780e with SMTP id 98e67ed59e1d1-2d5e9a1c42bmr1083873a91.20.1724212677161;
        Tue, 20 Aug 2024 20:57:57 -0700 (PDT)
Received: from pc-0182.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba30e40sm501627a91.24.2024.08.20.20.57.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 20:57:56 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1sgcTr-003xuT-0q;
	Wed, 21 Aug 2024 12:57:55 +0900
Date: Wed, 21 Aug 2024 12:57:45 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, marex@denx.de,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: drm/bridge/imx8mp-hdmi-tx: Allow inexact pixel clock frequencies
 (Was: [PATCH V8 10/12] drm/bridge: imx: add bridge wrapper driver for
 i.MX8MP DWC HDMI)
Message-ID: <ZsVluV50NvuGGHFX@atmark-techno.com>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-11-aford173@gmail.com>
 <Zm_UzO4Jmm7Aykcm@atmark-techno.com>
 <22a3f5266260dd3915269ae3eec7724f7537eb55.camel@pengutronix.de>
 <cd03ecb1-100e-4699-95ed-d837a2802dc7@kontron.de>
 <CAHCN7x+bh_ka250hOCenO3Et6re4EJ=5TG8=kpG1hs-PV0dQxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7x+bh_ka250hOCenO3Et6re4EJ=5TG8=kpG1hs-PV0dQxQ@mail.gmail.com>

Adam Ford wrote on Tue, Aug 20, 2024 at 09:49:03PM -0500:
> > > However, this check is a bit overcautious in that it only allows exact
> > > rate matches. IIRC HDMI allows a rate mismatch of +- 0.5%, so this
> > > check could be relaxed quite a bit to allow for that.
> >
> > I checked with a 1080p display that reports 23 possible modes via EDID.
> > Out of these 15 are accepted by the driver with the strict check.
> >
> > Two more would be accepted with a relaxed check that allows a 0.5% margin.
> >
> > For the remaining six modes, the pixel clock would deviate up to ~5%
> > from what the display expects. Still, if I remove the check altogether,
> > all 23 modes seem to work just fine.

I can confirm the displays I tested also seem pretty tolerant in
practice (up to ~3-4% at least), but I agree with Lucas that this isn't
something we can rely on for a general purpose driver as having examples
of things being tolerant doesn't mean all hardware will be as flexible..

> > I'd really like to be able to add more PHY PLL setpoints for displays
> > that use non-CEA-861 modes. Unfortunately I didn't manage to figure out
> > the fractional-n PLL parameter calculation so far.
> >
> > The i.MX8MP Reference Manual provides formulas to calculate the
> > parameters based on the register values and I tried to make sense of it
> > using the existing register values in the driver. But somehow it doesn't
> > add up for me.
> >
> > Lucas, did you already work with the PLL parameters? By any chance, do
> > you now how the math behind them works?
> 
> I spent a little time trying to understand it a bit.  I created a PMS
> calculator similar to the one used on the DSI controller,

Great! I'll admit this also flies over my head and I don't have the
time to study this, so this is much appreciated.

> except that
> the M seems to be fixed at a value of 62 per the data sheet, so it's
> more of a PS calculator.

Hmm... PHY_REG2 in the datasheet only lists '0011_1110b - 62' as
example(?) values, but it doesn't say other values are reserved either,
I'm not sure what to make of it.
In the current driver PHY_REG_02 (driver macro) is assigned the first
field of .pll_div_regs, which goes anywhere from 0x4b to 0x7b -- pretty
far from 62(0x3e)...

Since other frequencies have been adjusting this main diviser ratio we
actually tried copying neighboring values and adjusting only that reg 2
(so the M if I get this right?), but the end result ended up not
synchronizing properly every time... We didn't have time to check with a
scope if the generated signal was ugly or if it just didn't lock
properly, but the display worked when we just re-used the neighboring
values without changing anything despite being ~3-4% off, so we took the
easy way out here and didn't dig much further.

> Anyway, When I run my P-S calculator to generate the 'best rate' I get
> a value that's usually 0.2% variance from nominal, but I only verified
> a handful of values:
> 
> Several which were +0.2%
> 297600000 vs 297000000 (4k@30)
> 148800000 vs 148500000 (1080p60)
> 74400 vs 74200
> 
> One value was -0.16%
> 24800000 vs 25200000
> 
> If the M value was a bit more flexible, we might be able to reduce
> that variance more.

Yes, I think the M value could be more flexible, but that'd require
checking if it actually works, whereas having slightly off frequencies
will most likely be OK so I don't think it's worth the effort -- happy
to stick to what the datasheet describes.

> If / when I get some time, I might play with trying to disable the
> fractional mode and just use the PMS calculator for simplicity despite
> the inaccuracy.  Maybe we could fall back to using the PMS calculator
> if the desired frequency isn't in the look-up-table.

That'd be greatly appreciated, I don't have any strong opinion on
whether that should completely replace the table, or only be used if
there is no exact match in the table as these are values we know will
work; but we can definitely test any patch you can throw at us here.


Cheers,
-- 
Dominique



