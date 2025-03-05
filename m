Return-Path: <linux-kernel+bounces-546698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C3A4FDBF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D210D17175B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CFF248870;
	Wed,  5 Mar 2025 11:34:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673432459E0;
	Wed,  5 Mar 2025 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174477; cv=none; b=WeURlJfbfu9xUMSi7/Xg8RztHJJQ45hhzV0GEIuuODjhlLde2xOBRJsmIWEICUMps53uXGoRLRQN10MA0JsV2eidNPE3FUbj/6+tX4zeBBEHnhzioSYqQD4EHUWHNgYK2Tefzh9scxHak/rAJSoySVFWkUAZIDNemrvctPTamOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174477; c=relaxed/simple;
	bh=PX8YtGNzZCKFmT6MLhflwzHPvwo1LGdQ1btFvdv/xnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TI+WTvKSHtprhv7cuvXM2JGoTj4G6nImWAD/KgfofzAGO/xfRxOQleytx2ZpWZbAlN8jE6FLrS5NfRb0T9coOXHdDEVdWA7cdJqB+Y275ASfzNnRVhOPZTFN71XpswNQ6VHV1dIyRw4TMlBxBi20B/VKJ4t4DAzsvcd8CnrVN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5691D1007;
	Wed,  5 Mar 2025 03:34:48 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31DF23F673;
	Wed,  5 Mar 2025 03:34:33 -0800 (PST)
Date: Wed, 5 Mar 2025 11:34:30 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/15] dt-bindings: clk: sunxi-ng: document Allwinner
 A523 CCU
Message-ID: <20250305113430.47166de3@donnerap.manchester.arm.com>
In-Reply-To: <20250304141125.GA2518548-robh@kernel.org>
References: <20250304012805.28594-1-andre.przywara@arm.com>
	<20250304012805.28594-5-andre.przywara@arm.com>
	<20250304141125.GA2518548-robh@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 08:11:25 -0600
Rob Herring <robh@kernel.org> wrote:

Hi,

> On Tue, Mar 04, 2025 at 01:27:54AM +0000, Andre Przywara wrote:
> > The Allwinner A523/T527 SoCs have four CCUs, this adds the binding for
> > the main CCU.
> > 
> > The source clock list differs in some annoying details, and folding this
> > into the existing Allwinner CCU clock binding document gets quite
> > unwieldy, so create a new document for these CCUs.
> > Add the new compatible string, along with the required input clock
> > lists. This conditionally describes the input clock list, to make for
> > an easier patch adding the other CCUs.
> > 
> > Also add the DT binding headers, listing all the clocks with their ID
> > numbers.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../clock/allwinner,sun55i-a523-ccu.yaml      |  77 +++++++
> >  include/dt-bindings/clock/sun55i-a523-ccu.h   | 189 ++++++++++++++++++
> >  include/dt-bindings/reset/sun55i-a523-ccu.h   |  88 ++++++++
> >  3 files changed, 354 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
> >  create mode 100644 include/dt-bindings/clock/sun55i-a523-ccu.h
> >  create mode 100644 include/dt-bindings/reset/sun55i-a523-ccu.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
> > new file mode 100644
> > index 0000000000000..2eacaeaeabac7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/allwinner,sun55i-a523-ccu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner A523 Clock Control Unit
> > +
> > +maintainers:
> > +  - Andre Przywara <andre.przywara@arm.com>
> > +
> > +properties:
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +  compatible:
> > +    enum:
> > +      - allwinner,sun55i-a523-ccu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 4
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    minItems: 4
> > +    maxItems: 4
> > +
> > +required:
> > +  - "#clock-cells"
> > +  - "#reset-cells"
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +
> > +if:  
> 
> Put this under an allOf and use another 'if' instead of the 'else' 
> clause in the 2nd patch.

Ah, that's a neat idea! What do I do with the clocks and clock-names
above, then? Just have them as "true"?

Krzysztof, would you agree with this approach, and shall I still combine
both in just one patch?

Cheers,
Andre

> > +  properties:
> > +    compatible:
> > +      enum:
> > +        - allwinner,sun55i-a523-ccu
> > +
> > +then:
> > +  properties:
> > +    clocks:
> > +      items:
> > +        - description: High Frequency Oscillator (usually at 24MHz)
> > +        - description: Low Frequency Oscillator (usually at 32kHz)
> > +        - description: Internal Oscillator
> > +        - description: Low Frequency Oscillator fanout
> > +
> > +    clock-names:
> > +      items:
> > +        - const: hosc
> > +        - const: losc
> > +        - const: iosc
> > +        - const: losc-fanout
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ccu: clock@2001000 {  
> 
> Drop ccu and it's 'clock-controller' not 'clock'.
> 
> > +        compatible = "allwinner,sun55i-a523-ccu";
> > +        reg = <0x2001000 0x1000>;
> > +        clocks = <&osc24M>, <&osc32k>, <&iosc>, <&r_ccu 2>;
> > +        clock-names = "hosc", "losc", "iosc", "losc-fanout";
> > +        #clock-cells = <1>;
> > +        #reset-cells = <1>;
> > +    };
> > +
> > +...  


