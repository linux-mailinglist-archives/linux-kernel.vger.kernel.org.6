Return-Path: <linux-kernel+bounces-257362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E406293790A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66442B22A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5083144D10;
	Fri, 19 Jul 2024 14:15:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9506144D16
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398509; cv=none; b=jOUFqZyHTlKY/xBXmVJz1pe0BgEGFhWmMCYg620+DhzWlm7YpvSG9ORjm8Nvo1dVSdrXTnbDpFPcsk8mmJdot9Qolm51HzCC9ySuEAwGZG8iAA2f7I82IU7YiyUYGVeT9wP5FcqRo+atwzmzYpzZBQicdd9GEhxb0XND4cU0Tpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398509; c=relaxed/simple;
	bh=yqfxdF0jUFSX2SKms+e5IpFWN9gDJ9bNA/RR3Le1kus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFcSYncssLoe7DGqlVR22eDPhixYTMW8GdeM4+Zp679OqQ42cM55Cg0Dwz8ggAaPDSPHzaq9ZNhYm3hhpP19qEkds9K+C082a1KI/Qr6uzdy3p9YFoiqN25Jvty1fKAI5UBxQOz6qUiVCROzDvsLpTjXOrp/JG5VlNUdifZGqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 673091042;
	Fri, 19 Jul 2024 07:15:32 -0700 (PDT)
Received: from [10.1.38.23] (e122027.cambridge.arm.com [10.1.38.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB75A3F73F;
	Fri, 19 Jul 2024 07:15:04 -0700 (PDT)
Message-ID: <228161f4-6f97-43ac-a09a-79edeeebea7b@arm.com>
Date: Fri, 19 Jul 2024 15:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/panthor: add sysfs knob for enabling job
 profiling
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
 <20240716201302.2939894-5-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240716201302.2939894-5-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/07/2024 21:11, Adrián Larumbe wrote:
> This commit introduces a DRM device sysfs attribute that lets UM control
> the job accounting status in the device. The knob variable had been brought
> in as part of a previous commit, but now we're able to fix it manually.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Although we should probably copy/paste
Documentation/ABI/testing/sysfs-driver-panfrost-profiling - or at least
mention somewhere that the same knob is available for panthor.

Steve

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 36 +++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 6a0c1a06a709..a2876310856f 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1448,6 +1448,41 @@ static void panthor_remove(struct platform_device *pdev)
>  	panthor_device_unplug(ptdev);
>  }
>  
> +static ssize_t profiling_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct panthor_device *ptdev = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", ptdev->profile_mode);
> +}
> +
> +static ssize_t profiling_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct panthor_device *ptdev = dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err = kstrtobool(buf, &value);
> +	if (err)
> +		return err;
> +
> +	ptdev->profile_mode = value;
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(profiling);
> +
> +static struct attribute *panthor_attrs[] = {
> +	&dev_attr_profiling.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(panthor);
> +
>  static const struct of_device_id dt_match[] = {
>  	{ .compatible = "rockchip,rk3588-mali" },
>  	{ .compatible = "arm,mali-valhall-csf" },
> @@ -1467,6 +1502,7 @@ static struct platform_driver panthor_driver = {
>  		.name = "panthor",
>  		.pm = pm_ptr(&panthor_pm_ops),
>  		.of_match_table = dt_match,
> +		.dev_groups = panthor_groups,
>  	},
>  };
>  


