Return-Path: <linux-kernel+bounces-259110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3693915D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08844B21CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0E16DEA3;
	Mon, 22 Jul 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VOPefoLu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66516EBEA;
	Mon, 22 Jul 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660744; cv=none; b=CuwdR3XXqkTyrwPLAYOkTLAWnmOTuVFP5zgzoXCXMKakTI148blqGEkaQUnI2h1WNxL0k4KAgSFlVN/ayaTvD1wkosUMrjcAvHX47fhWkQ3N7JYQtzBw6UIGxm0VtQh3RzWkp0BQ2kr0UrnoDvGb9gX+czqx0cilRVTALTU5jl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660744; c=relaxed/simple;
	bh=sLVyGWJOqBRBNhkFXxDmIXAIszctI5pJTbC9XTG9YW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PibYiukuvmyP96M1Mvzgf/gK1Es901lu7wimxeg3wqUJAtt69NJQzkHFo9rI0x9cI8RZ0oJxczRNurZr68U+h5wmEIUIAzNdyW5p3rWuk2s+U/APu+Vy9UWkLIARSEgwOy9zBN7+rMo9rkggQY14RKscKzirrCPxXPIP86+wzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VOPefoLu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721660742;
	bh=sLVyGWJOqBRBNhkFXxDmIXAIszctI5pJTbC9XTG9YW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VOPefoLuebdSHdJq1uKoa3ninL9kZooNifFvsx3mwcbDkMiLG9Le8PsuMv2Az5qmw
	 fb7wUBZ1RafMUpHabpVQQWzIf7spT069mIYtw/tMqBhPx9YCTxEH3Vn1lfgzmIzlRW
	 eI25ASU2m9agr8tSSWAK6bgh0Gay842CsjO2KU0jVw5Mo5WKdEtwuyl26OTjOe4T4k
	 cvr4XnOyt5L6/kLcmmj5riPgzln6apRetpWzUYVJHYED/SatH3kXfNeeeXhY7xtm8r
	 3z8C+lpk6N5qBOGiSaNQAnN1IyFvgbxV7geleo9tW8w5iErF3ZXdzHu2TMIa1bn9e/
	 c8kTsNNG/+9rA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0CC8F3780523;
	Mon, 22 Jul 2024 15:05:40 +0000 (UTC)
Message-ID: <2938cb6d-b07f-4521-bd8b-b8f44dccf7c6@collabora.com>
Date: Mon, 22 Jul 2024 17:05:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8192: remove redundant null pointer
 check before of_node_put
To: Chen Ni <nichen@iscas.ac.cn>, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
 amergnat@baylibre.com, kuninori.morimoto.gx@renesas.com,
 jernej.skrabec@gmail.com, nfraprado@collabora.com, robh@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240709085131.1436128-1-nichen@iscas.ac.cn>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240709085131.1436128-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/07/24 10:51, Chen Ni ha scritto:
> of_node_put() has taken the null pointer check into account. So it is safe
> to remove the duplicated check before of_node_put().
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> ---
>   sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> index 8b323fb19925..db00704e206d 100644
> --- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> +++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> @@ -1108,9 +1108,7 @@ static int mt8192_mt6359_legacy_probe(struct mtk_soc_card_data *soc_card_data)
>   err_headset_codec:
>   	of_node_put(speaker_codec);
>   err_speaker_codec:
> -	if (hdmi_codec)
> -		of_node_put(hdmi_codec);
> -
> +	of_node_put(hdmi_codec);
>   	return ret;
>   }
>   



