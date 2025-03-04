Return-Path: <linux-kernel+bounces-543488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 039ECA4D63F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F8C1896996
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110BC1FBCA1;
	Tue,  4 Mar 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpDGT4pl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628743172;
	Tue,  4 Mar 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076728; cv=none; b=Vh2YCUfluw3emKHB01++vWn2+U0PKYC2NaDasFGTKUQMM8bXd/K7tiKNnkyH1O9yuNN9YOa3JFldvMPIeHSLkUw8YVJq0PaboHpEzwdWOw9N3ywNKredLximA7d+kidbOBIMXdJFEBsrDrrv1m6pDhjiRWWZ9AcqOPNIhxqGqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076728; c=relaxed/simple;
	bh=EjG1Ayc6WOrjJoENYUK2AAQIO5stxQf7QR9qv10BbjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icJTvtuqlRP+U4BNIOLg7OauCitAyB+RQ0ClEN5gmC1+YmG9QHthuTT2gpchcKqyMJgBBn26VYkuJwRDl7ghYRtxbIQseX4SlT2mzjlXQg/lLjfy4r/2adKlLu7ydK+XpXCYNKR+EAMiIXq/rPCXB+cDcxVjP2rjMhLkuodX0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpDGT4pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F116BC4CEE5;
	Tue,  4 Mar 2025 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741076727;
	bh=EjG1Ayc6WOrjJoENYUK2AAQIO5stxQf7QR9qv10BbjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpDGT4pl9OvTRcB3fq/ZOwLw8spKntrGFEwzLqPphNVifkDf/CruyEbhZQHgk/2P2
	 OaO/XH8YBr7vXXUzzAXb9MCxHwhS3Gv6Lw96scmHOli+H3nQsIXZDQDGC9W3emPS3N
	 nY3Dit1FlyI7es4f9fPs1wsEjQbPiYY11PCcNL82Y5z3/khVERpMwEhADig/jJn80Q
	 vxoAqgpGd+J/JtYDXZxRHPHA6yhMPJnjnhv1xxRiF8rjLhR7Ykgb7/Uf0tznDN5Gph
	 VGcFHF5LGIIO9dp4qig6fzhiykzDqDLh2TTUyPQxfH7e7pYRq0jETxtmR9wLg1j4SA
	 C5CHMLvKvr0yQ==
Date: Tue, 4 Mar 2025 09:25:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/15] dt-bindings: clk: sunxi-ng: document Allwinner
 A523 CCU
Message-ID: <20250304-resilient-spiritual-crane-30d4e1@krzk-bin>
References: <20250304012805.28594-1-andre.przywara@arm.com>
 <20250304012805.28594-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Drop, redundant.

> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 4
> +    maxItems: 4

Drop both and instead you need to list the items.

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

Drop, you have here only one device, no need for if:then.

Best regards,
Krzysztof


