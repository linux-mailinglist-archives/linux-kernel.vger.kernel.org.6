Return-Path: <linux-kernel+bounces-407579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A99C6FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3B4B27F58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16E81F77B4;
	Wed, 13 Nov 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2SQyVf+h"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB34C6C;
	Wed, 13 Nov 2024 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501588; cv=none; b=tb0Ya6cV+ZAJ7sxS7gkfbDuoVNs47J1tR4zLOHfU5pg1cuP74dWDvYbRrMtJHW15ZQPEG1+Rk3lrkYoWZApm5ilxy2oJVX9fj8pQ2dHXQx9C3CqI/FSPyfuVJboWUp3k9h0A/18JpnhVUM4VFDtQtHsAyjPurW0PN8lOIc0ojhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501588; c=relaxed/simple;
	bh=gKqFLRNsIwmH44eV0meSeljeLbEd+mAGQe2+yyq65/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4kwvWP3yi5BgCldnwPqP7O/eYdKw/0OFNdRFkHpWnQQCT9NjTFNriiAqdBH3WIBs9CQUXjpcDT3IPxCUA64o/R4GNIU/+Ao05e6CJ/aRCYvw/FvgRvOZZYo1Y3ua/M6MN5Ry95e7hn/svQME0BQzUj29HIvrRQ3vFjTKFQhOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2SQyVf+h; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KmeKU28bQtzm8XNGcvF30DDJ+SoCDTx1YSZjcXEcLKI=; b=2SQyVf+hPTARrHZbuwXr/dxWZx
	0CnmRSDkpJ36NC9AriqR4Sw7jSgBsKxRehtKc7D6tTG9eW6NuhlCfkVO8QSRGg2BBgCI5puI6plCW
	iP5vv2vMXErkCefUx2KyVCSqU21B2pU0fheOT5n2UJdjzsNGf7mKHS2mgwu//nd7qnaQZzqpVo/fk
	zmclxzYC56fex2+pLaC1uPQOeYWOrLVdlsyRAot+2h1yD5tvfrIVxpj/XEV79UT1JRTYrDQJSBe9a
	+JCxMChIJBYz1efnoTr8MN1EfXh2pKJQIj5pcUx53Lz6PNYBEaoRBWJRST8R+MG+F0m7pnbFUUxyc
	9HcAMXpg==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tBCeh-00033b-66; Wed, 13 Nov 2024 13:39:31 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quentin.schulz@cherry.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH v2 2/2] phy: rockchip: Add Samsung CSI/DSI Combo DCPHY driver
Date: Wed, 13 Nov 2024 13:39:30 +0100
Message-ID: <2564703.Sgy9Pd6rRy@diego>
In-Reply-To: <fynyo2amqillioxwfyydvztakba5ecwa2qrtdtuoaffyvwc62c@3vizyubfqvsf>
References:
 <20241104111121.99274-1-heiko@sntech.de>
 <20241104111121.99274-3-heiko@sntech.de>
 <fynyo2amqillioxwfyydvztakba5ecwa2qrtdtuoaffyvwc62c@3vizyubfqvsf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

> > +static void samsung_mipi_dcphy_bias_block_enable(struct samsung_mipi_dcphy *samsung)
> > +{
> > +	u32 bias_con2 = 0x3223;
> > +
> > +	regmap_write(samsung->regmap, BIAS_CON0, 0x0010);
> > +	regmap_write(samsung->regmap, BIAS_CON1, 0x0110);
> > +	regmap_write(samsung->regmap, BIAS_CON2, bias_con2);
> > +
> > +	/* default output voltage select:
> > +	 * dphy: 400mv
> > +	 * cphy: 530mv
> > +	 */
> > +	regmap_update_bits(samsung->regmap, BIAS_CON4,
> > +			   I_MUX_SEL_MASK, I_MUX_SEL_400MV);
> > +}
> > +
> > +static void samsung_mipi_dcphy_bias_block_disable(struct samsung_mipi_dcphy *samsung)
> > +{
> > +}
> 
> uhm? :)

When there was still the CSI stuff in here, that function still had
content ;-) .

But yeah, if and when that comes back, we can re-add things.


> > +static int samsung_mipi_dcphy_set_mode(struct phy *phy, enum phy_mode mode,
> > +				       int submode)
> > +{
> > +	return 0;
> > +}
> 
> You can just remove this. phy_set_mode_ext() will return 0 byself if
> the callback is NULL.

But it will not set the mode then.

See the part of
	ret = phy->ops->set_mode(phy, mode, submode);
	if (!ret)
		phy->attrs.mode = mode;

Without the set_mode callback phy->attrs.mode will not be set.
And while we don't have anything to do for set_mode itself,
we do need the mipi_dphy mode to be set.


Heiko



