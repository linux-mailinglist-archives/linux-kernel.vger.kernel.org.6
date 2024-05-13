Return-Path: <linux-kernel+bounces-177064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6318C39A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808581C20A45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB89A927;
	Mon, 13 May 2024 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d1Vnuf/a"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEF8F6D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715560363; cv=none; b=TjyOYU+khVDOEjkJMan/Ny/JLjcHLOKwSJfGf0q06f3HVNHLKV+buhSzeJlFJv72+4eq1dFRkAUT40VdKN3XgX3OpWFwilf4P7lbo3casT9avzT/0fOAhn92KbyxASqWgK3rVG5+OSDWqTpkrmQ/7Q6twa9CCmh+sl1FBJgu6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715560363; c=relaxed/simple;
	bh=yJyD0PQLiW0+c2L9DAkeDFgw94Ok371x2Syj9S66vzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXvJ0a5dxrJSmfjvo8Mvz3y6z5WGbICWeYXPrVglRQ9asSuPqx6TBUjZ3rc18OXsyxq0ClLi+dbuwWE2aoqoEx/X6iJ8Kosd7wKnBDuf1AjI2mPsjLtj7vSq2B9Yr3Z+No4X00iPDR6RAP8CBAncPDqfqEFWjSIj/epIk4KeKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d1Vnuf/a; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c110750a-0a82-42de-9e21-07b8bde57899@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715560359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQJ8T41hCIU0iIEaZ0wavsawTI/BhAVatIFoI6RLNr8=;
	b=d1Vnuf/aef998EA+ycBSbeHn5SOURCunWoAVROerJeDphuiAurYN+F56gMSWSFAjD2e1P6
	LzIZP4VpX5oXeOjS99Imv4exK55GTJ/fTt3KMy+CMM11pnSbA45T1sydY6X158Mp+lpyLb
	z9M/AtwJVQKyYasaGWxNEzK8Bd+i2GU=
Date: Mon, 13 May 2024 08:32:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/bridge: Remove a small useless code snippet
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240511124238.297192-1-sui.jingfeng@linux.dev>
 <20240512210907.GI17158@pendragon.ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240512210907.GI17158@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/5/13 05:09, Laurent Pinchart wrote:
> Hi Sui,
>
> Thank you for the patch.
>
> On Sat, May 11, 2024 at 08:42:38PM +0800, Sui Jingfeng wrote:
>> Because the check on the non-existence (encoder == NULL) has already been
>> done in the implementation of drm_bridge_attach() function, and
>> drm_bridge_attach() is called earlier. The driver won't get to check point
>> even if drm_bridge_attach() fails for some reasons, as it will clear the
>> bridge->encoder to NULL and return a negective error code.
> s/negective/negative/
>

Sorry, my bad.


>> Therefore, there is no need to check another again. Remove the redundant
>> codes at the later.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> If you end up sending a second version of this patch, please include all
> similar patches you have sent at the same time in a patch series,
> instead of sending them separately.

I will send a second version to correct spell error and collect and fold them into a series.

By the way, thanks a lot for you time review my patch and thanks a lot for the generous.

So happy be reviewed and its my pleasure to have opportunities to talk with you. Thanks a lot!


>> ---
>>   drivers/gpu/drm/bridge/simple-bridge.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
>> index 28376d0ecd09..3caa918ac2e0 100644
>> --- a/drivers/gpu/drm/bridge/simple-bridge.c
>> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
>> @@ -116,11 +116,6 @@ static int simple_bridge_attach(struct drm_bridge *bridge,
>>   	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>>   		return 0;
>>   
>> -	if (!bridge->encoder) {
>> -		DRM_ERROR("Missing encoder\n");
>> -		return -ENODEV;
>> -	}
>> -
>>   	drm_connector_helper_add(&sbridge->connector,
>>   				 &simple_bridge_con_helper_funcs);
>>   	ret = drm_connector_init_with_ddc(bridge->dev, &sbridge->connector,

-- 
Best regards,
Sui


