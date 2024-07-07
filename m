Return-Path: <linux-kernel+bounces-243569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630A9297D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395DE1C209AA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6C1E492;
	Sun,  7 Jul 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF5f9Hhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4B18C31;
	Sun,  7 Jul 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720355705; cv=none; b=iDgxN8XB8Z/ggEb7aBd4uuU2O6eGSvVsF0GwEbqm0kaAyCuM6kSIvNFWV/nfxQF9H3XgXe9PkMLSxDySmhiH6bsLKIBrRl9cuX5XJgcivvTLzi/uBem6K1V1A3zDWLwSnt4aA0E8cxCgL/c/65lNyBsf5an3xJQl1LTgHPbbl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720355705; c=relaxed/simple;
	bh=WWN+fePr3kxsmN+FBpOBpPnJnDZrGl72GjXhpYaus9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KT+WG/sYS0HcLMmaSUV09r5+n8w4xXV3OOD0LWOo/SnWqhQ6pbAPdxD3sGspJMDBzOz+GoOyIGcXtdwGNXLORu2w8f3zkObQLALPC/RdsGEF+eqznYU2iRlMqCMh1GtfppoIz7dRB+cM7dXytA2weE2Sz4VpdaYQd8hTypi7Fxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF5f9Hhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE07C3277B;
	Sun,  7 Jul 2024 12:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720355704;
	bh=WWN+fePr3kxsmN+FBpOBpPnJnDZrGl72GjXhpYaus9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QF5f9HhquPLiwmrVo/gRMcIOlCTzQnAf5n+HE7QGwsnNhd8dbtOd69gPsPlD9gofR
	 m6kwq3XUiE6JG76f3ZLj2q6V/YNTLckIi/SjXzMX2uXFrJZI6Z9ERWN7dm7E4+SVzg
	 LdU6kHAr28NcD0OMDDdVUVllGACPG1H9U6T8m/bdjAes/hXeHq/4wkxNnNq8PbpVna
	 t2B26l3cEekU2By3/dXuGALNQKfsPMcIwRTNBY+xSpmBBxk49GNgVtx3oaUDCvhJS0
	 sw5wMEPMkrVQ+m9Vl7a+3hFRXZYLMCVW7m0ZsiE9EU20tlQ/Rfc9PT0P9NX85vDrxi
	 vtb63DgjJgYwA==
Message-ID: <450d1575-c9b3-413b-bfa9-8dc4352fa263@kernel.org>
Date: Sun, 7 Jul 2024 14:34:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
 <20240705-imx-se-if-v4-2-52d000e18a1d@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240705-imx-se-if-v4-2-52d000e18a1d@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 15:52, Pankaj Gupta wrote:
> The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> creates an embedded secure enclave within the SoC boundary to enable
> features like:
> - HSM
> - SHE
> - V2X
> 
> Secure-Enclave(s) communication interface are typically via message
> unit, i.e., based on mailbox linux kernel driver. This driver enables
> communication ensuring well defined message sequence protocol between
> Application Core and enclave's firmware.
> 
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications, to be able to communicate over single MU.
> 
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

This binding is not improving, even though it is v5.

> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 133 +++++++++++++++++++++
>  1 file changed, 133 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> new file mode 100644
> index 000000000000..b9018645101d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> +
> +maintainers:
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +
> +description: |
> +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> +  enables features like
> +    - Hardware Security Module (HSM),
> +    - Security Hardware Extension (SHE), and
> +    - Vehicular to Anything (V2X)
> +
> +  Communication interface to the secure-enclaves is based on the
> +  messaging unit(s).
> +
> +properties:
> +  $nodename:
> +    pattern: "firmware@[0-9a-f]+$"
> +
> +  compatible:
> +    enum:
> +      - fsl,imx8ulp-se
> +      - fsl,imx93-se
> +      - fsl,imx95-se
> +
> +  reg:
> +    maxItems: 1
> +    description: Identifier of the communication interface to secure-enclave.
> +
> +  mboxes:
> +    description: contain a list of phandles to mailboxes.

Drop, obvious.

> +    items:
> +      - description: Specify the mailbox used to send message to se firmware
> +      - description: Specify the mailbox used to receive message from se firmware

Drop redundant/obvious parts.

So two mailboxes?

> +
> +  mbox-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +      - const: txdb
> +      - const: rxdb

4 mailboxes? This cannot be different.

> +    minItems: 2
> +
> +  memory-region:
> +    description: contains the phandle to reserved external memory.

Drop

> +    items:
> +      - description: It is used by secure-enclave firmware. It is an optional
> +          property based on compatible and identifier to communication interface.
> +          (see bindings/reserved-memory/reserved-memory.txt)
> +
> +  sram:
> +    description: contains the phandle to sram.

Drop

> +    items:
> +      - description: Phandle to the device SRAM. It is an optional property
> +          based on compatible and identifier to communication interface.
> +
> +required:
> +  - compatible
> +  - reg
> +  - mboxes
> +  - mbox-names
> +
> +additionalProperties: false

Keep it after allOf block


> +
> +allOf:
> +  # memory-region
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-se
> +              - fsl,imx93-se
> +    then:
> +      required:
> +        - memory-region
> +    else:
> +      properties:
> +        memory-region: false
> +
> +  # sram
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-se
> +    then:
> +      required:
> +        - sram
> +
> +    else:
> +      properties:
> +        sram: false
> +
> +examples:
> +  - |
> +    firmware {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      firmware@0 {
> +        compatible = "fsl,imx95-se";
> +        reg = <0x0>;
> +        mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> +        mbox-names = "tx", "rx";
> +      };

One example is enough.


Best regards,
Krzysztof


