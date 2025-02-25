Return-Path: <linux-kernel+bounces-530996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8267FA43AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A5E188C7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD3266B73;
	Tue, 25 Feb 2025 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KS+Js9EK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8890266B4F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477695; cv=none; b=mWOqFgd8ZLebd23pqPc/SW+S5ig6OaFo0lu20aLqo9OH1TGlfOf6r5UrYljdog9jfPp7pE2AVLeS60ey2zSwZEfl75NaKx3SOJElOPOUfcHOBHq8gZR6E2UK1uHVzHdRZS385LVwx2AM4AArEITB9WNsk0OupoHbRa+N8c4Ntyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477695; c=relaxed/simple;
	bh=80W3jRUeJgHuN6c6wY/5SS6Zo5/zBaxfdTgmqQWxMCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcggDhTt5G7OlvMPQKWLVSWbWSEhKu2CMukwlsOQytj9VIa/NQjCOoFNXh2TEOYUw8xRAXX0dhZByiliMrtqPsx1/44ymoh5pW+k+SYgIaHlNJqzAbg+E1kcCYY+FP7JPxUSiVKI3UpCfUVb6UUM5nA/VUdoX0WCcFtS8WbbHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KS+Js9EK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740477694; x=1772013694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=80W3jRUeJgHuN6c6wY/5SS6Zo5/zBaxfdTgmqQWxMCs=;
  b=KS+Js9EKMcqCueuR8VYeesBDoA1+7cTy6q3JGsRrQAJ0pnf1dHCZ/FZA
   RKYwAyXV1LacL97VRVTGw8LSo4o5XKDHT/g/b+GTweTgJzYQTIu7zYYus
   SxUSqmwCYgWM/L/l1Inmwfg6fiGgOL1oaz+/rZoHTw03r/oLpZe9StHgj
   EYHxq3k/6EWtA4SIOlP2GmRU0oX0zHNJqTReI4b+5WNZszDYi1vtjMZKA
   cMFH5GT6Y0qZAzEA/fjgq15W1Vlt6TaFiL+7GoVR3q1Eb9qcBD/bZVdU7
   v5hjP5EjlDTrrgE3evBKJgsbTTt4NoFYto4XXlGZuJgSjkjY8DcHJgOzQ
   g==;
X-CSE-ConnectionGUID: u5EGqvTPRrG+qo0rh3KUuA==
X-CSE-MsgGUID: Tmg3facpSDOUyzGW72MZwA==
X-IronPort-AV: E=Sophos;i="6.13,313,1732604400"; 
   d="scan'208";a="38095043"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2025 03:01:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Feb 2025 03:01:22 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 25 Feb 2025 03:01:22 -0700
Date: Tue, 25 Feb 2025 10:59:30 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: <p.zabel@pengutronix.de>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reset: mchp: sparx5: Fix for lan966x
Message-ID: <20250225095930.paeqka2z2tjuxp6g@DEN-DL-M31836.microchip.com>
References: <20250224092923.2648680-1-horatiu.vultur@microchip.com>
 <20250224140443.42ddc57c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224140443.42ddc57c@bootlin.com>

The 02/24/2025 14:04, Herve Codina wrote:
> 
> Hi Horatiu,

Hi Herve,

> 
> On Mon, 24 Feb 2025 10:29:23 +0100
> Horatiu Vultur <horatiu.vultur@microchip.com> wrote:
> 
> > With the blamed commit it seems that lan966x doesn't seem to boot
> > anymore when the internal CPU is used.
> > The reason seems to be the usage of the devm_of_iomap, if we replace
> > this with of_iomap, this seems to fix the issue as we use the same
> > region also for other devices.
> >
> > Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/reset/reset-microchip-sparx5.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
> > index aa5464be7053b..5a75f9833a91a 100644
> > --- a/drivers/reset/reset-microchip-sparx5.c
> > +++ b/drivers/reset/reset-microchip-sparx5.c
> > @@ -8,6 +8,7 @@
> >   */
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> > @@ -72,14 +73,17 @@ static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
> >                                                   struct device_node *syscon_np)
> >  {
> >       struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
> > -     resource_size_t size;
> > +     struct resource res;
> >       void __iomem *base;
> >
> > -     base = devm_of_iomap(dev, syscon_np, 0, &size);
> > -     if (IS_ERR(base))
> > -             return ERR_CAST(base);
> > +     if (of_address_to_resource(syscon_np, 0, &res))
> > +             return ERR_PTR(-ENOMEM);
> >
> > -     regmap_config.max_register = size - 4;
> > +     base = of_iomap(syscon_np, 0);
> > +     if (!base)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     regmap_config.max_register =  resource_size(&res) - 4;
> >
> >       return devm_regmap_init_mmio(dev, base, &regmap_config);
> >  }
> 
> In the Lan966x PCI device use case, the reset driver can be loaded, unloaded
> and re-loaded.
> 
> When the driver is unloaded, resources have to be released and so with a
> call to of_iomap(), a call to iounmap() is needed.
> 
> Maybe .remove() function in this driver should handle the needed iounmap()
> call.

Thanks for the comments.
I think you are right. I will update this in the next version.

> 
> Best regards,
> Hervé

-- 
/Horatiu

