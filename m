Return-Path: <linux-kernel+bounces-302766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A4E960301
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8900E28309F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95662154439;
	Tue, 27 Aug 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="VufqKVNZ";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="JDg4AamG"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6233999
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743602; cv=none; b=c8niVz/5viXvr2a1Z+qof102AJDv2x8/u0/ZLTBMUEV6sBRC1zunjZ6rcFQWD6EStStVs4Uq8T2jP3UpGNr1Ev5GzQN1wyps4ohLWrs/Foan8UXXYm+fL5dBDe6HpmgbvkZK88M127JKZXcSuR6G6a3oOPLrBZCrO6FZlS1UMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743602; c=relaxed/simple;
	bh=s5SVCmSXXVTlWTSGyITY2lSONRFpLbKxgXI0kEQ0mXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBRgkY8FQkl+yT63jUZ38eSKdP0i81q6dnKs5QHPU7sZ5RrJwKwb7nHA4d++uMw4Tr4RGDBZKYtsaiDTw2yMXd1UYgSynr53iB/oC3FTzhMMalhynsI44l+KTD6aPR3w1Wz5ek0aQpn8Xd3VKXmzdAF3uFMlDfJrLwL8MCKLZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=VufqKVNZ; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=JDg4AamG; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1724743599;
	bh=s5SVCmSXXVTlWTSGyITY2lSONRFpLbKxgXI0kEQ0mXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VufqKVNZpVTGUsL+xMKeQD5z7LrVCNxqkLtcFKzfQpxQUIzyYoEb4wrP+I9h9Rzd2
	 Loo9dYyNdPv5A2o3zsJx4AN9qST2+seOzFBseFgrEoh6QtSRV12vpnlKqdfB0kgV3D
	 Tmcaie+2L5X1R4PleYF8heugtnFM4h4cuOXwr1ErK6Y5nY5+rmm9Bvcpp5HuZwXQSa
	 JUGa4p8+MYzoMSGib2Ej3fAYgjk0wDCL5o3SR7kl62qz1M5IskLdKG4nDQHuK9DKze
	 H59xH7iHlDytlt4zMWLSi9PlZ1MM6Jc9TCXqYO53lgLMkXMQf3ksQjtuEFxy5rsXIz
	 /mi2qec61ryTg==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 9D05B9CC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:26:39 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=JDg4AamG;
	dkim-atps=neutral
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 72FE29A5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:26:36 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d3bbfcc5dbso5338427a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1724743595; x=1725348395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMSxmDf0MF2kmVGar68KDMZHrrKcCPfHUHgljqdD7Xs=;
        b=JDg4AamGf1VrL6yzS4+faq99wKBAiMByOqFAQLnK5Mxk5rmrfqZDVrUH81C19oh1WL
         YNhNvyT+Xhap4koXSARH85JpxQJ639kvK8ic5eLnYKWGXWkwwrzZW5jmbmwUpYOj+wff
         5F3K+ELKOiQAeGkjqPKmS3250pQ3eu0tqhTAx88dbmLJpj7GAtNZsa7AieH8QgBNC3cC
         MCwKB19zC8tFYnQ12fyrJT2pG3238fj7Auk/f0/JTRmDqgqB17ThqWyAwxqb9sbWWYx1
         nf/kipkf8cKH/lfksP35ZFYujjbkOiJhTROCohQTVc+xs/oX7bGBLuLQkWlzzc6PmZJx
         Nb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724743595; x=1725348395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMSxmDf0MF2kmVGar68KDMZHrrKcCPfHUHgljqdD7Xs=;
        b=f2THq/M5UUGfIxKH0vGqJhnKQq/Od2OIdnMKQkNpidVwDEIyJSbNU53A0FDDjPayPF
         iq/oJVVBHx9rn4V7kX+W17sCf+zueUJH8ToA58l4WHPKBZWJuGtWT9p28b+dHpMAeZLl
         +Ftur1xC5ymVgUN8XIECsuMp1pJDQ2oyIihSHvDC78SbiMraOHIiYcyStdF5rhjCqodr
         BzXWPu/tEQnAfRk+QnBNdZCIvXehxU0iIrJdvNwPFTclfVOpel9FM7wP2X2O9pblfD/f
         55iV4I0uFG74Mb2Jhrx7GGkp2Flcg4OGFQL7mCSeZ978KX9K5gkQhFj6+os3sbNxDYYZ
         e0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXa6Ez3m1RWuzh1FkJvwFgQlNz5ZgmMUBESK+t5cDsyM42xarIt/1ws3WYYZsD6z3ESXSDALxNHnZNDLJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjZrZ2JunNh0QLIkAtzE+uwzqTYom2HSvNfK8brJvKNBJTLzo
	nLTLGTMbpReEpTTkgxsmJbM7iUzWpKjbDc6yILVjZj7cP2fpsT9WTPIPOKGYCZXsdqkKEZII3vN
	FkO4u5UVghLcWsgti34e0QKrE2OtXfp4MlDJ27guoSBifEK4b6pa49tgqxV3dQNk=
