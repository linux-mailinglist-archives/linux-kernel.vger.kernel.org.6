Return-Path: <linux-kernel+bounces-183656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F38C9C25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC38280EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8F5380C;
	Mon, 20 May 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVIBQDl0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14D535B8;
	Mon, 20 May 2024 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716204959; cv=none; b=njpaOu4lTuROa3ba4P9wv9dwU+aMhs5hgNYpEV/rkwK6ZX+f1rK6ZAviV++z9tBUfPo7cP53eHSnHruHpf7ekovdZZflEPEN8eAZx8A0NOnKjpS2A9jxJbimmsUr4qtmgRuMQv/xnxT4x0y6nLdu6/z5JB4CekD44PBL0x8XDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716204959; c=relaxed/simple;
	bh=Hr/sWpeUV4cl98aDq73+/+6wpJS0JdebCeE2AtUog1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhJITpvJv3FxmKcNJd8Em/T/Xh4O7P1ziyNCIEXrLKDHkGYkCYL0+zlZisaP9yBGCblE2JTLiYI5fJWIxTRpqXdqkAkyxZ6XXjbDC9HeC8QJ+ggo4BdTIWEqpATXx7mJ8TT7sU6bqVoyKYfunVqJvNDdi1enbyXW+HXTCtKqfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVIBQDl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862B4C2BD10;
	Mon, 20 May 2024 11:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716204959;
	bh=Hr/sWpeUV4cl98aDq73+/+6wpJS0JdebCeE2AtUog1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nVIBQDl0Nk1gGYdr5G236zMGr3nqnH80mYQZX4OsdOgz5Zz5rfwLB11Xr2On2CoNB
	 YBBVy5IpKjQaVkwuoc2Q3rlQ4aXtQroy1TSQIlGYj6SEclPW9aapiQnSEqE07CeBfE
	 4MDo+Mjm45zvxXAYpbYmSsc/njUqzC4qGWIX31ee7V2yE4qpaxgIdJY9TxV93HXXoQ
	 U9FW64E+dqgtI/vGzw56x9CzZdCTZqGf8zS84bRgCkBZX7ykpKoMe/tUO7kEC5OohL
	 dDiYyVS4thGxzCS2CsCOTjGPdlYbV0lF5aqyM0Om6isKGyjcTtfbDST5jTZM/2SUJW
	 sXgcN5zCwXinw==
Message-ID: <b3145cd3-f6d4-4778-938c-33eb6ed6de5d@kernel.org>
Date: Mon, 20 May 2024 14:35:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: soc: ti: am62-system-controller: add
 AM62 syscon
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
 <20240518-dt-bindings-ti-soc-mfd-v1-1-b3952f104c9a@linaro.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-1-b3952f104c9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/05/2024 23:07, Krzysztof Kozlowski wrote:
> Add dedicated binding for AM62 and AM62A wakeup system controller
> registers, already used in the DTS to properly describe their children.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/ti/ti,am62-system-controller.yaml | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am62-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am62-system-controller.yaml
> new file mode 100644
> index 000000000000..d3bd67717999
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am62-system-controller.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/ti/ti,am62-system-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI AM62 System Controller Registers R/W
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>

Above email might be invalid. Please use this instead

Kishon Vijay Abraham I <kishon@kernel.org>

> +  - Roger Quadros <rogerq@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,am62-system-controller
> +          - ti,am62a-system-controller
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^chipid@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/hwinfo/ti,k3-socinfo.yaml#
> +
> +  "^syscon@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      compatible:
> +        items:
> +          - const: ti,am62-usb-phy-ctrl
> +          - const: syscon
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@43000000 {
> +        compatible = "ti,am62-system-controller", "syscon", "simple-mfd";
> +        reg = <0x43000000 0x20000>;
> +        bootph-all;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x43000000 0x20000>;
> +
> +        chipid@14 {
> +            compatible = "ti,am654-chipid";
> +            reg = <0x14 0x4>;
> +            bootph-all;
> +        };
> +
> +        syscon@4008 {
> +            compatible = "ti,am62-usb-phy-ctrl", "syscon";
> +            reg = <0x4008 0x4>;
> +        };
> +    };
> 

-- 
cheers,
-roger

