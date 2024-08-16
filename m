Return-Path: <linux-kernel+bounces-290405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB5955366
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46DF283968
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9120145B2D;
	Fri, 16 Aug 2024 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUCKfCOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD85BA33;
	Fri, 16 Aug 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847832; cv=none; b=rmyQ/XGJSpkSjovoYz81Y7SJJ1IpiH+RKhjSgPJRpfwtd2U0NiZyKZD7CMBNwqtviXG4t8yhBwbeI1dXso358D5IgFhBidNTxemuFiKXOuxLd2uaYvntL7Bzo2jIG3tGyU5OPhzD/Os7T+ihrjs0yeoFVVkdYICpsS9HDhlJ604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847832; c=relaxed/simple;
	bh=RyCJlWYK9S6rt9Lmx7407UIS/Kt3nkIojR6T7QOcSVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTuYWeGjw4aKia5XKkz35m+bWDVav2bg7JlDezm8le90azvLINsd1h/9RZXKzMKgK7n4WzJ0ytElJNz0jxNGpsXwmkJ3gBhWg7tV3SSF6XbwqCV9tr15KtLutAyHBIoo/313Bir76iLLj9MRJv+GjVje/fdczHKXoVEM2dyFFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUCKfCOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AD2C32782;
	Fri, 16 Aug 2024 22:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723847831;
	bh=RyCJlWYK9S6rt9Lmx7407UIS/Kt3nkIojR6T7QOcSVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUCKfCOPIoWnxxtaNhk3XFGhAPyv43yiKbbDVhG7Zr0kkKGjzYCAr9mcWiY+aP4m+
	 ESeW/leStl9x6YpaczZi/gZGDTjISCRl6pEUuZ64fLoD6w6fc8jAjEcVUTE753NY88
	 5/y8QS889uZcKOAnh8p2llfxUrNGYdo4eg00NBbhL5GxfcgkWtrVOb0Qe/rQuq9Pz1
	 y/0WWsXo6MA2VkQ6Hfzhi08zHyyS4jk+fAXAQQ0vtpEjBqcPt1GYT7bItwArEtlYb2
	 s0rd0/z7RnPSVBMnoaf51tTn68B6WYxinvj5WAP+jUXvfFcRPT+ROGpCPoaXAPdKnT
	 GCxd9VQUbpDNA==
Date: Fri, 16 Aug 2024 16:37:10 -0600
From: Rob Herring <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org,
	kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
	francesco@dolcini.it, frank.li@nxp.com
Subject: Re: [PATCH v3 06/19] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller command sequencer
Message-ID: <20240816223710.GA2394350-robh@kernel.org>
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <20240724092950.752536-7-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724092950.752536-7-victor.liu@nxp.com>

On Wed, Jul 24, 2024 at 05:29:37PM +0800, Liu Ying wrote:
> i.MX8qxp Display Controller contains a command sequencer is designed to
> autonomously process command lists.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3:
> * New patch. (Rob)
> 
>  .../imx/fsl,imx8qxp-dc-command-sequencer.yaml | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml
> new file mode 100644
> index 000000000000..2e0e8e40a185
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qxp Display Controller Command Sequencer
> +
> +description: |
> +  The Command Sequencer is designed to autonomously process command lists.
> +  By that it can load setups into the DC configuration and synchronize to
> +  hardware events.  This releases a system's CPU from workload, because it
> +  does not need to wait for certain events.  Also it simplifies SW architecture,
> +  because no interrupt handlers are required.  Setups are read via AXI bus,
> +  while write access to configuration registers occurs directly via an internal
> +  bus.  This saves bandwidth for the AXI interconnect and improves the system
> +  architecture in terms of safety aspects.
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qxp-dc-command-sequencer
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 5
> +
> +  interrupt-names:
> +    items:
> +      - const: error
> +      - const: sw0
> +      - const: sw1
> +      - const: sw2
> +      - const: sw3
> +
> +  fsl,iram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle pointing to the mmio-sram device node

'sram' is the standard property for this.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - interrupt-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +
> +    command-sequencer@56180400 {
> +        compatible = "fsl,imx8qxp-dc-command-sequencer";
> +        reg = <0x56180400 0x1a4>;
> +        clocks = <&dc0_lpcg IMX_LPCG_CLK_5>;
> +        interrupt-parent = <&dc0_intc>;
> +        interrupts = <36>, <37>, <38>, <39>, <40>;
> +        interrupt-names = "error", "sw0", "sw1", "sw2", "sw3";
> +    };
> -- 
> 2.34.1
> 

