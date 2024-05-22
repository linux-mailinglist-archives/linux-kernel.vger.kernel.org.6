Return-Path: <linux-kernel+bounces-186328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4DE8CC2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631F51F21AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E9113E03E;
	Wed, 22 May 2024 14:08:35 +0000 (UTC)
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB243AAB
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386915; cv=none; b=JXUYnIYs21aYy+kqvQ7lYtMvwzIoUIsf/VtzGAkbx2bnBUf+SQzxHIrjqASdVpBqghSZ64+gmk8+AQZq6yhnw+sKijUt6aJjDOeYXknTbYuhpIkkxg36cf1/x0Ps3XAEb1wVfR/QfXuGq8enhXMMgwXKmDyXRXAKVHoVo0oXH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386915; c=relaxed/simple;
	bh=KHwsZDEiIGJ2DyJzOBSHb0eWPfnlHZGZQg0MlCtoSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmkcOB0Dmg+RDiF3/smQtguPO9DTs/0wWBE9rLQFFjrx2Fj5cS8j8tYnd21+fXmJU5+jw78mD0DV+JpWh3T8swa8SWdVOozZJjgRWFaF6xACtuz23My3vNcFp6iy4HoT6AS5fjDxYJ2ARu9QC1Rh4KVUvJiI0+v7iAnybzCyMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 57C2F4081E;
	Wed, 22 May 2024 15:51:31 +0200 (CEST)
Date: Wed, 22 May 2024 15:51:29 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, Vinod Koul <vkoul@kernel.org>, 
	Caleb Connolly <caleb@connolly.tech>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/3] drm/panel/lg-sw43408: select
 CONFIG_DRM_DISPLAY_DP_HELPER
Message-ID: <lpguauybi5xs5hy7vglqvaloy4yykgejdhreeqp6fioeuelav6@pj2ap6eat3cy>
References: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
 <20240522-panel-sw43408-fix-v3-2-6902285adcc0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-panel-sw43408-fix-v3-2-6902285adcc0@linaro.org>

On 2024-05-22 09:25:54, Dmitry Baryshkov wrote:
> This panel driver uses DSC PPS functions and as such depends on the
> DRM_DISPLAY_DP_HELPER. Select this symbol to make required functions

Here and in the title: maybe this is a remnant from v2, but you split out a
DRM_DISPLAY_DSC_HELPER and shouldn't be enabling DP for a DSI panel now.

- Marijn

> available to the driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404200800.kYsRYyli-lkp@intel.com/
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 4a2f621433ef..3e3f63479544 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -340,6 +340,8 @@ config DRM_PANEL_LG_SW43408
>  	depends on OF
>  	depends on DRM_MIPI_DSI
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
> +	select DRM_DISPLAY_HELPER
>  	help
>  	  Say Y here if you want to enable support for LG sw43408 panel.
>  	  The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per
> 
> -- 
> 2.39.2
> 

