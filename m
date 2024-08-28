Return-Path: <linux-kernel+bounces-304582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A95962219
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB871C20E48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777F15C123;
	Wed, 28 Aug 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="hmA4HqvY"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590415B971
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832895; cv=none; b=hsuLBSfMphE07+iBpvEoYgzcQtF3B/S3Rbg2LqEzgovSVWEbZRMhJs4XAnKSMUwb7ufUumjB3QMcidLxszFD/qMqGYNiC0nc9wg0AxBhHNSMqUtU9IS0U1G6pVpESc/bwwe+N+ptclcpQRErRmXeUI7A2WlkfkBF5KHRUalHuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832895; c=relaxed/simple;
	bh=KPfRCZeCuQF+7q3omkeEXVCU1HukjXEtZLYDBD3nNUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4lB3FqUkoitxPdHE1f2kE4z+FBNm53LDsrZnuQ5XeVIUh0Tpk4i6NAxfl9Raeqw+evY1l4DV2h/9joFIHRHWtvIlqkdZ5TgyL7bbOFTshpUNkiK6ISkR91xkWSPWSjoGESPHmG1paSAq1PANXDbQiNW3GTkhcKmR9LaWECMrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=hmA4HqvY; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 297F1148349A;
	Wed, 28 Aug 2024 10:14:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724832891; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ae8VdjX8mFVpb9WPRFks2pGa/7r509LGvwKGNfqo+B0=;
	b=hmA4HqvY9T09iAg1FrAd7k2vsYfmYPthRH1VE4iYKlbvbyNFI/C/U3vXqcuCP2RuB9mcNX
	81C7v5xIyHrIdea59w2Bfa6w3DGGLDTKMar/lszE15UGQTV9ojPpnwmCMVXAnhg4qzHFFa
	OGmdJAB6YQqIbP8uSqoqs3bVpLUcPhsQNkoIMnBeQw+5Nh1ww4s9/4wbyx/9HBbofaTGha
	+8luElagJSxLRfWY1/+qQxBlAN+23otUHc6xiv3X9usLY/PYAivP6k7nGYK0O9ZKMpdgKM
	Qn614qz+oHjgFneD8kPWFP1xAyuB73E0L2s3u+GrnqOMIJpSOKuMxS3vngQVBQ==
Date: Wed, 28 Aug 2024 10:14:48 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Alexander Dahl <ada@thorsis.com>,
	Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	"moderated list:MICROCHIP OTPC DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v1 07/12] nvmem: microchip-otpc: Add missing register
 definitions
Message-ID: <20240828-making-gangrene-786ec368b106@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	"moderated list:MICROCHIP OTPC DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-8-ada@thorsis.com>
 <5228af83-b423-4f51-820a-edfc40017ca8@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5228af83-b423-4f51-820a-edfc40017ca8@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Sat, Aug 24, 2024 at 06:54:02PM +0300 schrieb claudiu beznea:
> 
> 
> On 21.08.2024 13:59, Alexander Dahl wrote:
> > According to datasheets DS60001765B for SAMA7G5 and DS60001579G for
> > SAM9X60.
> > 
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> >  drivers/nvmem/microchip-otpc.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> > index b8ed7412dbca..4630e96243ac 100644
> > --- a/drivers/nvmem/microchip-otpc.c
> > +++ b/drivers/nvmem/microchip-otpc.c
> > @@ -21,9 +21,24 @@
> >  #define MCHP_OTPC_AR			(0x8)
> >  #define MCHP_OTPC_SR			(0xc)
> >  #define MCHP_OTPC_SR_READ		BIT(6)
> > +#define MCHP_OTPC_IER			(0x10)
> > +#define MCHP_OTPC_IDR			(0x14)
> > +#define MCHP_OTPC_IMR			(0x18)
> > +#define MCHP_OTPC_ISR			(0x1C)
> > +#define MCHP_OTPC_ISR_COERR		BIT(13)
> >  #define MCHP_OTPC_HR			(0x20)
> >  #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
> >  #define MCHP_OTPC_DR			(0x24)
> > +#define MCHP_OTPC_BAR			(0x30)
> > +#define MCHP_OTPC_CAR			(0x34)
> > +#define MCHP_OTPC_UHC0R			(0x50)
> > +#define MCHP_OTPC_UHC1R			(0x54)
> > +#define MCHP_OTPC_UID0R			(0x60)
> > +#define MCHP_OTPC_UID1R			(0x64)
> > +#define MCHP_OTPC_UID2R			(0x68)
> > +#define MCHP_OTPC_UID3R			(0x6C)
> > +#define MCHP_OTPC_WPMR			(0xE4)
> > +#define MCHP_OTPC_WPSR			(0xE8)
> 
> Are all these used in driver?

Not all, but some.  What are you implying?  Only add register
definitions actually used in the driver?  Why?

Those register offsets won't change, but helped us when debugging.
Debug code (e.g. register dump) is not part of the patch series.

Greets
Alex

> 
> >  
> >  #define MCHP_OTPC_NAME			"mchp-otpc"
> >  #define MCHP_OTPC_SIZE			(11 * 1024)

