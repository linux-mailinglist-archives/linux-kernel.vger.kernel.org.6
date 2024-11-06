Return-Path: <linux-kernel+bounces-398359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FDE9BF00D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2E11F248D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D320111C;
	Wed,  6 Nov 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfLryTKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFF1D63DF;
	Wed,  6 Nov 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903161; cv=none; b=UJOed0qElehRi2q+Pig6hVdJnShCjORSuk7f+rbzdqCvqjweDlYMOrWs8y7cw8IZANqqyPoxMyGSgrgOWGCtmInRmdTVWmaoq5MlSLI592uwhij9CaLo7kKH3hDfq+P8acL8eCyziVcRNow5tNlbH0It9NbN8JcDnPuWjxJCQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903161; c=relaxed/simple;
	bh=sNQN7d+7mMF2pNrk500mlBetX/2XhhGnzLAs9VyZ840=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWF0awnm/pdOnyx5D9ed5MVvfx1Ri9t8X/1EL8LSMjh/J8q64AJLuK1ti45eIL5XhzscGBYM/AqnoEnP1ZuN/FBrjIG8VHyA4OmJm8FeUgVR1Yo+xtViniSCkDRQaMtTx0pZ0sglXEP96yHOqfVsNdAIsGKtqQ9GBTCsAhynjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfLryTKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3280CC4CEC6;
	Wed,  6 Nov 2024 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730903160;
	bh=sNQN7d+7mMF2pNrk500mlBetX/2XhhGnzLAs9VyZ840=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfLryTKQD1k9UP5jUpSTXyV8PLRs2R1RKdouDoI/PVIQXLEKQA/LNgQUoU0jG5hYb
	 IayngI+HvRQmkjZ2Tx3F2/ka0fgyF6zZQZTbG09yPwSR8w/XNVdinCRzRAwLIKOXGI
	 aW24HABJGgzrlikYGE1m3FfgLZppjxdMNApdWwaKz3kM6LthjFTvYedbdFXjnsXHK/
	 ooZ/sCnr4VW/kKjPcaMXyzeyNWjg/3A52vML2f8L8vpEobXi5USX7OOYdtvi4J3gdv
	 37OMscpJ9O6tBhQ4H9Mgh0LMVmXCsGMplNMoPHIfwyBU5TEeZ/0/XQa7T7pgpwqozI
	 0vLbIrByLmSJw==
Date: Wed, 6 Nov 2024 08:25:58 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 2/3] dt-bindings: display: rockchip: Add schema for
 RK3588 DW DSI2 controller
Message-ID: <20241106142558.GA3329455-robh@kernel.org>
References: <20241106123304.422854-1-heiko@sntech.de>
 <20241106123304.422854-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106123304.422854-3-heiko@sntech.de>

On Wed, Nov 06, 2024 at 01:33:03PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The Display Serial Interface 2 (DSI-2) is part of a group of communication
> protocols defined by the MIPI Alliance. The RK3588 implements this
> specification in its two MIPI DSI-2 Host Controllers that are based on a
> new Synopsis IP.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../rockchip/rockchip,rk3588-mipi-dsi2.yaml   | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
> new file mode 100644
> index 000000000000..8fc6b4a63f06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-mipi-dsi2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip specific extensions to the Synopsys Designware MIPI DSI2
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3588-mipi-dsi2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: sys
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      This SoC uses GRF regs to switch between vopl/vopb.
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: dcphy
> +
> +  ports:

Nodes after properties.

> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input node to receive pixel data.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: DSI output node to panel.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: apb
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - rockchip,grf
> +  - phys
> +  - phy-names
> +  - ports
> +  - reg
> +
> +allOf:
> +  - $ref: ../dsi-controller.yaml#

Absolute path: /schemas/...

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/rk3588-power.h>
> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      dsi0: dsi@fde20000 {

Drop unused labels.

> +        compatible = "rockchip,rk3588-mipi-dsi2";
> +        reg = <0x0 0xfde20000 0x0 0x10000>;
> +        interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks = <&cru PCLK_DSIHOST0>, <&cru CLK_DSIHOST0>;
> +        clock-names = "pclk", "sys";
> +        resets = <&cru SRST_P_DSIHOST0>;
> +        reset-names = "apb";
> +        power-domains = <&power RK3588_PD_VOP>;
> +        phys = <&mipidcphy0>;
> +        phy-names = "dcphy";
> +        rockchip,grf = <&vop_grf>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          dsi0_in: port@0 {
> +            reg = <0>;
> +          };
> +
> +          dsi0_out: port@1 {
> +            reg = <1>;
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.45.2
> 

