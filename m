Return-Path: <linux-kernel+bounces-180913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C1F8C74B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B91BB21D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B76145339;
	Thu, 16 May 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jrlp5AB4"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B636AF2
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856056; cv=none; b=X0AaPt5UjKe/MM+NhXttxG8eqybYK664dKytakjlQKQtBLjuY/b4EVwGDH3Pg5uu1vYn9VBP1KuWm6x9UEpA43n+sPza/DgHKgQBhzHH9TlXvm/qOUDSfp2JHXZNh0dSAUkZMaZ6DOiBdlNqxjQA0rPhsFdTu9LM/SBHrirKKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856056; c=relaxed/simple;
	bh=sGttAr4KFordtBrDF5gVghngOZmdSmOjdkfoI1eBtII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFOqWj4e83WjWc0RzRcdI5+SMCb/Ae9yGvM1ysYEnoq94LhyVuJYILcS2XuuY9guEl4qP1XUwZrySTs0bGPSLkh4kJWKZ6DNZRJnuiZlYR4MO1O7/89UQsP1VA7kN/bW8KWjA4eengvFZC0vmn6eQZ03FMYeR8xKLG0Q4VmMypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jrlp5AB4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mripard@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715856052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNeJ2ZdpLPa8Jx4oYrQIUXFJQZti3fsu6ianHYlk4uM=;
	b=jrlp5AB46TnutoFegGgEWhaZUDIOwL5m6VvgVbPFGM8/CZgEbT/wfliSMBypIWUrswPDMV
	1Ha4bKruEl2QcA1LPH5FQMvQSfNUaeO5hhzoXYnZmMfEExGOyZ0aFrFLQFyE+0/p6cMUTo
	l1SHmiIXilN3PZ1lP8MRee1YcBKdPog=
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: dmitry.baryshkov@linaro.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <e955b706-04dd-479f-8327-32771d94f70f@linux.dev>
Date: Thu, 16 May 2024 18:40:45 +0800
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
 <2c15c859-6b2b-4979-8317-698bf6cc430c@linux.dev>
 <20240516-intrepid-uptight-tench-0df95e@penduick>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240516-intrepid-uptight-tench-0df95e@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 5/16/24 16:25, Maxime Ripard wrote:
> On Wed, May 15, 2024 at 11:19:58PM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>>
>> On 5/15/24 22:58, Maxime Ripard wrote:
>>> On Wed, May 15, 2024 at 10:53:00PM +0800, Sui Jingfeng wrote:
>>>> On 5/15/24 22:30, Maxime Ripard wrote:
>>>>> On Wed, May 15, 2024 at 12:53:33AM +0800, Sui Jingfeng wrote:
>>>>>> On 2024/5/15 00:22, Maxime Ripard wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Tue, May 14, 2024 at 11:40:43PM +0800, Sui Jingfeng wrote:
>>>>>>>> Because a lot of implementations has already added it into their drived
>>>>>>>> class, promote it into drm_bridge core may benifits a lot. drm bridge is
>>>>>>>> a driver, it should know the underlying hardware entity.
>>>>>>> Is there some actual benefits, or is it theoretical at this point?
>>>>>>
>>>>>>
>>>>>> I think, DRM bridge drivers could remove the 'struct device *dev'
>>>>>> member from their derived structure. Rely on the drm bridge core
>>>>>> when they need the 'struct device *' pointer.
>>>>>
>>>>> Sure, but why do we need to do so?
>>>>>
>>>>> The other thread you had with Jani points out that it turns out that
>>>>> things are more complicated than "every bridge driver has a struct
>>>>> device anyway", it creates inconsistency in the API (bridges would have
>>>>> a struct device, but not other entities), and it looks like there's no
>>>>> use for it anyway.
>>>>>
>>>>> None of these things are deal-breaker by themselves, but if there's only
>>>>> downsides and no upside, it's not clear to me why we should do it at all.
>>>>
>>>> It can reduce boilerplate.
>>>
>>> You're still using a conditional here.
>>
>> It's for safety reason, prevent NULL pointer dereference.
>> drm bridge can be seen as either a software entity or a device driver.
>>
>> It's fine to pass NULL if specific KMS drivers intend to see
>> drm bridge as a pure software entity, and for internal use only.
>> Both use cases are valid.
> 
> Sorry, I don't follow you. We can't NULL dereference a pointer that
> doesn't exist.
> 
> Please state why we should merge this series: what does it fix or
> improve, aside from the potential gain of making bridges declare one
> less pointer in their private structure.

We could reduce more.

Bridge driver instances also don't have to embed 'struct i2c_client *'. 
We could use 'to_i2c_client(bridge->dev)' to retrieve the pointer,
where needed.

> Maxime

-- 
Best regards
Sui

