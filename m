Return-Path: <linux-kernel+bounces-412995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA99D120F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D571F218D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F61BB6A0;
	Mon, 18 Nov 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWjYBUU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2A1B85E1;
	Mon, 18 Nov 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936791; cv=none; b=lSiySSz+XiC2jdgbHbyPoobm0AMT0xLkoNzql6FMqPKksX8LyQbNAWHBxkSyPDZcyyg3hDleFNaoc2hyG0J/GOdp14JJYK163hS/J0rMDAHJwcQ3zFyudWxgsdZ0pzSHEF2VuNprGl/G+IkIK7vmcVMCyjpG7bvjZ/g0erG8zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936791; c=relaxed/simple;
	bh=+5pvSOuLXKYeKoNoRYSwaH7BlhZ+w4zgc0P/TP1RzcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/ks9XWtdf5ihwDkEGnryWz2arjPQI+Ba3llrmIvyvm9bY+MtGAntg6MDEl4Osdkh5yso81RQEOZNu3bwgvIt2DymQzfy+/QtboI3pQbpRpEW6fChNfW19QbTUGNGrZCghbWel7atusYWgTgE/7smrbQbi8TBBQ4imdbev/xByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWjYBUU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AEAC4CECC;
	Mon, 18 Nov 2024 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731936791;
	bh=+5pvSOuLXKYeKoNoRYSwaH7BlhZ+w4zgc0P/TP1RzcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWjYBUU/MEhTDeY3PtbV9E1sKL10BsWvYBDJW7/ux8XfYmsBX0YgHUPJwJ1KyjyKd
	 /ljy8eYSaKMoh77/TZgGrbk60+ahMmfmZFrCv6kEKwbDJeUFM9HEDeXoOF2CfIRakA
	 phiQc6FTwpi6Q0RU7dG/ye3iJJzTjupi97iDRmfFENnPWuvr3sCd9zvtSgMh0Fsyqj
	 IV6J47XX0PNV/0DvKKzNtPmrOidNFgOIqLxg47TdodPH16ciaMpFNqvy/P8qHx8SaO
	 04zgqvMtmYVpXiBx7ftitXYXPdzBNSnclt0EQJKkC9UCVUHEwKQOwwxrfBVVuL40Js
	 GhDguBYZJfHag==
Message-ID: <adcc5aa5-0f51-4c69-b684-a1e0844c5e3f@kernel.org>
Date: Mon, 18 Nov 2024 15:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
To: MD Danish Anwar <danishanwar@ti.com>, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, ssantosh@kernel.org, nm@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s-anna@ti.com, kristo@kernel.org, srk@ti.com
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-2-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241113110955.3876045-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13/11/2024 13:09, MD Danish Anwar wrote:
> The ICSSG module has 7 clocks for each instance.
> 
> These clocks are ICSSG0_CORE_CLK, ICSSG0_IEP_CLK, ICSSG0_ICLK,
> ICSSG0_UART_CLK, RGMII_MHZ_250_CLK, RGMII_MHZ_50_CLK and RGMII_MHZ_5_CLK
> These clocks are described in AM64x TRM Section 6.4.3 Table 6-398.
> 
> Add these clocks to the dt binding of ICSSG.
> 
> Link: https://www.ti.com/lit/pdf/spruim2 (AM64x TRM)
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> index 3cb1471cc6b6..927b3200e29e 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> @@ -92,6 +92,16 @@ properties:
>      description: |
>        This property is as per sci-pm-domain.txt.
>  
> +  clocks:
> +    items:
> +      - description: ICSSG_CORE Clock
> +      - description: ICSSG_IEP Clock
> +      - description: ICSSG_RGMII_MHZ_250 Clock
> +      - description: ICSSG_RGMII_MHZ_50 Clock
> +      - description: ICSSG_RGMII_MHZ_5 Clock
> +      - description: ICSSG_UART Clock
> +      - description: ICSSG_ICLK Clock
> +

There are actually many more clocks [1]
What is the purpose of adding all these clocks in the DT if driver doesn't
use them?

Only CORE and IEP clocks parent can be configured via clock muxes.
Those are already defined in the icssg?_cfg nodes.

[1] - https://software-dl.ti.com/tisci/esd/22_01_02/5_soc_doc/am64x/clocks.html

>  patternProperties:
>  
>    memories@[a-f0-9]+$:

-- 
cheers,
-roger


