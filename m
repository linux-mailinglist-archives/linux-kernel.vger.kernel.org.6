Return-Path: <linux-kernel+bounces-521704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C78CA3C12C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117D31890023
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556881A5BA4;
	Wed, 19 Feb 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyxD30Nh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAAA1EB18E;
	Wed, 19 Feb 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973604; cv=none; b=mNQEP6nY5FvdeQVIajBu8gdrQ+SE354Ik/QpawBz/S9KWFYomukEUqanf68l8wiDUTEDPHAHN8PpfrPXVar25K96uOyiLcSpswSrt7+SKpFR4sTdCf5pEUJTeXLkUIds1qTuM1nSbpjTK7hTmh5vaRMPKgKyD2mN0a/UpR6vvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973604; c=relaxed/simple;
	bh=6ZusAGCt8DmvwKekcN+BSAym8y589HIO8Pfps4RSgf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THNsNlHtjB6kBWb6GHUPgJAzhAaHyjprPJh7cXAqmsglPodV/id5VW0MWxm9yyomH7AevGWMQD/V0UjY40Tv43hmI5fIKumLNGT31G+n+CNeE1Ov+4leCyifAmLrfE2bXWGHfUsv5eho8CRZlQD61uwMYe4sXyIWrOsxcPozA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyxD30Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8F7C4CED1;
	Wed, 19 Feb 2025 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973604;
	bh=6ZusAGCt8DmvwKekcN+BSAym8y589HIO8Pfps4RSgf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyxD30Nhe6YpYKbVqAcwLSFdWrWdkr8UMwlbRcelUl+NHjeZNFl+ovapTnOxHdbmo
	 U6iW805NuGZsY0w5I0KTfJy1TEvE1rJGWiIGsDwp/mNi7VxCpcts13ReFpEFUZO0gf
	 msEbEHvkAc0hlm5njKOThBXXwVy6Wp1wSqY3A46hrysJzXjIPPifoKa+Da6vT5F+lk
	 cB4toeJnVqijSBkCQ4c3iLIzmsQ9Yx1pLvWp2OkSEqXf7UMXB+FzTzOZFpB5kfSM5f
	 CqzNlOJM+gKYItgy4+0MbqFb9KHnkZSm5QEHMVwjYwSeiRTGu27lb7sIoSj+xGHVW+
	 Q9NED/SG9qUUA==
Date: Wed, 19 Feb 2025 08:00:02 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dt-bindings: rtc: sophgo: add RTC support for Sophgo
 CV1800 series SoC
Message-ID: <20250219140002.GA2354937-robh@kernel.org>
References: <20250216180924.2506416-1-alexander.sverdlin@gmail.com>
 <20250218210630.GA872024-robh@kernel.org>
 <03302dcb85408facaee075dfdc6cd72a4fddcc59.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03302dcb85408facaee075dfdc6cd72a4fddcc59.camel@gmail.com>

On Tue, Feb 18, 2025 at 10:41:31PM +0100, Alexander Sverdlin wrote:
> Thank you for your feedback Rob!
> 
> On Tue, 2025-02-18 at 15:06 -0600, Rob Herring wrote:
> > > QUESTION:
> > > 
> > > I'm unsure about reg properties in the subnodes (child devices) of
> > > RTCSYS:
> > > - they will not be used anyway by the drivers because they genuinely
> > > overlap (the whole point of going MFD) -- therefore the drivers will do
> > > syscon_node_to_regmap(pdev->dev.parent->of_node)
> > > - as I understood from the history of MFD dt bindings' submissions, regs
> > > are encouraged, if can be specified
> > > - overlapping regs cause dt_binding_check warnings:
> > > Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in
> > > node /example-0/rtcsys@5025000/pmu@0)
> > > Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in
> > > node /example-0/rtcsys@5025000/rtc@0)
> > > 
> > > Shall I remove the MMIO resources from the actual devices or rather ignore the warnings?
> > 
> > Ignore the warnings is not an option.
> > 
> > Removing makes since if the registers and bitfields are completely mixed 
> > up. If they are, then I find it hard to believe the child nodes are 
> > separate blocks. And if they aren't, then it should all be just 1 node. 
> 
> The HW vendor calls it "RTC". But this "RTC" is also responsible for the
> whole power sequencing and [chip-wide] power management. And afterwards
> they've put SRAM controller registers and remoteproc (independent 8051 core)
> controller into the same address space (interleaved). I have hard times
> to apply any strict logic here.
> 
> > You don't have to have child nodes to have separate drivers.
> 
> But if I don't utilize "simple-mfd" and children nodes, then I'd need
> some MFD core driver registering the "cells" even though, there will be
> no other functions in it?
> 
> On the other hand, maybe this is the way forward if we are unsure as
> of now, which cells do we want to implement at all as a separate driver
> and which ones are we going to combine in a single driver?..

