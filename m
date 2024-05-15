Return-Path: <linux-kernel+bounces-180029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A188C6909
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEED81C21489
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6215573B;
	Wed, 15 May 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qteS1gDj"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E957CA1
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784793; cv=none; b=InSDZqh6ItK9dTugtALjlIFzOh6iWkG5hM5iwTVxUEmYB07XG/CqCimLq2+fklHvymFX8X0Az7Vin1ao7NNWaypnxMQr7i8kx6hQnNCa+SgFP1mnw/5kzGW/oB/YcY1cuyab4CrvNrUaZH9UO2A2S8kgZ2k5jHHBTKT4MPMxXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784793; c=relaxed/simple;
	bh=rRYOEWpUPnx9yP+R+8XJ107O/AntMZiGuDGOA1YFrec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7grQuLaq6oINyOqPBb6knn/aQylkdTYejun3GgVrPrfEysIEBo9bSz1IImsUj+hkn4nVemCcICDJ9tlj94Cwx897azmZqUx/OjhcdQYeQOjJCj+0DndNhTIzq7AAsN5RNePAy/0nZJ7fof00DZ9orl+DByC4uZ4K4u2MvvaTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qteS1gDj; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d394ee32-4fa4-41a8-a5ca-c1c7f77f44d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715784788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ji80YrVOn0CdzRUEfTOoKRvKIhm1LRO8qrYRQvN0VUA=;
	b=qteS1gDjKTwRJ40kT2ZSurGfr/ETwkhm8guWIa6oZqwY7EDyJEr6UzG8W8ZGp3Qumefycs
	UaCABkvUzDSq3qQ1DQY1eg6yYRJAsrg7GtTEK3HhglmI19LgDsYeiytemH6wwFB/uDIhVu
	5/mw5uxLSUMwe+JNYEdxDiVR5NwoTxk=
Date: Wed, 15 May 2024 22:53:00 +0800
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
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240515-fair-satisfied-myna-480dea@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/15/24 22:30, Maxime Ripard wrote:
> On Wed, May 15, 2024 at 12:53:33AM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>> On 2024/5/15 00:22, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Tue, May 14, 2024 at 11:40:43PM +0800, Sui Jingfeng wrote:
>>>> Because a lot of implementations has already added it into their drived
>>>> class, promote it into drm_bridge core may benifits a lot. drm bridge is
>>>> a driver, it should know the underlying hardware entity.
>>> Is there some actual benefits, or is it theoretical at this point?
>>
>>
>> I think, DRM bridge drivers could remove the 'struct device *dev'
>> member from their derived structure. Rely on the drm bridge core
>> when they need the 'struct device *' pointer.
> 
> Sure, but why do we need to do so?
> 
> The other thread you had with Jani points out that it turns out that
> things are more complicated than "every bridge driver has a struct
> device anyway", it creates inconsistency in the API (bridges would have
> a struct device, but not other entities), and it looks like there's no
> use for it anyway.
> 
> None of these things are deal-breaker by themselves, but if there's only
> downsides and no upside, it's not clear to me why we should do it at all.
> 


It can reduce boilerplate.


> Maxime

-- 
Best regards
Sui

