Return-Path: <linux-kernel+bounces-240907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2F92746C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39531F21A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084E11AC224;
	Thu,  4 Jul 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+vdwe8G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3B1C6A8;
	Thu,  4 Jul 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090413; cv=none; b=hV1Wujxpf+lOOshGvqa3af0UfGNmYBNskIDnC2qPOiXKMbQ4sHlZ53NoqYl4GKUGLT+KRkHGtJZTLjpUDsZT9to6YOM9kosX9go+Etm4oh+kco3U15iW2as8k0r9ml7hchC65r0VFnyaJMwDCzkwIp7qatFYinVKb1C8kgviwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090413; c=relaxed/simple;
	bh=w4Cv32uuo4ZtkK2rhTa0Lj3AYy2bsH3y1qztTl1euXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCua316ZTr/Asutq+ua6eIBr3fqR2Al8j8IwmGpSthel3CU9t9bc4KEjWqx/ep9bjZ/c273J1tsm3sKrTkAs9UN5sxhqFGOVuVF3K6ecZ2dnsJ94FUmUTdP2xxlT0nbxwvWqd3ZrUYb0gMXmOkPH99zwLlg5RRKUDG/ru8jnZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+vdwe8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1445C3277B;
	Thu,  4 Jul 2024 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720090412;
	bh=w4Cv32uuo4ZtkK2rhTa0Lj3AYy2bsH3y1qztTl1euXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y+vdwe8GAmmEToPV4SxHcDW6veCc6SnmuaHXiXCL2NpyK/SZeKipHy/ruDwFs28dI
	 xe5iyCye8pSJUmXsOn/BAnzdEcHRrtTIS9tpgyPSmae1Q7/foCXzk61ZrG90xaJKNO
	 LIeF36mTGEEEpOgLFERm9ZJd+/AEw/hnTixHkv/1JJn7Py/n3iXhoZcMgdVkYwN5du
	 ke15LFY1dYaZFDOMYN5VxHyqSlXHHKxa/3LTxWwrMuUNCe6OfG9bJrpWR98k3pzRj1
	 jbB3ZUnH9rJNp+FE2k7m8xSYtBvsTTlQUuE3msbYg7cmfvIAsdb0LvWzFhz1OX7zz/
	 u7pE3Ns7k+Lcg==
Message-ID: <50c48961-0817-42d0-82eb-80bdc7ccae62@kernel.org>
Date: Thu, 4 Jul 2024 12:53:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: display: bridge: add sam9x75-mipi-dsi
 binding
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, arnd@arndb.de,
 Jason@zx2c4.com, palmer@rivosinc.com, mpe@ellerman.id.au,
 rdunlap@infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Hari.PrasathGE@microchip.com
References: <20240704084837.168075-1-manikandan.m@microchip.com>
 <20240704084837.168075-2-manikandan.m@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240704084837.168075-2-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2024 10:48, Manikandan Muralidharan wrote:
> Add the 'sam9x75-mipi-dsi' compatible binding, which describes the
> Microchip's specific wrapper for the Synopsys DesignWare MIPI DSI HOST
> Controller for the sam9x75 series System-on-Chip (SoC) devices.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
> new file mode 100644
> index 000000000000..87aaf9c929e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/microchip,sam9x75-mipi-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip SAM9X75 MIPI DSI Controller
> +
> +maintainers:
> +  - Manikandan Muralidharan <manikandan.m@microchip.com>
> +
> +description:
> +  Microchip specific extensions or wrapper to the Synopsys Designware MIPI DSI.
> +  The MIPI Display Serial Interface (DSI) Host Controller implements all
> +  protocol functions defined in the MIPI DSI Specification. The DSI Host
> +  provides an interface between the LCD Controller (LCDC) and the MIPI D-PHY,
> +  allowing communication with a DSI-compliant display.
> +
> +allOf:
> +  - $ref: /schemas/display/dsi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: microchip,sam9x75-mipi-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      MIPI DSI must have two clocks to function correctly.Peripheral clock
> +      'pclk' for the hardware block functionality and Generic clock 'refclk' to
> +      drive the D-PHY PLL block.

List the clocks with description instead of writing it in free-form text.

> +    minItems: 2

Drop, three clocks would not be correct anyway, right?

> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: refclk
> +
> +  microchip,sfr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to Special Function Register (SFR) node.To enable the DSI/CSI

Everywhere: there is always a space after full stop.

> +      selection bit in SFR's ISS Configuration Register.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          DSI Input port node, connected to the LCDC RGB output port.
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            properties:
> +              remote-endpoint: true

Why do you need it?

No constraints on data-lanes or frequencies?

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          DSI Output port node, connected to a panel or a bridge input port.
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            properties:
> +              remote-endpoint: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi: dsi@f8054000 {

Drop unused label.

> +         compatible = "microchip,sam9x75-mipi-dsi";
> +         reg = <0xf8054000 0x200>;
> +         clocks = <&pmc PMC_TYPE_PERIPHERAL 54>, <&pmc PMC_TYPE_GCK 55>;
> +         clock-names = "pclk", "refclk";
> +         microchip,sfr = <&sfr>;
> +
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +
> +         ports {
> +                #address-cells = <1>;

Messed indentation, everywhere in the example...

Use 4 spaces for example indentation.

> +                #size-cells = <0>;
> +
> +                port@0 {
> +                        reg = <0>;
> +                        dsi_in: endpoint {
> +                            remote-endpoint = <&hlcdc_panel_output>;
> +                        };
> +                };
> +
> +                port@1 {
> +                        reg = <1>;
> +                        dsi_out: endpoint {
> +                            remote-endpoint = <&mipi_in_panel>;
> +                        };
> +                };
> +         };
> +
> +         panel@0 {

Drop the node, not related.

Best regards,
Krzysztof


