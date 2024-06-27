Return-Path: <linux-kernel+bounces-232931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD7091B014
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7AEBB23392
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71519CCFE;
	Thu, 27 Jun 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tec+vNI4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3945BE4;
	Thu, 27 Jun 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518745; cv=none; b=ervGFbUDGUEVH/pPJRkWILesyzcL8F0suqzmv7y9vkSBbgBeLZBywfqJFng29690dLcijUfCLvMVkaBXAPBncQQCcvrWjB0YTYhD2DJQlGqCle5PYtXwDwizD7UkV/OaFymJ7Gzo6bQNOEOTZ55sGnMbhTF3p5j9kk6RCYUuPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518745; c=relaxed/simple;
	bh=FE5LwB4HXBRsoGB9+h+mvR30T3AMRQyyiUCPx6AJibA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWpwRADPWwjUJv0O0VANh0ny2YVkErBUBokjICps4z9hVPYBoLoqXlbUsxDnDDkSnqqjIM+9pq0ckQioQaRTcXIDb+piZjOEw7iQIBpjCfi6tgS1IrVyCQeHwI4rTIbLID4cqGLwsxB7Afz3rTmPtU55inX2L9lKSdBAoYZu6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tec+vNI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94157C2BBFC;
	Thu, 27 Jun 2024 20:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719518744;
	bh=FE5LwB4HXBRsoGB9+h+mvR30T3AMRQyyiUCPx6AJibA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tec+vNI4sG/7Ti1RLprvNypZGPCnZzbOElovxV8ey0vBaoA25bDO8+Sdev08E7LqF
	 tulhYfqmL4+QD3GGENY2J4+RtUiB67WaEDA/CKwNNJp7lwlU7kmdS19OcHnt3DhJn2
	 Ir2osxCYd/WoCsLCXfHVxSBYA1UKb+v45IlR5XQsMbSm4slNgKPjgtNd0J0L1GS51v
	 CJAzCQjQhGrs9f3RQPcfqpLIaCEBQQ0eg9uiflzHCiuDezYQrRCgpaeUv0RM6+D1N+
	 rsxH6wTx0oaKBrCmHtZuXDkbHJJcmN11Isfvs/gjCqegEA0JwxBWB2kEbw88wyfEeQ
	 clzt1q3VRAhPw==
Date: Thu, 27 Jun 2024 14:05:43 -0600
From: Rob Herring <robh@kernel.org>
To: Kartik Agarwala <agarwala.kartik@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: mt6397: Add reference for
 mediatek,mt6358-sound
Message-ID: <20240627200543.GA439514-robh@kernel.org>
References: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
 <20240617-mt6358-v2-3-5d9f0e99941e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-mt6358-v2-3-5d9f0e99941e@gmail.com>

On Mon, Jun 17, 2024 at 05:58:26PM +0530, Kartik Agarwala wrote:
> Add reference for mediatek,mt6358-sound
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 10540aa7a..cf7fcc402 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -48,6 +48,7 @@ Optional subnodes:
>  - codec
>  	Required properties:
>  		- compatible: "mediatek,mt6397-codec" or "mediatek,mt6358-sound"
> +	see ../sound/mediatek,mt6358.yaml

No point in adding this as this file should get converted.

Rob

