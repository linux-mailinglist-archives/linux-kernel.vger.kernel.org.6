Return-Path: <linux-kernel+bounces-547359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D890A5063D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BE9188A484
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266622E419;
	Wed,  5 Mar 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aTA7Zklj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2621A3160;
	Wed,  5 Mar 2025 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195127; cv=none; b=n22xYoplFx/5vouB4OynpMkyrj6a7BRWRrm8hISWjnGGOUzHrg6ph1ze/N/fF/1uCeKHV1OiSVuFl1v87Wft1M+KC6aytbrSEGLXsd2trFWzLyEC4P9Iz3GI2df48j899gPLqGgVkrOrWCR4VQeUgNAq1+CesEa7AI7N98Hpsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195127; c=relaxed/simple;
	bh=VLo1VfKrncc62HR3H2AUBFVFZ8nlgV/Ud1MBfjGjdvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVMvaD+D3os09f6Be8vSzyxCC88DJYajb07ARVyaxvQ11LtmJmSkJaY5CT74GpBB0SE9NDjAFqOl7X4GiENGCZ3JbfMBmALK0U+bqkVRuFxYLRCMz3qbFJJBJ6ZD4sc0JtgZOlXzFauP0eQn7cWvQSilPxn+TgkfVCGs3btSMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aTA7Zklj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741195122;
	bh=VLo1VfKrncc62HR3H2AUBFVFZ8nlgV/Ud1MBfjGjdvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aTA7ZkljZ0mv/kvuFSL6iNhvjnFmepeIqml6cipt78WQCD8DVBYT4ayvgJNa8bDxZ
	 9eyAoRiJFFSLFDUWN/eYHS4iFF6gG1x21l6eC4OVpNq/LxPxUV3Kag5RH38TpsPS/D
	 Tj9X1QpmSv3XQOhFpvb0ppJ+71rYZJYxdGx3fjlIjSJoyRErnnPsUJr4+UABm9pOsV
	 zvkQTu++r3FyH99pMIh36+wrVRM2D62KYLydeDBpxWVRFPd9abf/Yrr0CpuM1WqXDZ
	 9TzubIlTg/b9ZFaTPbSF20cGG5fT6j1ItwO37jslD/R4XNdUZWZvBK9rMQE+SSp8PI
	 FpzVtRGmCqe2w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB02417E0599;
	Wed,  5 Mar 2025 18:18:41 +0100 (CET)
Message-ID: <59d0d382-1d15-46c4-b9e4-b66c32c188d3@collabora.com>
Date: Wed, 5 Mar 2025 18:18:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ASoC: mediatek: mt8188-mt6359: Add accdet headset
 jack detect support
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Trevor Wu <trevor.wu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Zoran Zhan <zoran.zhan@mediatek.com>
References: <20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com>
 <20250304-mt8188-accdet-v2-3-27f496c4aede@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-mt8188-accdet-v2-3-27f496c4aede@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/03/25 22:35, Nícolas F. R. A. Prado ha scritto:
> Enable headset jack detection for MT8188 platforms that use the MT6359
> ACCDET block for it, indicated by the mediatek,accdet property in DT.
> For those platforms, register a jack and initialize the ACCDET block to
> report jack events through it.
> 
> Co-developed-by: Zoran Zhan <zoran.zhan@mediatek.com>
> Signed-off-by: Zoran Zhan <zoran.zhan@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

We chatted about the issue that I raised before with mt8188_headset_jack_pins[],
it's fine to have it for now, as whatever we do with that would still duplicate
things and there's no way around that for now.

The sound card driver should get a bigger cleanup anyway, and it's not really
possible even because otherwise we'd break UCM2 confs, so it is what it is.

> ---
>   sound/soc/mediatek/Kconfig                |  1 +
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 43 +++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 3033e2d3fe16840631a465dd967da77f7a6ff43c..64155ea7965a1cc50593fef442ce90761836f328 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -237,6 +237,7 @@ config SND_SOC_MT8188_MT6359
>   	select SND_SOC_NAU8825
>   	select SND_SOC_RT5682S
>   	select SND_SOC_ES8326
> +	select SND_SOC_MT6359_ACCDET

The only remaining complaint that I have is that this driver shouldn't really
add a select SND_SOC_MT6359_ACCDET.

Instead, the mt6359-accdet.h header should be modified to stub-ify the accdet
driver functions in the case in which it's not built in, or not available as a
module anyway.

This is because the accdet driver is not *mandatory* for this driver to work,
and being it an optional peripheral, adding a dependency doesn't really make
a lot of sense as it'd only force in bloat when not wanted.

So...

Get to that mt6359-accdet.h header and:

#if IS_ENABLED(CONFIG_SND_SOC_MT6359_ACCDET)

function signatures

#else

static .... { return -EINVAL; (or whatever else) }

#endif

That said, for the future v3 of this commit, after removing the select
SND_SOC_MT6359_ACCDET (and granted that the proposed header fix is in place),
you can add my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo



