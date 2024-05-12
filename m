Return-Path: <linux-kernel+bounces-177015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628538C387D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AC81C20C5D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C713C53E22;
	Sun, 12 May 2024 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TRAw1oL2"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484E381DA
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548160; cv=none; b=W7JU9pr/nHBxtyPH9YVyMtfpKaPiZo9oiyJ0dBwGYzpklAzDGOIRIxWXA9Y38R1lAA6KFMNm8O6ffZXYqgcvjvyTBPx04J4H4d/cZp5dEBOA4r7y8bqKmnIuWSFBhoOkTV2IhtLZ879mGrzfmJ12+wjtROYxyEPujG3SqmWZFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548160; c=relaxed/simple;
	bh=fCWAahIT/hAJe3k/y0iiyAVf9CH7viLpCUTVy233AxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAA5M27fzAwtoHE4qszDUoY/WG694ffpctX1fQp7TxUgVZ0T5IPNChaoml3pmALx5x/kg0tVrdzqnwMDTyF5dosXsNic2qHiBrPsKy2IuDvPOu0Fz98OL+dl5hLwdLW2PA4q5wKWvUFtr/wzpn4jOA9J/W7BLF2owx8InckYBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TRAw1oL2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58CE38BE;
	Sun, 12 May 2024 23:09:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548150;
	bh=fCWAahIT/hAJe3k/y0iiyAVf9CH7viLpCUTVy233AxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRAw1oL2FDVmkRCJkBG0UC1UZ0E7Ofluwevib+Yj9OVIqA8WrBz6hXvauu8LJMfhd
	 5nQ3hZGgq+/hBLIBJ278QThc1H+LYWnJcBs9ALdcDM5MemCAb9wei1mM2Z8TigIatO
	 lpT1WBSToTWeCc4nXJvbZeuhkmKG1K3ocNakGYk0=
Date: Mon, 13 May 2024 00:09:07 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Remove a small useless code snippet
Message-ID: <20240512210907.GI17158@pendragon.ideasonboard.com>
References: <20240511124238.297192-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511124238.297192-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 08:42:38PM +0800, Sui Jingfeng wrote:
> Because the check on the non-existence (encoder == NULL) has already been
> done in the implementation of drm_bridge_attach() function, and
> drm_bridge_attach() is called earlier. The driver won't get to check point
> even if drm_bridge_attach() fails for some reasons, as it will clear the
> bridge->encoder to NULL and return a negective error code.

s/negective/negative/

> 
> Therefore, there is no need to check another again. Remove the redundant
> codes at the later.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If you end up sending a second version of this patch, please include all
similar patches you have sent at the same time in a patch series,
instead of sending them separately.

> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 28376d0ecd09..3caa918ac2e0 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -116,11 +116,6 @@ static int simple_bridge_attach(struct drm_bridge *bridge,
>  	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>  		return 0;
>  
> -	if (!bridge->encoder) {
> -		DRM_ERROR("Missing encoder\n");
> -		return -ENODEV;
> -	}
> -
>  	drm_connector_helper_add(&sbridge->connector,
>  				 &simple_bridge_con_helper_funcs);
>  	ret = drm_connector_init_with_ddc(bridge->dev, &sbridge->connector,

-- 
Regards,

Laurent Pinchart