X-Received: by 2002:a17:90b:1c11:b0:2cb:4c25:f941 with SMTP id 98e67ed59e1d1-2d82580e22fmr2028892a91.17.1724743595330;
        Tue, 27 Aug 2024 00:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW1/oji6zx+gfbgJZ3oB4Xn4c8WVytmZDVMFJCBO9GQDivVWFqkuYDN36JnD5SWjWnqM9TQg==
X-Received: by 2002:a17:90b:1c11:b0:2cb:4c25:f941 with SMTP id 98e67ed59e1d1-2d82580e22fmr2028858a91.17.1724743594925;
        Tue, 27 Aug 2024 00:26:34 -0700 (PDT)
Received: from pc-0182.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af145dsm11209569a91.38.2024.08.27.00.26.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 00:26:34 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1siqb2-00ArlM-2Y;
	Tue, 27 Aug 2024 16:26:32 +0900
Date: Tue, 27 Aug 2024 16:26:22 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Adam Ford <aford173@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
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
Message-ID: <Zs1_nnjtRKWUtBat@atmark-techno.com>
References: <20240203165307.7806-11-aford173@gmail.com>
 <Zm_UzO4Jmm7Aykcm@atmark-techno.com>
 <22a3f5266260dd3915269ae3eec7724f7537eb55.camel@pengutronix.de>
 <cd03ecb1-100e-4699-95ed-d837a2802dc7@kontron.de>
 <CAHCN7x+bh_ka250hOCenO3Et6re4EJ=5TG8=kpG1hs-PV0dQxQ@mail.gmail.com>
 <ZsVluV50NvuGGHFX@atmark-techno.com>
 <CAHCN7xJnjfjr7HfKF+4pwbENP+p2=vvMXWW1AQShNy87vfQ=-A@mail.gmail.com>
 <CAHCN7xKgpqfRf_2p1z5NyKiOYubbcDA7YE5ML8G56pVmcV+1xA@mail.gmail.com>
 <CAHCN7x+HgasGG_v-PdtmRszhJn5odHzfV6ddeeT10_1yCOS+DQ@mail.gmail.com>
 <2d877963-e2be-4090-a86f-aadccf8f5e69@kontron.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d877963-e2be-4090-a86f-aadccf8f5e69@kontron.de>

Frieder Schrempf wrote on Tue, Aug 27, 2024 at 09:00:34AM +0200:
> > Using my PMS calculator and Rev 2 of the Tech Ref Manual, I think I
> > can generate you a table entry for 51.2MHz.  I don't have the ability
> > to test it.  I am still working on figuring out an algorithm to
> > calculate the fractional divider, but 51.2MHz x 5 does not' appear to
> > need the fractional clock divider, so I think I can just get away with
> > the standard PMS calculations.
> 
> Thanks Adam for all the efforts. The initial request for the 51.2 MHz
> clock was from Dominique, not me. I was just jumping onto the bandwagon
> with my own use-cases.

We still have that 51.2 MHz display around, so happy to test -- might
take a little bit of time as this already has a workaround but it's
definitely something I'd like to clean up so more than happy to help.

> > I still think it's a good idea to fall back to the PMS calculator if
> > the fractional stuff isn't found.  We could then determine which clock
> > frequency is closer between the nearest table entry or the PMS
> > calculator until someone can come up with an algorithm for it.
> 
> Yes, I think that's a good idea.

Seconded; we can keep the code as fallback of the table at first and if
it works well maybe even remove the table altogether later, but just
having fallback first would be great.

-- 
Dominique



