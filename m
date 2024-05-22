Return-Path: <linux-kernel+bounces-186358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405F58CC326
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8846CB237F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0F1420D1;
	Wed, 22 May 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHQZSJMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA513DBA4;
	Wed, 22 May 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387744; cv=none; b=on076gWg7s8f+2V89sFTROKYwu8Ttt/kGPx1SQoKEkCcXX97oMkMVmG7CVfdczlE0IAW+zL3KlQcrTc2hp73ES7GnahZLGxSEK9lXgY4DtDIo8imA8/h8vgPnvEKJyOU+x/Ocg7nYL1YzK7u3Xk8mcfrTWl4IuvfLRgMD/3d9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387744; c=relaxed/simple;
	bh=02yLNhRVRmQSt+76M8uiULZ6FJnruuhVT6KDY9FoVsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBMV/CcGYSnT0cM9X5A0PDTZc6P3odTHA9wQfXi6eSs99W4+uxdGSGOxH94Ql+SVjcizRVB/CsqlgB0A2G6TVO7gZIHFh7Tsv4qFQhRpKwTxAxTIvAlPC7HtqFWBPPNTojqB+21KUafn2FhGmn2lmc+3N2IGtxs31ovU67CxvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHQZSJMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3633C2BBFC;
	Wed, 22 May 2024 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716387743;
	bh=02yLNhRVRmQSt+76M8uiULZ6FJnruuhVT6KDY9FoVsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHQZSJMD+LDSMdHxaFM8Sc2jrh8zDM+ql5/ADheDOvkUkeQbzKimRchWLUJsrrql6
	 GW24zhJMXazK5LFioESgNjg1jSNm6MswtEiePZDdf3RshpK/7ortI0DSBnqCL9azVm
	 Cvyif3gmFsFIqePBujx+CqhYLqFvGTxHTSH/rmE5gR7Meprnam4PD1PGu1lDAdoLY2
	 bBxvR8TjxZaINagz2xwFwCeJWR0OA0tGQtO+7u9RWUX9V7Iv+dLkK6oJ2HrO03QHyj
	 yALoTuGO5B9AluBjqeo8Mqxg/S9CSlKjnHfOV4vbiBa0wELXoZjOW6WNbRbC+MDF7F
	 bubZG4nIv3fJw==
Date: Wed, 22 May 2024 09:22:22 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Mighty <bavishimithil@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Message-ID: <20240522142222.GA3233115-robh@kernel.org>
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>

On Wed, May 22, 2024 at 04:56:11PM +0300, Péter Ujfalusi wrote:
> Hi,
> 
> On 22/05/2024 10:52, Mighty wrote:
> > From: Mithil Bavishi <bavishimithil@gmail.com>
> > 
> > Convert the OMAP4+ McPDM bindings to DT schema.
> > 
> > Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> > ---
> > Changelog v5:
> > - Add imports for constants
> > - Add desc to ti,hwmods
> > 
> >  .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ---------
> >  .../bindings/sound/ti,omap4-mcpdm.yaml        | 61 +++++++++++++++++++
> >  2 files changed, 61 insertions(+), 30 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
> >  create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
> > deleted file mode 100644
> > index ff98a0cb5..000000000
> > --- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -* Texas Instruments OMAP4+ McPDM
> > -
> > -Required properties:
> > -- compatible: "ti,omap4-mcpdm"
> > -- reg: Register location and size as an array:
> > -       <MPU access base address, size>,
> > -       <L3 interconnect address, size>;
> > -- interrupts: Interrupt number for McPDM
> > -- ti,hwmods: Name of the hwmod associated to the McPDM
> > -- clocks:  phandle for the pdmclk provider, likely <&twl6040>
> > -- clock-names: Must be "pdmclk"
> > -
> > -Example:
> > -
> > -mcpdm: mcpdm@40132000 {
> > -	compatible = "ti,omap4-mcpdm";
> > -	reg = <0x40132000 0x7f>, /* MPU private access */
> > -	      <0x49032000 0x7f>; /* L3 Interconnect */
> > -	interrupts = <0 112 0x4>;
> > -	interrupt-parent = <&gic>;
> > -	ti,hwmods = "mcpdm";
> > -};
> > -
> > -In board DTS file the pdmclk needs to be added:
> > -
> > -&mcpdm {
> > -	clocks = <&twl6040>;
> > -	clock-names = "pdmclk";
> > -	status = "okay";
> > -};
> > diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> > new file mode 100644
> > index 000000000..966406078
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: OMAP McPDM
> > +
> > +maintainers:
> > +  - Misael Lopez Cruz <misael.lopez@ti.com>
> > +
> > +description:
> > +  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,omap4-mcpdm
> > +
> > +  reg:
> > +    items:
> > +      - description: MPU access base address
> > +      - description: L3 interconnect address
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  ti,hwmods:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [mcpdm]
> > +    description: Name of the hwmod associated to the McPDM, likely "mcpdm"
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pdmclk
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - ti,hwmods
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    pdm@40132000 {
> 
> The original label and name is preferred to be used.

I imagine both were review comments. I can only imagine given the poor 
changelog.

Unused labels in examples should be dropped.

Node names should be generic. Though if we haven't defined the name in 
the spec or a schema, I don't care too much what is used.

> > +      compatible = "ti,omap4-mcpdm";
> > +      reg = <0x40132000 0x7f>, /* MPU private access */
> > +            <0x49032000 0x7f>; /* L3 Interconnect */
> > +      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> > +      interrupt-parent = <&gic>;
> > +      ti,hwmods = "mcpdm";
> > +      clocks = <&twl6040>;
> > +      clock-names = "pdmclk";
> 
> The clocks cannot be added at the time when the node is defined, it is
> board specific. This way you imply that it is OK to have it in main dtsi
> file. It is not.

That's a .dtsi structuring decision which is irrelevant to the 
binding.

Rob

