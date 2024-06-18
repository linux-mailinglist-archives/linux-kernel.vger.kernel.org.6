Return-Path: <linux-kernel+bounces-219094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6190C9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65FB1C213AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C617B42C;
	Tue, 18 Jun 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T3sDvnow"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92417A926;
	Tue, 18 Jun 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708019; cv=none; b=K8ucNthweuyOc8bFjRKWHEaYQPcrirY2m5c4BvMFxX8Exq9IWMcVPi2fZYdp60H7jyhUil6bjl6j8Gl/NwMFzqp8G//+F5BPLgiPD80LaBSsM3EyS6vCBj42UI21MQG6Kh8AdnT1HNo48AvOPoi9lQ0wMWxWbbDCLuNjOxz/jBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708019; c=relaxed/simple;
	bh=TKqnk7jdCrlyYi8lHm4Cy6BpCu+PEPISCKnloXabxsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+TL5vKaaY+6R2BGvBrnK/xA/i94vcqG+srhb/5uf5Jrr/3L54Qw75R2IuwLOK4/tj1gGbApZckqb86BF4Q2hdt9zSp9rHzshPKtFVevxD9CVpldBkLEMoNBVDwsrM07uDN4tz3fT/zshcXhvqt0cCiC930Q0BbYOi6g1Vdnjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T3sDvnow; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718708009;
	bh=TKqnk7jdCrlyYi8lHm4Cy6BpCu+PEPISCKnloXabxsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T3sDvnowOuc5j5SAyXkZYuRQqtjLCzeuWXDNu7JM6UfW/5aAEUGEmcGCnl/+1Dzu2
	 e1NcDsb5dMNpo7tCs1zonM0kgbCKK4EnshAYLhBUeitHge+f0tRWbyvgY8lPhNsIgW
	 eUqe69fgQOrCQghppGrnFYBrq94GUIa62Hhvz2oi+ihsNPD71DLErz1xNYodqdAtk2
	 68RbHixeRono48IWOIuho6U1ECDo2zkPXTY65E8vBeIyhtCm4it8idgS7WKM5skXUl
	 nRq7etEn7hdrTlwoL17snOv7f7nSkZJiCFtUDXNCgqxUg3sV3Rvp4c+TLOvr634fSR
	 beUrZULdrfjtQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BC8443781183;
	Tue, 18 Jun 2024 10:53:28 +0000 (UTC)
Message-ID: <51b7bb8d-801b-4c2f-8650-40162bf08e13@collabora.com>
Date: Tue, 18 Jun 2024 12:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: mt6358: Convert to dtschema
To: Kartik Agarwala <agarwala.kartik@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
 <20240617-mt6358-v2-1-5d9f0e99941e@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240617-mt6358-v2-1-5d9f0e99941e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/06/24 14:28, Kartik Agarwala ha scritto:
> Convert from txt to dtschema
> ---
>   .../devicetree/bindings/sound/mediatek,mt6358.yaml | 51 ++++++++++++++++++++++
>   Documentation/devicetree/bindings/sound/mt6358.txt | 26 -----------
>   2 files changed, 51 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
> new file mode 100644
> index 000000000..336d2d969
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt6358.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6358 Audio Codec

title: MediaTek MT6358/MT6366 Audio Codec

> +
> +maintainers:
> +  - Kartik Agarwala <agarwala.kartik@gmail.com>

   - Jiaxin Yu <jiaxin.yu@mediatek.com>


> +
> +description:
> +  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
> +  For more detail, please visit Mediatek PMIC wrapper documentation.
> +  Must be a child node of PMIC wrapper.
> +

   The communication between MT6358 or MT6366 and SoC happens through
   the MediaTek PMIC Wrapper.
   For more detail, please visit MediaTek PMIC wrapper documentation:
   Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
   Must be a child node of a PMIC.

> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt6358-sound
> +      - const: mediatek,mt6366-sound

This should be an enum.

> +      - items:
> +          - const: mediatek,mt6366-sound
> +          - const: mediatek,mt6358-sound
> +
> +  Avdd-supply:
> +    description: power source of AVDD
> +
> +  mediatek,dmic-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates how many data pins are used to transmit two channels of PDM
> +      signal. 0 means two wires, 1 means one wire. Default value is 0.
> +    default: 0
> +    enum:

enum: [ 0, 1 ]

> +      - 0
> +      - 1
> +

Regards,
Angelo

> +required:
> +  - compatible
> +  - Avdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    audio-codec {
> +        compatible = "mediatek,mt6366-sound";
> +        Avdd-supply = <&mt6358_vaud28_reg>;
> +        mediatek,dmic-mode = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/sound/mt6358.txt b/Documentation/devicetree/bindings/sound/mt6358.txt
> deleted file mode 100644
> index fbe9e55c6..000000000
> --- a/Documentation/devicetree/bindings/sound/mt6358.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Mediatek MT6358 Audio Codec
> -
> -The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
> -For more detail, please visit Mediatek PMIC wrapper documentation.
> -
> -Must be a child node of PMIC wrapper.
> -
> -Required properties:
> -
> -- compatible - "string" - One of:
> -    "mediatek,mt6358-sound"
> -    "mediatek,mt6366-sound"
> -- Avdd-supply : power source of AVDD
> -
> -Optional properties:
> -- mediatek,dmic-mode : Indicates how many data pins are used to transmit two
> -	channels of PDM signal. 0 means two wires, 1 means one wire. Default
> -	value is 0.
> -
> -Example:
> -
> -mt6358_snd {
> -	compatible = "mediatek,mt6358-sound";
> -	Avdd-supply = <&mt6358_vaud28_reg>;
> -	mediatek,dmic-mode = <0>;
> -};
> 




