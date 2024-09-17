Return-Path: <linux-kernel+bounces-331344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021597AB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FA31C213AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12B213049E;
	Tue, 17 Sep 2024 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXyvubyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B61A920;
	Tue, 17 Sep 2024 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555182; cv=none; b=UkzV+i65lEYIC06wkkbrJteTmRE0vbB0nYyGXRRXnT705LZTO+QFU8MnzGVjOoObJMPye+tqEnKBXGNMeB3nS4dOE9NRC41df/enQNqWqqIQX6uj/2o/iFFL9tF1SfQCyqJ7zvBcr83eO57SuYEEyoKUDLIjuJ/alf3NIlop6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555182; c=relaxed/simple;
	bh=KOEJZeVljojcmRdwqwJWhjQoq6gbxqBjzRiz12hG9lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2J6svtYdP9C8esx5iFjTcE9cEAUsrcVezqrPfOAF5UXdFqY6zBwbHm/JrqX184KKXA/gWb1Xm1ceSzjdulgUuAuxr/FZbZ9PRttyfanIHXlSwHFwMXlJ3ydb1Shff9z3+yil+ale6Y6sFlJdBYyHpPUFyYnJMlDorRvwTiXZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXyvubyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2762AC4CEC6;
	Tue, 17 Sep 2024 06:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726555182;
	bh=KOEJZeVljojcmRdwqwJWhjQoq6gbxqBjzRiz12hG9lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXyvubyGaCUUsTrHT+W7VZ7JeaIytYlT3RDrRDLrKg0sS6oE6PMzgPaDG91555GFs
	 0Tzg4SM3D6OH2dOdx83Qy6CvHDAUZwf4yazQcDTdX9p/lOGxPyWCDb1FR/qF/xvGYf
	 V10susybUX8F7Vd9CaqjgDsV4DRyQE9r6Gj7JAIy5Un42raGcSMmsif99H5T12BgYx
	 44c+hzVKxXIZ07xoLR0r7wL2CMpd9Hh5/WciDMr7a/LZ9H7Z1lZ0G/439wKpFL7T51
	 2tGLthWSxHpVT01kFntNdV3lxaHP6ULgYwzI0s5Ntl0WdwQA5mOQjhTR9x5DnB6Ng7
	 3g0wfta/r/ZBg==
Date: Tue, 17 Sep 2024 08:39:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
	Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: spacemit: Add clock
 controllers of Spacemit K1 SoC
Message-ID: <zsayhliz4a4fauzmvkimd4uzucuunt6gmkypjlqh4omle4uqx4@cbknudobc57g>
References: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221BDC11EE244C7D70C229DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SEYPR01MB4221BDC11EE244C7D70C229DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>

On Mon, Sep 16, 2024 at 10:23:09PM +0000, Haylen Chu wrote:
> Add definition for the clock controllers of Spacemit K1 SoC. The clock
> tree is managed by several SoC parts, thus different compatible strings
> are added for each.
> 
> spacemit,k1-syscon.yaml is updated as well to allow clock controller
> being its subnode.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>

Please order patches correctly. First this, then the parent so you will
not submit incomplete binding.

You still must test it, though :(

> ---
>  .../bindings/clock/spacemit,k1-ccu.yaml       |  71 +++++++
>  .../soc/spacemit/spacemit,k1-syscon.yaml      |   4 +
>  include/dt-bindings/clock/spacemit,k1-ccu.h   | 198 ++++++++++++++++++
>  3 files changed, 273 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
>  create mode 100644 include/dt-bindings/clock/spacemit,k1-ccu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml b/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
> new file mode 100644
> index 000000000000..0186722cfd87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/spacemit,k1-ccu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spacemit K1 SoC Clock Controller
> +
> +maintainers:
> +  - Haylen Chu <heylenay@outlook.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - spacemit,k1-ccu-apbs
> +      - spacemit,k1-ccu-mpmu
> +      - spacemit,k1-ccu-apbc
> +      - spacemit,k1-ccu-apmu
> +
> +  clocks:
> +    minItems: 4

Drop

> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: clk_32k
> +      - const: vctcxo_1
> +      - const: vctcxo_24
> +      - const: vctcxo_3
> +
> +  spacemit,mpmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing "Main PMU (MPMU)" registers. It is used to
> +      check PLL lock status.
> +
> +  "#clock-cells":
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/spacemit,k1-ccu.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +
> +additionalProperties: false

Move it after allOf block

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,k1-ccu-apbs
> +    then:
> +      required:
> +        - compatible
> +        - "#clock-cells"

Drop both, redundant


> +        - spacemit,mpmu
> +
> +examples:
> +  - |
> +    syscon_apbs: system-control@d4090000 {

Only one example, keep it in parent node.

> +        compatible = "spacemit,k1-apbs-syscon", "syscon", "simple-mfd";
> +        reg = <0x0 0xd4090000 0x0 0x1000>;
> +
> +        clk_apbs: clock-controller {
> +            compatible = "spacemit,k1-ccu-apbs";
> +            #clock-cells = <1>;
> +            spacemit,mpmu = <&syscon_mpmu>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> index 4e3a72b48aff..08efda207101 100644
> --- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> @@ -27,6 +27,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clock-controller:
> +    $ref: /schemas/clock/spacemit,k1-ccu.yaml#
> +    type: object
> +

This MUST be part of other patch.

Best regards,
Krzysztof


