Return-Path: <linux-kernel+bounces-256261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0528D934B97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE651C21C65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C08286D;
	Thu, 18 Jul 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lm/u3WpG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD841EA74
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298284; cv=none; b=fIRq5PH3I6ewu3cAihLxKGNHM6J9SvTXHM7lahs1cspmFg0ZvIJQkHz/VgQFAWuVcxxnSdCEdcfzVGVIsB5/IXej8NW37neEkCWHIvFeqmimJbnE6rbfeEqYVFHchiNHdsxWmDLIMtYb7FL+yS6zHLdf3DMIGeAVKdtuJjg81jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298284; c=relaxed/simple;
	bh=VfGA0MNPDxpzY3+7gxwzo8OvFAauh4Lp07OuvQvJc64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7X74YemrrDh3JQNBqwCCPSkMNAIKylqcVF5cX4pN5FpyMnOI47eDVx7G5PedCNxTflt0o5pcCvNif476Gf0BRyhobi+r/ISx2KZhBQ7LRiiIFJw2Pyi+lz71OYFc1eudW9o/2SIMtjMt0AlfRgJ7dhw3xa2iwIn79JZWW0vQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lm/u3WpG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721298280;
	bh=VfGA0MNPDxpzY3+7gxwzo8OvFAauh4Lp07OuvQvJc64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lm/u3WpGxs2VcAayIMBmt6INiXYpVfQnbDc0FwxQl/I5JRVORgK3dCNj5KRzSb7vV
	 cg+HV9vwO3DdMUh5WiEO2dG0YlXO/V0WCQwjUcv/i32WSw+fzF4VhzImrRzLyEmYTi
	 GBbmvMW+/IHm+AjbkUxqXODBc+2en/EzF4Z3AzIJPUHFPDG7jt1GfyhxD/5By8rt8K
	 /RN+F48ILmBFl5l8oLSckGeKNKafYx1D+TBIZAOVEzO8K7U/A6edUU14F8E6pQfR8g
	 +D+w6irDgFgB9ko57cLxQGB4qLGbWmQDSUbuUwyKxA2QLVpHQna3iZW9ZOvnSD1kQH
	 EpS2rBPxk0XzA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D66BE37813D3;
	Thu, 18 Jul 2024 10:24:39 +0000 (UTC)
Message-ID: <74e7477b-81c7-4713-80cc-1cb476185bc9@collabora.com>
Date: Thu, 18 Jul 2024 12:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Set sensible cursor width/height values to
 fix crash
To: Fei Shao <fshao@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, shawn.sung@mediatek.com,
 ck.hu@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240718082410.204459-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GBg73kWuiDt=9s7M4oJeHhWOF3bPY7Ju+qn1kJgNNaGw@mail.gmail.com>
 <CAC=S1nigoJWAECBrm-Q=Co1-qd_yUhx3R4D9=dYeUV=gr5UYfQ@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAC=S1nigoJWAECBrm-Q=Co1-qd_yUhx3R4D9=dYeUV=gr5UYfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/07/24 11:27, Fei Shao ha scritto:
> On Thu, Jul 18, 2024 at 4:49 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> (CC-ed Fei Shao)
>>
>> On Thu, Jul 18, 2024 at 4:24 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Hardware-speaking, there is no feature-reduced cursor specific
>>> plane, so this driver reserves the last all Overlay plane as a
>>> Cursor plane, but sets the maximum cursor width/height to the
>>> maximum value that the full overlay plane can use.
>>>
>>> While this could be ok, it raises issues with common userspace
>>> using libdrm (especially Mutter, but other compositors too) which
>>> will crash upon performing allocations and/or using said cursor
>>> plane.
>>>
>>> Reduce the maximum width/height for the cursor to 512x512 pixels,
>>> value taken from IGT's maximum cursor size test, which succeeds.
>>>
>>> Fixes: a4c9410b31ca ("drm/mediatek: Set DRM mode configs accordingly")
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> index 6f0b415a978d..b96763664c4f 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> @@ -540,8 +540,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>>>          }
>>>
>>>          /* IGT will check if the cursor size is configured */
>>> -       drm->mode_config.cursor_width = drm->mode_config.max_width;
>>> -       drm->mode_config.cursor_height = drm->mode_config.max_height;
>>> +       drm->mode_config.cursor_width = 512;
>>> +       drm->mode_config.cursor_height = 512;
>>
>> Fei already did the same (?) workaround downstream just recently.

Heh, didn't know that :-D

> 
> Well, so another userspace gets confused...
> I actually sent a separate userspace (i.e. Chrome) fix where I
> encountered the issue, so I didn't proceed with upstreaming it in the
> end.
> 

Actually, there is a specific recipe that doesn't trigger this bug, that's why
I couldn't trigger it when reviewing the patch that was introducing it; if you
use a module instead of built-in, and insert it right after Panfrost, then you
will get stuff working - but with a performance penalty (and I upgraded my system
right before testing this patch, so I thought it happened because of the upgrade
and not because of this one).

After some more upgrades here and there, and seeing that I was on X11 and not
Wayland as usual, I was able to trigger this bug in any and every condition...

> This matches my preference in [1], so of course I'd like to see it
> merged... if maintainers are okay with it.
> Given I've tested the exact same change before:
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Tested-by: Fei Shao <fshao@chromium.org>
> 

Thanks!

> [1]: https://lore.kernel.org/all/CAC=S1nhKPo5BUYJ_cHGz3OoPrWNh5eO8rhdyikLimsqSOrZ5Xg@mail.gmail.com/
> 
> Regards,
> Fei
>>
>> OOTH, Intel recently added a feature for enumerating "suggested"
>> cursor sizes. See https://patchwork.freedesktop.org/patch/583299/
>>
>> Not sure if other compositors will end up using it or not.

Yeah, that's good, and we might do that as well in MediaTek DRM... in a slightly
different way, as it looks like they are simply hinting the same values as the
mode_config is declaring... while we'd be adding a hint with a sensible size that
is less than the maximum supported one from the overlay.

In reality, here, the issue is that the most popular compositors do not support
overlay planes (as in, they don't use them at all)... my first idea was to remove
the CURSOR plane entirely and declare it as per what it is for real (an OVERLAY),
but that would only give a performance penalty as that'd become yet another unused
plane and nothing else.

If at least the most popular compositors did support overlay planes, I'd have done
that instead... but oh, well!

And anyway I hope that the maintainers are okay with this because, well, otherwise
MediaTek SoCs won't be usable with any popular WM.

Cheers!
Angelo

>>
>> ChenYu
>>
>>>          /* Use OVL device for all DMA memory allocations */
>>>          crtc = drm_crtc_from_index(drm, 0);
>>> --
>>> 2.45.2
>>>


