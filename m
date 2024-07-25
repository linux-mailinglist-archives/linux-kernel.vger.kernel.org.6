Return-Path: <linux-kernel+bounces-261996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E048293BF24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CFAB210A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D3197A87;
	Thu, 25 Jul 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OEqmsNzu"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E9196DA4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900042; cv=none; b=WsdUnS5CevkJReFHw0sy3k12gtnhb+X8Jc/DDQzyz6pHCkvIlSjGZxdcKMHdcdxVC7R3iJ+G56pCDEzvXGq1RRXJRbqSCCyPZIwVCjRLXe9jRCHcjbE+zW2tFFLho/i+ANVKK19PUslh6jMsIHBD6KesjWeVKZntX3w/eAgrEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900042; c=relaxed/simple;
	bh=GFq5xiMElGG8EsnSRRsj0rTx2aMgsasbt3MZQHLQUHY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KPLcaI9uS8HmbIFKBk6qA61Td7jvnbzaAUAiRM/mvbOMLjnscMrpTau1MkCQ8nboqj1QVnHQsKgI0zqfYhSRMNc6ULanj85N3m8+dcjkST04LZIl+N1K14KWziigyOApYWKtlyP+IJrwq2eoEi+3wfD7D1r7+3WjlSMcoKupytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OEqmsNzu; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721900036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftboGbAMunxAO4+cPMRch4E/ukDKcT8aii0ePtJNgZM=;
	b=OEqmsNzuwGqFduFXmrMacdbTUo+E6LIynswzDXCif4+33hqVHg3eB7zB7PznRuRWSOAlOL
	gn6ojfZuue2msva48byR7iF+GgPh3Og7go0k1YUZvShhZlmK0mT44kCD5Up61AK0D/ph7D
	FBO5zCg7O4M7SzaL5Uvb7FBKOHsCJ0XLhY/oYofBFhG49YXQPKA4qEXqpJ6zbLlzt7ssc8
	EvA13CE1/qyKoOC9j/rUribYJxM9Of9qC2b/XNnDDdXIdIKFri3mQ0ZnAnaKcMo/zW+SnP
	imsl4EkSdJnUhj19AWo5iwqMf2cEe4IdolUFKZwYIYuTC9JcWi9P7PXmgQrE/Q==
Date: Thu, 25 Jul 2024 11:33:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Clean up a few logged messages
In-Reply-To: <92db74a313547c087cc71059428698c4ec37a9ae.1720048818.git.dsimic@manjaro.org>
References: <92db74a313547c087cc71059428698c4ec37a9ae.1720048818.git.dsimic@manjaro.org>
Message-ID: <62c163be6ba3eeb9af82672d41e93b78@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

Just checking, is this patch good enough to be accepted?  If not, is 
there
some other preferred way for cleaning up the produced messages?

On 2024-07-04 01:32, Dragan Simic wrote:
> Clean up a few logged messages, which were previously worded as rather
> incomplete sentences separated by periods.  This was both a bit 
> unreadable
> and grammatically incorrect, so convert them into partial sentences 
> separated
> (or connected) by semicolons, together with some wording improvements.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index bd7aa891b839..ee9def197095 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -969,46 +969,44 @@ static void cdn_dp_pd_event_work(struct 
> work_struct *work)
> 
>  	/* Not connected, notify userspace to disable the block */
>  	if (!cdn_dp_connected_port(dp)) {
> -		DRM_DEV_INFO(dp->dev, "Not connected. Disabling cdn\n");
> +		DRM_DEV_INFO(dp->dev, "Not connected; disabling cdn\n");
>  		dp->connected = false;
> 
>  	/* Connected but not enabled, enable the block */
>  	} else if (!dp->active) {
> -		DRM_DEV_INFO(dp->dev, "Connected, not enabled. Enabling cdn\n");
> +		DRM_DEV_INFO(dp->dev, "Connected, not enabled; enabling cdn\n");
>  		ret = cdn_dp_enable(dp);
>  		if (ret) {
> -			DRM_DEV_ERROR(dp->dev, "Enable dp failed %d\n", ret);
> +			DRM_DEV_ERROR(dp->dev, "Enabling dp failed: %d\n", ret);
>  			dp->connected = false;
>  		}
> 
>  	/* Enabled and connected to a dongle without a sink, notify userspace 
> */
>  	} else if (!cdn_dp_check_sink_connection(dp)) {
> -		DRM_DEV_INFO(dp->dev, "Connected without sink. Assert hpd\n");
> +		DRM_DEV_INFO(dp->dev, "Connected without sink; assert hpd\n");
>  		dp->connected = false;
> 
>  	/* Enabled and connected with a sink, re-train if requested */
>  	} else if (!cdn_dp_check_link_status(dp)) {
>  		unsigned int rate = dp->max_rate;
>  		unsigned int lanes = dp->max_lanes;
>  		struct drm_display_mode *mode = &dp->mode;
> 
> -		DRM_DEV_INFO(dp->dev, "Connected with sink. Re-train link\n");
> +		DRM_DEV_INFO(dp->dev, "Connected with sink; re-train link\n");
>  		ret = cdn_dp_train_link(dp);
>  		if (ret) {
>  			dp->connected = false;
> -			DRM_DEV_ERROR(dp->dev, "Train link failed %d\n", ret);
> +			DRM_DEV_ERROR(dp->dev, "Training link failed: %d\n", ret);
>  			goto out;
>  		}
> 
>  		/* If training result is changed, update the video config */
>  		if (mode->clock &&
>  		    (rate != dp->max_rate || lanes != dp->max_lanes)) {
>  			ret = cdn_dp_config_video(dp);
>  			if (ret) {
>  				dp->connected = false;
> -				DRM_DEV_ERROR(dp->dev,
> -					      "Failed to config video %d\n",
> -					      ret);
> +				DRM_DEV_ERROR(dp->dev, "Failed to configure video: %d\n", ret);
>  			}
>  		}
>  	}

