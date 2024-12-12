Return-Path: <linux-kernel+bounces-442924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFD9EE416
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772FE188BD73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A80210F6E;
	Thu, 12 Dec 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RmalG9PH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8692101A3;
	Thu, 12 Dec 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999278; cv=none; b=uzGJW4G7DAVBqagKbyyiOWlYnEJ08KTCxYEMVBe7S/UwJrpe2iG8gcYEm3r+gq5VrT3OtD5inRjKVT2khBNO4zB22FzVViL6g39fGoytuwEvqPvqWh2YoJvgRJE0VFwMeDD/87SaoGF3X7E2Y0nyvkx+qmK3Nz+1S5HTZMT+Qv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999278; c=relaxed/simple;
	bh=DLrR9DvNEGy896WEuOkI4qVaTUviwn0zBvUtMaDFUeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlWaP2W52LlGfTyHQaRh869ZVoJqlk6w+M8b9Oe9/Aaw5YHgYBx5kg9ssJVAZcCOuJU87AIhEmzzEXFfxiLB/KvZireeRNfmaw2C46G/n0vn1AToHuaM/2dPR43TwU+Ju/sUEzCRVMUfGVInICwTzKtJT9zekrFQY1F1dyHUwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RmalG9PH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733999274;
	bh=DLrR9DvNEGy896WEuOkI4qVaTUviwn0zBvUtMaDFUeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RmalG9PHOrb25SCruoUFZylPL/u2f5QgwpAZWBbSEhAXiJgtEiPj1MNi0dWlFKRye
	 tY2eo0osFH/1HmsClI1TF9ipGymNCLK7D8XXxmbO9ccQZOrgRLyYvwTYxdc9oa/8QQ
	 epz/pbrbOBhc7AqECMmAzqj4Jhiaf///6SLznrY7gQEEwBSDAWsoQ4fjnkx2WJZ7CR
	 cl+BPm+AAX5F9vENdXGE4ZuCRs9fOkOC2Iaqf0z8HcMp0GuFsH1Pm/e+0Zthqsb5f7
	 HVfkv9i7NwX9GPypAbtAsIudbZ8pdrFwGuYk9e3gA6B3drQnEORdjz33DGjSjkWPDE
	 tszN+/h87ARiw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D62517E35D8;
	Thu, 12 Dec 2024 11:27:54 +0100 (CET)
Message-ID: <5d06211b-5ee2-48dd-9334-7c8bcffb894e@collabora.com>
Date: Thu, 12 Dec 2024 11:27:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: memory-controllers: Add mediatek
 common-dramc dt-bindings
To: Crystal Guo <crystal.guo@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241212090029.13692-1-crystal.guo@mediatek.com>
 <20241212090029.13692-3-crystal.guo@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241212090029.13692-3-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/12/24 09:59, Crystal Guo ha scritto:
> Add devicetree binding for mediatek common-dramc driver.
> 
> The DRAM controller of MediaTek SoC provides an interface to
> get the current data rate of DRAM.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>   .../mediatek,common-dramc.yaml                | 129 ++++++++++++++++++
>   1 file changed, 129 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml
> new file mode 100644
> index 000000000000..c9e608c7f183
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# Copyright (c) 2024 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,common-dramc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Common DRAMC (DRAM Controller)

MediaTek DRAM Controller (DRAMC)

> +
> +maintainers:
> +  - Crystal Guo <crystal.guo@mediatek.com>
> +
> +description: |
> +  The DRAM controller of MediaTek SoC provides an interface to
> +  get the current data rate of DRAM.

No, the DRAM Controller does much more than just that.

> +
> +properties:
> +  compatible:
> +    const: mediatek,common-dramc

Absolutely no! Compatibles are per-soc.

mediatek,mt8186-dramc
mediatek,mt8188-dramc
mediatek,mt8195-dramc

etc

> +
> +  reg:
> +    minItems: 9
> +    items:
> +      - description: DRAMC_AO_CHA_BASE
> +      - description: DRAMC_AO_CHB_BASE
> +      - description: DRAMC_AO_CHC_BASE
> +      - description: DRAMC_AO_CHD_BASE

All those channels are sequential in AO->NAO, in the sense that
every channel is:

CH0     AO: 0x10230000   len: 0x4000
CH0    NAO: 0x10234000   len: 0x2000
CH0 PHY_AO: 0x10236000   len: 0x2000
CH0 PHY_AO: 0x10238000   len: 0x2000

So the reg can be simplified as

minItems: 4
items:
   - description: DRAM Controller Channel 0
   - description: DRAM Controller Channel 1
   - description: DRAM Controller Channel 2
   - description: DRAM Controller Channel 3


> +      - description: DRAMC_NAO_CHA_BASE
> +      - description: DRAMC_NAO_CHB_BASE
> +      - description: DRAMC_NAO_CHC_BASE
> +      - description: DRAMC_NAO_CHD_BASE
> +      - description: DDRPHY_AO_CHA_BASE
> +      - description: DDRPHY_AO_CHB_BASE
> +      - description: DDRPHY_AO_CHC_BASE
> +      - description: DDRPHY_AO_CHD_BASE
> +      - description: DDRPHY_NAO_CHA_BASE
> +      - description: DDRPHY_NAO_CHB_BASE
> +      - description: DDRPHY_NAO_CHC_BASE
> +      - description: DDRPHY_NAO_CHD_BASE
> +      - description: SLEEP_BASE

You're not using the SLEEP_BASE iospace, and that's not even really specific
to the DRAM Controller. Drop it.

> +
> +  support-ch-cnt:
> +    maxItems: 1

Don't tell me that the DRAM Controller in MediaTek SoCs cannot see how many
channels are actually occupied by a DRAM bank, because I will be really skeptical.

You can autodetect that in the driver, you don't need a DT property for that.

> +
> +  fmeter-version:
> +    maxItems: 1
> +    description:
> +      Fmeter version for calculating dram data rate

The Fmeter version is SoC-specific, you need platform data, not DT property.

> +
> +  crystal-freq:
> +    maxItems: 1
> +    description:
> +      Reference clock rate in MHz

Is this crystal an external component, or is it integrated into the SoC?

> +
> +  shu-of:
> +    maxItems: 1

There's no description, what is shu-of?

> +
> +  pll-id: true
> +  shu-lv: true
> +  sdmpcw: true
> +  posdiv: true
> +  fbksel: true
> +  dqsopen: true
> +  async-ca: true
> +  dq-ser-mode: true

Same for these ones, please describe them - but then remember: if those parameters
are board-specific, they can stay here, otherwise those go in platform data.

Besides, I doubt that those are board specific.

Regards,
Angelo


