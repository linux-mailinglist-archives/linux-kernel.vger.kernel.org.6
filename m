Return-Path: <linux-kernel+bounces-348021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C198E19C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB34285491
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB241D1741;
	Wed,  2 Oct 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgWwaYDl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B971D0F62;
	Wed,  2 Oct 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890196; cv=none; b=LgvW14XJf5PkXnuhuEvQfEbPpH74shQebKi1qkmobAzrEtMSIIrqADvuea9BlXfvctLuauJXivZCk3LSyAXJ+jln+6v1y/LXth3cUKAotvntp5akzPlaX0ERgoRz+OyOBOCHQVuIeDG/cx9qcihNwQTOz0v0hZ2nTStlUJLDWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890196; c=relaxed/simple;
	bh=euTbIsusSo0TN7GQC3gr8HVYHu0/z+hrLKfLWfB/pHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipa9NeMz7CU/MS+Ec5dEzGVcYXQmVD1YT2L27enGXR0/TVTXiIeEWktfEBSlhmNAm9T/Y5OHJdNrcP2qUzT66Lb5uEWINc7OTG5AwTSfKbrRoicsuCTCkGduL15F2HN0KXhKiRobH3nBDI2DDmTaR9kUcpaBsztKGXQcK4ykVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgWwaYDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88CEC4CECD;
	Wed,  2 Oct 2024 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727890196;
	bh=euTbIsusSo0TN7GQC3gr8HVYHu0/z+hrLKfLWfB/pHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgWwaYDl6Js4BsVRqODHfKzyEdBFSRxhFJzHY67W9nVfKtVPfnkm3QsZUZfXEL4Pf
	 XjA5UCvfqKpSMXVnb+FCFqBaWJSLjDkEgFYuwhYhqpTnE4FcKD6pCKRr5fI97rQ5nR
	 Nv+kbr8LZAa2digbaNtZR/BP0NtRcjCkhbqYUfe16SPPQjsixGqG5WZqByvL7QEuvb
	 ScQTuam4gy7UCU43ba7kKlrJ8gD+AytEwUpCUwP0joc/2uxS95x1WMid/MB/034DLx
	 cl3KWrw4zP3tva75Kt8SpQjotqFieejQUo20L/GGrIhzsfwDollxDzoHzYg5eNZ+LI
	 YR6vAxHblfXnQ==
Date: Wed, 2 Oct 2024 12:29:54 -0500
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <20241002172954.GA1001788-robh@kernel.org>
References: <20241002-ondie-v2-0-318156d8c7b4@gmail.com>
 <20241002-ondie-v2-2-318156d8c7b4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-ondie-v2-2-318156d8c7b4@gmail.com>

On Wed, Oct 02, 2024 at 11:01:31AM +0200, Marcus Folkesson wrote:
> Convert the bindings to yaml format.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ------------------
>  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 105 +++++++++++++++++++++
>  2 files changed, 105 insertions(+), 94 deletions(-)
> 

> diff --git a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..c0e09cccea8e65a6fcb98291c0cee0db56a97def
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> @@ -0,0 +1,105 @@
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
> +
> +  ti,davinci-chipselect:
> +    description: |

Don't need '|' if no formatting.

> +      Number of chipselect. Indicate on the davinci_nand
> +      driver which chipselect is used for accessing
> +      the nand.

Wrap lines at 80 char.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  ti,davinci-mask-ale:
> +    description: |
> +      Mask for ALE. Needed for executing address
> +      phase. These offset will be added to the base
> +      address for the chip select space the NAND Flash
> +      device is connected to.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x08
> +
> +  ti,davinci-mask-cle:
> +    description: |
> +      Mask for CLE. Needed for executing command
> +      phase. These offset will be added to the base
> +      address for the chip select space the NAND Flash
> +      device is connected to.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x10
> +
> +  ti,davinci-mask-chipsel:
> +    description: |
> +      Mask for chipselect address. Needed to mask
> +      addresses for given chipselect.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  ti,davinci-ecc-bits:
> +    description: Used ECC bits.
> +    $ref: /schemas/types.yaml#/definitions/uint32
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
> +    description: |
> +      Use flash based bad block table support. OOB
> +      identifier is saved in OOB area.
> +    deprecated: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - ti,davinci-chipselect
> +
> +examples:
> +  - |
> +    nand_cs3@62000000 {

nand-controller@...

> +    compatible = "ti,davinci-nand";
> +    reg = <0x62000000 0x807ff
> +    0x68000000 0x8000>;
> +    ti,davinci-chipselect = <1>;
> +    ti,davinci-mask-ale = <0>;
> +    ti,davinci-mask-cle = <0>;
> +    ti,davinci-mask-chipsel = <0>;
> +    nand-ecc-mode = "hw";
> +    ti,davinci-ecc-bits = <4>;
> +    nand-on-flash-bbt;

Wrong indentation.

> +
> +        partition@180000 {
> +            label = "ubifs";
> +            reg = <0x180000 0x7e80000>;
> +        };
> +    };
> 
> -- 
> 2.46.0
> 

