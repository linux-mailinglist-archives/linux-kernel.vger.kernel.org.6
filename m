Return-Path: <linux-kernel+bounces-272882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893BB946241
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB81B1C2132F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEFE1537AE;
	Fri,  2 Aug 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KuCuIm7E"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B416BE06
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722618501; cv=none; b=Ns7xcjlWd8JNqlFaKb71bOYBYvmPIFw0mX4pq2fhFzhSyaqBct0Kg5r0Ef6rQYCwuxzAKvGnBklk5J6Q/mYJnC98fDR56r8wNA0Fp4K2WHa7REQcBm4tPX0A7nwMZ1bAUlsM+voNmLmPU0FFfsyZEvySNGamz4VU1KnS34c033U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722618501; c=relaxed/simple;
	bh=xagRC+4ijWNGhIzFIvxVvo5zwUqvGhZsUPg9xjpLj48=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ucHELo5qL8URT+Ol38Ez2uf/LSKByaaYW8Z+9EmQZ5TOXTQ1PyWB2HUq/yJyprYCCKBhbZlfcYgai4sJoxBHwO1VJE6AIP4lXYeQA1E+4mMqqSt86XUt5FBI37E5UcVMKE1kw1EZuKIz0reOT7DeiKZR7bwG0rGZcYmAvaD4gVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KuCuIm7E; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722618490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDf+A9txkVqV1W2Ctpc6t6vDZn8LLAQXpSRjiyJzMOU=;
	b=KuCuIm7EjTaDAWS+pem9FA5VGekuTecxRgvzgPRfLBUP9PekSaU0a03rI1qpbWZMGQbvJL
	qv6GlRUcB64STvmMlbm24I2DOKR8MdmiEmegNdShlEo5VBMBP8NqYsVcygy2lKPZiqWk/F
	zFS7H31XC4cVdQwPyuUsL4VN1WzstzwqHTu3piXCO8r/a0k9cy4rPKH3GMRcuWrQP7gAUC
	GppNzsrsuRNrL1eOCUf0MtNVCq/mDNtCju4relzGX7oDWpXAEg/BVaZgam3g/dZmzTO6OC
	vXSxUVI8DVd9sj/TPEJnnGC/j0dV+65AsFAiaQt0qnmYJU//jgOf8B9AzAzLYQ==
Date: Fri, 02 Aug 2024 19:08:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Clean up a few logged messages
In-Reply-To: <62c163be6ba3eeb9af82672d41e93b78@manjaro.org>
References: <92db74a313547c087cc71059428698c4ec37a9ae.1720048818.git.dsimic@manjaro.org>
 <62c163be6ba3eeb9af82672d41e93b78@manjaro.org>
Message-ID: <ee2476ba76d91682ba53248df4789e90@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-25 11:33, Dragan Simic wrote:
> Hello all,
> 
> Just checking, is this patch good enough to be accepted?  If not, is 
> there
> some other preferred way for cleaning up the produced messages?

Just a brief reminder...

> On 2024-07-04 01:32, Dragan Simic wrote:
>> Clean up a few logged messages, which were previously worded as rather
>> incomplete sentences separated by periods.  This was both a bit 
>> unreadable
>> and grammatically incorrect, so convert them into partial sentences 
>> separated
>> (or connected) by semicolons, together with some wording improvements.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> index bd7aa891b839..ee9def197095 100644
>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> @@ -969,46 +969,44 @@ static void cdn_dp_pd_event_work(struct 
>> work_struct *work)
>> 
>>  	/* Not connected, notify userspace to disable the block */
>>  	if (!cdn_dp_connected_port(dp)) {
>> -		DRM_DEV_INFO(dp->dev, "Not connected. Disabling cdn\n");
>> +		DRM_DEV_INFO(dp->dev, "Not connected; disabling cdn\n");
>>  		dp->connected = false;
>> 
>>  	/* Connected but not enabled, enable the block */
>>  	} else if (!dp->active) {
>> -		DRM_DEV_INFO(dp->dev, "Connected, not enabled. Enabling cdn\n");
>> +		DRM_DEV_INFO(dp->dev, "Connected, not enabled; enabling cdn\n");
>>  		ret = cdn_dp_enable(dp);
>>  		if (ret) {
>> -			DRM_DEV_ERROR(dp->dev, "Enable dp failed %d\n", ret);
>> +			DRM_DEV_ERROR(dp->dev, "Enabling dp failed: %d\n", ret);
>>  			dp->connected = false;
>>  		}
>> 
>>  	/* Enabled and connected to a dongle without a sink, notify 
>> userspace */
>>  	} else if (!cdn_dp_check_sink_connection(dp)) {
>> -		DRM_DEV_INFO(dp->dev, "Connected without sink. Assert hpd\n");
>> +		DRM_DEV_INFO(dp->dev, "Connected without sink; assert hpd\n");
>>  		dp->connected = false;
>> 
>>  	/* Enabled and connected with a sink, re-train if requested */
>>  	} else if (!cdn_dp_check_link_status(dp)) {
>>  		unsigned int rate = dp->max_rate;
>>  		unsigned int lanes = dp->max_lanes;
>>  		struct drm_display_mode *mode = &dp->mode;
>> 
>> -		DRM_DEV_INFO(dp->dev, "Connected with sink. Re-train link\n");
>> +		DRM_DEV_INFO(dp->dev, "Connected with sink; re-train link\n");
>>  		ret = cdn_dp_train_link(dp);
>>  		if (ret) {
>>  			dp->connected = false;
>> -			DRM_DEV_ERROR(dp->dev, "Train link failed %d\n", ret);
>> +			DRM_DEV_ERROR(dp->dev, "Training link failed: %d\n", ret);
>>  			goto out;
>>  		}
>> 
>>  		/* If training result is changed, update the video config */
>>  		if (mode->clock &&
>>  		    (rate != dp->max_rate || lanes != dp->max_lanes)) {
>>  			ret = cdn_dp_config_video(dp);
>>  			if (ret) {
>>  				dp->connected = false;
>> -				DRM_DEV_ERROR(dp->dev,
>> -					      "Failed to config video %d\n",
>> -					      ret);
>> +				DRM_DEV_ERROR(dp->dev, "Failed to configure video: %d\n", ret);
>>  			}
>>  		}
>>  	}

