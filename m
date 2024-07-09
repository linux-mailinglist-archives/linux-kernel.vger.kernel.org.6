Return-Path: <linux-kernel+bounces-245603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626092B4D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8594C1F21F11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D0155C98;
	Tue,  9 Jul 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AM1o5vtN"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66838FB0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519858; cv=none; b=jmhbN08ngEmfV/ACSdT7X+kJCGlHQ2yVZw4PbQGqlWWFTeYNoJa1DSErQSyPsC5M7lwZWgFbcMWR4piJffLTjyPas4qWbSgPYiGW7cbO0A9wi9XMj/7Y2TokQqrs36o5bFalazfRGGG6NgRk8CpfoBkHOT9/B9jxuUNPAg7LH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519858; c=relaxed/simple;
	bh=W/C6zjKNL9tquK+TIBzv0xUn3KARYueAB6Mlr/5TjPU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=vFOs1qbEsEyszEancoWFEk67sfM0mnYbUWCV47fWpZt9KWT4J3ndEf9xUclMnAtGbJ+nwzwLLDNL5j0Y4Pn1NZhLsV6JJCV99sY9fx03JqMqyh3vdGW2F051IwhstJTDTuO+x0qLy/EgTLtSUrKUeml+zPGE8eBC/OEIgA0+g0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AM1o5vtN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720519852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJUfQJE1Sv8l2zjCk6SyNU0265sG/LqJbdrgagUvL0w=;
	b=AM1o5vtN62Ewqm+OedTbPjtLuKCC+lFAOvj5rmlr+UYCqsuoYp2qBlP2F2Dv1VSqhBO2Hx
	cQmdUV5sloyy6J5IeKOGk7OaRNB7mo2CyxEum/qdnzVvf+GQz3tEwwkAuW6c9k2HL4bW3d
	jBLEM4d2ZCO49+qbvwhUgBnbnpJFvvuYk30dCe9mQbOWWsF6iFLBMgbhk6zOiDVzqStVPI
	tVMbTCoypLgf0uaUBx2nhMZ1rtWKKtdo+NFdmWTOmb8U3yNG01dM5iwH4inNN/LWIviLpk
	ACCgrCrWV6TXHFc/52flMLkpdTmCzigEqFaHN8NuU0I/m2CLH70+u5specHr7Q==
Date: Tue, 09 Jul 2024 12:10:51 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, javierm@redhat.com
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Remove redundant workarounds for
 firmware loading
In-Reply-To: <909d072.9028.19096c2429a.Coremail.andyshrk@163.com>
References: <9b7a9e9b88ad8c7489ee1b4c70b8751eeb5cf6f9.1720049413.git.dsimic@manjaro.org>
 <109c6f19.2559.1907b817a99.Coremail.andyshrk@163.com>
 <0bf4701d98833609b917983718c610aa@manjaro.org>
 <2fd3aabd.785b.190914ec1a6.Coremail.andyshrk@163.com>
 <f0fb9feed2d9262bb4d7c8ade836af62@manjaro.org>
 <909d072.9028.19096c2429a.Coremail.andyshrk@163.com>
