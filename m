Return-Path: <linux-kernel+bounces-355288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2586994FD2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E901F218E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064E1E00A5;
	Tue,  8 Oct 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neveWu31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A001DFE34;
	Tue,  8 Oct 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394117; cv=none; b=HxKcafwSCt4lujQN1exmgu45R1CQaII3QbsSPFxBPW81q5saKtiGAhrOgc20qGz51lUUi/Uc1oxp5RNBtNJDElHjrLZYKZ6TuhdI5icTQLDv6V+xkepDkbOvlcbsAOHhpN8Bnfe36RX+6hZLSMXthTZhtRFxktkVIrjo/6DsPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394117; c=relaxed/simple;
	bh=14qGYeM0ii/htuwDgyw45Jd41C1hUPbWSgeByF8tYkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIg3pXJWorH8U30Jo9vzEtZ009LHNmscFWe0HeWboej2ghPugW245TnENcPwGwNNokboSc3YM8x4ntQ34s2uG37MRo0xO1bSkD5VOZYs+jeOb27IfV0K4K18wo4SN4KLWL1bTAAxZuwWnNS7OtJISesqeciucqcYRnu7oqL0rGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neveWu31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8CDC4CECD;
	Tue,  8 Oct 2024 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394117;
	bh=14qGYeM0ii/htuwDgyw45Jd41C1hUPbWSgeByF8tYkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neveWu31FituKGuru4HxDagfnPHNfLpq0n+EN/+IFoMajVnymRa0UDighXjUSRmOn
	 utWBLcm1c8YPSLTPdmKpOT/qT5BjFR1Ht0kKigkiFU9LlObh7kmx/jjOAHu5P+wcPf
	 Dhr8ofyX2xaHAlZc0bNcy+W0shER2yYn4tIyWZY/Rpsbzb0dCFlwJz1BFkvJlK3Xe2
	 Widt+XTS/Zq5z6V1AxOXKr+7j6K+pGjpmBekwWHvUo1tJhF1cAnKbfre5HVAvIBTVS
	 7uLZMmPgbzne7nmUcDfJWWRmmbVhQl0afFCdm6jIAovcFuYMuGVU+NRJVGfd1hVtGV
	 MRmjgYi37eYgQ==
Date: Tue, 8 Oct 2024 15:28:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <4u5iv24enpz46funfvbo2aggx6yiqxy7beaa3ldt5ai5wf65kl@bnlm4eyuwkui>
References: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
 <20241008-ondie-v5-2-041ca4ccc5ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008-ondie-v5-2-041ca4ccc5ee@gmail.com>

On Tue, Oct 08, 2024 at 09:02:45AM +0200, Marcus Folkesson wrote:
> Convert the bindings to yaml format.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -----------------
>  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 115 +++++++++++++++++++++
>  2 files changed, 115 insertions(+), 94 deletions(-)
> 


> diff --git a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..1263616593532e8483d556b4242b004a16620ddf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI DaVinci NAND controller
> +
> +maintainers:
> +  - Marcus Folkesson <marcus.folkesson@gmail.com>
> +
> +allOf:
> +  - $ref: nand-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,davinci-nand
> +      - ti,keystone-nand
> +
> +  reg:
> +    maxItems: 1

This was different in original binding and commit msg does not explain
changes.  Be sure any change from pure conversion is explained in the
commit msg.

> +
> +  partitions:
> +    $ref: /schemas/mtd/partitions/partitions.yaml
> +
> +  ti,davinci-chipselect:
> +    description:
> +      Number of chipselect. Indicate on the davinci_nand driver which
> +      chipselect is used for accessing the nand.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  ti,davinci-mask-ale:
> +    description:
> +      Mask for ALE. Needed for executing address phase. These offset will be
> +      added to the base address for the chip select space the NAND Flash
> +      device is connected to.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x08
> +
> +  ti,davinci-mask-cle:
> +    description:
> +      Mask for CLE. Needed for executing command phase. These offset will be
> +      added to the base address for the chip select space the NAND Flash device
> +      is connected to.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x10
> +
> +  ti,davinci-mask-chipsel:
> +    description:
> +      Mask for chipselect address. Needed to mask addresses for given
> +      chipselect.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  ti,davinci-ecc-bits:
> +    description: Used ECC bits.
> +    enum: [1, 4]
> +
> +  ti,davinci-ecc-mode:
> +    description: Operation mode of the NAND ECC mode.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [none, soft, hw, on-die]
> +    deprecated: true
> +
> +  ti,davinci-nand-buswidth:
> +    description: Bus width to the NAND chip
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [8, 16]
> +    default: 8
> +    deprecated: true
> +
> +  ti,davinci-nand-use-bbt:
> +    type: boolean
> +    description:
> +      Use flash based bad block table support. OOB identifier is saved in OOB
> +      area.
> +    deprecated: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - ti,davinci-chipselect
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    nand-controller@2000000 {
> +      compatible = "ti,davinci-nand";
> +      #address-cells = <1>;
> +      #size-cells = <0>;

I did not notice it last time.... but what is this? How could you have
no sizes?

> +
> +      reg = <0 0x02000000>;

This is odd. Address is not 0... and size should be 0.

I don't get how it even works. For sure it is not correct.

Best regards,
Krzysztof

