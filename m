Return-Path: <linux-kernel+bounces-556407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DE0A5C719
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CB91895FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA125E83E;
	Tue, 11 Mar 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWk1KiOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E071A5BA4;
	Tue, 11 Mar 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706822; cv=none; b=a7JfhvGJo01ap9hCqRoMKWyfnOi9kvZwzsfFHoDe0XZ6SM7h0BOrpoFCa/zPx8oUf+fDnqVbLQm9m1crwU2A0i0C2lGW/s0JosMHdvGVnRoSR0nAEbOLTjfZvesATgR4YDjeKH/0TLZ6vAnntg7Vv74uk14XqIr6E1CiU5tYlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706822; c=relaxed/simple;
	bh=N5pBHs40qF4tSGmpD9K2uV1M+O09K7VOkhy8h8RS8Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrHUwbX3M0+UoTbnsMpGYFBildKD2f/lpJXAvON6TDomzdhKP5thcHWFigXpTAN996xBteHWR8pwYFeqKam2POLzKPfvLJ8sTVolfX3GzpsZor3hliClDigebocLwNNA/SQ9WdMEBSZ3eZVF4cd+l/z+4bl858mS+Mtc0z+0LyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWk1KiOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33633C4CEF0;
	Tue, 11 Mar 2025 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741706822;
	bh=N5pBHs40qF4tSGmpD9K2uV1M+O09K7VOkhy8h8RS8Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWk1KiOh3m6e+EycK2ezspHCiAKChk9bAQpHOkzhS+et6nLFjCIGFUTniCV2PhePq
	 2UV2jTRAGNhmVy7lVbO0o0CVx/Rk+xRcuYSyLYI8lUZYDtiCnRt2lQyg+PNNRkU/rE
	 YXZcXw7MiCZF1kXQroKTsBm9YIr02t4KLz18Pk6zMimjPLD447Gix4kv1o1d3HHtHj
	 UXKmfDmec0HR2/xkk1x9feLXyPzUJSqoQnTur7F3SuQZaobAq3xxeWr+8ZqWQxfPyp
	 I7wRUWw+pTdq8pKvykzlO5KEkOOVzSi5I27oTo/7F00LQnSFC3NC9Jb7TzFRXz1XNU
	 bzUpsOPq8Vk1Q==
Date: Tue, 11 Mar 2025 10:27:00 -0500
From: Rob Herring <robh@kernel.org>
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, krzysztof.kozlowski+dt@linaro.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mtd: microchip-nand: add atmel pmecc
Message-ID: <20250311152700.GA3573545-robh@kernel.org>
References: <20250311122847.90081-1-balamanikandan.gunasundar@microchip.com>
 <20250311122847.90081-3-balamanikandan.gunasundar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311122847.90081-3-balamanikandan.gunasundar@microchip.com>

On Tue, Mar 11, 2025 at 05:58:46PM +0530, Balamanikandan Gunasundar wrote:
> Add bindings for programmable multibit error correction code controller
> (PMECC).
> 
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> ---
> 
> Changes in v2:
> - Rename filename to match compatible string
> - Add constraints for sam9x7
> - Droped unused dt labels 
> 
> .../devicetree/bindings/mtd/atmel-nand.txt    | 61 -----------------
>  .../bindings/mtd/microchip,pmecc.yaml         | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> index dbbc17a866f2..1934614a9298 100644
> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> @@ -1,64 +1,3 @@
> -* ECC engine (PMECC) bindings:
> -
> -Required properties:
> -- compatible: should be one of the following
> -	"atmel,at91sam9g45-pmecc"
> -	"atmel,sama5d4-pmecc"
> -	"atmel,sama5d2-pmecc"
> -	"microchip,sam9x60-pmecc"
> -	"microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc"
> -- reg: should contain 2 register ranges. The first one is pointing to the PMECC
> -       block, and the second one to the PMECC_ERRLOC block.
> -
> -Example:
> -
> -	nfc_io: nfc-io@70000000 {
> -		compatible = "atmel,sama5d3-nfc-io", "syscon";
> -		reg = <0x70000000 0x8000000>;
> -	};
> -
> -	pmecc: ecc-engine@ffffc070 {
> -		compatible = "atmel,at91sam9g45-pmecc";
> -                reg = <0xffffc070 0x490>,
> -                      <0xffffc500 0x100>;
> -	};
> -
> -	ebi: ebi@10000000 {
> -		compatible = "atmel,sama5d3-ebi";
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		atmel,smc = <&hsmc>;
> -		reg = <0x10000000 0x10000000
> -		       0x40000000 0x30000000>;
> -		ranges = <0x0 0x0 0x10000000 0x10000000
> -			  0x1 0x0 0x40000000 0x10000000
> -			  0x2 0x0 0x50000000 0x10000000
> -			  0x3 0x0 0x60000000 0x10000000>;
> -		clocks = <&mck>;
> -
> -                nand_controller: nand-controller {
> -			compatible = "atmel,sama5d3-nand-controller";
> -			atmel,nfc-sram = <&nfc_sram>;
> -			atmel,nfc-io = <&nfc_io>;
> -			ecc-engine = <&pmecc>;
> -			#address-cells = <2>;
> -			#size-cells = <1>;
> -			ranges;
> -
> -			nand@3 {
> -				reg = <0x3 0x0 0x800000>;
> -				atmel,rb = <0>;
> -
> -				/*
> -				 * Put generic NAND/MTD properties and
> -				 * subnodes here.
> -				 */
> -			};
> -		};
> -	};
> -
> ------------------------------------------------------------------------
> -
>  Deprecated bindings (should not be used in new device trees):
>  
>  Required properties:
> diff --git a/Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml b/Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml
> new file mode 100644
> index 000000000000..98260a691a2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/microchip,pmecc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip pmecc controller
> +
> +maintainers:
> +  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  Bindings for microchip Programmable Multibit Error Correction Code
> +  Controller (PMECC). pmecc is a programmable BCH encoder/decoder. This
> +  block is passed as the value to the "ecc-engine" property of microchip
> +  nand flash controller node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,at91sam9g45-pmecc
> +          - atmel,sama5d2-pmecc
> +          - atmel,sama5d4-pmecc
> +          - microchip,sam9x60-pmecc
> +          - microchip,sam9x7-pmecc

Both alone and with a fallback should not be allowed. Pick one. A 
fallback is only useful if there's a driver/client that only understands 
the fallback and would work with the new implementation. IOW, if 'they 
are the same'.

> +      - items:
> +          - const: microchip,sam9x7-pmecc
> +          - const: atmel,at91sam9g45-pmecc
> +      - items:
> +          - const: microchip,sam9x60-pmecc
> +          - const: atmel,at91sam9g45-pmecc

Combine the last 2 'items' to 1 as the fallback is the same for both.

> +
> +  reg:
> +    items:
> +      - description: Base address and size of PMECC controller registers
> +      - description: Base address and size of PMECC_ERRLOC controller

Drop 'Base address and size of '.

> +
> +  clocks:
> +    description: The clock source for pmecc controller

For a single clock, what else would it be? Drop.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,sam9x7-pmecc
> +    then:
> +      properties:
> +        clocks:
> +          description: The clock source for pmecc controller

What's the purpose of this if/then? It doesn't do anything.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ecc-engine@ffffc070 {
> +        compatible = "microchip,sam9x7-pmecc";
> +        reg = <0xffffe000 0x300>,
> +              <0xffffe600 0x100>;
> +        clocks = <&pmc 2 48>;
> +    };
> -- 
> 2.34.1
> 

