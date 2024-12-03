Return-Path: <linux-kernel+bounces-429057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB579E18F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004BEB2FC59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC91DFD9E;
	Tue,  3 Dec 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KY36np5n"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D81DE8A3;
	Tue,  3 Dec 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216973; cv=none; b=scIsAIWH39QvMW2rjYB2nEQoglITv2xaeEWdRJQkf5rA8L+rrKz65H+Dj+07MVZGhFTq223Zzn9WEjdFDINTgsbttQFOlpkKBIf5NYzFgwAr5F2SIZ5RYp3bg4vHGoO2vhZJAFVBPQZ9hnEymS5IBblPCzbNnDCNHnJvi5eqUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216973; c=relaxed/simple;
	bh=IEUB6/FeNi9MLZCmRFS4et5QKnXC5lPTq/3qhfvv080=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYIOv2wQSWHRmLe6mnyJzwdzLn/BRO8F2M0w849HTCOWS1555U3LrIC9QzrvMKqLf3Lv8BisOa9y1WPMdClivgos/yrlbSYjQAl5NfIVYpC2nZzw9ggddVuDcyOCPrYyjb417OqkQ8SG3DnCCKvXuEo/ckJmh2hbFKUOfyGKXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KY36np5n; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733216969;
	bh=IEUB6/FeNi9MLZCmRFS4et5QKnXC5lPTq/3qhfvv080=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KY36np5n2rInUb/hAO8z3V84UptGwrhykUTd5bYv8/sVe1nnet2m/3AyAVZfid4WB
	 Zxb6FmC3czxnpBG/IOLb33CSPnAeG438i3yk+j6PUe7Zc41ftjpAQdE9NB2j5JO/Bn
	 aC3jkEP3CoEVus42DkBzdPaEYj0xBFUgm9MoeKCW2KfA4LZIyUSWzwZMLA4H+KnMpI
	 Sr38XTQMUAq39/9diOlom0nify9BKotRPqG8jpln0ntbrupZLkqS133zhVha4Nz9Wf
	 kyMLUu+mWajIamWDM2L9kKzWUUDY5RJpFOx0rtqTS1QnG7gjnAt4aRLxZTvGFqmBeL
	 7kaTL8XXSRC/Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D5BDB17E35CB;
	Tue,  3 Dec 2024 10:09:28 +0100 (CET)
Message-ID: <1666021a-6840-4bb4-b5e2-225a528302fa@collabora.com>
Date: Tue, 3 Dec 2024 10:09:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: mediatek: Add MT8186 Chinchou
 Chromebook
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, wenst@chromium.org, hsinyi@chromium.org,
 sean.wang@mediatek.com, dianders@google.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20241202032035.29045-2-xiazhengqiao@huaqin.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202032035.29045-2-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 04:20, Zhengqiao Xia ha scritto:
> Add an entry for the MT8186 based Chinchou Chromebook, also known as the
> ASUS Chromebook CZ12 Flip (CZ1204F) and CZ12(CZ1204C).
> 
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/arm/mediatek.yaml     | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..3efab59b8a73 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -239,6 +239,34 @@ properties:
>             - enum:
>                 - mediatek,mt8183-pumpkin
>             - const: mediatek,mt8183
> +      - description: Google Chinchou (Asus Chromebook CZ1104CM2A/CZ1204CM2A)
> +        items:
> +          - const: google,chinchou-sku0
> +          - const: google,chinchou-sku2
> +          - const: google,chinchou-sku4
> +          - const: google,chinchou-sku5
> +          - const: google,chinchou
> +          - const: mediatek,mt8186
> +      - description: Google Chinchou (Asus Chromebook CZ1104FM2A/CZ1204FM2A/CZ1104CM2A/CZ1204CM2A)
> +        items:
> +          - const: google,chinchou-sku1
> +          - const: google,chinchou-sku17
> +          - const: google,chinchou-sku3
> +          - const: google,chinchou-sku6
> +          - const: google,chinchou-sku7

Please move sku17 here to keep alphabetical order.
For consistency, please do the same in mt8186-corsola-chinchou-sku1.dts.

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +          - const: google,chinchou-sku20
> +          - const: google,chinchou-sku22
> +          - const: google,chinchou-sku23
> +          - const: google,chinchou
> +          - const: mediatek,mt8186
> +      - description: Google Chinchou360 (Asus Chromebook CZ1104FM2A/CZ1204FM2A Flip)
> +        items:
> +          - const: google,chinchou-sku16
> +          - const: google,chinchou-sku18
> +          - const: google,chinchou-sku19
> +          - const: google,chinchou-sku21
> +          - const: google,chinchou
> +          - const: mediatek,mt8186
>         - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
>           items:
>             - const: google,steelix-sku393219




