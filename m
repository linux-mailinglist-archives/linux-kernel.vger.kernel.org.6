Return-Path: <linux-kernel+bounces-182045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB008C8586
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254BA1F22167
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364AF3D576;
	Fri, 17 May 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2OD+hhn9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5233B78B
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945007; cv=none; b=GVOaB+Nl+EDzPyBINuAS7HQLwHBY5zK02Sxj7HmE8GP+8VaMCgrgimx0cSvBVV++xKEefSfZZRZ6EkV5wZ8xnkT2pTovypcgB5AF/JEDrdiZ7K2gOjpReJz1Y1pEATeaBSiDwKHauo7ch94NXpqlHy1cTUlPN1jtqNTvlg2qUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945007; c=relaxed/simple;
	bh=t1oRx5quleIZIXruOJvRYEzRTKhRag7Aj8Fnm51J3kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvVkBv2iuvKTbeuf/TCWGwKK9ajvz9JwRLgNY8SmbVmRw2EYFdp9sYhrZMk0+lD5z3ZU9KaefEx3m2U2nQTD9+nZr0mBoh2KR01PJnLyOtUaoL6WsUX5VXHeTYjGEJlI/hf5W6XNZsi91byeqhgvhbS8SOwXglOgD2SbPTe4w7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2OD+hhn9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715945004;
	bh=t1oRx5quleIZIXruOJvRYEzRTKhRag7Aj8Fnm51J3kM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2OD+hhn9SW30Ydu2LGewa9jzaESmHUxXrkr6SlPCRV/WKO52/YU3erv82twMgl6jd
	 waq6Kfi1E+O8RJTeThqg+6nIvh+3yzcqcPwaiDJ+/gx8I96WmeW/+8beC5M/hWStfy
	 uxNLCv8pkW2Qeor+69gghAnSjOkqRMCc+FnHzCVI6Lvjp2o/2twpw5aOFN1hB4t+Ng
	 +Xf2M+25tZrk4k3Y5agl7SLQs1dNpU5Hy+WTCvSufIJPRu3aRrlRdtxlOK7VDFjQbn
	 8GwmUXZJEWrKW/+y5V5oSysosvm8vtbqiTKmJ5r1HciVkkBYgrnsRLuH9YmIXDIciP
	 MkbeFu6BLjsyw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 60B3537821B5;
	Fri, 17 May 2024 11:23:23 +0000 (UTC)
Message-ID: <af6cad98-fde0-440d-8d26-05045387df08@collabora.com>
Date: Fri, 17 May 2024 13:23:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek/dp: fix spurious kfree()
To: Michael Walle <mwalle@kernel.org>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Chen-Yu Tsai <wenst@chromium.org>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240517093024.1702750-1-mwalle@kernel.org>
 <de0191f3-271b-4f0e-aa73-910543587c9d@collabora.com>
 <D1BVE3G40OVL.3KX13LU75M122@kernel.org>
 <0d8f89d4-e16e-4c8d-b983-38df8fcc387e@collabora.com>
 <D1BVPABXTSPH.22ML1GLOMHEJR@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <D1BVPABXTSPH.22ML1GLOMHEJR@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/05/24 13:21, Michael Walle ha scritto:
> On Fri May 17, 2024 at 1:09 PM CEST, AngeloGioacchino Del Regno wrote:
>> Il 17/05/24 13:07, Michael Walle ha scritto:
>>> On Fri May 17, 2024 at 12:35 PM CEST, AngeloGioacchino Del Regno wrote:
>>>> Il 17/05/24 11:30, Michael Walle ha scritto:
>>>>> drm_edid_to_sad() might return an error or just zero. If that is the
>>>>> case, we must not free the SADs because there was no allocation in
>>>>> the first place.
>>>>>
>>>>> Fixes: dab12fa8d2bd ("drm/mediatek/dp: fix memory leak on ->get_edid callback audio detection")
>>>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>>>> ---
>>>>>     drivers/gpu/drm/mediatek/mtk_dp.c | 10 ++++++++--
>>>>>     1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
>>>>> index 536366956447..ada12927bbac 100644
>>>>> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
>>>>> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
>>>>> @@ -2073,9 +2073,15 @@ static const struct drm_edid *mtk_dp_edid_read(struct drm_bridge *bridge,
>>>>>     		 */
>>>>>     		const struct edid *edid = drm_edid_raw(drm_edid);
>>>>>     		struct cea_sad *sads;
>>>>> +		int ret;
>>>>>     
>>>>> -		audio_caps->sad_count = drm_edid_to_sad(edid, &sads);
>>>>> -		kfree(sads);
>>>>> +		ret = drm_edid_to_sad(edid, &sads);
>>>>> +		/* Ignore any errors */
>>>>> +		if (ret < 0)
>>>>> +			ret = 0;
>>>>> +		if (ret)
>>>>
>>>> Eh, this will never work, because you're clearing the error before checking
>>>> if there's any error here?!?! :-P
>>>
>>> Don't get what you mean? Yes, I'm ignoring the error. Thus, in case
>>> of an error ret will be zero and there will be no free. If ret was
>>> zero, there won't be a free either. So you're left with the "normal"
>>> case, where you have to free the sads. Just like before.
>>>
>>>> Anyway in reality, it returns -ENOMEM if the allocation was not successful...
>>>> in the event that any future update adds any other error we'd be back with the same
>>>> issue, but I'm not sure how much should we worry about that.
>>>>
>>>> To be extremely safe, we could do...
>>>>
>>>> if (ret != -ENOMEM)
>>>> 	kfree(sads)
>>>>
>>>> audio_caps->sad_count = ret < 0 ? 0 : ret;
>>>
>>> Which is the same as above, but you only check for ENOMEM?
>>>
>>
>> Yes, the point is to avoid kfree(sads) for -ENOMEM only, as other errors that may
>> be introduced later might still allocate it and leave it allocated.
> 
> Honestly, I doubt that any sane function will allocate memory, then
> return an error and expect the caller to free it.
> 

My point was "you never know". But that wasn't a strong opinion anyway.

It's ok for me regardless of what you choose, either follow what I said or don't,
the end result is the same, you're still fixing the issue and both ways are
acceptable, so...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


