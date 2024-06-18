Return-Path: <linux-kernel+bounces-220136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061D790DD11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29551F25B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A016F277;
	Tue, 18 Jun 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XAM5oCBX"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146216EB76;
	Tue, 18 Jun 2024 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741388; cv=none; b=IpDoJjFqY53hthp8+RiRdjgLzJolmtAobAkFXvwCYmckLjSVoHtWmbBnagUE1v92bOtIdGBGp9qpRVS4lRG/IgMkoWz25jE17GC26DsSH0U2+rNmwESjDolapEmnOkJ+Zge1ToDJ3obFFNydUPMUi+zqz75NqiL451bVISxgtXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741388; c=relaxed/simple;
	bh=xzT72cnzFAOsO1Dlftr5kGujPAaYNwOv5kLYJyfnQFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9C4BM8+Bw11s4mDEtMS3nOwQ73KCQtrKRUxgbWSlBiCn97w66HqpkP9FeSkp2Oy03ZQL8dkr56VdsT+eJDzf49xnETsucQqvU/UR8Pv4HRWEiGMQmmAIuOxQz2e1lV8hg+TSLCWO1g0LHVTschZMRHE0Fj4VSifydAsc1qvBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XAM5oCBX; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38F4A20002;
	Tue, 18 Jun 2024 20:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718741377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5QkoL0pNNpii6fLkIcYMP6ZEwDfv27RbGj78tY8cKco=;
	b=XAM5oCBX/upEqGKEDtOn0CIi7bnlHESrdK45xPDJYlLWzkrkgLPQl7j8mXnYeuepLZ7Aci
	0Qfx+Nkjtfgp91e6lRWv4/DFqC0J6kSFi+29g+2bF6TsZRzzdetTquL2mrEJqwSvqPpgvt
	ZcbTQg0lN3etaxx2EDQYbycZA3Qs1Hm4Evc7bmhmCv8gL6/ZiENoXhNkwwAyb7D8+YO4UZ
	Fs48WHWRnJ3RqSvQzI4bOD4xZhi9k10hOEQNLWbkJsZSBdYWqOJ8vHHpGP+T0V8Man0ENG
	WDUiNEcKyEb927fiM1BWC2rkGQoq//2X4ToMnWxMzK4qgJRuGCPPpnm2agcDwQ==
Date: Tue, 18 Jun 2024 22:09:32 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aniket <aniketmaurya@google.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] i3c: dw: Add optional apb clock
Message-ID: <20240618200932858a6e40@mail.local>
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240611171600.1105124-3-aniketmaurya@google.com>
 <202406182005584f0deea8@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406182005584f0deea8@mail.local>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 18/06/2024 22:06:00+0200, Alexandre Belloni wrote:
> Hello,
> 
> On 11/06/2024 17:16:00+0000, Aniket wrote:
> > Besides the core clock, IP also has an apb
> > interface clock. Add an optional hook for
> > the same and appropriately enable and disable.
> > 
> > Signed-off-by: Aniket <aniketmaurya@google.com>
> > ---
> >  drivers/i3c/master/dw-i3c-master.c | 12 ++++++++++++
> >  drivers/i3c/master/dw-i3c-master.h |  1 +
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> > index 77a2a1c3fd1d..41cdfd6741e3 100644
> > --- a/drivers/i3c/master/dw-i3c-master.c
> > +++ b/drivers/i3c/master/dw-i3c-master.c
> > @@ -1470,12 +1470,20 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
> >  	if (IS_ERR(master->core_clk))
> >  		return PTR_ERR(master->core_clk);
> >  
> > +	master->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
> > +	if (IS_ERR(master->pclk))
> > +		return PTR_ERR(master->pclk);
> > +
> 
> I guess you need to update the device tree binding documentation too.

Sorry, you did and you had changes requested, forget about that.
> 
> >  	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
> >  								    "core_rst");
> >  	if (IS_ERR(master->core_rst))
> >  		return PTR_ERR(master->core_rst);
> >  
> >  	ret = clk_prepare_enable(master->core_clk);

It could be worth having a look at devm_clk_get_optional_enabled

> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = clk_prepare_enable(master->pclk);
> >  	if (ret)
> >  		goto err_disable_core_clk;
> >  
> > @@ -1520,6 +1528,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
> >  err_assert_rst:
> >  	reset_control_assert(master->core_rst);
> >  
> > +	clk_disable_unprepare(master->pclk);
> > +
> >  err_disable_core_clk:
> >  	clk_disable_unprepare(master->core_clk);
> >  
> > @@ -1533,6 +1543,8 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
> >  
> >  	reset_control_assert(master->core_rst);
> >  
> > +	clk_disable_unprepare(master->pclk);
> > +
> >  	clk_disable_unprepare(master->core_clk);
> >  }
> >  EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
> > diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
> > index 8cb617b8147e..50c38e790c0e 100644
> > --- a/drivers/i3c/master/dw-i3c-master.h
> > +++ b/drivers/i3c/master/dw-i3c-master.h
> > @@ -36,6 +36,7 @@ struct dw_i3c_master {
> >  	void __iomem *regs;
> >  	struct reset_control *core_rst;
> >  	struct clk *core_clk;
> > +	struct clk *pclk;
> >  	char version[5];
> >  	char type[5];
> >  	bool ibi_capable;
> > -- 
> > 2.45.2.505.gda0bf45e8d-goog
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

