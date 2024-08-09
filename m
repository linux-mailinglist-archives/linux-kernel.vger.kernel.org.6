Return-Path: <linux-kernel+bounces-281413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CACA94D6BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54B21F21D67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6B015534B;
	Fri,  9 Aug 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YmRVIDw7"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A02F56
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229713; cv=none; b=mB8Pftd9UFvIlNjEEmZxL7DBjkne5KzvgGPqhFOUlaCFZZWZCevjZvH9O4nPqKE4unMdbm1s1Z1oI6h9+Ef2wFBGe5tPeQ9htdY4D84hpZ7Qg8Pc9OJO1MFNKMJYl7DObURy1DH/dcbg4jxoqi4owB8b+AtWl+E5ag5prk4sxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229713; c=relaxed/simple;
	bh=qgjuph52eRvfDq1ToYpn0f0xaQspvyDA3cJbwJ1G7mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6nGbYO8Ks+VxyFBRwhh/wBlCUSCT+0WJaAY/UDlpYqBbDfqEQdQcUsfiA/u42wqv1mZebZe+obyQOaWIS6/WUjhpUS4Zn9GemXUrzu+DS5acPCo12Fq5dhrFp4G18vtHOhHxGRW7kPjP2l0g0u3C7L9X1uadkJksk3/1e63PRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YmRVIDw7; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <98826ab8-856a-4bd6-ae8b-bbfce945bdf4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723229708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JocOi7P3PjNGxJXi85Ya63UzzmF3ct3nIXqmRfsseYc=;
	b=YmRVIDw7k2/37Z6EOMldslDBm4DczE3AbIQt9+QBJSgTTso7Hoy7CYBO8ID5Nh8CRMQ7RR
	XrGcgKsfmndxddCmO+f1WRhvLFSuFWfKNND0ez9JAsKk2IqPIa3sEJqWedDuPxe+t73UMd
	vwaeYadfizEmSt34bODbewXhiMlsi5E=
Date: Fri, 9 Aug 2024 14:55:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/10] drm: zynqmp_dp: IRQ cleanups and debugfs support
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240503192922.2172314-1-sean.anderson@linux.dev>
 <e5ca9be5-2918-427a-b7eb-28f1915b5d31@ideasonboard.com>
 <5c5aa8ae-75c4-4f0f-ad19-50ad57c61216@linux.dev>
 <f44fd8f1-2e65-4cdd-b6ba-49398f5d8c7c@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <f44fd8f1-2e65-4cdd-b6ba-49398f5d8c7c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/8/24 08:46, Tomi Valkeinen wrote:
> Hi Sean,
> 
> On 17/06/2024 17:48, Sean Anderson wrote:
>> On 6/17/24 03:47, Tomi Valkeinen wrote:
>>> Hi Sean,
>>>
>>> On 03/05/2024 22:29, Sean Anderson wrote:
>>>> This series cleans up the zyqnmp_dp IRQ and locking situation. Once
>>>> that's done, it adds debugfs support. The intent is to enable compliance
>>>> testing or to help debug signal-integrity issues.
>>>>
>>>> Last time I discussed converting the HPD work(s) to a threaded IRQ. I
>>>> did not end up doing that for this series since the steps would be
>>>>
>>>> - Add locking
>>>> - Move link retraining to a work function
>>>> - Harden the IRQ
>>>> - Merge the works into a threaded IRQ (omitted)
>>>>
>>>> Which with the exception of the final step is the same as leaving those
>>>> works as-is. Conversion to a threaded IRQ can be done as a follow-up.
>>>
>>> I tested this, and the "drm: zynqmp_dp: Convert to a hard IRQ" causes a hang for me when unloading the drivers. Unfortunately I'm not in the condition to debug it at the moment.
>>>
>>> I have picked the first three patches into drm-misc-next, though, to decrease the number of patches in the series a bit. They looked independent and safe enough to apply.
>>
>> Are you running into [1]?
>>
>> --Sean
>>
>> [1] https://lore.kernel.org/dri-devel/4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev/
>>
> 
> No. Afaics, it breaks because the irq handler is requested with IRQF_SHARED, and that means the handler can be called at any time. The handler reads DP registers, but the DP IP could already be powered off.
> 
> You'll probably see it easily if you enable CONFIG_DEBUG_SHIRQ, and unload the module or unbind the device.

Ah, looks like I need to use devm_free_irq instead of disable_irq.

And after fixing this, [1] turns up again. I guess I'll take a crack at it...

--Sean


