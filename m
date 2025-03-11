Return-Path: <linux-kernel+bounces-556435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB33A5C8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846FD1885DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071F25E80C;
	Tue, 11 Mar 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL82uFWA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BD3EA76;
	Tue, 11 Mar 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707761; cv=none; b=PwSAiN4eGtbYxh6zXbxHnUWuKwwQoTfF1VGhi5FQhFyYbn1hmokZ7/WWwGU+UOWRlWH8X9Ao5cSS0jOiXr1etjCL/jB9aiBTEOfuIgMOLxaXEOT/6pCU2MF9rTiWcXc8rOObd9iPj/Th1vj/hwWncfuockSF6QX7mHIpAP9c5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707761; c=relaxed/simple;
	bh=89x/1qxFEYxTYOSIdKWCTAJ1qovLRzV2USmp6ofGHfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2yo8498lcQ8uLZM85V4/q8PVecSTWktOt21ngxpfBlHJFi+x6MBALpS12wGTvYGSLy8EeWy/4ihRQOaxvfhka5MdudE9a6m7jsvbZHKiJguVw6R5fmlmWzzmBNzxlcAtdfHw4z8KjgS7miEaPVxnDgCxffToX3iH2pWniLp0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL82uFWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA09C4CEE9;
	Tue, 11 Mar 2025 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741707760;
	bh=89x/1qxFEYxTYOSIdKWCTAJ1qovLRzV2USmp6ofGHfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mL82uFWAHCdJRJBYb8f9ZwLNXMqPJpCpj6b7iIzW8FGvpC9GTgrOAVvdt6lsimhXq
	 Pm7SHQxPJglKWFH2SWxlNakL6yg8TmAJRtKywXfGNvrd/Ur8LSaWk6E7wJf1qQH+Cn
	 9XQuAg3+ggBfO45YbCP1ncGJwCh/d/NRSGa5zi0swfZs2pOmTiGNATf5bamuA5VBye
	 0fB2rvEgNUisq8vBIqUrw6vjKg6noLgKMT5/JUmRepWirYThFoiFIctnTZ8iGWtedS
	 fwhEXvJ9GLKC+Di7MnyrIsUg7/8TAQn3XxvK4AF1/XYwxq9jF8H4Jbf8RFHnn5lQph
	 wHMNgF9iblMmA==
Date: Tue, 11 Mar 2025 10:42:39 -0500
From: Rob Herring <robh@kernel.org>
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, krzysztof.kozlowski+dt@linaro.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: atmel-nand: add legacy nand
 controllers
Message-ID: <20250311154239.GB3573545-robh@kernel.org>
References: <20250311122847.90081-1-balamanikandan.gunasundar@microchip.com>
 <20250311122847.90081-4-balamanikandan.gunasundar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311122847.90081-4-balamanikandan.gunasundar@microchip.com>

