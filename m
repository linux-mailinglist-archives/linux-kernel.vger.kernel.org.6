Return-Path: <linux-kernel+bounces-177016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6908C387F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794FD281B63
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2B5467F;
	Sun, 12 May 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="o7zlbeth"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7150A6E
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548370; cv=none; b=mVHBqdK7ahfNJK1AeQ2t8/3gAUp69AS4o+3Y/1LTVaXi5X1paBQa5LUAoOzz5NixnBLadFFlytBYjUZUGi4ZrHsv50QZ4qez4gbHUicR1I1DvDFiuypPFF5uy9jtX8vx37auZoll6jUTHGLNglY4rsa0NXX2IyFy83qNbf0kWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548370; c=relaxed/simple;
	bh=0Y6YWsXVS/Pnd6DKSQDP6mb62MOpLyFDRoFLxmIMW+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgGCZUZTaXvTNaaXyy5kqt9pg1qMCUssUa75Xh6H7DedgCwT6ml3LRMsf7yPNp7zq48aHt+nNESDG4AoVrCTlMtszxQFNTV2l4bfWmhN+y7X+Y0fkmMY4afRO6wYsXC2ES71pjD9z4FiFK3WqPyWaPocAsQOVTEtN0uegOG5B5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=o7zlbeth; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 200EB8BE;
	Sun, 12 May 2024 23:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548361;
	bh=0Y6YWsXVS/Pnd6DKSQDP6mb62MOpLyFDRoFLxmIMW+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7zlbethJzCmIh/T5QP+RvEyUBA1J1mLuWM5vdGx+4UXJlCMKHlbuB+SKrwmkQDtI
	 3u186NcufAoj1bahm1S3g05e3bgH+vqrOgewA2XvNOfu7rRh42RHkhO4RXgfhKFt/s
	 WdXUz65vxVJjLulfIsbaXWJt5EtmqQttzp2rM0ZI=
Date: Mon, 13 May 2024 00:12:38 +0300
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
Subject: Re: [PATCH] drm/bridge: tfp410: Remove a small useless code snippet
Message-ID: <20240512211238.GJ17158@pendragon.ideasonboard.com>
References: <20240511132423.311884-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511132423.311884-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 09:24:23PM +0800, Sui Jingfeng wrote:
> In the tfp410_attach(), the check on the existence of bridge->encoder has
> already been done in the implementation of drm_bridge_attach() function.
> The driver won't go further if bridge->encoder is NULL and the driver will
> quit even if drm_bridge_attach() fails for some reasons.
> 
> Therefore there is no need to check another time at the later, remove the
> redundant checking codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/ti-tfp410.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
> index c7bef5c23927..b1b1e4d5a24a 100644
> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> @@ -133,11 +133,6 @@ static int tfp410_attach(struct drm_bridge *bridge,
>  	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>  		return 0;
>  
> -	if (!bridge->encoder) {
> -		dev_err(dvi->dev, "Missing encoder\n");
> -		return -ENODEV;
> -	}
> -
>  	if (dvi->next_bridge->ops & DRM_BRIDGE_OP_DETECT)
>  		dvi->connector.polled = DRM_CONNECTOR_POLL_HPD;
>  	else

-- 
Regards,

Laurent Pinchart

