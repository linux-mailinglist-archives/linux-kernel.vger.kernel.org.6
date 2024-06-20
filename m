Return-Path: <linux-kernel+bounces-222430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52834910172
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9467282400
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C191AAE04;
	Thu, 20 Jun 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JwAxtL4D"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E91EA91;
	Thu, 20 Jun 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879225; cv=none; b=DDBiHH+zySmjaJmmzRiHOQPdFlZIIVs+UDR2BD9RgugdMzbQNP61u7lW+bNQ5xoj1YT1qdMl+jRwdIwE0P6KLhxENEI+8bp2FkpU+EZ+rBesFfM5QXEn8nRZq4kaM9LABx7JquEQKwYE6V2k0hzLG+drfr7WTaT/YkPzf9G1BaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879225; c=relaxed/simple;
	bh=MDwHYzc+sSlTWkT2rzpeIoOGVSVCib30Bhl9mdbk5R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aq3kXGDZ+vcebHvM3UwgaAEqShx7+bNFkg+llrQzuOm3QP674x7szlu31iNcz7+ydmGWcNU1wyApaznv8uXazjKhf024+7Rya4cq2UplcD+8eFhTKkWFg5N6VC8patm3bQcJbzwOuc5rXeQJfprg1HFeITI7IAK2pnwzkcWoFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JwAxtL4D; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718879222;
	bh=MDwHYzc+sSlTWkT2rzpeIoOGVSVCib30Bhl9mdbk5R8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JwAxtL4DZSYlvz9FRg+aflJ3XNf4s0cUBbBLbl1vMvOi0PX7/oRVnmVgG04dTst+E
	 FpGMpsy7H9OYgMd3+3DfpO5u3h/w85co3skjyHsZxK7ZemlqghEP8rN/tbbgB8vyPH
	 R/efrvkdAfnfg9CmcAiRCiHbxUB1Z4LIQ7n6sTau/ft2nPRqUA8yBFIDvPrCxi7Vbc
	 dI5R07TQaPgUeB4RIc8jgqEeBR74u3+zyis3bHbcPZhsfxKB07WEj+RCKyltbYitaH
	 OLqZed51xGYPGWFKBxiSRv/7o3GKa1vNbIfeALHcny6t6dYyYuFSE+aRhyIAZmhxfF
	 gNmyxsmQAHEEQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AAA473780698;
	Thu, 20 Jun 2024 10:27:01 +0000 (UTC)
Message-ID: <35047932-65d0-44ae-98e1-b4c771be0e6b@collabora.com>
Date: Thu, 20 Jun 2024 12:27:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Re-add codec entry for
 ETDM1_OUT_BE dai link
To: Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Trevor Wu <trevor.wu@mediatek.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240620092526.2353537-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240620092526.2353537-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/06/24 11:25, Chen-Yu Tsai ha scritto:
> This partially reverts commit e70b8dd26711704b1ff1f1b4eb3d048ba69e29da.
> 
> Said commit removes the codec entry for the ETDM1_OUT_BE dai link for
> some reason. This does not have the intended effect, as the remaining
> DAILINK_COMP_ARRAY(COMP_EMPTY()) platform entry becomes the codec
> entry, and the platform entry is completely gone.
> 
> This causes in a KASAN out-of-bounds warning in mtk_soundcard_common_probe()
> in sound/soc/mediatek/common/mtk-soundcard-driver.c:
> 
> 	for_each_card_prelinks(card, i, dai_link) {
> 		if (adsp_node && !strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")))
> 			dai_link->platforms->of_node = adsp_node;
> 		else if (!dai_link->platforms->name && !dai_link->platforms->of_node)
> 			dai_link->platforms->of_node = platform_node;
> 	}
> 
> where the code expects the platforms array to have space for at least one entry.
> 
> Re-add the entry so that dai_link->platforms has space.
> 

Ok, but wait a minute... the commit that you're pointing at in the Fixes tag is
a commit that fixes a problem identified in commit

13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_DUMMY()")

to keep it short, after that one, without removing the COMP_DUMMY(), the audio
was broken in .. some way, I don't currently remember specifically what was
happening, but I had no sound at all.

If the problem is not showing up anymore, backporting this commit to the kernels
kernels affected by the issue that I solved... will break sound!

So... well.. that's the "some reason".... :-)

Cheers,
Angelo

> Fixes: e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai component and rework codec link")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   sound/soc/mediatek/mt8195/mt8195-mt6359.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> index ca8751190520..2832ef78eaed 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> @@ -827,6 +827,7 @@ SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
>   
>   SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
>   		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
>   		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
>   
>   SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,


