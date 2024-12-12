Return-Path: <linux-kernel+bounces-442957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DF9EE495
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98901887336
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE196211486;
	Thu, 12 Dec 2024 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7SkfFGR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65401F2381;
	Thu, 12 Dec 2024 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001087; cv=none; b=fATB6JXZlJYIMAjoEjxa4H7IGqV5KUYERJIrO3soXziOJ+kyq2zdYO00VzlIPm7FvhgZaVg/npBNeM6tACcv+yQTpvbOGyvBbS7GGyDcI53g17x4n5cDENPWomChiKS8tEhO5rd/tuFKEYv2uhHx6mbJtZeC/rjUoQCHYzHl3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001087; c=relaxed/simple;
	bh=66P2538eW1BwTyHrvBkaCpsiuD8uE1SJepz34ONQCVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jckRzZkfrkUSbgl+4PNDjVy0597Q8XTt79N3AT8I5YWOruBiTV1djar9iiHrHpwyXWkE8Hm1XhaPlDcW4sU4XEQO+W6TTvN0S/5cxM35DY+i3E+Q7KLltLRJgABR/vhdIb+ChxA/0TpVYLcN+Kw+RoLIwgbxPxjd8InK5N1YBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7SkfFGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F20C4CED7;
	Thu, 12 Dec 2024 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734001086;
	bh=66P2538eW1BwTyHrvBkaCpsiuD8uE1SJepz34ONQCVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z7SkfFGRFKmALJf74ryXdLI35465PeVGRYz3KYib06+rInBoGTmgOugwNSZZdkRIZ
	 wisUTtp53taKfhhwXCVQYhRBzbm5J/rnerCCqq9cmI7vV1BDBbOHml9qxh+OuXi13L
	 6oMbLkXUzSzGZ9o6epuikVzG6sKXGZ5zrM0gaR5P4CSFAF4ysMILQpNEtumvoRy71J
	 2zOs9xUecnEm/bX6rp3TTPBK9LX13HfTyBk81LmIkVvXCzaIZdsmWhogZVcylzoP4C
	 kqG/OOlm3Tew2yhXaBBOC2JM3RXdjBn1vCqTKJEY4ev03Pe1w/sGwUehVuanNaW5DM
	 sq5LkkkDNgSow==
Message-ID: <c978937a-e589-4e9a-ba37-265dbfc1b252@kernel.org>
Date: Thu, 12 Dec 2024 11:58:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: memory-controllers: Add mediatek
 common-dramc dt-bindings
To: Crystal Guo <crystal.guo@mediatek.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241212090029.13692-1-crystal.guo@mediatek.com>
 <20241212090029.13692-3-crystal.guo@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241212090029.13692-3-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/2024 09:59, Crystal Guo wrote:
> Add devicetree binding for mediatek common-dramc driver.
> 
> The DRAM controller of MediaTek SoC provides an interface to
> get the current data rate of DRAM.

Bindings are before users.



A nit, subject: drop second/last, redundant "dt-bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  .../mediatek,common-dramc.yaml                | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml
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

Common? Is this a real thing? Please describe the hardware.

> +
> +maintainers:
> +  - Crystal Guo <crystal.guo@mediatek.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The DRAM controller of MediaTek SoC provides an interface to
> +  get the current data rate of DRAM.

So not common here?

> +
> +properties:
> +  compatible:
> +    const: mediatek,common-dramc

This has to be SoC.

> +
> +  reg:
> +    minItems: 9

Why this is flexible?

> +    items:
> +      - description: DRAMC_AO_CHA_BASE
> +      - description: DRAMC_AO_CHB_BASE
> +      - description: DRAMC_AO_CHC_BASE
> +      - description: DRAMC_AO_CHD_BASE
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

Don't use some defines. Look at other bindings how they describe items.

> +
> +  support-ch-cnt:

Nope

> +    maxItems: 1
> +
> +  fmeter-version:
> +    maxItems: 1
> +    description:
> +      Fmeter version for calculating dram data rate
> +
> +  crystal-freq:
> +    maxItems: 1
> +    description:
> +      Reference clock rate in MHz
> +
> +  shu-of:
> +    maxItems: 1
> +
> +  pll-id: true
> +  shu-lv: true
> +  sdmpcw: true
> +  posdiv: true
> +  fbksel: true
> +  dqsopen: true
> +  async-ca: true
> +  dq-ser-mode: true


This binding is terrible. Was not tested and does not follow any
guidelines. Please read example schema and writing bindings document.
You can also read slides from my talks...


> +
> +required:
> +  - compatible
> +  - reg
> +  - support-ch-cnt
> +  - fmeter-version
> +  - crystal-freq
> +  - pll-id
> +  - shu-lv
> +  - shu-of
> +  - sdmpcw
> +  - posdiv
> +  - fbksel
> +  - dqsopen
> +  - async-ca
> +  - dq-ser-mode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        dramc: dramc@10230000 {

memory-controller@
and drop unused label.

Best regards,
Krzysztof