Those are all OS questions which have little to do with the DT binding. 
Design the binding to best match the h/w.

> > >   .../bindings/mfd/sophgo,cv1800b-rtcsys.yaml   | 222 ++++++++++++++++++
> > >   1 file changed, 222 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml b/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> > > new file mode 100644
> > > index 000000000000..2dc7c2df15c1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> > > @@ -0,0 +1,222 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/sophgo,cv1800b-rtcsys.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Cvitek CV18xx/Sophgo SG200x Real Time Clock module
> > > +
> > > +maintainers:
> > > +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > +  - sophgo@lists.linux.dev
> > > +
> > > +description:
> > > +  The RTC (Real Time Clock) is an independently powered module in the chip. It
> > > +  contains a 32KHz oscillator and a Power-On-Reset (POR) sub-module, which can
> > > +  be used for time display and scheduled alarm produce. In addition, the
> > > +  hardware state machine provides triggering and timing control for chip
> > > +  power-on, power-off and reset.
> > > +
> > > +  Furthermore, the 8051 subsystem is located within RTCSYS and is independently
> > > +  powered. System software can use the 8051 to manage wake conditions and wake
> > > +  the system while the system is asleep, and communicate with external devices
> > > +  through peripheral controllers.
> > > +
> > > +  Technical Reference Manual available at
> > > +    https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
> > > +
> 
> [...]
> 
> > 
> > > +  "^sram@[0-9a-f]+$":
> > > +    type: object
> > > +    additionalProperties: false
> > > +
> > > +    description:
> > > +      Provide 2KB of SRAM, which can host software code or temporary data.
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        items:
> > > +          - enum:
> > > +              - sophgo,cv1800b-rtc-sram
> > > +
> > > +      reg:
> > > +        maxItems: 1
> > > +
> > > +      clocks:
> > > +        maxItems: 1
> > > +
> > > +    required:
> > > +      - compatible
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  - ranges
> > > +
> > > +additionalProperties:
> > > +  type: object
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/sophgo,cv1800.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    rtcsys@5025000 {
> > > +        compatible = "sophgo,cv1800b-rtcsys", "simple-mfd", "syscon";
> > > +        reg = <0x5025000 0x2000>;
> > > +        #address-cells = <1>;
> > > +        #size-cells = <1>;
> > > +        ranges = <0 0x5025000 0x2000>;
> > > +
> > > +        mcu@0 {
> > > +            compatible = "sophgo,cv1800b-rtc-dw8051";
> > > +            reg = <0x0 0x1000>;
> > > +            clocks = <&clk CLK_SRC_RTC_SYS_0>;
> > > +            sram = <&rtc_sram>;
> > > +        };
> > > +
> > > +        pmu@0 {
> > > +            compatible = "sophgo,cv1800b-rtc-pmu";
> > > +            reg = <0x0 0x2000>;
> > > +            interrupts = <18 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <19 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "longpress", "vbat";
> > > +        };
> > > +
> > > +        rtc@0 {
> > > +            compatible = "sophgo,cv1800b-rtc";
> > > +            reg = <0 0x2000>;
> > > +            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "alarm";
> > > +            clocks = <&clk CLK_RTC_25M>;
> > > +        };
> > > +
> > > +        rtc_sram: sram@0 {
> > > +            compatible = "sophgo,cv1800b-rtc-sram";
> > > +            reg = <0x0 0x1000>;
> > 
> > How does the SRAM overlap registers?
> 
> Those are not SRAM cells mapped into this address space,
> but rather several control registers controlling reset,
> power and clock of the SRAM.

The 'sram' property points to regions of SRAM memory. So what you have 
is incorrect use of the property.

Rob

