Return-Path: <linux-kernel+bounces-422032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BFC9D9397
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DECB2185A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C071B0F06;
	Tue, 26 Nov 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UgSfkvuo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91513C3F6;
	Tue, 26 Nov 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611124; cv=none; b=nfpY0LrEdUKogn3JifekuDKHflihTN/DuuPmxHGBL6MAVSAUE/MT4hp1FZSSfsR7ZF2ljd/hwQ8VD6b3u+l5jV/a0183BMM6A0FmMjjS81e+j17uLiBzwCW8StJ6PWt0Ura0kYWxh3ne0qkgBKo6pSBaP7eG8lAO+bSJTQhAyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611124; c=relaxed/simple;
	bh=ZNiXeKu3VMMs+mJ7Uwi6rVoXAummZLmskjT7q9ZCRRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgqrmVo4zMPGNbujB8/sxY0gHCNxsHc9GeuAszOZXkCrSrenjSobjvJWTe5WfsRdGtT9SHvR/l5p2TpwWTBvSwihX7RwTOlbRC7nn8LPrpt0oHjRmm/VGju4Pvn6pO5BqVXQ5arKE1WkSmzgmdISv7Tmx/af+Z+esiZjPAGKVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UgSfkvuo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732611120;
	bh=ZNiXeKu3VMMs+mJ7Uwi6rVoXAummZLmskjT7q9ZCRRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UgSfkvuohiJ/eL0XEasFCiJVAiiPRbwOzbGyu6aUkpF5x2Hlo46RU8rF8X8wbUAMd
	 bAorUi1ky8OaHMZZ3WmJ/m6Zqx4KN3jDhE5d1dhRzEbtvSD0grHRlCh8z40IINJ/KF
	 0jMu4emeu5GM/bVZA38Xk2Hg6Y/0e/uxtvrcObaLdHs+H2CVDH5dHT5Hruk30HDQcZ
	 Ml4w9+BDleTqVxnxP5y0fCd8m428B+sbgLoA1omHdCG6v9nNP5K1S5tvuaEYWJyoV2
	 OPU4RHrISvl6sgIA79t6xor1PO+XzW6YOV7nuEmlEJy8uqIYWObBJQ6A80kWEsHZkY
	 Th/0Kia2KLO3Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EB63117E1366;
	Tue, 26 Nov 2024 09:51:59 +0100 (CET)
Message-ID: <4901ecf5-8cd1-4d82-a240-f56794f46429@collabora.com>
Date: Tue, 26 Nov 2024 09:51:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek,xsphy: add property to set
 disconnect threshold
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241126025859.29923-1-chunfeng.yun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241126025859.29923-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/11/24 03:58, Chunfeng Yun ha scritto:
> Add a property to tune usb2 phy's disconnect threshold.
> And add a compatible for mt8196.
> 

Is this a board-specific property? If so, can you please describe the reason?

Thanks,
Angelo

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> index a9e3139fd421..2e012d5e1da1 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> @@ -49,6 +49,7 @@ properties:
>         - enum:
>             - mediatek,mt3611-xsphy
>             - mediatek,mt3612-xsphy
> +          - mediatek,mt8196-xsphy
>         - const: mediatek,xsphy
>   
>     reg:
> @@ -129,6 +130,13 @@ patternProperties:
>           minimum: 1
>           maximum: 7
>   
> +      mediatek,discth:
> +        description:
> +          The selection of disconnect threshold (U2 phy)
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 1
> +        maximum: 15
> +
>         mediatek,efuse-intr:
>           description:
>             The selection of Internal Resistor (U2/U3 phy)




