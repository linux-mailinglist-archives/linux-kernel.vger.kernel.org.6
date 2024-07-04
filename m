Return-Path: <linux-kernel+bounces-240882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F68927425
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631CA1F22D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933641ABC3B;
	Thu,  4 Jul 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JWG1AfrB"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F081A38EE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089349; cv=none; b=HojKc1+42X0wUZ/JGUY6VjUtSBFf1nXryCVU5FwEy7RVOPxOIYM5Fqh/J62khAXI2cNP4lcVWdHDfC5w/lzRm8RVnKtv4mdBc1uTWazrYQ9jwGghdrkLyFiUfnCn6MutTb4UCAPY13MqWk9nD91FnHJF3GOIm9Fc6r9QmYqyB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089349; c=relaxed/simple;
	bh=HnTn04cXFJ2PANtudWBe5O1iDxBxVMzRQcaaA9G9djY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GIEzGrw2X47FAuccjR+Z9EIwcmLQ+7tDDzWX+e54nncI8xjAAHRIamF8hsVx6Uqv3rg/tZcOv4vOIdhQSOVy46lEt+7KQQ3hmbaXKZnRBC3qfE2HK/GXBuM5dGwTyVnn9q5MvUgKv1BDKK1mNl33Q2f5Kws91XVCRi9X4/23dJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JWG1AfrB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720089343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJOFsT26L8JdFVcMMX9b4cqXxsGrGFsPl357c5nOzqE=;
	b=JWG1AfrBc+4vkUyLgNP2jWcN58hOkyPDvbjMENRwcvc+0331+xLKVvKw0TzZkHMzrpGKfN
	m+zqd/bZlA9vjBHFuylMBeTOgkwyhu2efWUjovyhlgXvlbneXTxIABQ1W8BHvkQ8cOgoSi
	jlRMcI0Qq1AUff02y/8H3Gk6hqqmsv5/731JlbRDgLNb1O5kVtQn7VTEnEwq2kqIEs54ax
	fnNR1O8V+Kn/+4JCroVPBXQh3oFFytcRYEIRJmFrmOcfqImqW/dhhAU3QMJEjfH6Vvsxfl
	jf8+WMbN7znp4tQM6T3hZZjzsbNX2URxgfK+arj6dT5iAts/wNlnRsSQ8coHKA==
Date: Thu, 04 Jul 2024 12:35:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Remove redundant workarounds for
 firmware loading
In-Reply-To: <109c6f19.2559.1907b817a99.Coremail.andyshrk@163.com>
References: <9b7a9e9b88ad8c7489ee1b4c70b8751eeb5cf6f9.1720049413.git.dsimic@manjaro.org>
 <109c6f19.2559.1907b817a99.Coremail.andyshrk@163.com>
Message-ID: <0bf4701d98833609b917983718c610aa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andy,

