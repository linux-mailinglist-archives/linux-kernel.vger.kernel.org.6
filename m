Return-Path: <linux-kernel+bounces-571968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC8A6C4C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2ED3B8127
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5A22FE1F;
	Fri, 21 Mar 2025 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpRv4R6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346141E991D;
	Fri, 21 Mar 2025 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591104; cv=none; b=eQLHlEalm22gsUm8i4pB08iAxdzSwh6tf9zra83PSbTpoOvbGvjkeRZqpRYRkYpizaZsEhjSLg36bT72ih0bDMXIiaQ7+d5fb/Kvp/FRQ9bm7M2roKQuaeTDt8RVrxR3WUossnNUxHGQ9ZngU5guAo3yNwBW9gKP5H0KlqIqAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591104; c=relaxed/simple;
	bh=A9FUC3QyUqSWEHdchGeECptIKSK+nMDFJ+yvdlBJ5A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0cxcNexHo+98qceqnjfSgiB371SOQ7J35JdCcQv5KzqY+wCG743jA5kr60Cth2+h4kdDKm8J1YLeYmvRbijAR6uHoG2SHjGKGhsDGF6yjH/azDZ/pXc/p3XzJ8sqUNAwj0007w5/UbFEsnJOAAxmcepbQVz3JhFjAeprAInMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpRv4R6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796F2C4CEE3;
	Fri, 21 Mar 2025 21:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742591103;
	bh=A9FUC3QyUqSWEHdchGeECptIKSK+nMDFJ+yvdlBJ5A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpRv4R6MzxwOOJZp90MblHHDhWmYvVrc5uA6Jxtn/txEGu6rgLMCloYMPokZC0t4H
	 TKtYfGk9GFtYUmVocoipcebaKNF2H/E237K66IEIYxnF2fhANQZHraBcVbAHwFJWk5
	 BUAntDCF679V5mpXR89t3FHDGJEGMEEef4ca/KJiBU5gTdnmTMi22DR7h6FQHPsPoa
	 efte32JKWoJwDA/JK2I0HrogwYtxcO9l1E1ysh5CF1455NxxOA57sdlnhyWJRTLVlT
	 ER9iiz8/cLen/CxJeWxIzk8WHkSiHdbZewHHzuPSriF5+JEp0l/UgC2kZTCpfUmkkW
	 CEjvxB5ebnL0g==
Date: Fri, 21 Mar 2025 16:05:02 -0500
From: Rob Herring <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: edac: altera-s10: Convert to YAML
Message-ID: <20250321210502.GA3912181-robh@kernel.org>
References: <20250321153109.8362-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321153109.8362-1-matthew.gerlach@altera.com>

On Fri, Mar 21, 2025 at 08:31:09AM -0700, Matthew Gerlach wrote:
> Convert the device tree bindings for the Altera Stratix10 SoCFPGA ECC
> Manager from text to yaml.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v2:
>  - Fix $id: path.
>  - Remove unneeded '|'.
>  - Move vendor properties last (but before child nodes).
>  - Add appropriate blank lines.
>  - Don't break ABI.
>  - Avoid changing existing DTSI and DTS.
> ---
>  .../edac/altr,socfpga-s10-ecc-manager.yaml    | 280 ++++++++++++++++++
>  .../bindings/edac/socfpga-eccmgr.txt          | 150 ----------
>  MAINTAINERS                                   |   5 +
>  3 files changed, 285 insertions(+), 150 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> new file mode 100644
> index 000000000000..a908bb4df60f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> @@ -0,0 +1,280 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2025 Altera Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/altr,socfpga-s10-ecc-manager.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera Stratix10 SoCFPGA ECC Manager (ARM64)
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@altera.com
> +
> +description:
> +  The Stratix10 implementation of the SoCFPGA ECC Manager counts and corrects
> +  single bit errors. Double bit errors are treated as SErrors in ARM64. This
> +  implementation requires access to registers only available to the Secure
> +  Device Manager (SDM) via Secure Monitor Calls (SMC).
> +
> +properties:
> +
> +  compatible:
> +    $ref: /schemas/types.yaml#/definitions/string-array

compatible already has a type, drop this. Elsewhere too.

> +    description: list of compatibles

Don't need generic descriptions. Drop.

> +    items:
> +      - const: altr,socfpga-s10-ecc-manager
> +      - const: altr,socfpga-a10-ecc-manager

This doesn't work for socfpga_arria10.dtsi. You need:

oneOf:
  - items:
      - const: altr,socfpga-s10-ecc-manager
      - const: altr,socfpga-a10-ecc-manager
  - const: altr,socfpga-a10-ecc-manager

Make sure the other compatibles pass validation too.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +  altr,sysmgr-syscon:
> +    maxItems: 1

       $ref: /schemas/types.yaml#/definitions/phandle

And a description of what this is for.

> +
> +  sdramedac:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: altr,sdram-edac-s10
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      altr,sdr-syscon:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to SDRAM parent
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - altr,sdr-syscon
> +
> +  ocram-ecc@ff8cc000:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: list of compatibles
> +        items:
> +          - const: altr,socfpga-s10-ocram-ecc
> +          - const: altr,socfpga-a10-ocram-ecc
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to OCRAM parent
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - altr,ecc-parent
> +
> +  usb0-ecc@ff8c4000:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: list of compatibles
> +        items:
> +          - const: altr,socfpga-s10-usb-ecc
> +          - const: altr,socfpga-usb-ecc
> +
> +      reg:
> +        maxItems: 1
 > +
> +      interrupts:
> +        maxItems: 1
> +
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to USB parent
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - altr,ecc-parent
> +
> +  emac0-rx-ecc@ff8c0000:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: list of compatibles
> +        items:
> +          - const: altr,socfpga-s10-eth-mac-ecc
> +          - const: altr,socfpga-eth-mac-ecc
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to ethernet parent
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - altr,ecc-parent
> +
> +  emac0-tx-ecc@ff8c0400:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: list of compatibles
> +        items:
> +          - const: altr,socfpga-s10-eth-mac-ecc
> +          - const: altr,socfpga-eth-mac-ecc
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to ethernet parent
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - altr,ecc-parent
> +
> +  sdmmca-ecc@ff8c8c00:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: list of compatibles
> +        items:
> +          - const: altr,socfpga-s10-sdmmc-ecc
> +          - const: altr,socfpga-sdmmc-ecc
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 2
> +
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to ethernet parent

SD/MMC parent?

Rob

