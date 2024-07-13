Return-Path: <linux-kernel+bounces-251613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F596930705
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 20:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88164B24C60
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8113DDC2;
	Sat, 13 Jul 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdQQLyOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAE25779;
	Sat, 13 Jul 2024 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720895498; cv=none; b=HJv2Q+opwK9DHXvaW9EuMygh0N72QnltNzcx70k2a6/cTyssnQ0u37YmL9WClM751c6gOcSjrxd5rSFdH6labGKWWxGpA7S2zfjv8QDuSg2jnZxBIKepqlVJUurFnkzwWzTmtWLCGMo5q3AZSrk3suABTBZmFN2RBFZLNnvzOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720895498; c=relaxed/simple;
	bh=R6wHy7aWuyIdiwE5tNEQ5nJ8LRorEa5CV9NJfHR06No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdSfwmK77Yjhq3wMnMAF2IcdEZQdzsRtAYo9SqcR68gBLyjgb4EWu9zIge/QbNRSqACyP+bQnIlyVNy1m8JtKZcyLBNHWVTQjy9TXzT/1A9bTdxiiTUsYH2g5C8ZcrrNqszACUbTqR3VqFtvqNrRS2aGocs9ViPesWKDDRsmsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdQQLyOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373CCC32781;
	Sat, 13 Jul 2024 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720895498;
	bh=R6wHy7aWuyIdiwE5tNEQ5nJ8LRorEa5CV9NJfHR06No=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WdQQLyObguVHp0gQxv+Y1vlhB0LQd9NyfS0PJMcQssCZzE6jdtrAnCHYyFJvMVHkK
	 NtVQLUcdVLJg6EUpXOmqHwVg/wrR8JrBA5MEHgZP4H4rvqj5M/QjCh9hMj1VXy9UMK
	 ZYLnUKwwPJtdHplNbT5BrQRyI/x54E1gAXz3lW/3rt3gpFZjIaMmSqCZ6OPseXXzwO
	 TSEQ4SLizURV3q7uYOEru3YROQg0sA+LKJ3ZDwDo7iDy7jrZJxIc6Yq75OJ0XItSsB
	 pREenFeOqishvtM3plx3VNT6JyyCaSdqaUqgfCpzcORss7fSIRhD8gyrW2KAJTNq+j
	 TR90RuR27mZsQ==
Message-ID: <7a419156-d2eb-4810-9281-dc3414320ad1@kernel.org>
Date: Sat, 13 Jul 2024 20:31:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: nvmem: sprd-efuse: convert to YAML
To: Stanislav Jakubek <stano.jakubek@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZpJvRePtbaiG94Te@standask-GA-A55M-S2HP>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZpJvRePtbaiG94Te@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2024 14:12, Stanislav Jakubek wrote:
> Convert the Spreadtrum eFuse bindings to DT schema. Since they are very
> similar, both of the existing Spreadtrum txt bindings were merged into
> one common binding document, named after the only in-tree user, SC2731.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/nvmem/sc27xx-efuse.txt           | 52 -----------
>  .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 88 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/sprd-efuse.txt  | 39 --------
>  3 files changed, 88 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt b/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
> deleted file mode 100644
> index 586c08286aa9..000000000000
> --- a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -= Spreadtrum SC27XX PMIC eFuse device tree bindings =
> -
> -Required properties:
> -- compatible: Should be one of the following.
> -	"sprd,sc2720-efuse"
> -	"sprd,sc2721-efuse"
> -	"sprd,sc2723-efuse"
> -	"sprd,sc2730-efuse"
> -	"sprd,sc2731-efuse"
> -- reg: Specify the address offset of efuse controller.
> -- hwlocks: Reference to a phandle of a hwlock provider node.
> -
> -= Data cells =
> -Are child nodes of eFuse, bindings of which as described in
> -bindings/nvmem/nvmem.txt
> -
> -Example:
> -
> -	sc2731_pmic: pmic@0 {
> -		compatible = "sprd,sc2731";
> -		reg = <0>;
> -		spi-max-frequency = <26000000>;
> -		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		efuse@380 {
> -			compatible = "sprd,sc2731-efuse";
> -			reg = <0x380>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			hwlocks = <&hwlock 12>;
> -
> -			/* Data cells */
> -			thermal_calib: calib@10 {
> -				reg = <0x10 0x2>;
> -			};
> -		};
> -	};
> -
> -= Data consumers =
> -Are device nodes which consume nvmem data cells.
> -
> -Example:
> -
> -	thermal {
> -		...
> -		nvmem-cells = <&thermal_calib>;
> -		nvmem-cell-names = "calibration";
> -	};
> diff --git a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
> new file mode 100644
> index 000000000000..98d1400991d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/sprd,sc2731-efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum eFuse
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc2720-efuse
> +      - sprd,sc2721-efuse
> +      - sprd,sc2723-efuse
> +      - sprd,sc2730-efuse
> +      - sprd,sc2731-efuse
> +      - sprd,ums312-efuse
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: enable
> +
> +  hwlocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - hwlocks
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +  - $ref: nvmem-deprecated-cells.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sprd,ums312-efuse
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +    else:
> +      properties:
> +        clocks: false
> +        clock-names: false

Half of the binding is this "if:", so I would say they are not that
similar. I think it would be easier to read them if these were split
into two bindings.

Best regards,
Krzysztof


