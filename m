Return-Path: <linux-kernel+bounces-357879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CC6997744
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B052839A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E581E22E6;
	Wed,  9 Oct 2024 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGgRIQKN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801F13A409;
	Wed,  9 Oct 2024 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508278; cv=none; b=B8BwIBLlkeZkPbsTr3HvI5ncJcfX9E7usUNnRbc1GjMHjutZZTDVgn791dPhi9Ynf4R5DokumfCeBTo9W3Jr827ke9zX3IJmlZy37Z8LuNHKsVq8IgYXljuyABRE3brzkGTBAQEmXQXAYqTxmf94i+G8+bl9XF3sOzCaxG/2lSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508278; c=relaxed/simple;
	bh=2qQdeHWaX+qTxGR0KQZi4qkIcfoXEQWS9Egj0Q4nlf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTevSyJqF34B13puhw/EHZCUb8B47upN01o4HEah7NcjGKLhllLLSeaH3TpsdQ1pIisZj6bE645X2E0AvLXaOfo2AFTf8QMLKQEeiylHl3SE8oJ/PM/+HyYYIWSb8Ih8uPOjHFapwH3mYRIDiUypQhw9WrlCOu2S3o8OutNT90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGgRIQKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B49C4CEC3;
	Wed,  9 Oct 2024 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728508278;
	bh=2qQdeHWaX+qTxGR0KQZi4qkIcfoXEQWS9Egj0Q4nlf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGgRIQKNVPuCm/Ouid8MPqRKI3K90ejJcdcKpPB8YxRDkqFsG64eUWGa0uYxlxayn
	 RYHOso+H6e9C0KlL6R1BFsrZrlFp3dFPkB5vhaHIP0VLr3K6IsTxzHwqOPbM5sLTcE
	 b/Ak83oCC9ep8LThG1oxTmU3ai+ewYmbl7biY9noBbyiWXVtwV10kQeZNyD68oqSA1
	 pHDyLzQu6dqBXY5K9ir2ySoTRPwfS7ArseORsVHhGLh079BfQY3AAsf4zu/vC7fHzR
	 FY8xZ2aXkhG7p4yMWUH1QyMHqcgUmPHmlqEdax0MwsK8ZsW0KQB5pWyZzPyTDy/oj7
	 v1Ef5s59J/75A==
Date: Wed, 9 Oct 2024 16:11:16 -0500
From: Rob Herring <robh@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: tglx@linutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC
Message-ID: <20241009211116.GA676770-robh@kernel.org>
References: <20241009115813.2908803-1-kevin_chen@aspeedtech.com>
 <20241009115813.2908803-2-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009115813.2908803-2-kevin_chen@aspeedtech.com>

On Wed, Oct 09, 2024 at 07:58:12PM +0800, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) contain second level and
> third level interrupt controller.
> 
> INTC0:
> The second level INTC, which used to assert GIC(#192~#197) if interrupt
> in INTC1 asserted. There are 6 GIC interrupt number(#192~#197) used in
> one INTC0.
> 
> INTC1_x:
> The third level INTC, which used to assert GIC(#192~#197) if interrupt in
> INTC1 asserted. There are 6 GIC interrupt number(#192~#197) used in one INTC0.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> new file mode 100644
> index 000000000000..650a1f6e1177
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed AST2700 Interrupt Controller
> +
> +description:
> +  This interrupt controller hardware is second level interrupt controller that
> +  is hooked to a parent interrupt controller. It's useful to combine multiple
> +  interrupt sources into 1 interrupt to parent interrupt controller.
> +
> +maintainers:
> +  - Kevin Chen <kevin_chen@aspeedtech.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2700-intc-ic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2

Describe the meaning of the cells here.

> +
> +  interrupts:
> +    maxItems: 10
> +    description:

You need '|' to preserve formatting.

> +      Depend to which INTC0 or INTC1 used.
> +      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
> +      status registers for use.
> +      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> +      INTC1 is used to assert INTC0 if interrupt of modules asserted.
> +      +-----+   +-------+     +---------+---module0
> +      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
> +      |     |   |       |  |  |         |---...
> +      +-----+   +-------+  |  +---------+---module31
> +                           |
> +                           |   +---------+---module0
> +                           +---| INTC1_1 |---module2
> +                           |   |         |---...
> +                           |   +---------+---module31
> +                          ...
> +                           |   +---------+---module0
> +                           +---| INTC1_5 |---module2
> +                               |         |---...
> +                               +---------+---module31
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        interrupt-controller@12101b00 {
> +            compatible = "aspeed,ast2700-intc-ic";
> +            reg = <0 0x12101b00 0 0x10>;
> +            #interrupt-cells = <2>;
> +            interrupt-controller;
> +            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> -- 
> 2.34.1
> 

