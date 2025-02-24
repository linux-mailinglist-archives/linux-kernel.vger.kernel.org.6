Return-Path: <linux-kernel+bounces-529696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C81A429F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDE018897BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CE264A8B;
	Mon, 24 Feb 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTQ87Y5E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C326280C;
	Mon, 24 Feb 2025 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418478; cv=none; b=BsWPMHtyAf8naAVr+d0seHFlRnDjXaaqF40BOgl9jERX7xdiooNMSBxapvrdsHwo8+12ZQvKjaj6Z68HCA7TLVhl9qd207MNnraGJYUjJM7wfbO2WqfTarVTb65gBT19Q5VQN/uMPzne7TVSopuLaT8KvtnW3urvR7uuhGRtldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418478; c=relaxed/simple;
	bh=sCwX7+nI/q81kiD2Y4/3tqSc3VlI4gc1dBG+Icft1Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw5M+DM/TiHYubm9BbhQZvVfdnmDYvau/BfokQy4FPmhoMz45hb7Ronjg8FMHGgno4xV2XisD11XMC9rvXpt0R8jcg+XZ24UD4qXiuC3+AXkcXLfPpGv8lzOi33EwLhQH0szqVWi/dgx9oRZ99NiQkza5l3JJ65iwGpbEqS18AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTQ87Y5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3560DC4CED6;
	Mon, 24 Feb 2025 17:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740418477;
	bh=sCwX7+nI/q81kiD2Y4/3tqSc3VlI4gc1dBG+Icft1Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTQ87Y5EJefkpgjqkOeu0y6B5lNoAOCly/eXwp3K8arYTGs7bcZbVzUX4x9a8zKrE
	 fQMnAJNEPArkOi/b0YFY4zipLp+oj2+sz88wuvfD0yO3p41Pe2e4w5LNDdkuC1oJQy
	 omNqK13szevPn7ITpFrP2LUzwKO/J8sRkcfbpy5Zaeha/9jYHIHOX2cVtpRYD7S21l
	 TOT5v7/SM3B9U/Mxk+NSFxwq6QbA96irjalNyV1JWBXAnP6A6tF4kIsLiY74DmBH92
	 eyLlIJyxOJV96k4y1RNOJQNyw17IoAyXKvuQO8vyOcHWgxlYN05Tcs9xKLHLNatvm6
	 FGbpObWGrs0Lw==
Date: Mon, 24 Feb 2025 11:34:35 -0600
From: Rob Herring <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: imx8mp: add axi clock
Message-ID: <20250224173435.GA3560337-robh@kernel.org>
References: <20250221190929.31469-1-laurentiumihalcea111@gmail.com>
 <20250221190929.31469-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221190929.31469-2-laurentiumihalcea111@gmail.com>

On Fri, Feb 21, 2025 at 02:09:26PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> The AUDIOMIX clock provider takes an additional clock: AUDIO_AXI_CLK_ROOT.
> 

Fixes tag? The commit message should be expanded a bit as this is an ABI 
change.

> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> index 6588a17a7d9a..0272c9527037 100644
> --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> @@ -24,8 +24,8 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    minItems: 7
> -    maxItems: 7
> +    minItems: 8
> +    maxItems: 8
>  
>    clock-names:
>      items:
> @@ -36,6 +36,7 @@ properties:
>        - const: sai5
>        - const: sai6
>        - const: sai7
> +      - const: axi
>  
>    '#clock-cells':
>      const: 1
> @@ -72,10 +73,11 @@ examples:
>                   <&clk IMX8MP_CLK_SAI3>,
>                   <&clk IMX8MP_CLK_SAI5>,
>                   <&clk IMX8MP_CLK_SAI6>,
> -                 <&clk IMX8MP_CLK_SAI7>;
> +                 <&clk IMX8MP_CLK_SAI7>,
> +                 <&clk IMX8MP_CLK_AUDIO_AXI_ROOT>;
>          clock-names = "ahb",
>                        "sai1", "sai2", "sai3",
> -                      "sai5", "sai6", "sai7";
> +                      "sai5", "sai6", "sai7", "axi";
>          power-domains = <&pgc_audio>;
>      };
>  
> -- 
> 2.34.1
> 