Message-ID: <31062b80d3f9e11c339c400a70464f43@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-09 11:10, Andy Yan wrote:
> At 2024-07-09 16:17:06, "Dragan Simic" <dsimic@manjaro.org> wrote:
>> On 2024-07-08 09:46, Andy Yan wrote:
>>> At 2024-07-04 18:35:42, "Dragan Simic" <dsimic@manjaro.org> wrote:
>>>> On 2024-07-04 04:10, Andy Yan wrote:
>>>>> At 2024-07-04 07:32:02, "Dragan Simic" <dsimic@manjaro.org> wrote:
>>>>>> After the additional firmware-related module information was
>>>>>> introduced by
>>>>>> the commit c0677e41a47f ("drm/rockchip: cdn-dp-core: add
>>>>>> MODULE_FIRMWARE
>>>>>> macro"), there's no longer need for the firmware-loading 
>>>>>> workarounds
>>>>>> whose
>>>>>> sole purpose was to prevent the missing firmware blob in an 
>>>>>> initial
>>>>>> ramdisk
>>>>>> from causing driver initialization to fail.  Thus, delete the
>>>>>> workarounds,
>>>>>> which removes a sizable chunk of redundant code.
>>>>> 
>>>>> What would happen if there was no ramdisk? And the firmware is in
>>>>> rootfs ？
>>>>> 
>>>>> For example： A buildroot based tiny embedded system。
>>>> 
>>>> Good point, let me explain, please.
>>>> 
>>>> In general, if a driver is built into the kernel, there should also 
>>>> be
>>>> an initial ramdisk that contains the related firmware blobs, because
>>>> it's
>>>> unknown is the root filesystem available when the driver is probed.
>>>> If
>>>> a driver is built as a module and there's no initial ramdisk, having
>>>> the related firmware blobs on the root filesystem should be fine,
>>>> because
>>>> the firmware blobs and the kernel module become available at the 
>>>> same
>>>> time, through the root filesystem. [1]
>>>> 
>>>> Another option for a driver built statically into the kernel, when
>>>> there's
>>>> no initial ramdisk, is to build the required firmware blobs into the
>>>> kernel
>>>> image. [2]  Of course, that's feasible only when a kernel image is
>>>> built
>>>> specificially for some device, because otherwise it would become too
>>>> large
>>>> because of too many drivers and their firmware blobs becoming
>>>> included,
>>>> but that seems to fit the Buildroot-based example.
>>>> 
>>>> To sum it up, mechanisms already exist in the kernel for various
>>>> scenarios
>>>> when it comes to loading firmware blobs.  Even if the deleted
>>>> workaround
>>>> attempts to solve some issue specific to some environment, that 
>>>> isn't
>>>> the
>>>> right place or the right way for solving any issues of that kind.
>>>> 
>>>> While preparing this patch, I even tried to find another kernel 
>>>> driver
>>>> that
>>>> also implements some similar workarounds for firmware loading, to
>>>> justify
>>>> the existence of such workarounds and to possibly move them into the
>>>> kernel's
>>>> firmware-loading interface.  Alas, I was unable to find such
>>>> workarounds
>>>> in
>>>> other drivers, which solidified my reasoning behind classifying the
>>>> removed
>>>> code as out-of-place and redundant.
>>> 
>>> For some tiny embedded system，there is no such ramdisk，for example：
>>> a buildroot based rootfs，the buildroot only generate rootfs。
>>> 
>>> And FYI， there are mainline drivers try to fix such issue by
>>> defer_probe，for example：
>>> smc_abc[0]
>>> There are also some other similar scenario in gpu driver{1}[2]
>>> 
>>> [0]https://elixir.bootlin.com/linux/latest/source/drivers/tee/optee/smc_abi.c#L1518
>>> [1]https://patchwork.kernel.org/project/dri-devel/patch/20240109120604.603700-1-javierm@redhat.com/
>>> [2]https://lore.kernel.org/dri-devel/87y1918psd.fsf@minerva.mail-host-address-is-not-set/T/
>> 
>> Thanks for providing these examples.
>> 
>> Before I continue thinking about the possible systemic solution,
>> could you please clarify the way Buildroot builds the kernel and
>> prepares the root filesystem?  I'm not familiar with Buildroot,
>> but it seems to me that it builds the drivers statically into the
>> produced kernel image, while it places the related firmware blobs
>> into the produced root filesystem.  Am I right there?
> 
> in practice we can chose build the drivers statically into the kernel，
> we can also build it as a module。
> And in both case， the firmware blobs are put in rootfs。
> If the drivers is built as a module， the module will also put in 
> rootfs，
> so its fine。
> But if a drivers is built into the kernel ，it maybe can't access the
> firmware blob
> before the rootfs is mounted.
> So we can see some drivers try to use  DEFER_PROBE to fix this issue.

When Buildroot builds the drivers statically into the kernel image,
can it also be told to build the required firmware blobs into the
kernel image, for which there's already support in the kernel?

Of course, that would be feasible if only a small number of firmware
blobs would end up built into the kernel image, i.e. if the Buildroot
build would be tailored for a specific board.

Otherwise...

>> As I already wrote earlier, and as the above-linked discussions
>> conclude, solving these issues doesn't belong to any specific driver.
>> It should be resolved within the kernel's firmware loading mechanism
>> instead, and no driver should be specific in that regard.
> 
> IT would be good if it can be resolved within the kernel's  firmware
> loading mechanism.

... we'll need this as a systemic solution.

>>>> [1]
>>>> https://www.kernel.org/doc/Documentation/driver-api/firmware/direct-fs-lookup.rst
>>>> [2]
>>>> https://www.kernel.org/doc/Documentation/driver-api/firmware/built-in-fw.rst
>>>> 
>>>>>> Various utilities used by Linux distributions to generate initial
>>>>>> ramdisks
>>>>>> need to obey the firmware-related module information, so we can 
>>>>>> rely
>>>>>> on the
>>>>>> firmware blob being present in the generated initial ramdisks.
>>>>>> 
>>>>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>>>>> ---
>>>>>> drivers/gpu/drm/rockchip/cdn-dp-core.c | 53
>>>>>> +++++---------------------
>>>>>> 1 file changed, 10 insertions(+), 43 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>>>>> b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>>>>> index bd7aa891b839..e1a7c6a1172b 100644
>>>>>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>>>>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>>>>> @@ -44,9 +44,9 @@ static inline struct cdn_dp_device
>>>>>> *encoder_to_dp(struct drm_encoder *encoder)
>>>>>> #define DPTX_HPD_DEL		(2 << 12)
>>>>>> #define DPTX_HPD_SEL_MASK	(3 << 28)
>>>>>> 
>>>>>> -#define CDN_FW_TIMEOUT_MS	(64 * 1000)
>>>>>> #define CDN_DPCD_TIMEOUT_MS	5000
>>>>>> #define CDN_DP_FIRMWARE		"rockchip/dptx.bin"
>>>>>> +
>>>>>> MODULE_FIRMWARE(CDN_DP_FIRMWARE);
>>>>>> 
>>>>>> struct cdn_dp_data {
>>>>>> @@ -909,61 +909,28 @@ static int cdn_dp_audio_codec_init(struct
>>>>>> cdn_dp_device *dp,
>>>>>> 	return PTR_ERR_OR_ZERO(dp->audio_pdev);
>>>>>> }
>>>>>> 
>>>>>> -static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
>>>>>> -{
>>>>>> -	int ret;
>>>>>> -	unsigned long timeout = jiffies +
>>>>>> msecs_to_jiffies(CDN_FW_TIMEOUT_MS);
>>>>>> -	unsigned long sleep = 1000;
>>>>>> -
>>>>>> -	WARN_ON(!mutex_is_locked(&dp->lock));
>>>>>> -
>>>>>> -	if (dp->fw_loaded)
>>>>>> -		return 0;
>>>>>> -
>>>>>> -	/* Drop the lock before getting the firmware to avoid blocking
>>>>>> boot
>>>>>> */
>>>>>> -	mutex_unlock(&dp->lock);
>>>>>> -
>>>>>> -	while (time_before(jiffies, timeout)) {
>>>>>> -		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
>>>>>> -		if (ret == -ENOENT) {
>>>>>> -			msleep(sleep);
>>>>>> -			sleep *= 2;
>>>>>> -			continue;
>>>>>> -		} else if (ret) {
>>>>>> -			DRM_DEV_ERROR(dp->dev,
>>>>>> -				      "failed to request firmware: %d\n", ret);
>>>>>> -			goto out;
>>>>>> -		}
>>>>>> -
>>>>>> -		dp->fw_loaded = true;
>>>>>> -		ret = 0;
>>>>>> -		goto out;
>>>>>> -	}
>>>>>> -
>>>>>> -	DRM_DEV_ERROR(dp->dev, "Timed out trying to load firmware\n");
>>>>>> -	ret = -ETIMEDOUT;
>>>>>> -out:
>>>>>> -	mutex_lock(&dp->lock);
>>>>>> -	return ret;
>>>>>> -}
>>>>>> -
>>>>>> static void cdn_dp_pd_event_work(struct work_struct *work)
>>>>>> {
>>>>>> 	struct cdn_dp_device *dp = container_of(work, struct 
>>>>>> cdn_dp_device,
>>>>>> 						event_work);
>>>>>> 	struct drm_connector *connector = &dp->connector;
>>>>>> 	enum drm_connector_status old_status;
>>>>>> -
>>>>>> 	int ret;
>>>>>> 
>>>>>> 	mutex_lock(&dp->lock);
>>>>>> 
>>>>>> 	if (dp->suspended)
>>>>>> 		goto out;
>>>>>> 
>>>>>> -	ret = cdn_dp_request_firmware(dp);
>>>>>> -	if (ret)
>>>>>> -		goto out;
>>>>>> +	if (!dp->fw_loaded) {
>>>>>> +		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
>>>>>> +		if (ret) {
>>>>>> +			DRM_DEV_ERROR(dp->dev, "Loading firmware failed: %d\n", ret);
>>>>>> +			goto out;
>>>>>> +		}
>>>>>> +
>>>>>> +		dp->fw_loaded = true;
>>>>>> +	}
>>>>>> 
>>>>>> 	dp->connected = true;
>>>>>> 