On Tue, Mar 11, 2025 at 05:58:47PM +0530, Balamanikandan Gunasundar wrote:
> Add support for atmel legacy nand controllers. These bindings should not be
> used with the new device trees.
> 
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> ---
> 
> Changes in v2:
> 
> - Filename matching the compatibles
> - Remove "bindings" from the subject
> - Remove "deprecated" as these are the only bindings available for the devices
> - Add missing constraints.
> - Add default for nand-ecc-mode
> - Add 32 in pmecc-cap for sama5d2
> - Add default for sector-size, pmecc-lookup-table-offset, nand-bus-width
> 
>  .../devicetree/bindings/mtd/atmel-nand.txt    | 116 -------------
>  .../devicetree/bindings/mtd/atmel-nand.yaml   | 163 ++++++++++++++++++
>  2 files changed, 163 insertions(+), 116 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> deleted file mode 100644
> index 1934614a9298..000000000000
> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -Deprecated bindings (should not be used in new device trees):
> -
> -Required properties:
> -- compatible: The possible values are:
> -	"atmel,at91rm9200-nand"
> -	"atmel,sama5d2-nand"
> -	"atmel,sama5d4-nand"
> -- reg : should specify localbus address and size used for the chip,
> -	and hardware ECC controller if available.
> -	If the hardware ECC is PMECC, it should contain address and size for
> -	PMECC and PMECC Error Location controller.
> -	The PMECC lookup table address and size in ROM is optional. If not
> -	specified, driver will build it in runtime.
> -- atmel,nand-addr-offset : offset for the address latch.
> -- atmel,nand-cmd-offset : offset for the command latch.
> -- #address-cells, #size-cells : Must be present if the device has sub-nodes
> -  representing partitions.
> -
> -- gpios : specifies the gpio pins to control the NAND device. detect is an
> -  optional gpio and may be set to 0 if not present.
> -
> -Optional properties:
> -- atmel,nand-has-dma : boolean to support dma transfer for nand read/write.
> -- nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
> -  Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
> -  "soft_bch".
> -- atmel,has-pmecc : boolean to enable Programmable Multibit ECC hardware,
> -  capable of BCH encoding and decoding, on devices where it is present.
> -- atmel,pmecc-cap : error correct capability for Programmable Multibit ECC
> -  Controller. Supported values are: 2, 4, 8, 12, 24. If the compatible string
> -  is "atmel,sama5d2-nand", 32 is also valid.
> -- atmel,pmecc-sector-size : sector size for ECC computation. Supported values
> -  are: 512, 1024.
> -- atmel,pmecc-lookup-table-offset : includes two offsets of lookup table in ROM
> -  for different sector size. First one is for sector size 512, the next is for
> -  sector size 1024. If not specified, driver will build the table in runtime.
> -- nand-bus-width : 8 or 16 bus width if not present 8
> -- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
> -
> -Nand Flash Controller(NFC) is an optional sub-node
> -Required properties:
> -- compatible : "atmel,sama5d3-nfc".
> -- reg : should specify the address and size used for NFC command registers,
> -        NFC registers and NFC SRAM. NFC SRAM address and size can be absent
> -        if don't want to use it.
> -- clocks: phandle to the peripheral clock
> -Optional properties:
> -- atmel,write-by-sram: boolean to enable NFC write by SRAM.
> -
> -Examples:
> -nand0: nand@40000000,0 {
> -	compatible = "atmel,at91rm9200-nand";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	reg = <0x40000000 0x10000000
> -	       0xffffe800 0x200
> -	      >;
> -	atmel,nand-addr-offset = <21>;	/* ale */
> -	atmel,nand-cmd-offset = <22>;	/* cle */
> -	nand-on-flash-bbt;
> -	nand-ecc-mode = "soft";
> -	gpios = <&pioC 13 0	/* rdy */
> -		 &pioC 14 0 	/* nce */
> -		 0		/* cd */
> -		>;
> -	partition@0 {
> -		...
> -	};
> -};
> -
> -/* for PMECC supported chips */
> -nand0: nand@40000000 {
> -	compatible = "atmel,at91rm9200-nand";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	reg = < 0x40000000 0x10000000	/* bus addr & size */
> -		0xffffe000 0x00000600	/* PMECC addr & size */
> -		0xffffe600 0x00000200	/* PMECC ERRLOC addr & size */
> -		0x00100000 0x00100000	/* ROM addr & size */
> -		>;
> -	atmel,nand-addr-offset = <21>;	/* ale */
> -	atmel,nand-cmd-offset = <22>;	/* cle */
> -	nand-on-flash-bbt;
> -	nand-ecc-mode = "hw";
> -	atmel,has-pmecc;	/* enable PMECC */
> -	atmel,pmecc-cap = <2>;
> -	atmel,pmecc-sector-size = <512>;
> -	atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
> -	gpios = <&pioD 5 0	/* rdy */
> -		 &pioD 4 0	/* nce */
> -		 0		/* cd */
> -		>;
> -	partition@0 {
> -		...
> -	};
> -};
> -
> -/* for NFC supported chips */
> -nand0: nand@40000000 {
> -	compatible = "atmel,at91rm9200-nand";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges;
> -        ...
> -        nfc@70000000 {
> -		compatible = "atmel,sama5d3-nfc";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		clocks = <&hsmc_clk>
> -		reg = <
> -			0x70000000 0x10000000	/* NFC Command Registers */
> -			0xffffc000 0x00000070	/* NFC HSMC regs */
> -			0x00200000 0x00100000	/* NFC SRAM banks */
> -		>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.yaml b/Documentation/devicetree/bindings/mtd/atmel-nand.yaml
> new file mode 100644
> index 000000000000..8afc4a144caf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/atmel-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel NAND flash controller
> +
> +maintainers:
> +  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> +
> +description: |

Don't need '|'.

> +  Atmel nand flash controller. This should not be used for new device
> +  trees. For the latest controllers refer microchip,nand-controller.yaml

This reads more like the h/w changed in newer controllers. Make it clear 
this is deprecated. You can also put at the top-level:

deprecated: true

But you should only put that if you plan to update all in tree .dts 
files to the non-deprecated binding.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91rm9200-nand
> +      - atmel,sama5d2-nand
> +      - atmel,sama5d4-nand
> +
> +  reg:
> +    description:
> +      The localbus address and size used for the chip, and hardware ECC
> +      controller if available. If the hardware ECC is PMECC, it should
> +      contain address and size for PMECC and PMECC Error Location
> +      controller. The PMECC lookup table address and size in ROM is
> +      optional. If not specified, driver will build it in runtime.
> +
> +  atmel,nand-addr-offset:
> +    description:
> +      offset for the address latch.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 31
> +
> +  atmel,nand-cmd-offset:
> +    description:
> +      offset for the command latch.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 31
> +
> +  '#address-cells': true

0-3 is okay?

> +
> +  '#size-cells': true

0-2 is okay?

> +
> +  gpios:
> +    description:
> +      specifies the gpio pins to control the NAND device. detect is an
> +      optional gpio and may be set to 0 if not present.

Which entry is detect? Need to define what each entry is.

> +    minItems: 1
> +    maxItems: 3
> +
> +  atmel,nand-has-dma:
> +    description:
> +      support dma transfer for nand read/write.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  atmel,has-pmecc:
> +    description:
> +      enable Programmable Multibit ECC hardware, capable of BCH encoding
> +      and decoding, on devices where it is present.
> +    $ref: /schemas/types.yaml#/definitions/flag

All vendor specific properties go last.

> +
> +  nand-on-flash-bbt:
> +    description:
> +      enable on flash bbt option if not present false
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  nand-ecc-mode:
> +    description:
> +      operation mode of the NAND ecc
> +    enum:
> +      [none, soft, hw, hw_syndrome, hw_oob_first, soft_bch]
> +    default: soft
> +    $ref: /schemas/types.yaml#/definitions/string

You should be referencing mtd/raw-nand-chip.yaml either directly or 
indirectly. And then drop the type. Same on the others.

> +
> +
> +  atmel,pmecc-cap:
> +    description:
> +      error correct capability for Programmable Multibit ECC Controller.
> +    enum:
> +      [2, 4, 8, 12, 24, 32]
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  atmel,pmecc-sector-size:
> +    description:
> +      sector size for ECC computation.
> +    enum:
> +      [512, 1024]
> +    default: 512
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +
> +  atmel,pmecc-lookup-table-offset:
> +    description:
> +      Two offsets of lookup table in ROM for different sector size. First
> +      one is for sector size 512, the next is for sector size 1024. If not
> +      specified, driver will build the table in runtime.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    default: 512
> +
> +  nand-bus-width:

Before vendor specific properties.

> +    description:
> +      nand bus width
> +    enum:
> +      [8, 16]
> +    default: 8
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - atmel,nand-addr-offset
> +  - atmel,nand-cmd-offset
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    nand@40000000,0 {

Not a correct unit-address.

nand-controller is preferred node name.

> +        compatible = "atmel,at91rm9200-nand";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x40000000 0x10000000
> +               0xffffe800 0x200>;
> +        atmel,nand-addr-offset = <21>;	/* ale */
> +        atmel,nand-cmd-offset = <22>;	/* cle */
> +        nand-on-flash-bbt;
> +        nand-ecc-mode = "soft";
> +        gpios = <&pioC 13 0	/* rdy */
> +                 &pioC 14 0 /* nce */
> +                 0		/* cd */
> +                >;
> +    };
> +  - |
> +    /* for PMECC supported chips */
> +    nand1@40000000 {
> +        compatible = "atmel,at91rm9200-nand";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x40000000 0x10000000	/* bus addr & size */
> +               0xffffe000 0x00000600	/* PMECC addr & size */
> +               0xffffe600 0x00000200	/* PMECC ERRLOC addr & size */
> +               0x00100000 0x00100000>;	/* ROM addr & size */
> +
> +        atmel,nand-addr-offset = <21>;	/* ale */
> +        atmel,nand-cmd-offset = <22>;	/* cle */
> +        nand-on-flash-bbt;
> +        nand-ecc-mode = "hw";
> +        atmel,has-pmecc;	/* enable PMECC */
> +        atmel,pmecc-cap = <2>;
> +        atmel,pmecc-sector-size = <512>;
> +        atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
> +        gpios = <&pioD 5 0	/* rdy */
> +                 &pioD 4 0	/* nce */
> +                 0		/* cd */
> +                >;
> +    };
> -- 
> 2.34.1
> 

