Return-Path: <linux-kernel+bounces-361312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCEE99A699
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688C01F23406
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4356193402;
	Fri, 11 Oct 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRmoFP+l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B71184;
	Fri, 11 Oct 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657639; cv=none; b=DmKA699bhs0dJrCUsZZ8Pm1G3ESJw/PUun5cuKxiww9HGNZCbuui2ZVqclW6Xs9/u9xjctQSo4a7rfJyU5o9IGk3Hba6IWm7ACNZp0Kg971SMAeByRytkCkV5bKNEbiXNxVFHcFOMAItZbyrUb9lgubrtlWOIFHDGUbwiW9BJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657639; c=relaxed/simple;
	bh=6SqYYBEsm71tcxIAaMo23RVH9XZyNIzk09bKjoIID8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLsSsbEmZknfBj60PLz3GoEtYYcoW+vRbhDpEKXgQqVsa7OvnDWCNHGcxzhdXHyyX0r+relkQEEZl61gnu7OoxS9aapo7KaX9t1bFOnFa/MPogCpyxSUmuCYag1BYlEuhZIkLY5ROp227a/LqfJ3qlea9sd7Sq24tdGPDJQdfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRmoFP+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBBDC4CEC3;
	Fri, 11 Oct 2024 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657639;
	bh=6SqYYBEsm71tcxIAaMo23RVH9XZyNIzk09bKjoIID8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRmoFP+lJ6P5BFPJja4XMRG3L1lmAuSpANWpNjp1v1jhF8QGGlyR1qS4sZZtFascj
	 s0esdxbnzbw4RAaH9EzxeKA+MZ5NQfCJLVUa7ymDqY0lRPiLeqd1q/eQ2ptEqee+Qe
	 Gq1ueOH/MccWpfoih3ICk2cP4Ng2sx9xjoH1apvr6qfWVCXUD7ixI2eINCgtlG8Ql2
	 K9w1LSdAVUtrujwD/YYMWAxY/La7fNfolSU9QDiEuide4VlGypIh3PqM7NF+T/IyoQ
	 UWEXSsKjQK+VG3PUw4yr2DGc7muQIq5THiYp9GvHYATWqX6tzmnsPRYiM1Ud417cy9
	 RlemtF1XEVEAw==
Date: Fri, 11 Oct 2024 16:40:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com, 
	aisheng.dong@nxp.com, frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com, 
	linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: Add i.MX91 clock definition
Message-ID: <posan34opc4p3crccwstomt7fwvtt3dm6urtcmcrm4wwduoli6@mmzj5qdjp374>
References: <20241011045736.308338-1-pengfei.li_1@nxp.com>
 <20241011045736.308338-3-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011045736.308338-3-pengfei.li_1@nxp.com>

On Thu, Oct 10, 2024 at 09:57:35PM -0700, Pengfei Li wrote:
> i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
> Add i.MX91 related clock definition.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/dt-bindings/clock/imx93-clock.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> index 787c9e74dc96..6c685067288b 100644
> --- a/include/dt-bindings/clock/imx93-clock.h
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -204,6 +204,10 @@
>  #define IMX93_CLK_A55_SEL		199
>  #define IMX93_CLK_A55_CORE		200
>  #define IMX93_CLK_PDM_IPG		201
> -#define IMX93_CLK_END			202

This is supposed to be separate patch, because you are removing
something from ABI.

If your maintainer NAKed it, then do not sneak it some other way. Sort
the problem with maintainer or entire patchset cannot enter.

Best regards,
Krzysztof


