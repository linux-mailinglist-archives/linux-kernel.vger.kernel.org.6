Return-Path: <linux-kernel+bounces-535868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DF8A47853
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE09171B84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A12226173;
	Thu, 27 Feb 2025 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="er7EmWRK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D38225412
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646448; cv=none; b=f5kGjKyCe8KNziWOzQsMe9gwIYU+DXZsFoPJSbLqx2P+QbpzzryefpSVJNcYRHa8nh25sOahk8gYbszbenxQCeaARm1nMjdqp9tgdd3hYc3IxFRyBdHIug+WMcCE7OGkTbdP0bA1LXvLXUhMZ4CrK9woudTboLVgoMhmD/CRzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646448; c=relaxed/simple;
	bh=XAbrctXtesSLToALyuGAt+44obnQxRaAX9V/KR/oWfI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf2qtImT5oevFa3q7JBAZhMm5zdG6Wd0YRvWlR9P4MuXKzXm0+8hV64EFtSJImIPZJkDiTPuyWjnvV1Wkzl8GFFumcheiVBvhy9g8I1S6a9/+w7whTWuL8WZ79rBostwmV/35D9jSIEZKEQzcCrHxjdgR7D0MIAMXdr00hjJ7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=er7EmWRK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740646446; x=1772182446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XAbrctXtesSLToALyuGAt+44obnQxRaAX9V/KR/oWfI=;
  b=er7EmWRKSMcqcJs61n73FPqjn8vZQ+CccAk9bHyi7tEuSWYnVl23jdH0
   6IW6cC+Y+7N3ZWQdDjQ4+TZFfm64Fv2K+hKC5t59sE3hyafLJL8FPE6CF
   hkIP7RldXnpPhO1vkFCgABn32FiL7k9xxm2aBfkKrG63SUKqFpV6ElrlU
   NFHM/mA6VRVPQQUkRKTs/C+8BhEpJHo43B/xCd1yqBN+iQrofNTuDwsIj
   VY4klRsVrF9JLtiqKY8Mwb2znggnqxSFqUNhOfoXkkh0q3VjZM7+wgDw3
   7aHAygbFGcO22BFTHdKUxoVu+ZjYxdEeeQz3jr3eI5e0oo/6Oj1xnfoUt
   g==;
X-CSE-ConnectionGUID: qCYUNJyrRXGyNKYkLUQ6tQ==
X-CSE-MsgGUID: Iq7AC7y9TEiNnIH5R9rQJQ==
X-IronPort-AV: E=Sophos;i="6.13,319,1732604400"; 
   d="scan'208";a="38620683"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 01:54:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 01:53:42 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 27 Feb 2025 01:53:42 -0700
Date: Thu, 27 Feb 2025 09:51:48 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: <Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <herve.codina@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] reset: mchp: sparx5: Fix for lan966x
Message-ID: <20250227085148.ulqc2n7xvc2fa745@DEN-DL-M31836.microchip.com>
References: <20250226144645.1950451-1-horatiu.vultur@microchip.com>
 <5cc5cd05e0a481773212fff0bce574dcfea3f74d.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5cc5cd05e0a481773212fff0bce574dcfea3f74d.camel@pengutronix.de>

The 02/26/2025 17:32, Philipp Zabel wrote:

Hi,

> 
> On Mi, 2025-02-26 at 15:46 +0100, Horatiu Vultur wrote:
> > With the blamed commit it seems that lan966x doesn't seem to boot
> > anymore when the internal CPU is used.
> > The reason seems to be the usage of the devm_of_iomap, if we replace
> > this with of_iomap, this seems to fix the issue as we use the same
>             ^^^^^^^^
> The is not accurate anymore.

Good catch. I will update in the next version.

> 
> > region also for other devices.
> >
> > Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
> > Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> > Tested-by: Herve Codina <herve.codina@bootlin.com>
> 
> Is this still correct?
> 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> > v2->v3:
> > - forward error from of_address_to_resource
> > - use devm_ioremap instead of_iomap
> > v1->v2:
> > - make sure to use iounmap when driver is removed
> > ---
> >  drivers/reset/reset-microchip-sparx5.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
> > index aa5464be7053b..176b3f46e9243 100644
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
> > @@ -72,14 +73,19 @@ static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
> >                                                   struct device_node *syscon_np)
> >  {
> >       struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
> > -     resource_size_t size;
> > +     struct resource res;
> >       void __iomem *base;
> > +     int err;
> > +
> > +     err = of_address_to_resource(syscon_np, 0, &res);
> > +     if (err)
> > +             return ERR_PTR(err);
> >
> > -     base = devm_of_iomap(dev, syscon_np, 0, &size);
> > -     if (IS_ERR(base))
> > -             return ERR_CAST(base);
> 
> It would be nice to add a comment here that devm_of_iomap() can't be
> used because the resource is shared with other devices. Do you know
> which ones?

Yes, I will add a comment in the next version.
Looking at the device trees (lan966x.dtsi), it looks like it is shared
with the clock driver (clks).

> 
> Otherwise, this looks good to me.
> 
> 
> regards
> Philipp

-- 
/Horatiu

