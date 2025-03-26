Return-Path: <linux-kernel+bounces-576820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDAA714C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40198175DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F001B423E;
	Wed, 26 Mar 2025 10:25:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05701B21B4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984740; cv=none; b=hKucgXFDZpk5R/Bic1c/PjeSmGfsElEr873b1lEpeTWex9zHtRGfBJ4ELyhWog18+/ZMFvcX3ZJcRVaFGGEoOiA0+bauO8OJruoBtt1FZRIHLWm7oseJIVwU3LPpaZsFtmsOackh/FhnuIL1JroV9ZQRPxViRJ3JP/+mCFFWwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984740; c=relaxed/simple;
	bh=wuFLlvUXlFpsXneQRdiEzeRYO/930T9m8+BICitSVn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FazfG99PpYMIpZ2EWQuIGyWau4TN0Ak2l2i8E851QLhTYVz9akUNSyur5hZVEPzUcheufzNudWPjf8xPQbv+F9MlC3VQiTAQ6XBUVh+3+fVuci6Vx4+GttYlZIS6RFgYkBwGW+CoApLZyJvIHmBcfy+N2cqShlGCk9Xv6lxSFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1txNwp-0008Ep-B0; Wed, 26 Mar 2025 11:25:23 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1txNwo-001jOU-1d;
	Wed, 26 Mar 2025 11:25:22 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1txNwo-000552-2V;
	Wed, 26 Mar 2025 11:25:22 +0100
Date: Wed, 26 Mar 2025 11:25:22 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <Frank.li@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: bus: add documentation for the IMX
 AIPSTZ bridge
Message-ID: <20250326102522.rtsffb37wvolhwd4@pengutronix.de>
References: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
 <20250324162556.30972-2-laurentiumihalcea111@gmail.com>
 <20250325032303.GA1624882-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325032303.GA1624882-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Laurentiu,

On 25-03-24, Rob Herring wrote:
> On Mon, Mar 24, 2025 at 12:25:52PM -0400, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > 
> > Add documentation for IMX AIPSTZ bridge.
> > 
> > Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > ---
> >  .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 107 ++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
> > new file mode 100644
> > index 000000000000..c0427dfcdaca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/fsl,imx8mp-aipstz.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Secure AHB to IP Slave bus (AIPSTZ) bridge
> > +
> > +description:
> > +  The secure AIPS bridge (AIPSTZ) acts as a bridge for AHB masters
> > +  issuing transactions to IP Slave peripherals. Additionally, this module
> > +  offers access control configurations meant to restrict which peripherals
> > +  a master can access.
> 
> Wrap at 80 chars.
> 
> > +
> > +maintainers:
> > +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx8mp-aipstz
> > +
> > +  reg:
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: bus
> > +      - const: ac
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  "#access-controller-cells":
> > +    const: 0
> 
> With 0 cells, how do you identify which device it is?
> 
> > +
> > +  ranges: true
> > +
> > +# borrowed from simple-bus.yaml, no additional requirements for children
> > +patternProperties:
> > +  "@(0|[1-9a-f][0-9a-f]*)$":
> > +    type: object
> > +    additionalProperties: true
> > +    properties:
> > +      reg:
> > +        items:
> > +          minItems: 2
> > +          maxItems: 4
> > +        minItems: 1
> > +        maxItems: 1024
> > +      ranges:
> > +        oneOf:
> > +          - items:
> > +              minItems: 3
> > +              maxItems: 7
> > +            minItems: 1
> > +            maxItems: 1024
> > +          - $ref: /schemas/types.yaml#/definitions/flag
> > +    anyOf:
> > +      - required:
> > +          - reg
> > +      - required:
> > +          - ranges
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - power-domains
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - "#access-controller-cells"
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8mp-clock.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    bus@30c00000 {
> > +        compatible = "fsl,imx8mp-aipstz";
> > +        reg = <0x30c00000 0x400000>, <0x30df0000 0x10000>;
> 
> It doesn't look like you have any registers in the 1st entry, but they 
> are child devices? Then you should use ranges and drop it here:
> 
> ranges = <0x0 0x30c00000 0x400000>;
> 
> 
> > +        reg-names = "bus", "ac";

Thanks for picking up my suggestion :) IMHO it does look more logical
now. I wasn't aware of the 'ranges' property else I would have suggested
you to use this property instead of having two regs, sorry. Once you
changed it to ranges we can drop the 'reg-names' as well since you only
need to supply the 'ac' register space.

Regards,
  Marco

> > +        power-domains = <&pgc_audio>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        #access-controller-cells = <0>;
> > +        ranges;
> > +
> > +        dma-controller@30e00000 {
> > +            compatible = "fsl,imx8mp-sdma", "fsl,imx8mq-sdma";
> > +            reg = <0x30e00000 0x10000>;
> > +            #dma-cells = <3>;
> > +            clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SDMA3_ROOT>,
> > +                     <&clk IMX8MP_CLK_AUDIO_ROOT>;
> > +            clock-names = "ipg", "ahb";
> > +            interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > +            fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> 
> No 'access-controllers' here?
> 
> > +        };
> > +    };
> > -- 
> > 2.34.1
> > 
> 

