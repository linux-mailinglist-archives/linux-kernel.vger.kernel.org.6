Return-Path: <linux-kernel+bounces-335629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9697E84A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1230B203BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B81946D1;
	Mon, 23 Sep 2024 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="mccx32tK"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF3194158
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082776; cv=none; b=YqHo+PL9ZyxIDkLfMzX7T14bUjs+NCAgDY4kKvluudVfrCcEoltt0IU/8Azl7IguM1BpUbQ2KTT5C2iiPTeJAQBHcftK6tg8LoJZ4BAoOCpYTENE2SHtClQRUqLfg2gUJV+7cD89DgKvpOQtb9YrLF0CH3NgV9yuROAJGw72RIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082776; c=relaxed/simple;
	bh=ltbp2Ljs7Bfwl1Q+wylO8WNLdUroGdokwPt/VLPtPDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiVfC2e5nl49gCAPHldE8+9eDvZbfJj1QyJid3Bl+0+MMbK02iZDRvnfg6sPkNRIeQIUA5trCiBmRRvC5OdbcjO5p7fCU27J9b6iReSY2uTGeOf7IhoSlboYyrLNJDpqlDcFKvQacaAtf2Ci1dfWO1cdTtKcm3u39QTXyC9TfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=mccx32tK; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727082766;
 bh=dAioT3wyKoxKPb4pl0VnZgSZEzeLXfNhVBSyVYoz4/0=;
 b=mccx32tKRHC+uZQnSVR+9I2Yp8iB5iFdpx9rfxCgmC+klT/TUJ2rYGZniZ+zpoQ5cV+FanHGj
 mis3tg4BqxdCf8bA3dQ7odkBcoESNAQLQm/fr76OET7X9wkr3Kf4hkXPgdYCdATnN7aZ5ywzzwo
 h9dI+KYic6N9Idq8hk1fvG4GuRi+iXv9s3fGj0Rqt3SJY+MlJDN8oYYQaOwsIcspatHHBUiNrbr
 jmOErRY4/hTFtLZJ6Bu0sc56TVQJDsl+ndnTIFNeMtiQGHcvnaNVstU+Zm8iqvqZr75zdGRAAEZ
 8gnPJShe34Pu1xnfcWaviL/W/azuTqoulWgjLg4oTEZQ==
Message-ID: <26ed8563-b6d6-4e72-91a9-f4d5946cef8f@kwiboo.se>
Date: Mon, 23 Sep 2024 11:01:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/rockchip: vop: Split rk3288-vop into big and lit
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240921222007.2301868-1-jonas@kwiboo.se>
 <20240921222007.2301868-4-jonas@kwiboo.se>
 <c6821033-57be-4d10-9e37-935f7748570e@kernel.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <c6821033-57be-4d10-9e37-935f7748570e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f12e7e53a7abd54c98a970

Hi Krzysztof,

On 2024-09-22 10:15, Krzysztof Kozlowski wrote:
> On 22/09/2024 00:20, Jonas Karlman wrote:
>> The Rockchip RK3288 SoC contain two different Visual Output Processor
>> (VOP) blocks, VOP_BIG and VOP_LIT. The VOP blocks support different max
>> output resolution, 3840x2160 and 2560x1600.
>>
>> Add support for the compatible used to differentiate between VOP_BIG and
>> VOP_LIT, support for the old compatible is kept for compatibility with
>> older device tree.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 27 +++++++++++++++------
>>  1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> index e2c6ba26f437..978db93cda33 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> @@ -762,7 +762,7 @@ static const struct vop_intr rk3288_vop_intr = {
>>  	.clear = VOP_REG(RK3288_INTR_CTRL0, 0xf, 8),
>>  };
>>  
>> -static const struct vop_data rk3288_vop = {
>> +static const struct vop_data rk3288_vop_big = {
>>  	.version = VOP_VERSION(3, 1),
>>  	.feature = VOP_FEATURE_OUTPUT_RGB10,
>>  	.intr = &rk3288_vop_intr,
>> @@ -772,14 +772,22 @@ static const struct vop_data rk3288_vop = {
>>  	.win = rk3288_vop_win_data,
>>  	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
>>  	.lut_size = 1024,
>> -	/*
>> -	 * This is the maximum resolution for the VOPB, the VOPL can only do
>> -	 * 2560x1600, but we can't distinguish them as they have the same
>> -	 * compatible.
>> -	 */
>>  	.max_output = { 3840, 2160 },
>>  };
>>  
>> +static const struct vop_data rk3288_vop_lit = {
>> +	.version = VOP_VERSION(3, 1),
>> +	.feature = VOP_FEATURE_OUTPUT_RGB10,
>> +	.intr = &rk3288_vop_intr,
>> +	.common = &rk3288_common,
>> +	.modeset = &rk3288_modeset,
>> +	.output = &rk3288_output,
>> +	.win = rk3288_vop_win_data,
>> +	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
>> +	.lut_size = 1024,
>> +	.max_output = { 2560, 1600 },
>> +};
>> +
>>  static const int rk3368_vop_intrs[] = {
>>  	FS_INTR,
>>  	0, 0,
>> @@ -1245,8 +1253,13 @@ static const struct of_device_id vop_driver_dt_match[] = {
>>  	  .data = &rk3066_vop },
>>  	{ .compatible = "rockchip,rk3188-vop",
>>  	  .data = &rk3188_vop },
>> +	{ .compatible = "rockchip,rk3288-vop-big",
>> +	  .data = &rk3288_vop_big },
> 
> Hm... that's not really needed. Instead of having three compatibles, you
> could keep "rk3288-vop" as big and then my comment on bindings patch
> could be ignored (you keep the compatible).

Thanks, I guess that just adding a new compatible for vop-lit should be
enough.

VOP_BIG: rockchip,rk3288-vop
VOP_LIT: rockchip,rk3288-vop-lit, rockchip,rk3288-vop

That should ensure backward/forward compatibility with any mix of
old/new boot-firmware, DTs and kernels.

Will change to use that in v2.

Regards,
Jonas

> 
> 
> 
> Best regards,
> Krzysztof
> 


