Return-Path: <linux-kernel+bounces-544362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47914A4E082
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EC13B9012
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92184204C2C;
	Tue,  4 Mar 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXcEid9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63517583;
	Tue,  4 Mar 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097488; cv=none; b=RkeaNE2Q1gVm5Ecloj2oZzb+/SvCh4thTBs4QuMrkYtcqML5vaWN8Hjo164SIkwmfQ1XFZIVD7tJ5zdPG4QYzO4HXqoPN6do9Vt8ObF6dJer4lZy3RwXgXOrnunY4JmXsoBFKREORLjzePmRNuuje/13iUomicmpCpLTMYdBwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097488; c=relaxed/simple;
	bh=uZAr3o4anHDvD9RQXrKUeVfxL/By4d6vCjGFzZTYNJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4uyZJg41+j6lKukvh0r/7xABPdYy/Uw5CtJyrKMh8L+COj5GgrNwq0zldKJoQX17HzjtLX/WL7zqJxHAfMf3Fy/h2w11TXcdih7qsfY4CLAM4F/PQlQHmPpdTs0pQmJ0ksZKnIuuPizQJvH8h/Bx/L/H1UmAemoGToXOC0Yqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXcEid9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CAAC4CEE5;
	Tue,  4 Mar 2025 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097487;
	bh=uZAr3o4anHDvD9RQXrKUeVfxL/By4d6vCjGFzZTYNJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXcEid9Ufzy2HTrGc7vpehSk3qt9XEZnJuIj0o5jqXiT51j7xjCxC/Rs8SWaMGubz
	 p6EWZPC3NYKj6sYy3kZRE8CMuSG80bADbm8prImUYIIiZdZ7RBS8q3+qEPwWs0JGy3
	 xQGlN2ixEzXRvi/6bT21yzJr7RhwRzPos2fFaNifnGPEJkKXnm6MaDAUfHpfm0oiT9
	 2ZgAGUnrb2cjyNq4oEvpS4wkngjptSYGnrW7VeblRca/T1Sekxxg55j92gS8WndiDa
	 PDCkeO85jGWgFkv5edfvIQhXXPt/epi1L9N3GUKx8nZfIpaUthb+qHW10km/ijfb4E
	 RBlLQfoe33FmA==
Date: Tue, 4 Mar 2025 08:11:25 -0600
From: Rob Herring <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/15] dt-bindings: clk: sunxi-ng: document Allwinner
 A523 CCU
Message-ID: <20250304141125.GA2518548-robh@kernel.org>
References: <20250304012805.28594-1-andre.przywara@arm.com>
 <20250304012805.28594-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304012805.28594-5-andre.przywara@arm.com>

On Tue, Mar 04, 2025 at 01:27:54AM +0000, Andre Przywara wrote:
> The Allwinner A523/T527 SoCs have four CCUs, this adds the binding for
> the main CCU.
> 
> The source clock list differs in some annoying details, and folding this
> into the existing Allwinner CCU clock binding document gets quite
> unwieldy, so create a new document for these CCUs.
> Add the new compatible string, along with the required input clock
> lists. This conditionally describes the input clock list, to make for
> an easier patch adding the other CCUs.
> 
> Also add the DT binding headers, listing all the clocks with their ID
> numbers.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../clock/allwinner,sun55i-a523-ccu.yaml      |  77 +++++++
>  include/dt-bindings/clock/sun55i-a523-ccu.h   | 189 ++++++++++++++++++
>  include/dt-bindings/reset/sun55i-a523-ccu.h   |  88 ++++++++
>  3 files changed, 354 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
>  create mode 100644 include/dt-bindings/clock/sun55i-a523-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun55i-a523-ccu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
> new file mode 100644
> index 0000000000000..2eacaeaeabac7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/allwinner,sun55i-a523-ccu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A523 Clock Control Unit
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - allwinner,sun55i-a523-ccu
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 4
> +    maxItems: 4
> +
> +required:
> +  - "#clock-cells"
> +  - "#reset-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +if:

Put this under an allOf and use another 'if' instead of the 'else' 
clause in the 2nd patch.

> +  properties:
> +    compatible:
> +      enum:
> +        - allwinner,sun55i-a523-ccu
> +
> +then:
> +  properties:
> +    clocks:
> +      items:
> +        - description: High Frequency Oscillator (usually at 24MHz)
> +        - description: Low Frequency Oscillator (usually at 32kHz)
> +        - description: Internal Oscillator
> +        - description: Low Frequency Oscillator fanout
> +
> +    clock-names:
> +      items:
> +        - const: hosc
> +        - const: losc
> +        - const: iosc
> +        - const: losc-fanout
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ccu: clock@2001000 {

Drop ccu and it's 'clock-controller' not 'clock'.

> +        compatible = "allwinner,sun55i-a523-ccu";
> +        reg = <0x2001000 0x1000>;
> +        clocks = <&osc24M>, <&osc32k>, <&iosc>, <&r_ccu 2>;
> +        clock-names = "hosc", "losc", "iosc", "losc-fanout";
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +    };
> +
> +...

