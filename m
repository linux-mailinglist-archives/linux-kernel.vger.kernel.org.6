Return-Path: <linux-kernel+bounces-196873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577548D62D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3665B2806D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7D76026;
	Fri, 31 May 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRL+4Y7r"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156F158D62
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161611; cv=none; b=lmzGCeCGFg0OqWAS2fFr2BBnNGbexPw8NNuBEcidY4yKuEd+NllwEp6UzuXsH7vLzvY/AQgPn/Nf+5NiGZvEzsPDYF/6tqvrldVWRNNWFPkCkbABpvIHYYiZded5mNpm7OBKLGXjHnlSg80yCU5cQJPxCGVNdee29DzcoFjXs+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161611; c=relaxed/simple;
	bh=+23NoZdbP3sDWrl/C4DDAWtc0doCEz8lA1bAx4ziuI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1Hu8BagSMF8Ouc4kojt4wFJ0b1nom4VXF70llp1GtILzdZFWnHiasyP1yrM79HXqdK9iwyEYHxMgKht/c5OveR2HRqJHf4C2vBMfZyUMnd65mhGQP8sAEn+pxpXwLQAL14xS6p7+L4pteRnB/bbnyk2vHu2PoUQNpUXBau20nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MRL+4Y7r; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: j-choudhary@ti.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717161607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kW7p+495kaagcNi9JTec3IGLF/Kn4TrnUM2RlI0AJJw=;
	b=MRL+4Y7rXpq2+L//0TuE1nQaHxgRnVB1gOvWXiVZLdwlPT3yYinVNnndOllqygfGa/WBSf
	xKxpv2I3JJ987ULBZNWp5r3sO8x3TBfLIv2lKb0vnRWMYuINVTwIrYnngl0Wzu+cBzobfO
	edbO6ZDp3MwJqBBSu66ufFRJQg1s+BY=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: dmitry.baryshkov@linaro.org
X-Envelope-To: andrzej.hajda@intel.com
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: rfoss@kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: sam@ravnborg.org
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: a-bhatia1@ti.com
X-Envelope-To: dri-devel@lists.freedesktop.org
Message-ID: <e5ce13e6-1007-41c9-bedc-2045d6f75480@linux.dev>
Date: Fri, 31 May 2024 21:20:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v4,1/2] drm/bridge: sii902x: Fix mode_valid hook
To: Jayesh Choudhary <j-choudhary@ti.com>, linux-kernel@vger.kernel.org,
 dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, mripard@kernel.org, sam@ravnborg.org
Cc: jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, a-bhatia1@ti.com, dri-devel@lists.freedesktop.org
References: <20240530092930.434026-2-j-choudhary@ti.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240530092930.434026-2-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/30/24 17:29, Jayesh Choudhary wrote:
> Currently, mode_valid hook returns all mode as valid and it is
> defined only in drm_connector_helper_funcs. With the introduction of
> 'DRM_BRIDGE_ATTACH_NO_CONNECTOR', connector is not initialized in
> bridge_attach call for cases when the encoder has this flag enabled.
> So move the mode_valid hook to drm_bridge_funcs with proper clock
> checks for maximum and minimum pixel clock supported by the bridge.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>


Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>


> ---
>   drivers/gpu/drm/bridge/sii902x.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 2fbeda9025bf..6a6055a4ccf9 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -163,6 +163,14 @@
>   
>   #define SII902X_AUDIO_PORT_INDEX		3
>   
> +/*
> + * The maximum resolution supported by the HDMI bridge is 1080p@60Hz
> + * and 1920x1200 requiring a pixel clock of 165MHz and the minimum
> + * resolution supported is 480p@60Hz requiring a pixel clock of 25MHz
> + */
> +#define SII902X_MIN_PIXEL_CLOCK_KHZ		25000
> +#define SII902X_MAX_PIXEL_CLOCK_KHZ		165000
> +

This bridge can drive 2560x1080@75Hz monitor(LG 34BL650), the pixel
clock can up to 181250 kHz. I remember that I have tested the native
mode with LS2K1000 SoC, and it do works in practice. And there are
also has 320x240 panels, maybe it's also usuable with this HDMI
transmitter

Well, the datasheet mentioned that it supports up to 165 MHz
dual-edge and single-edge modes. So I'm not against your patch,
just mention it to let you know.


>   struct sii902x {
>   	struct i2c_client *i2c;
>   	struct regmap *regmap;
> @@ -310,17 +318,8 @@ static int sii902x_get_modes(struct drm_connector *connector)
>   	return num;
>   }
>   
> -static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
> -					       struct drm_display_mode *mode)
> -{
> -	/* TODO: check mode */
> -
> -	return MODE_OK;
> -}
> -
>   static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
>   	.get_modes = sii902x_get_modes,
> -	.mode_valid = sii902x_mode_valid,
>   };
>   
>   static void sii902x_bridge_disable(struct drm_bridge *bridge)
> @@ -504,6 +503,20 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
>   	return 0;
>   }
>   
> +static enum drm_mode_status
> +sii902x_bridge_mode_valid(struct drm_bridge *bridge,
> +			  const struct drm_display_info *info,
> +			  const struct drm_display_mode *mode)
> +{
> +	if (mode->clock < SII902X_MIN_PIXEL_CLOCK_KHZ)
> +		return MODE_CLOCK_LOW;
> +
> +	if (mode->clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
> +		return MODE_CLOCK_HIGH;
> +
> +	return MODE_OK;
> +}
> +
>   static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>   	.attach = sii902x_bridge_attach,
>   	.mode_set = sii902x_bridge_mode_set,
> @@ -516,6 +529,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>   	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
>   	.atomic_check = sii902x_bridge_atomic_check,
> +	.mode_valid = sii902x_bridge_mode_valid,
>   };
>   
>   static int sii902x_mute(struct sii902x *sii902x, bool mute)

-- 
Best regards
Sui

