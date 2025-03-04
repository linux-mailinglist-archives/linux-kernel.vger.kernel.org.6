Return-Path: <linux-kernel+bounces-543485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663CA4D637
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A6D173FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B811FBEA2;
	Tue,  4 Mar 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH1AGMd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24621FBC99;
	Tue,  4 Mar 2025 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076686; cv=none; b=KYAETYMo5fdrk51Uz2ij+gQFvO3QO4QDKo9JXuadTrIDYsDpeZhaKKHRt3L55kGPBWqS/4U1uDKfZX5izvLtYLprW6XnxWsv0FuQ0AHbEmJV3VcdWVmerIZZWx4R4AyNwIyuh2dsBmAYYJ1+3uDSItjlU5UXnHOvUKJcWUu2+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076686; c=relaxed/simple;
	bh=TAw6fNcNSg7YEvEqtiZRQve5lHtjiupPT421lnC+KgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7fCaB8or9jiPlCSxplWFHwwmoHWZvPU/Ruv6Ljbrq01HDianO28cZ9Ec49edp6tKMDxFCMpF70iy8aSHe50aktujU2oRSakCKO/xcyWWYmJ5UAn8qA4FsqYqoE4jNRo/FPniR4//8EnKiawW/XsWiTVMQLn1q44MRaPlCOm79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH1AGMd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965A7C4CEE9;
	Tue,  4 Mar 2025 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741076685;
	bh=TAw6fNcNSg7YEvEqtiZRQve5lHtjiupPT421lnC+KgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FH1AGMd8G1LRCF9lw6vdX7tGzR5edBc4ZLYek88tB93kOeyrHhacKB0a5T4MF/1XJ
	 qLOnmf2SAi4ZGkCxli6zkzeK7pRgFyVrWk+ZO+L1FcwqiRFCUFDRCu82m+zFyoXzF0
	 zHumQyHi27uzUh6slpVEc4pV8rhJR6xhAx4E3d0Ld8Z6SSfgN5zWPyRlWHAGxhfP74
	 p4xXpRekD0Wb/i7AqnlldQWvGQWG2Fgrv9487/gmQQDwy79VhFZ/xBtzbjLLogl2yt
	 nNqRQ8TgMtMn5a1AnFPkgll67VwUgYJ95m+amQ+poVrtLFwq+Y6NqmA9+UyFJc1vk2
	 zMkxoqBrjSZaw==
Date: Tue, 4 Mar 2025 09:24:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/15] dt-bindings: clk: sunxi-ng: add compatible for
 the A523 PRCM-CCU
Message-ID: <20250304-rare-hyrax-of-criticism-1c7b12@krzk-bin>
References: <20250304012805.28594-1-andre.przywara@arm.com>
 <20250304012805.28594-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304012805.28594-6-andre.przywara@arm.com>

On Tue, Mar 04, 2025 at 01:27:55AM +0000, Andre Przywara wrote:
> The Allwinner A523/T527 SoCs have four CCUs, this adds the binding for
> the PRCM R_CCU.
> 
> Add the new compatible string, along with the required input clock
> lists. There is now an extra input clock (PLL_AUDIO), so add this to the
> list of allowed clocks and required it for the A523 PRCM CCU.
> Also add the DT binding headers, listing all the clocks with their ID
> numbers.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../clock/allwinner,sun55i-a523-ccu.yaml      | 23 +++++++++++-
>  include/dt-bindings/clock/sun55i-a523-r-ccu.h | 37 +++++++++++++++++++
>  include/dt-bindings/reset/sun55i-a523-r-ccu.h | 25 +++++++++++++
>  3 files changed, 83 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/clock/sun55i-a523-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun55i-a523-r-ccu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
> index 2eacaeaeabac7..a64a35b423736 100644
> --- a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
> @@ -19,17 +19,18 @@ properties:
>    compatible:
>      enum:
>        - allwinner,sun55i-a523-ccu
> +      - allwinner,sun55i-a523-r-ccu
>  
>    reg:
>      maxItems: 1
>  
>    clocks:
>      minItems: 4
> -    maxItems: 4
> +    maxItems: 5

You just added these lines in previous patch, so squash these and make a
complete binding in one patch.

Otherwise you will get comment like:

>  
>    clock-names:
>      minItems: 4

This is not supposed to be here in previous patch...

> -    maxItems: 4
> +    maxItems: 5

Best regards,
Krzysztof


