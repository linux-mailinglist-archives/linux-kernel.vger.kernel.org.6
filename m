Return-Path: <linux-kernel+bounces-226791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F789143CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37010282217
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F44594D;
	Mon, 24 Jun 2024 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kppcXub/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142C4436E;
	Mon, 24 Jun 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214767; cv=none; b=avheLYdd26tsOerySkA4jZ1A8YDiutX1F5pClqZEFEmSo173WITO6YayXjXVHbJSa+TCqF6m1D+3Zonl/he/0u8Jx5J4JHZR3Dsem01OfFPkFjNXCVVc66b/gIHmer0sgZmops81HlfN0SgMXdPVg6XLsfoYuuB0w8E/UI/NywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214767; c=relaxed/simple;
	bh=V+/MuvOB5oRpHrUXIua2jOm8NVL5toa1d2l3vx43fvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1k312EUmTS8FDb+ao7wFf0wpecC5VlhnTSEUptUdA3+PBIh1pW+IvEwizcy3HE5sCgbdj3hP0CQHv9HhfxEtotywNHbZAdaB52CTRpzOotw1Mqr0ZyGjtgD3dBIPmtJEQSgRqdSbqTtfqnTB5AIMYSst7CvyXBz75ziQEMx5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kppcXub/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719214758;
	bh=V+/MuvOB5oRpHrUXIua2jOm8NVL5toa1d2l3vx43fvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kppcXub/wGYVKDXZW9lsyJvZlE+MHw94Ab2zNNosm0jdkPczLSeXIa1mX4CnB0TH3
	 Yb4E0vqO3PjC9VKzOt94QYra2asAz1mEXL6qdPrzeUV6k0kfkfIAGNjjidmDutXjkx
	 jsSsLzOtK/Ei0/dHmSjjlfMHlGaNxutpfeWUPXqGmg70DzoOe7p/L/gO5rcfofNGCh
	 UzEFxUwjQIZ9Xr2d5UaBFjQ0XqYnx37U/cIJpHRFV5DMamkEVIJW4boJpkbktShAqi
	 j78oPgSc40mkbwC6rOjvnJXUWGPueXDg5W3arSGPIQptFoOFBh/14pPeR9ZJ4u2DAC
	 PqUdQOigkcQHA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 950BA378216B;
	Mon, 24 Jun 2024 07:39:17 +0000 (UTC)
Message-ID: <aefe76a3-5712-4e34-8990-0463a5036324@collabora.com>
Date: Mon, 24 Jun 2024 09:39:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: mediatek: mt8195: Add platform entry for
 ETDM1_OUT_BE dai link
To: Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Trevor Wu <trevor.wu@mediatek.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240624061257.3115467-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240624061257.3115467-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/06/24 08:12, Chen-Yu Tsai ha scritto:
> Commit e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai component
> and rework codec link") removed the codec entry for the ETDM1_OUT_BE
> dai link entirely instead of replacing it with COMP_EMPTY(). This worked
> by accident as the remaining COMP_EMPTY() platform entry became the codec
> entry, and the platform entry became completely empty, effectively the
> same as COMP_DUMMY() since snd_soc_fill_dummy_dai() doesn't do anything
> for platform entries.
> 
> This causes a KASAN out-of-bounds warning in mtk_soundcard_common_probe()
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
> Add an COMP_EMPTY() entry so that dai_link->platforms has space.
> 
> Fixes: e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai component and rework codec link")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> ---
> Changes since v1:
> - Reword commit message with more details on how the original commit
>    got things wrong, and what this commit adds and fixes
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



