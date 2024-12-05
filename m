Return-Path: <linux-kernel+bounces-433263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61E9E55B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDF316A07C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93D0218E96;
	Thu,  5 Dec 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aOzgpfaY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C9218AD5;
	Thu,  5 Dec 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402488; cv=none; b=gqVYZF7s6zVSxGdfsF/wtXSR+5Z+BBctF/89daWoWJaZfRdhu5XEyRVGQEreb0VKcCAP4YDkDyeONs4CKKLwdIPjPOgI16zwnwEE43ZGZO0OaX0f4GF0kC5roqFfHORGXzAcjo4QUzQpDEDweu8xYjr0JiBQkfvoZZeF7AaAmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402488; c=relaxed/simple;
	bh=HO0wXGzhDvgrKBdJi7+/8nVYZ/pZQYioghULZD0qjqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQES4Tp4fNRkslG9BdAT1IDcHBQ7g5CCOxGuJTNW2moM7SBpB9Aop1JKPSRBL/Q1WY+VD5iNon+zxeS3wPlv5FslPCVdkfP8c2qitnk+7u4ezEalaAiATjgot09uDMNBNjofO5ryiI4+XSj/Q1Le2jf3ZuHpCxMFXOJ4bWST+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aOzgpfaY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733402484;
	bh=HO0wXGzhDvgrKBdJi7+/8nVYZ/pZQYioghULZD0qjqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aOzgpfaY0TmEBk4soLcN6wXjvOIK/KhkM2yCNrY0T55tinTVZmWGVnzCruNUqUrRK
	 VloxJi6n5F4lESgTIFAqIEVKP/pyK1wORtxVWe60RzpzCah+cA/h/avbuMD3ggk4gs
	 QA7cKy5fG+YEe2NHFvFqfJh2ltiIe2FnvcjYOvoA/Yqo4RPtios+9XokGEdnu9A9V3
	 FbiCTkQKgB0xj6Ijxd6e5vEiQxZe0nnMQdI9E+IuaW4CHnTWKNqf48NgsBP2yJwVPK
	 H72H0ITEThfLkRK5emjJ1JX2R7kstw5LqBE7EFw2ElTfRkoz2O7zuWFOANE4ZImGLi
	 Lb3Ky7+KGFHpw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F6B017E369C;
	Thu,  5 Dec 2024 13:41:23 +0100 (CET)
Message-ID: <ef8db876-bd06-4d5d-96ff-c570beefaa9a@collabora.com>
Date: Thu, 5 Dec 2024 13:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add DSP
 properties
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
 <20241205-genio700-audio-output-v1-3-0e955c78c29e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241205-genio700-audio-output-v1-3-0e955c78c29e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/12/24 13:13, Nícolas F. R. A. Prado ha scritto:
> Add the mediatek,adsp and mediatek,dai-link properties to allow
> describing the DSP configuration in the sound card node, as is already
> the case for other MediaTek SoCs.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml      | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> index ffe9347b543f5c687433862a21ad534b8aace27e..1e282c34dbd99851d3959b641096968c0b2e71be 100644
> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> @@ -33,6 +33,16 @@ properties:
>       $ref: /schemas/types.yaml#/definitions/phandle
>       description: The phandle of MT8188 ASoC platform.
>   
> +  mediatek,adsp:

This is already upstream

https://lore.kernel.org/r/20241105091246.3944946-1-fshao@chromium.org

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8195 ADSP platform.
> +
> +  mediatek,dai-link:

That shouldn't be needed.

...so this patch can be dropped :-)

Cheers,
Angelo

> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      A list of the desired dai-links in the sound card. Each entry is a
> +      name defined in the machine driver.
> +
>   patternProperties:
>     "^dai-link-[0-9]+$":
>       type: object
> 


