Return-Path: <linux-kernel+bounces-533508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3833A45B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930671891315
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702362459DA;
	Wed, 26 Feb 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cxHhfoDy"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72031A5BBD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564851; cv=none; b=iy7g7IPzNC5FEQOR+tVHK2YNp6iCkGfif5wndwaEmM/2QnQ3pTRGuniOX/HhEAPhllklFKIZebO8qQTc80NuYs9mKKopn8IxBJ5gF3y2R7z6pnyDJBeAHTex5KXIR7XbATHfuNlc30bPrVztIxSnFwwqM7jQMO+4XQ1wxOnoKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564851; c=relaxed/simple;
	bh=JwPoUTazQXufTbjf/ZxqmK4bOqDDORG57uVsI9ugLIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTZgone23S/GwepUvmrg5lP2FUeY5LWChIQgRCpwCAY3v09SzEpYDOqoOFW1qHosic74UXUC887bnvn+u2wcGSn8VS62XE6+iSBJWThJh1f0GuK+tiq0jGUkdxVgjlKTH1gu5VoFJfmxbL0bAZMQ/EKjSlC2abfH9hVxtecWyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cxHhfoDy; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 665FF44369;
	Wed, 26 Feb 2025 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740564848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERVqXRTL7y1GGxMaoU0rAys8hfRqKfxsOWaRlkZ0eO4=;
	b=cxHhfoDyxHTrxLtsq7eJGyif1RSW/hB6hu5P4rV6dLWzdFXrsgd3h2ApyCcqzokFwtTsnu
	NBVm82yKoLQDQ2SPK/zhvC/v8s3Ge1y703CKUtndr7CqLc1YV3+Omtfb4sVR3gOmrh80tI
	IGX9NAbqzG1FikedaFvhuLw9HA1GUoVjIg1rf68Toly+zgyOc25zpZtFDZnJRpewYGDHoK
	6KM9cB2ovGW96HlYSnudtM1VgiJSJrnp4ybgT0aw6jm9dazktgXfQtLsbB2qdmlbLourwx
	TXJ4A7eArKRtuEgB+jFB5vUU42DIsMJoB3MsUANHEqkl4Lpx46MIk3OAbCNzbA==
Date: Wed, 26 Feb 2025 11:14:06 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <p.zabel@pengutronix.de>, <Steen.Hegelund@microchip.com>,
 <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] reset: mchp: sparx5: Fix for lan966x
Message-ID: <20250226111406.2751ebce@bootlin.com>
In-Reply-To: <20250225105329.3037853-1-horatiu.vultur@microchip.com>
References: <20250225105329.3037853-1-horatiu.vultur@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehhohhrrghtihhurdhvuhhlthhurhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehprdiirggsvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopefuthgvvghnrdfjvghgvghluhhnugesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhop
 egurghnihgvlhdrmhgrtghhohhnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepfgfpiffnihhnuhigffhrihhvvghrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: herve.codina@bootlin.com

Hi Horatiu,

On Tue, 25 Feb 2025 11:53:29 +0100
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> With the blamed commit it seems that lan966x doesn't seem to boot
> anymore when the internal CPU is used.
> The reason seems to be the usage of the devm_of_iomap, if we replace
> this with of_iomap, this seems to fix the issue as we use the same
> region also for other devices.
> 
> Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
> v1->v2:
> - make sure to use iounmap when driver is removed
> ---
>  drivers/reset/reset-microchip-sparx5.c | 40 +++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 

...

>  static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
> -						    struct device_node *syscon_np)
> +						    struct device_node *syscon_np,
> +						    struct mchp_reset_context *ctx)
>  {
>  	struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
> -	resource_size_t size;
> -	void __iomem *base;
> +	struct resource res;
>  
> -	base = devm_of_iomap(dev, syscon_np, 0, &size);
> -	if (IS_ERR(base))
> -		return ERR_CAST(base);
> +	if (of_address_to_resource(syscon_np, 0, &res))
> +		return ERR_PTR(-ENOMEM);

Why not forwarding the error returned by of_address_to_resource() ?

Other than that:

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Also, I tested the patch successfully on my LAN966x PCI device.

Tested-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