On 2024-07-04 04:10, Andy Yan wrote:
> At 2024-07-04 07:32:02, "Dragan Simic" <dsimic@manjaro.org> wrote:
>> After the additional firmware-related module information was 
>> introduced by
>> the commit c0677e41a47f ("drm/rockchip: cdn-dp-core: add 
>> MODULE_FIRMWARE
>> macro"), there's no longer need for the firmware-loading workarounds 
>> whose
>> sole purpose was to prevent the missing firmware blob in an initial 
>> ramdisk
>> from causing driver initialization to fail.  Thus, delete the 
>> workarounds,
>> which removes a sizable chunk of redundant code.
> 
> What would happen if there was no ramdisk? And the firmware is in 
> rootfs ？
> 
> For example： A buildroot based tiny embedded system。

Good point, let me explain, please.

In general, if a driver is built into the kernel, there should also be
an initial ramdisk that contains the related firmware blobs, because 
it's
unknown is the root filesystem available when the driver is probed.  If
a driver is built as a module and there's no initial ramdisk, having
the related firmware blobs on the root filesystem should be fine, 
because
the firmware blobs and the kernel module become available at the same
time, through the root filesystem. [1]

Another option for a driver built statically into the kernel, when 
there's
no initial ramdisk, is to build the required firmware blobs into the 
kernel
image. [2]  Of course, that's feasible only when a kernel image is built
specificially for some device, because otherwise it would become too 
large
because of too many drivers and their firmware blobs becoming included,
but that seems to fit the Buildroot-based example.

To sum it up, mechanisms already exist in the kernel for various 
scenarios
when it comes to loading firmware blobs.  Even if the deleted workaround
attempts to solve some issue specific to some environment, that isn't 
the
right place or the right way for solving any issues of that kind.

While preparing this patch, I even tried to find another kernel driver 
that
also implements some similar workarounds for firmware loading, to 
justify
the existence of such workarounds and to possibly move them into the 
kernel's
firmware-loading interface.  Alas, I was unable to find such workarounds 
in
other drivers, which solidified my reasoning behind classifying the 
removed
code as out-of-place and redundant.

[1] 
https://www.kernel.org/doc/Documentation/driver-api/firmware/direct-fs-lookup.rst
[2] 
https://www.kernel.org/doc/Documentation/driver-api/firmware/built-in-fw.rst

>> Various utilities used by Linux distributions to generate initial 
>> ramdisks
>> need to obey the firmware-related module information, so we can rely 
>> on the
>> firmware blob being present in the generated initial ramdisks.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> drivers/gpu/drm/rockchip/cdn-dp-core.c | 53 +++++---------------------
>> 1 file changed, 10 insertions(+), 43 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c 
>> b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> index bd7aa891b839..e1a7c6a1172b 100644
>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> @@ -44,9 +44,9 @@ static inline struct cdn_dp_device 
>> *encoder_to_dp(struct drm_encoder *encoder)
>> #define DPTX_HPD_DEL		(2 << 12)
>> #define DPTX_HPD_SEL_MASK	(3 << 28)
>> 
>> -#define CDN_FW_TIMEOUT_MS	(64 * 1000)
>> #define CDN_DPCD_TIMEOUT_MS	5000
>> #define CDN_DP_FIRMWARE		"rockchip/dptx.bin"
>> +
>> MODULE_FIRMWARE(CDN_DP_FIRMWARE);
>> 
>> struct cdn_dp_data {
>> @@ -909,61 +909,28 @@ static int cdn_dp_audio_codec_init(struct 
>> cdn_dp_device *dp,
>> 	return PTR_ERR_OR_ZERO(dp->audio_pdev);
>> }
>> 
>> -static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
>> -{
>> -	int ret;
>> -	unsigned long timeout = jiffies + 
>> msecs_to_jiffies(CDN_FW_TIMEOUT_MS);
>> -	unsigned long sleep = 1000;
>> -
>> -	WARN_ON(!mutex_is_locked(&dp->lock));
>> -
>> -	if (dp->fw_loaded)
>> -		return 0;
>> -
>> -	/* Drop the lock before getting the firmware to avoid blocking boot 
>> */
>> -	mutex_unlock(&dp->lock);
>> -
>> -	while (time_before(jiffies, timeout)) {
>> -		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
>> -		if (ret == -ENOENT) {
>> -			msleep(sleep);
>> -			sleep *= 2;
>> -			continue;
>> -		} else if (ret) {
>> -			DRM_DEV_ERROR(dp->dev,
>> -				      "failed to request firmware: %d\n", ret);
>> -			goto out;
>> -		}
>> -
>> -		dp->fw_loaded = true;
>> -		ret = 0;
>> -		goto out;
>> -	}
>> -
>> -	DRM_DEV_ERROR(dp->dev, "Timed out trying to load firmware\n");
>> -	ret = -ETIMEDOUT;
>> -out:
>> -	mutex_lock(&dp->lock);
>> -	return ret;
>> -}
>> -
>> static void cdn_dp_pd_event_work(struct work_struct *work)
>> {
>> 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
>> 						event_work);
>> 	struct drm_connector *connector = &dp->connector;
>> 	enum drm_connector_status old_status;
>> -
>> 	int ret;
>> 
>> 	mutex_lock(&dp->lock);
>> 
>> 	if (dp->suspended)
>> 		goto out;
>> 
>> -	ret = cdn_dp_request_firmware(dp);
>> -	if (ret)
>> -		goto out;
>> +	if (!dp->fw_loaded) {
>> +		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
>> +		if (ret) {
>> +			DRM_DEV_ERROR(dp->dev, "Loading firmware failed: %d\n", ret);
>> +			goto out;
>> +		}
>> +
>> +		dp->fw_loaded = true;
>> +	}
>> 
>> 	dp->connected = true;
>> 

