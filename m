Return-Path: <linux-kernel+bounces-257124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8651793759E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22BD1C21A29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F980038;
	Fri, 19 Jul 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VdOah8/+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671180617
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380815; cv=none; b=uj2/+nA3S8q+BJiW/wjw0MncdbxSIxePBTm7EWIsCbXAc82SaZbYCt+QwPS5khyEvSw145O3HCXftL3T5OT4PWYaK/+2xTYEloaeIcVsR2/RdISMq5M4FYqGQ/QTQTq5MRzYj25+rv/0u9OlVbgrskc0ZAkTZnGoFmJvt1hv7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380815; c=relaxed/simple;
	bh=yAETZC0ppWDyfmBdfHX8Kz6iCIh8buKJ8L4qqK40C4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmnqzfSwEkJf38RyZUFRftSuJo9rkyhWwBIEOkkNn4tWGpdGJgwsoPwl6+EYHV7uGfOUJmoCDTivs3IYqDN5nkMtajfueHqQt1klhRkCDZ4HSDxI7V0S10hnTIqEk/82Ggt59LxjEv8qTWpVEIqEkLHb6GVjViqJjfhloAewxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VdOah8/+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721380805;
	bh=yAETZC0ppWDyfmBdfHX8Kz6iCIh8buKJ8L4qqK40C4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VdOah8/+V/XtUxxIeVO4oIpiIH0uCMgVd99oNApZzhhpP3jQV5Kljtp9IeuvGwNXB
	 e2skTMRVBepNfeZO52MHmQMCeVo/k3JiAnLmji+QAvdPtChjV5azSSkVAsWW4XnYbv
	 U7LIw1ghoUkOPUzSPRgCwacR5Qiy8O4/6hFQEE5V773FAd5HLYJ/DNigf9qQyGFm3b
	 pHHNxN/cR4drlZg5v2+6rYcKBy/I1fBMnPpbqb5zIspHImL1NM4apEP0CITd0p1d/B
	 UeeSScaI2QHoygyMFiMCa9mnxInK/BXRnQe8X8ehq8RDyVU27h5otNIM6T1BY9biSW
	 PGjRwfbOlrPCg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D57D73782063;
	Fri, 19 Jul 2024 09:20:04 +0000 (UTC)
Message-ID: <c5ba072f-5a38-4faf-9b8f-906bc896881d@collabora.com>
Date: Fri, 19 Jul 2024 11:20:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Set sensible cursor width/height values to
 fix crash
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "daniel@fooishbar.org" <daniel@fooishbar.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "fshao@chromium.org" <fshao@chromium.org>
References: <20240718082410.204459-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GBg73kWuiDt=9s7M4oJeHhWOF3bPY7Ju+qn1kJgNNaGw@mail.gmail.com>
 <CAC=S1nigoJWAECBrm-Q=Co1-qd_yUhx3R4D9=dYeUV=gr5UYfQ@mail.gmail.com>
 <74e7477b-81c7-4713-80cc-1cb476185bc9@collabora.com>
 <CAPj87rPZRjmMPjaOY-UH4auTuMS6mh9N7=maRBzxut2OgtALbw@mail.gmail.com>
 <d6f20609-5127-4010-b691-40cd3b253283@collabora.com>
 <e74e25b01f85fb33d95e073f18a8049288b5c70d.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e74e25b01f85fb33d95e073f18a8049288b5c70d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 19/07/24 10:42, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Thu, 2024-07-18 at 13:23 +0200, AngeloGioacchino Del Regno wrote:
>> Il 18/07/24 13:10, Daniel Stone ha scritto:
>>> Hi all,
>>>
>>> On Thu, 18 Jul 2024 at 11:24, AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>> Il 18/07/24 11:27, Fei Shao ha scritto:
>>>>> This matches my preference in [1], so of course I'd like to see it
>>>>> merged... if maintainers are okay with it.
>>>>> Given I've tested the exact same change before:
>>>>> Reviewed-by: Fei Shao <fshao@chromium.org>
>>>>> Tested-by: Fei Shao <fshao@chromium.org>
>>>>
>>>> Thanks!
>>>
>>> And:
>>> Reviewed-by: Daniel Stone <daniels@collabora.com>
>>>
>>>>>> OOTH, Intel recently added a feature for enumerating "suggested"
>>>>>> cursor sizes. See https://urldefense.com/v3/__https://patchwork.freedesktop.org/patch/583299/__;!!CTRNKA9wMg0ARbw!nRf6mf-9tnE7vLYracLE6Xq_oblRvtENffF73fRzgz_E3zPc3yxeQPE5yPw95sj-ZeoiYJCQSIPWFZ0C3HCXpBkHikWK$
>>>>>>
>>>>>> Not sure if other compositors will end up using it or not.
>>>>
>>>> Yeah, that's good, and we might do that as well in MediaTek DRM... in a slightly
>>>> different way, as it looks like they are simply hinting the same values as the
>>>> mode_config is declaring... while we'd be adding a hint with a sensible size that
>>>> is less than the maximum supported one from the overlay.
>>>>
>>>> In reality, here, the issue is that the most popular compositors do not support
>>>> overlay planes (as in, they don't use them at all)... my first idea was to remove
>>>> the CURSOR plane entirely and declare it as per what it is for real (an OVERLAY),
>>>> but that would only give a performance penalty as that'd become yet another unused
>>>> plane and nothing else.
>>>>
>>>> If at least the most popular compositors did support overlay planes, I'd have done
>>>> that instead... but oh, well!
>>>>
>>>> And anyway I hope that the maintainers are okay with this because, well, otherwise
>>>> MediaTek SoCs won't be usable with any popular WM.
>>>
>>> Every compositor is going to use it, yeah. But until it does, people
>>> are just going to use cursor_width and cursor_size. A lot of older
>>> desktop hardware supports only a single fixed dimension for the cursor
>>> plane (hence the single values), so rather than guess if it needs to
>>> be 32x32 or 64x64 or whatever, people just allocate to the size. Not
>>> to mention that the old pre-atomic cursor ioctls actually require that
>>> you allocate for cursor_width x cursor_height.
>>>
>>> So yeah, this is the right fix - though you could even be more
>>> aggressive and reduce it to 256x256 - and supporting the CURSOR_SIZE
>>> property would be even more useful again.
>>>
>>
>> I thought about being more aggressive, but then I saw that IGT tests for up to 512
>> and that MSM also declares the same, so, making IGT happy because we can indeed
>> support that much (since we can support even more, but doesn't make sense) :-)
>>
>> Regarding CURSOR_SIZE ... right, I can take a look at that a bit later, most
>> probably not for this merge window, though.
> 
> This patch looks acceptable but it could be better.
> It's urgent to fix the crash, if better solution does not come out soon,
> I would apply this patch first.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> 
> I will remove the Fixes tag because Shawn's patch has no logical problem but the system resource is not enough.
> 
> It's a dilemma that small size has no resource problem but application is limited
> and large size has resource problem but support more application.
> 

Thanks, but the Fixes tag is important, as otherwise v6.11 will be unusable :-)

Regards,
Angelo

> Regards,
> CK
> 
>>
>> Cheers!
>>
>>> Cheers,
>>> Daniel
>>
>>


