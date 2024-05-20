Return-Path: <linux-kernel+bounces-183667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB98C9C40
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC51B2233F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD653E05;
	Mon, 20 May 2024 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiP1nCzH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B054BE8;
	Mon, 20 May 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205303; cv=none; b=UR+79MXWP9vxUMxSpZCiYooQsIJ5Q/rZegxuoc3k/JkA9jAz4LZ+Ap7TlXxshwYraYl/6lehNR9k9cmBkTd8P9e2yxxUuQ6oOCPsNvqkBbiWOsG2X9i3tM5h9/5Zsn+Jy9Z9MvWwLITTfRBu0qQlsNpo/ET7RbOrWIXFxnONrgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205303; c=relaxed/simple;
	bh=u130tbWpT6LvE50q6tsnZs3h7loPdMb44w2PkpTnAbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQW6Em04gepbJYmmkLRmU6JsJSjPyO294Pb2JFad5OUtL2Fk+iNSfxQ2fHJ/b2HtWrOkRXtmoCgWkx/voIOVw4qF2fOuSfPd9kJDCFAYFCsyDyUEQ12CIDKq5LeaPIAyIeUeju8Uooyx8+AM91yIpcMZzZ4fvHSPRiazGUtlbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiP1nCzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3016AC2BD10;
	Mon, 20 May 2024 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716205303;
	bh=u130tbWpT6LvE50q6tsnZs3h7loPdMb44w2PkpTnAbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EiP1nCzHxOEa+BR7Kpdt3rojQ2goPIuUi6CR+1vWHvRUjXLnPYaw6gBMEjffQLnbz
	 +/CFIgAxdyc7dbPVPNpj2EsuQJEwlY75/Hw+i2f0aoida5RtbXnnOYcHntdzi/AeJq
	 7OmzLIRjjxYW/MhMyv+NRbQ9Dj91lttRf8tNy++iUVluN+BC5Omqckl7dxWtjLLfo8
	 JKD6UeguXk62LjHE+TtjJPIlNgOD/iZt75WkjbbFvPUYhimLhVu8gkCXgGDcmX0Q76
	 8ln0fn+EsWqm7r3OKtiR/x6fRdIhUn5+y45OO1ZEUJ+TVSLhlRYDCMED1u/qHchR2c
	 60A7bnWsGH9Ow==
Message-ID: <6f9f87d3-9570-4eb0-a3d0-f087308d9815@kernel.org>
Date: Mon, 20 May 2024 14:41:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: soc: ti: am645-system-controller: add
 AM654 syscon
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
 <20240518-dt-bindings-ti-soc-mfd-v1-2-b3952f104c9a@linaro.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-2-b3952f104c9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/05/2024 23:07, Krzysztof Kozlowski wrote:
> Add dedicated binding for the AM654 MCU SCM system controller registers,
> already used in the DTS to properly describe its children.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../soc/ti/ti,am654-system-controller.yaml         | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> new file mode 100644
> index 000000000000..e79803e586ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/ti/ti,am654-system-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI AM654 System Controller Registers R/W
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>

Please update the email address to Kishon Vijay Abraham I <kishon@kernel.org>

> +  - Roger Quadros <rogerq@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,am654-system-controller
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
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
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
> +    syscon@40f00000 {
> +        compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
> +        reg = <0x40f00000 0x20000>;
> +        ranges = <0x0 0x40f00000 0x20000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        phy@4040 {
> +            compatible = "ti,am654-phy-gmii-sel";
> +            reg = <0x4040 0x4>;
> +            #phy-cells = <1>;
> +        };
> +    };
> 

-- 
cheers,
-roger

