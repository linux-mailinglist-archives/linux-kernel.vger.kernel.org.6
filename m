Return-Path: <linux-kernel+bounces-310411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF298967C5D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 23:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04704B2126E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74213A3E4;
	Sun,  1 Sep 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="uHEuHBYx";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="J6uk9Wj2"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0561C36
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725227203; cv=none; b=hqCxI0O5ku3PAQXZfG7iAFhme1TUoFvftTwJD9cu0c3U6hXvk6pSoHDhvfBYfGjpuUnlUaHOtiFuKWxEXNNdlITh8c+QM5KIsVtNAplC8Toq388+XbyUTfEBDL8AY8es5F7jHJ96EFjq48/3v7G9xFr4YwgXcP/CiO68nvxGMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725227203; c=relaxed/simple;
	bh=Fc6jdlhhqUfBDtoCkcjqQlwdvZp0Mm902RhOUtVCNUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmZ8G0ENAtj580E392XRR4hlPW7FW8rU8L5msbN+Lh2PQlGMbb1HClb74Ag2yAXTF9uSWe+fsSUJERN/orHPFM+9NWDzml9rKz4EJANuxF+tQoGcwW9DzJuu8mnkIxzb3O0i4gDicMv5jScZ8wro6XAwzuRgjRNkvEqosnuKFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=uHEuHBYx; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=J6uk9Wj2; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1725227193;
	bh=Fc6jdlhhqUfBDtoCkcjqQlwdvZp0Mm902RhOUtVCNUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHEuHBYxnOWvOuwjEgpbzVB6TLglQZwatK8gNUWPP3Lv2YZp3E+kRcHl3WjL/ph2I
	 Fde+aUPI+Tk/noYZ2cC7nQ4HF+l2LR8X3UIOsHZSOnlc9ch7MNEpUFW5w39dkmdlFn
	 MGDDXMdteqrcHhBPw6mMfs/EKRf0Y6RklfUMuqNXwPUu0D0GUbL2cUYuLHnzNRpvHl
	 ohA98+VkvvJCYcoDsYciTiH3if+NCgCeJxphmoxASbUBLifZu9AYVj0VyqcMLx0WOV
	 W7UA2KhVFLDQsAcCrth7KDq/Xds7fjPrnp4Hcc/Ec+K7uqzadw/wzBZ8bi1AyAvmO/
	 vsK/KE+E+MvJg==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 92EC5938
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:46:33 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=J6uk9Wj2;
	dkim-atps=neutral
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id ECAB5938
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:46:31 +0900 (JST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8e59fcd4bso228372a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1725227191; x=1725831991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqoR1K0s1LZWBnxVYuck4KdhPBlvgzt5rveXqQj0UWY=;
        b=J6uk9Wj23CQLlXMLIJ9RA+quJ9dJJeEX+nbtle0ed4VdgaNTeKfLZIMWhqYOVHcP6K
         1wySxGy6cZk88yG017M6NH64MKKrSF+K4JLRs2bUChmg8FA1D3R+38v1lUCPdu42QHBM
         MLL0ivM+R2Paj60FbvX+3vytSBx3f/aQrsJkCec13W6uMxrkLDA5L8ns8j5KvAPRm4P9
         slKruy18K+XYJAeqPNcbAfoGvMaAlScvfjF3+Cc2q2HlWxyuYFLDkUfbClwj/sjDTDfU
         j3rKlJRjU+YY+72ugKo3QGlAE76U49E0DtGHdvOO9IeU9VeXwg5qzIAo9jhU3g8TOswX
         tYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725227191; x=1725831991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqoR1K0s1LZWBnxVYuck4KdhPBlvgzt5rveXqQj0UWY=;
        b=Zvh/4LE+eDopT0QiPRQXtBhvyGaPFW5AEb8uLMG8yoH2Zo2I4Oy3hKF+GHVlrF0Ex3
         DdCAliR7gbhDRZtMqVtxOiAXof7Xy1w9tOIHmKE0F3It/VaT5l3hOAhaoiIefGy9Amlk
         8uI8f6GrB2SgeFmjQayommmHYhOPw80nUdAzHdZE0sFH2DmABpVeMS+TMNG9T2FwM0QD
         8IP570UXKqHKXi+vtCM2LsYDfDC9NIYa8oAgYcZHrhBcU898HI63PW9bIy/dYy7bmz1H
         8kwIR6EodybCA+psujIc0oAU9Xke2lJsT0dEt8UUIMI9l6fM0d9fh2BBmKIX/XxnyDub
         rrzg==
X-Forwarded-Encrypted: i=1; AJvYcCUTwItHnsAFdCFVbdTCNXiLqXVNMeQAT4PcVOna5bJ1ZhGrpNzggivhVrOQqz+sm1WJLjUch0wK+f5Xtms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdFodFyzVwPhOK3GBo3oR7C2BBhUy3HRwrFFTHU49O9H8tTMt
	odioKCzrYxxTRi1bDRK/x1dcfxDJ/oxnjmMsB+hHACvgyK230MB750ROg5jdUP7SY6yaR9YfZcV
	KCbtcIMc0cSE+8+mAg+dK2XLeiQIbOqfs2Z4zkkHFdn8JyMR7APvMLRII/+hjJ+Q=
X-Received: by 2002:a17:90a:9293:b0:2d8:bbf7:bb7b with SMTP id 98e67ed59e1d1-2d8bbf7bc18mr2942112a91.30.1725227190799;
        Sun, 01 Sep 2024 14:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMVGk1ZWIrg1GcUpcuZvKPNFbQMzrfBBFDeKfNRBY77z9dAbgRFAXRyGZG/Ha2mCmFixr2Yw==
X-Received: by 2002:a17:90a:9293:b0:2d8:bbf7:bb7b with SMTP id 98e67ed59e1d1-2d8bbf7bc18mr2942097a91.30.1725227190321;
        Sun, 01 Sep 2024 14:46:30 -0700 (PDT)
Received: from pc-0182.atmarktech (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b3b95cesm7632101a91.53.2024.09.01.14.46.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2024 14:46:29 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1sksOy-002Ekh-1I;
	Mon, 02 Sep 2024 06:46:28 +0900
Date: Mon, 2 Sep 2024 06:46:18 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: [RFC V3 3/3] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
Message-ID: <ZtTgqj3kBEc8sAjE@atmark-techno.com>
References: <20240830032442.226031-1-aford173@gmail.com>
 <20240830032442.226031-3-aford173@gmail.com>
 <ZtFfBs4HEShmJKsi@atmark-techno.com>
 <CAHCN7x+xy+Y6o++Y5NdZaBJUsHV9Ru_2PwuH6G-2oz1juO=+rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7x+xy+Y6o++Y5NdZaBJUsHV9Ru_2PwuH6G-2oz1juO=+rQ@mail.gmail.com>

Adam Ford wrote on Fri, Aug 30, 2024 at 10:04:41AM -0500:
> > So, as far as I'm concerned I'd be happy to move forward with that and
> > will backport this to our tree/remove our kludged values, would "just"
> > need to properly pick the closest value if no exact match instead of
> > always falling back to the table (or just remove the table altogether if
> > we can test a few monitors?)
> 
> I took that step on my local build machine to remove the integer
> divider stuff from the LUT since it can be found automatically.  I
> haven't committed them yet, but I'll likely add it to the series once
> submit it without the RFC.
> 
> I am also likely to update the rounding function to look at the delta
> between the closest LUT clock value and the closest integer clock
> value and use whichever is closest to the desired value.

Sounds good, thanks!

> > I'd change cur_cfg from pointer to the struct itself like this (partial
> > patch that probably won't even apply on your branch:)
> > ----
> > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > index 9048cdc760c2..d7124604819c 100644
> > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > @@ -402,7 +402,7 @@ struct fsl_samsung_hdmi_phy {
> >
> >         /* clk provider */
> >         struct clk_hw hw;
> > -       const struct phy_config *cur_cfg;
> > +       struct phy_config cur_cfg;
> >  };
> >
> >  static inline struct fsl_samsung_hdmi_phy *
> > @@ -562,9 +562,9 @@ static int phy_clk_set_rate(struct clk_hw *hw,
> >         if (i < 0)
> >                 return -EINVAL;
> >
> > -       phy->cur_cfg = &phy_pll_cfg[i];
> > +       phy->cur_cfg = phy_pll_cfg[i];
> >
> > -       return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> > +       return fsl_samsung_hdmi_phy_configure(phy, &phy->cur_cfg);
> >  }
> >
> >  static const struct clk_ops phy_clk_ops = {
> > ----
> >
> > Then you can just set it directly for calculated values.
> > But conceptually it's the same, just one less indirection.
> 
> I was thinking about that, but I wasn't sure the impact of
> un-const-ing would have on the LUT.
> 
> Using the extra indirection minimizes the impact of changes to the LUT
> and how its handled by the compiler.

The LUT has to stay const, you don't want something modifying it by
mistake; my suggestion makes cur_cfg a copy which does not need to be
const and the assignment (`phy->cur_cfg = phy_pll_cfg[i];`) is
equivalent to a memcpy -- the struct is small enough that the cost of
copying it if the value didn't match is negligible in my opinion.

With that said, I'm not saying you must do this, this just avoids using
a static value which could be problematic if there are multiple parallel
uses of the driver, go ahead with whatever you prefer for v4.
(note my approach doesn't fix the same problem if the driver is
used twice in parallel.. is it possible that e.g. one kernel thread
calls phy_clk_set_rate() while another thread checks something about the
hardware and calls phy_clk_round_rate()? If so neither approach is
correct and we can't easily skip recomputing, and it'd be better to just
have a phy_config struct on the stack instead -- on my imx8mp it takes
4.7us without -O, 0.6us with -O2 to compute; I *think* we can affort to
recompute every time...)

-- 
Dominique



