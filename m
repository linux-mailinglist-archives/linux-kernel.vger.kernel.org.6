Return-Path: <linux-kernel+bounces-533185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDCCA45695
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6353A8595
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196F26A1D7;
	Wed, 26 Feb 2025 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UbDAUJSP"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DDA1E502
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554721; cv=none; b=mG2haSH+KpljC2EwuQacH9m+RqJ0ZwCezrjwq8e2aTgavBw3q7EUxGr+IqmysU/H2eF9QQ2QZCjUC3M2yMq8H7L0PueVEFmjjAN4wrsM0L0w9VYly8cpV1zlOTb9OquEWr9T3hMOOLnuHO58yhQR2hlDUXWdoa4j4ih2y1z+tXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554721; c=relaxed/simple;
	bh=7WlhRxpuxiPuCCVMzqM4FrkJ+cNEEmiMKqCLlweoQY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRqba6IecswmPtAmVe5cyMld5s0BSyVY53R7EOe3iuJ8bpmTDPpGKAnyn5tK00mGgGLHbE32W8gTLeLHidXQAB1Kda3YMegVVEzUqUZbWSDHFBQWPSg3JlZ8l+vQ2RGYmHs/V4HRBlaIC6UNiFgFhUuBdGOjCRUwY3sv829LWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UbDAUJSP; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CBF2441C4;
	Wed, 26 Feb 2025 07:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740554714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8mj65+pl/QUAcncSVFmPbyy7s7I9gO0TgTOYjN9bpw=;
	b=UbDAUJSPj8Mt3qUiUv/IJ7qqiGZv2Arxe0YEnLQBZmNMHDm1bADYE+rtiKrN0b4OAM1+eD
	9C6Tthn0OGceshavOjzra15AxKa6TfAEQvyE1i281ueOLcURbbufFKCQpaI939ti9zX3Q3
	ugbzRjIUNC+gq1AKmFsrc9wipFEkQp3UTMMpvdPKYJJNpDpWAuX5DNncszaw9oe+PrcFkY
	A0RofZCq1FOgtnknke3cUor+nJxeJ6w6929uOlCFap9jLN/Zc0Q0HwS2V11yTEQI706icU
	PUAyXK1McWM/lDbeV1WX0IzjVt74PdfgPsDPGri00bp2vSFKnISMLUqxC5z7Xw==
Date: Wed, 26 Feb 2025 08:25:12 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/bridge: ti-sn65dsi83: Support negative DE
 polarity
Message-ID: <20250226082512.6a06e9f7@bootlin.com>
In-Reply-To: <20250225135114.801884-1-alexander.stein@ew.tq-group.com>
References: <20250225135114.801884-1-alexander.stein@ew.tq-group.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekfeelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheprghlvgigrghnuggvrhdrshhtvghinhesvgifrdhtqhdqghhrohhuphdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtt
 hhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: herve.codina@bootlin.com

Hi Alexander,

On Tue, 25 Feb 2025 14:51:13 +0100
Alexander Stein <alexander.stein@ew.tq-group.com> wrote:

> Polarity for DE is stored in bridge state. Use this flag for setting
> the DE polarity in the bridge.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 54ad462d17ef7..95563aa1b450d 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -561,6 +561,8 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>  	       REG_LVDS_FMT_HS_NEG_POLARITY : 0) |
>  	      (mode->flags & DRM_MODE_FLAG_NVSYNC ?
>  	       REG_LVDS_FMT_VS_NEG_POLARITY : 0);
> +	val |= bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_DE_LOW ?
> +	       REG_LVDS_FMT_DE_NEG_POLARITY : 0;
>  
>  	/* Set up bits-per-pixel, 18bpp or 24bpp. */
>  	if (lvds_format_24bpp) {

Tested without regression on my system.

Tested-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé


