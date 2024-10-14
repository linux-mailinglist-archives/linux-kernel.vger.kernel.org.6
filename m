Return-Path: <linux-kernel+bounces-363728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FD99C625
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7DD1F236C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A21581F4;
	Mon, 14 Oct 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RZnqlicO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85714156230
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899045; cv=none; b=edwYIImkJKvrsqUXKfZBQXrbbB/kplF4f4WTcUMqKLOHhpPkf2tFRxctuPhHpO38KFfKLD/UiIqXiVzvyLwQ5bUBpWqEQG22MtfPXAKYoA59Mxi9XuOYw/2OYggPbLBqJCaHYvqgh9gN2NDKp00usucNlXSX+0XHJmeWEYKNNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899045; c=relaxed/simple;
	bh=d8mmBTMzQw0eATTs8K+Ognc0TOnmxw6QIf4V8eWf3h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oHONZFPFVLAaAlgQYZsOhdiKc91XCR4rCFK1AUIND1rLGBI5x75cQGRyqojymXLy9n8FLAtSdsqUMyuTlEi/C6vyjMJuWWsSGLdOwrfLS0B/xLcb54zK28qR0ubqdxzgz288C44vSoSVADJB6MSHfzHmjcOB++vEljLYpAoDDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RZnqlicO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728899043; x=1760435043;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=d8mmBTMzQw0eATTs8K+Ognc0TOnmxw6QIf4V8eWf3h0=;
  b=RZnqlicOC385bq1hhLJOuPEyo88OKfDcpVI3n1FnAXCnXLM3A+GVeXod
   Y7xlcTteBSWc4bqIljRAEYaB3Cea3vgIPwkTPa4m6fomrm/bD3H+gPDhj
   Pnh1NWQm9hjlDuLApkoze0oKFBevd3hTa4UHCbwgeEhPYRL1QM7UijtiV
   uQZnQDwtktKnlsY5ZKm/2Ftayq1PVdM0pbgtXd0chzKZit6yJsVfSxKIY
   MKYJMlPSX+l5zlCQmZXPSuwiDIVIc0p5nTtZX2JltAOhSiXnI7B+mdND9
   dgbOxn7ZDSmGavqKDdhGU/X9aUuOyp2PPohTpLuWlrzu7IKd+JKDEOKi9
   g==;
X-CSE-ConnectionGUID: nSGur+sPSS29M1xsOrSxxQ==
X-CSE-MsgGUID: sfdqwUpWRm6ZzStgyyQ/PA==
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="32778525"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 02:44:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 14 Oct 2024 02:44:00 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 14 Oct 2024 02:43:58 -0700
Message-ID: <16e23ecd-24e3-4d6e-a336-da3c4308011d@microchip.com>
Date: Mon, 14 Oct 2024 11:44:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: atmel-hlcdc: update the LCDC_ATTRE register in plane
 atomic_disable
Content-Language: en-US, fr-FR
To: Manikandan Muralidharan <manikandan.m@microchip.com>, <sam@ravnborg.org>,
	<bbrezillon@kernel.org>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241014064644.292943-1-manikandan.m@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20241014064644.292943-1-manikandan.m@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 at 08:46, Manikandan Muralidharan wrote:
> update the LCDC_ATTRE register in drm plane atomic_disable to handle
> the configuration changes of each layer when a plane is disabled.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Mani. Best regards,
   Nicolas

> ---
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |  3 ++-
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 17 ++++++++++++++---
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index e1a0bb24b511..53d47f01db0b 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -378,7 +378,8 @@ struct atmel_lcdc_dc_ops {
>   	void (*lcdc_update_buffers)(struct atmel_hlcdc_plane *plane,
>   				    struct atmel_hlcdc_plane_state *state,
>   				    u32 sr, int i);
> -	void (*lcdc_atomic_disable)(struct atmel_hlcdc_plane *plane);
> +	void (*lcdc_atomic_disable)(struct atmel_hlcdc_plane *plane,
> +				    struct atmel_hlcdc_dc *dc);
>   	void (*lcdc_update_general_settings)(struct atmel_hlcdc_plane *plane,
>   					     struct atmel_hlcdc_plane_state *state);
>   	void (*lcdc_atomic_update)(struct atmel_hlcdc_plane *plane,
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 4a7ba0918eca..4bcaf2cd7672 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -816,7 +816,8 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>   	return 0;
>   }
>   
> -static void atmel_hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
> +static void atmel_hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane,
> +				       struct atmel_hlcdc_dc *dc)
>   {
>   	/* Disable interrupts */
>   	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IDR,
> @@ -832,7 +833,8 @@ static void atmel_hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
>   	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
>   }
>   
> -static void atmel_xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
> +static void atmel_xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane,
> +				       struct atmel_hlcdc_dc *dc)
>   {
>   	/* Disable interrupts */
>   	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_XLCDC_LAYER_IDR,
> @@ -842,6 +844,15 @@ static void atmel_xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
>   	atmel_hlcdc_layer_write_reg(&plane->layer,
>   				    ATMEL_XLCDC_LAYER_ENR, 0);
>   
> +	/*
> +	 * Updating XLCDC_xxxCFGx, XLCDC_xxxFBA and XLCDC_xxxEN,
> +	 * (where xxx indicates each layer) requires writing one to the
> +	 * Update Attribute field for each layer in LCDC_ATTRE register for SAM9X7.
> +	 */
> +	regmap_write(dc->hlcdc->regmap, ATMEL_XLCDC_ATTRE, ATMEL_XLCDC_BASE_UPDATE |
> +		     ATMEL_XLCDC_OVR1_UPDATE | ATMEL_XLCDC_OVR3_UPDATE |
> +		     ATMEL_XLCDC_HEO_UPDATE);
> +
>   	/* Clear all pending interrupts */
>   	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ISR);
>   }
> @@ -852,7 +863,7 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
>   	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>   	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
>   
> -	dc->desc->ops->lcdc_atomic_disable(plane);
> +	dc->desc->ops->lcdc_atomic_disable(plane, dc);
>   }
>   
>   static void atmel_hlcdc_atomic_update(struct atmel_hlcdc_plane *plane,


