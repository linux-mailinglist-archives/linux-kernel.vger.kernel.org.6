Return-Path: <linux-kernel+bounces-180061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D48C698D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F32282971
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C862C15575A;
	Wed, 15 May 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XFxgfMP3"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388215574C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786406; cv=none; b=Qs/7EWnIWVRbmRCiTC3JXebOz+K/AYBTcYBotDeoEQk9y7+x/ubE5Jdgm+X3MwNd0FuNz5lsmr33Kn/8XHhvAA6EOMoINa8eOljGYLQR5ua22nTb5DQN8QqbF78HGrIlO8HGZ/lzlNxIcPUPuBa1ih/IsdmeI2siD1gEDGFK0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786406; c=relaxed/simple;
	bh=TNvTFxD0lNFbtP/hbUhnEE8TGogQNxPRZHVVwl0fwJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blp0bUx3SWteFYNX8WD8XPu9RQNKWjXCfNnIQ/2GeShgbJ46S50v2yNPchGbgrOdbHdWyssMIWnYWyqmwdNdXu/Wy1Lwg996dUnzfMatTLMrXCgw6qKYjn3VpzA7mCywVs6H0+mhh0WGqXlT47qi+sTmXnLwEJhuhz5zUD1kuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XFxgfMP3; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c15c859-6b2b-4979-8317-698bf6cc430c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715786402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmD4Qw+Oobw3jODJD0oLXnLEGlKRGxu/voHJf2ZarqM=;
	b=XFxgfMP3HPxLUow/pJcgRdJr6LVhiCG33NNCO9WQPk36A8Xk1FCTVDOgqDzgP73sAq7Rk4
	IWgSOsYKCKHgsAJlBedjYqWBPhMdG2LvTfrpV7ilPe5Ka7/0t4xvR9XL/UOM3+xFbMTcgv
	8RNIRLe1w9ETbdzwSueiZzzVYiP+/7E=
Date: Wed, 15 May 2024 23:19:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
 <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>
 <20240515-fair-satisfied-myna-480dea@penduick>
 <d394ee32-4fa4-41a8-a5ca-c1c7f77f44d2@linux.dev>
 <20240515-copper-chimpanzee-of-fortitude-ff3dab@penduick>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240515-copper-chimpanzee-of-fortitude-ff3dab@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/15/24 22:58, Maxime Ripard wrote:
> On Wed, May 15, 2024 at 10:53:00PM +0800, Sui Jingfeng wrote:
>> On 5/15/24 22:30, Maxime Ripard wrote:
>>> On Wed, May 15, 2024 at 12:53:33AM +0800, Sui Jingfeng wrote:
>>>> On 2024/5/15 00:22, Maxime Ripard wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, May 14, 2024 at 11:40:43PM +0800, Sui Jingfeng wrote:
>>>>>> Because a lot of implementations has already added it into their drived
>>>>>> class, promote it into drm_bridge core may benifits a lot. drm bridge is
>>>>>> a driver, it should know the underlying hardware entity.
>>>>> Is there some actual benefits, or is it theoretical at this point?
>>>>
>>>>
>>>> I think, DRM bridge drivers could remove the 'struct device *dev'
>>>> member from their derived structure. Rely on the drm bridge core
>>>> when they need the 'struct device *' pointer.
>>>
>>> Sure, but why do we need to do so?
>>>
>>> The other thread you had with Jani points out that it turns out that
>>> things are more complicated than "every bridge driver has a struct
>>> device anyway", it creates inconsistency in the API (bridges would have
>>> a struct device, but not other entities), and it looks like there's no
>>> use for it anyway.
>>>
>>> None of these things are deal-breaker by themselves, but if there's only
>>> downsides and no upside, it's not clear to me why we should do it at all.
>>
>> It can reduce boilerplate.
> 
> You're still using a conditional here.


It's for safety reason, prevent NULL pointer dereference.
drm bridge can be seen as either a software entity or a device driver.

It's fine to pass NULL if specific KMS drivers intend to see
drm bridge as a pure software entity, and for internal use only.
Both use cases are valid.

> 
> Maxime

-- 
Best regards
Sui

