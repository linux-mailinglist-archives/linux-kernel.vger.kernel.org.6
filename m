Return-Path: <linux-kernel+bounces-539475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68568A4A4DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08713B3051
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD31DB92E;
	Fri, 28 Feb 2025 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhiOd0la"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39C1D90D9;
	Fri, 28 Feb 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777466; cv=none; b=ryidEj+wrq6Q62HI44YtShMsP+GYZ6wBZHcBzJBgGFPjrn+mqFKOYfgeoo3Dt14APfKYMjkmPKfMZz/ZP4PGfZmtYauCX2OJPSPbla4Cl33PuqVedxAqNy9zD1sLat6hm9nz97dXqCJi2P55mMxNGmwMsF4v/vHRybK4fHfr8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777466; c=relaxed/simple;
	bh=IkOzcwzD6g/Xe/Qr+wg9oscXEq2A/Wh3cy8CHPJBqN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPIUAslg6tUlBL6W71LyGQ/oIzz3cbSyM+K++1+0B8wJjfuhQRB2NRlxVC0bRcZEhz7QEUYKNt5yo1gnJxJjlwM3krvwJP4XjYRGnRQsTAGpRHqiLMbxi3Zl2nUTXNKQMfTBPDmrePhFabsAleVqUtn2WMlivs80+VNmuZn5dNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhiOd0la; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4396EC4CEE2;
	Fri, 28 Feb 2025 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777466;
	bh=IkOzcwzD6g/Xe/Qr+wg9oscXEq2A/Wh3cy8CHPJBqN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhiOd0lax+NjVz/abbtzMM1eU2nq1Oma4KGTGpNIQT6pq6zCLYH27hKVoJV3YgvMn
	 Zp/A8qRN74k5g6Ycebg//15KT6UaMnaQUrMjXq7SZg4gK5/5flt5Syfp7XPdGEb023
	 85F0CSvVnaiSGoEnnN5OO6K50WZQ5ViKICYsoVG1U8gcsPg5CPnLUFFKU+3bf93CL3
	 8GMlxFjvBX2UiZwmZgDJ6NmZFZWoTix849Wt1rhZR8gTbbPdY/0HloYHZQ7r2ZXlv7
	 LkIXxJlTIYyyNhv8qCSkKiXryR1OXiRbY5gBA6S0xjqwZWztavQhj057n1FyVCRxD7
	 Ic9yHC2CusVVw==
Date: Fri, 28 Feb 2025 15:17:44 -0600
From: Rob Herring <robh@kernel.org>
To: Christophe Parant <c.parant@phytec.fr>
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	upstream@lists.phytec.de
Subject: Re: [PATCH 03/11] dt-bindings: arm: stm32: Rename STM32MP15x Phytec
 board and SoM
Message-ID: <20250228211744.GA3730587-robh@kernel.org>
References: <20250227154012.259566-1-c.parant@phytec.fr>
 <20250227154012.259566-4-c.parant@phytec.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227154012.259566-4-c.parant@phytec.fr>

On Thu, Feb 27, 2025 at 04:40:04PM +0100, Christophe Parant wrote:
> Modifications following new PHYTEC stm32mp15x SoM and board device tree
> naming.

Why?

It's an ABI, so you are stuck with the names. It's just a unique 
identifier, so it's really not important what the string is.

> 
> Signed-off-by: Christophe Parant <c.parant@phytec.fr>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index b6c56d4ce6b9..11b3f59ac550 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -169,10 +169,11 @@ properties:
>            - const: seeed,stm32mp157c-odyssey-som
>            - const: st,stm32mp157
>  
> -      - description: Phytec STM32MP1 SoM based Boards
> +      - description: Phytec STM32MP15x SoM based Boards
>          items:
> -          - const: phytec,phycore-stm32mp1-3
> -          - const: phytec,phycore-stm32mp157c-som
> +          - enum:
> +              - phytec,stm32mp157c-phyboard-sargas-rdk
> +          - const: phytec,stm32mp157c-phycore-som
>            - const: st,stm32mp157
>  
>        - description: ST STM32MP257 based Boards
> -- 
> 2.34.1
> 

