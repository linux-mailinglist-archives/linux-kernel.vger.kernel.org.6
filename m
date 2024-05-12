Return-Path: <linux-kernel+bounces-177017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23AA8C3881
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF93B21011
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472A548EF;
	Sun, 12 May 2024 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Oagbd5b0"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C654762
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548412; cv=none; b=u2eXtVmUeTj7lFl4FbPtjQpsgrVL+VQxnB/WEJuNhXT3iNGjMQoymxIXa1Gmo3MKzlM90a+KRI3ePW3o8MK7AHBgkG0FOV9TUS/seFZo5AkCk+upyhS1vUPr/iFn/CJmaL9lSlqMc2a4FssIGy3hbKiZu9sP/eUgHwwE+VPefnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548412; c=relaxed/simple;
	bh=wDUVbv8ZpYrdpvWTtjkKG9IWXTdRp0GildcxKyLIlAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJxxQkDcEJdqCcNPxIoX02lsHqB3Swa9fQuRTBeA/zU0h96q9TearjBmk36I8jBHkEMHig/dbgT2P446FUJQH49L5hP0rBWCy8Cx2xOlwtCF5MWmHJYOPHBlwONDY+3n15KK/I5Upc5LdtdhtRoIdyE2jyCQp14XM/D6VnRKNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Oagbd5b0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3EFF78BE;
	Sun, 12 May 2024 23:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548403;
	bh=wDUVbv8ZpYrdpvWTtjkKG9IWXTdRp0GildcxKyLIlAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oagbd5b00gl5Njyd3u5ypxKJ/hgK+l/Ok/rKSJEuXzER0o/7sm5Z8y4lMlzstK3Uf
	 G6ghJcW/HtQYzoWAVPHr6bhHR0dPX+MthO1XjT6nux3Cy+PTFjw5sNiDgTkeH59vA5
	 oYefUCdaZicEYg9LGU/YAGWhQ4bFLPuxCmqYapzE=
Date: Mon, 13 May 2024 00:13:21 +0300
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
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: Remove a small useless code
 snippet
Message-ID: <20240512211321.GK17158@pendragon.ideasonboard.com>
References: <20240511134251.313513-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511134251.313513-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 09:42:50PM +0800, Sui Jingfeng wrote:
> In ptn3460_bridge_attach(), the check on the existence of bridge->encoder
> has already been done in the implementation of drm_bridge_attach(). The
> driver won't go further if bridge->encoder is NULL and the driver will quit
> even if drm_bridge_attach() fails for some reasons. Thereforei, there is

s/Thereforei/Therefore/

> no need to check another time at the later, remove the redundant checking
> codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/nxp-ptn3460.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> index ed93fd4c3265..e77aab965fcf 100644
> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> @@ -229,11 +229,6 @@ static int ptn3460_bridge_attach(struct drm_bridge *bridge,
>  	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>  		return 0;
>  
> -	if (!bridge->encoder) {
> -		DRM_ERROR("Parent encoder object not found");
> -		return -ENODEV;
> -	}
> -
>  	ptn_bridge->connector.polled = DRM_CONNECTOR_POLL_HPD;
>  	ret = drm_connector_init(bridge->dev, &ptn_bridge->connector,
>  			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);

-- 
Regards,

Laurent Pinchart

