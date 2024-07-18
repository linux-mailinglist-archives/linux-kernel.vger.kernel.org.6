Return-Path: <linux-kernel+bounces-256313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57B934C57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA921C2190A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E213210D;
	Thu, 18 Jul 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eRVtoGyN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725821BF37
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301792; cv=none; b=iqJ7HybMYdLuvhzKWOw6s8aSG41AqJZ3Uw/5NXnopADlXqhKfn0JkHPnYhW5Ijh1J6G8gSG8Twmwu1fI/gyicWu9RCvJAR9tkkBOR7rPxU9vO21ZqINN6eFkRHF1RmwJYbCzlRLDMbaiLUGaaa4uknZz46iAP4KE9ytWN4NQksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301792; c=relaxed/simple;
	bh=Rhu+ivLN8i4cGGfuNKe45o1pJKIStecWgDqToMVnLUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtU5FKR//txGhSbvajkF9cz+W+PESnpnxsJp0O/CdQnPjDOkYkv/iwPP8RK/Zq5zX6RNAhl4aGsENPi1M2ha8fv5B478yv3XTHVQ3uaCYbR05/LRTUctL7Gbgp0B2/3cVnxxckfwLy0Gr6RursTBka4pOtKJ6M9SIcClIFNKTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eRVtoGyN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721301787;
	bh=Rhu+ivLN8i4cGGfuNKe45o1pJKIStecWgDqToMVnLUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eRVtoGyNQfsWeg4dFxpH5wAPa+R0323lbfRdSK23/AWBENSv+IAO3XPjSge9THc/E
	 PZqHjs4HABtU3UnGe0EYzgLA+quFty+o7HbaYM2ueuBQj/5vOKc2M2FXZidiTnCaU1
	 lf5JhkTpiidnrL8ssxsLdxAivJhW0mij2wPJzPeDrVWRNno4+ZpKrxpCARnFrEEYbw
	 s/JHlZ7qhswD4XVdqDl8KEh5CQjt8zqnTceRAKP2if5Op5phQV3RuBJBDJEnDi0BWR
	 M0ibod+QQlL4Pu/12Y9YGAq53aIJJFDv+RZl/3iYWfsqjpuTRdASZYbUQCyfkV/v+Q
	 gGySo5cAKzTbQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A5FBB378202D;
	Thu, 18 Jul 2024 11:23:06 +0000 (UTC)
Message-ID: <d6f20609-5127-4010-b691-40cd3b253283@collabora.com>
Date: Thu, 18 Jul 2024 13:23:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Set sensible cursor width/height values to
 fix crash
To: Daniel Stone <daniel@fooishbar.org>
Cc: Fei Shao <fshao@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>,
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, shawn.sung@mediatek.com,
 ck.hu@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240718082410.204459-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GBg73kWuiDt=9s7M4oJeHhWOF3bPY7Ju+qn1kJgNNaGw@mail.gmail.com>
 <CAC=S1nigoJWAECBrm-Q=Co1-qd_yUhx3R4D9=dYeUV=gr5UYfQ@mail.gmail.com>
 <74e7477b-81c7-4713-80cc-1cb476185bc9@collabora.com>
 <CAPj87rPZRjmMPjaOY-UH4auTuMS6mh9N7=maRBzxut2OgtALbw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAPj87rPZRjmMPjaOY-UH4auTuMS6mh9N7=maRBzxut2OgtALbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/07/24 13:10, Daniel Stone ha scritto:
> Hi all,
> 
> On Thu, 18 Jul 2024 at 11:24, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 18/07/24 11:27, Fei Shao ha scritto:
>>> This matches my preference in [1], so of course I'd like to see it
>>> merged... if maintainers are okay with it.
>>> Given I've tested the exact same change before:
>>> Reviewed-by: Fei Shao <fshao@chromium.org>
>>> Tested-by: Fei Shao <fshao@chromium.org>
>>
>> Thanks!
> 
> And:
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> 
>>>> OOTH, Intel recently added a feature for enumerating "suggested"
>>>> cursor sizes. See https://patchwork.freedesktop.org/patch/583299/
>>>>
>>>> Not sure if other compositors will end up using it or not.
>>
>> Yeah, that's good, and we might do that as well in MediaTek DRM... in a slightly
>> different way, as it looks like they are simply hinting the same values as the
>> mode_config is declaring... while we'd be adding a hint with a sensible size that
>> is less than the maximum supported one from the overlay.
>>
>> In reality, here, the issue is that the most popular compositors do not support
>> overlay planes (as in, they don't use them at all)... my first idea was to remove
>> the CURSOR plane entirely and declare it as per what it is for real (an OVERLAY),
>> but that would only give a performance penalty as that'd become yet another unused
>> plane and nothing else.
>>
>> If at least the most popular compositors did support overlay planes, I'd have done
>> that instead... but oh, well!
>>
>> And anyway I hope that the maintainers are okay with this because, well, otherwise
>> MediaTek SoCs won't be usable with any popular WM.
> 
> Every compositor is going to use it, yeah. But until it does, people
> are just going to use cursor_width and cursor_size. A lot of older
> desktop hardware supports only a single fixed dimension for the cursor
> plane (hence the single values), so rather than guess if it needs to
> be 32x32 or 64x64 or whatever, people just allocate to the size. Not
> to mention that the old pre-atomic cursor ioctls actually require that
> you allocate for cursor_width x cursor_height.
> 
> So yeah, this is the right fix - though you could even be more
> aggressive and reduce it to 256x256 - and supporting the CURSOR_SIZE
> property would be even more useful again.
> 

I thought about being more aggressive, but then I saw that IGT tests for up to 512
and that MSM also declares the same, so, making IGT happy because we can indeed
support that much (since we can support even more, but doesn't make sense) :-)

Regarding CURSOR_SIZE ... right, I can take a look at that a bit later, most
probably not for this merge window, though.

Cheers!

> Cheers,
> Daniel



