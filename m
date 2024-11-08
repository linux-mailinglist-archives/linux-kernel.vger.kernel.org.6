Return-Path: <linux-kernel+bounces-401777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0327B9C1F07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A351F2487C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57411F4295;
	Fri,  8 Nov 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Cu67kjSV"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E71DEFC2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075542; cv=none; b=Ke/H+jJ3N+7k30Yiv0VMlY9WEg7TipS/KUbVOLBDyxcCQeXdiWOlhr/ak8h2zOfnAc8ru2xsXngkoNkjHn9i5833IOMNeb3jdWH74AP0LNccV3CGH7NHRUl7Z+rzZ6atZC1+MTldQrOYu9+GkuoJXYkloEtBwNNPxsGwAfrbk+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075542; c=relaxed/simple;
	bh=6FTZFwIOAM1Tqzh1quBVoMkok0YIlAwyZOBxDgtHwUQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ca6LCsiJx6eCY4zxuqau1KoZ/W2/N4j2hV3DzjvrMAlyd3R//S9gyKwBvdX+hCMPWFYomweYiwcozpQ77lc8nFV5ozslXEnagRBt4ZMwudYJQYIW+CFB0qjO6Kbr/JnCAXNhOKWguJT21kwxM2kFgB2FpLFt3K8C1DekfujDZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Cu67kjSV; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731075537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upYsGgf23umhPBOmb5HT7kjqp65LPpB+QOD8j0l2rE4=;
	b=Cu67kjSVWeIMcCC+Jbh62CKfQeBvbLbaeVrOoJTC7E08ONzDAKwTyxCnm3RyphTtwkEVxz
	7Wau9/7UQPCWK+ySJoG4vlhqVFRzMAEh/VWwMiZF/1PwqTKqkv5r7Xaoa1MCJdJdGKU//+
	lmsJf12fwprFcVfdBv5pTh5FGelCl/UYDveT2OBScypZ2UfzdmrVq55B5XiAaCuPhnikrr
	sg5AUSk0Po+kPHUOE88sesoLjlepcOFGoK3+HEIAlYw9DzstYiqNJgSRhhFXYDTI7LI2eg
	s6zc6+jAtlJisK2L8fbwYDSy2yZy6bsw+7wCAGQAivffatli+E/rkGxXezjTDA==
Date: Fri, 08 Nov 2024 15:18:57 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH 2/2] drm/rockchip: dsi: Don't log errors on deferred dphy
In-Reply-To: <yrm6r4urzf5hvnui53cvepw2loqvuhydalq6haw7qmpktor5y5@zjc34wlcoeg2>
References: <cover.1731073565.git.dsimic@manjaro.org>
 <559094275c3e41cae7c89e904341f89a1240a51a.1731073565.git.dsimic@manjaro.org>
 <yrm6r4urzf5hvnui53cvepw2loqvuhydalq6haw7qmpktor5y5@zjc34wlcoeg2>
Message-ID: <599471308374b786af4dc8a6b42fea76@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sebastian,

On 2024-11-08 15:08, Sebastian Reichel wrote:
> On Fri, Nov 08, 2024 at 02:53:58PM +0100, Dragan Simic wrote:
>> Deferred driver probing shouldn't result in errors or warnings being 
>> logged,
>> because their presence in the kernel log provides no value and may 
>> actually
>> cause false impression that some issues exist.  Thus, let's no longer 
>> produce
>> error messages when getting the dphy results in deferred probing.
>> 
>> This prevents misleading error messages like the following one, which 
>> was
>> observed on a Pine64 PineTab2, from appearing in the kernel log.  To 
>> make
>> matters worse, the following error message was observed appearing 
>> multiple
>> times in the kernel log of a single PineTab2 boot:
>> 
>>   dw-mipi-dsi-rockchip fe060000.dsi: [drm:dw_mipi_dsi_rockchip_probe \
>>   [rockchipdrm]] *ERROR* failed to get mipi dphy: -517
>> 
>> At the same time, make the adjusted logged message a bit more 
>> consistent with
>> the other logged messages by capitalizing its first word.
>> 
>> Reported-by: Diederik de Haas <didi.debian@cknow.org>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
> 
> From include/drm/drm_print.h:
> 
>  * DRM_DEV_ERROR() - Error output.
>  *
>  * NOTE: this is deprecated in favor of drm_err() or dev_err().
> 
> The recommended way to do this nowadays looks like this:
> 
> return dev_err_probe(dev, PTR_ERR(dsi->phy), "Failed to get mipi 
> dphy");
> 
> That will not print anything for -EPROBE_DEFER, but capture
> the reason and make it available through
> /sys/kernel/debug/devices_deferred if the device never probes.

Thanks for your quick response!  As already discussed with Heiko,
I'll move forward with implementing a complete file-level conversion.
At first, I thought that a partial bugfix would be beneficial, [1]
but now I agree that performing a complete file-level coversion is
the way to go. [2]

I've got to admit, I love seeing that DRM_DEV_ERROR() is deprecated,
because I've never been a big fan of the format of the messages
it produces.

[1] 
https://lore.kernel.org/dri-devel/3734f6a5424e3537d717c587a058fc85@manjaro.org/
[2] 
https://lore.kernel.org/dri-devel/047164cc6e88dcbc7701cb0e28d564db@manjaro.org/

>>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c 
>> b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> index f451e70efbdd..ffa7f2bc640d 100644
>> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> @@ -1387,7 +1387,8 @@ static int dw_mipi_dsi_rockchip_probe(struct 
>> platform_device *pdev)
>>  	dsi->phy = devm_phy_optional_get(dev, "dphy");
>>  	if (IS_ERR(dsi->phy)) {
>>  		ret = PTR_ERR(dsi->phy);
>> -		DRM_DEV_ERROR(dev, "failed to get mipi dphy: %d\n", ret);
>> +		if (ret != -EPROBE_DEFER)
>> +			DRM_DEV_ERROR(dev, "Failed to get mipi dphy: %d\n", ret);
>>  		return ret;
>>  	}
>> 

