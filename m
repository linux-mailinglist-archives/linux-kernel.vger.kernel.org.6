Return-Path: <linux-kernel+bounces-347042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64298CCF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C41F23B62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3393839EB;
	Wed,  2 Oct 2024 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+qtrCDI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB271F93E;
	Wed,  2 Oct 2024 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849502; cv=none; b=YFIPgTIglCbLUNrUwrI1AhmovDwn1wgJiOfismsZG0Ec4y5IUt82mCofrcKqLxfDCCveeygqRpWyJ8hfZGJZmFbopv/1bYoh/JIfRzhr1N0y6fKvT7PpCgxC6UcMhX0hLUiT0Dt3sWTL+tJ5PCv9XZdAjr1Xm7tqGjtSb+0E8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849502; c=relaxed/simple;
	bh=2y3iWK2PGdYna/MWeskhSWBizeDSgrBBmx0svF+hg+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFzoHL2XYhGcyMD/Af2YITL7uPP7WQvLSxP353nfs0o2NfnqqKBnEoOcH9a7jJIvAL+QQk3Z3LnVPs5qAMkfu6+xAq5Ht2ecm682uIhhDvdZPyBubH2ZORzREOnkoMZiC6fKrBWtraxto/xHF3Eb1xSFgKRV3ECN+AqhBMvOUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+qtrCDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9F6C4CEC5;
	Wed,  2 Oct 2024 06:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727849501;
	bh=2y3iWK2PGdYna/MWeskhSWBizeDSgrBBmx0svF+hg+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+qtrCDIVZ8EGwzzt1SNU+qkeseOJbL0CFREx8eHQkdZR00sWzH95mOItvG1nkrRF
	 kSn6911vx5QIZ9KSNR4zIBK3Sws6vlBwvts5ESyYFFweSdbDm0z6VwiZi0kR/AIqVX
	 wHg+DZgeqOPZJ7IGDL7Ikz71HOKSmpb0te/Evwcp0V9ZSt8EBbub6qxOTnEcqt/ibc
	 krHIvq+kROfOZ/TpUG8XsoC7/MEHIj+L+T2h7o5JVQI2/vFF2cF3pT8vjwmThMd/dk
	 2GnFthf6cvnuAXQXuNycWLhz92WBM7PZNbf0EAuwcMOUkay7xakQhIpPNvjP0aOF1b
	 gjXNgQnnwhS7w==
Date: Wed, 2 Oct 2024 08:11:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pablo Sun <pablo.sun@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 3/6] dt-bindings: nvmem: mediatek: efuse: Reuse
 mt8186-efuse in mt8188
Message-ID: <mh7upw2y2dclyosved3chw7chpqgdg4a3j5ftwftfhm6v5uqpt@cotoeuopfbqg>
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
 <20241002022138.29241-4-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002022138.29241-4-pablo.sun@mediatek.com>

On Wed, Oct 02, 2024 at 10:21:35AM +0800, Pablo Sun wrote:
> mt8188 has the same GPU speed binning efuse field just
> like mt8186, which requires post-processing to convert to the
> bit field format specified by OPP table.
> 
> Add the binding for the compatible list:
>   "mediatek,mt8188-efuse", "mediatek,mt8186-efuse"
> so mt8188 uses the same conversion.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 32b8c1eb4e80..70815a3329bf 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -39,6 +39,10 @@ properties:
>                - mediatek,mt8195-efuse
>                - mediatek,mt8516-efuse
>            - const: mediatek,efuse
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-efuse
> +          - const: mediatek,mt8186-efuse

And this is not compatible with generic one? This is confusing. Why are
you adding generic fallbacks if they are not valid?

Best regards,
Krzysztof


