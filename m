Return-Path: <linux-kernel+bounces-321749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5521971EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D701D1C21AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B013A3EC;
	Mon,  9 Sep 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0UioKsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DB91BC44;
	Mon,  9 Sep 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898473; cv=none; b=iaH9dCyP7ybFvY3DCIaZrPi4LDEdSD7qSqZVp791EOss39Sqh0EgbpoR9b0xHbjvip47kiijWgUAIS97Wgh41Mr9qDvfXIXIGwWu/5LyCtu6SsOtD1PLM2evb4q2J1raPmYSoH5g9twuyKyM+pYXKJpwehB87eFXq1IdzJ64mOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898473; c=relaxed/simple;
	bh=o/SuPZXr/C+udjYl73B0JYb0XneMaCtDYYTZC1RoxxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe0TJMIdIvUqy3XesXbdO0LNs0lQNrL607bj0XMpLB+l6JBq2zL8hRal+bkMaR1dpUnSwHlzzlJqbEh636x7crpnagMRQWn67t0nuJ/0RVotLjAUjWfvgdaF+huX4kmXDkqB0uc2UkvhdbV7jpoOKDPrIfJ0AUofzA9HLp04FIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0UioKsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A28C4CEC5;
	Mon,  9 Sep 2024 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898473;
	bh=o/SuPZXr/C+udjYl73B0JYb0XneMaCtDYYTZC1RoxxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0UioKsMstyYQHNJKE/TW5OgM/SFftNOHJVs3xmDDCKXgXCzLEuHJBqL0/185llQH
	 fvXsX91di30TRDGOyFWCbDV1vLRBMMxw2eLTN7SEflZEs8IBOsA2OqenUoJRu0bdEa
	 094JtI9gl36ktHE9vAegXsAhLbg6yXZB9r6VkWwAMmmyu6ovx9/iExNVZc2hCErPMi
	 KapRmBlNUHcPuCKhQVHc7L5JX9kPHb4uCyLPTIZZSCH/jQsbFGy+eMdqyw28b1vpxI
	 cnrgnMEVJ2EUj3E1KN/lfxxO7tkxS/ClaKVteK8LOkafJqmBZeu5kd+nHMm285xX64
	 uazBPd9uZXwKg==
Date: Mon, 9 Sep 2024 11:14:32 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, Michael Walle <mwalle@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Document the btt3 i.MX28 based board
Message-ID: <20240909161432.GA328353-robh@kernel.org>
References: <20240909113858.359112-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909113858.359112-1-lukma@denx.de>

On Mon, Sep 09, 2024 at 01:38:58PM +0200, Lukasz Majewski wrote:
> The imx287 based btt3 board is very similar to xea in terms of used SOM
> module.

One series with the dts changes please.

> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 80747d79418a..f290c824a91b 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -97,6 +97,7 @@ properties:
>                - i2se,duckbill
>                - i2se,duckbill-2
>                - karo,tx28                 # Ka-Ro electronics TX28 module
> +              - lwn,imx28-btt3
>                - lwn,imx28-xea
>                - msr,m28cu3                # M28 SoM with custom base board
>                - schulercontrol,imx28-sps1
> -- 
> 2.39.2
> 

