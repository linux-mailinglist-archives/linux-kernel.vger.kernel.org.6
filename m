Return-Path: <linux-kernel+bounces-383825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692529B2098
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC63281DB3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6AD18595B;
	Sun, 27 Oct 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpUBkjQK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715D1DFE8;
	Sun, 27 Oct 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062475; cv=none; b=jocGmwJKVI7wYK6Co3smnOkTBP2Z+GxIbTdi880P9jZ8IFNLEAY6INnghNtSXuWepYMZgCTop09NGIDG3wiaP8Wh2L0BAKuUQdt4YwAGnAvuFftWhcAwIPJ1OyZz9g7D2CSRX7l7ocZF0qakjXbqqA1R4yTxxxApd9iBS+JzZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062475; c=relaxed/simple;
	bh=2/SY7cEbrOd1n+Q4oIA/+7D/s8Dxlqav5A6rulFeiwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYzhyzHm28/Y7c8k+Ig8Q9aC9zsuYsigvfiA6CdFupin3y7GjDsa0N8gLisJt29A3pSauYNxAd0y0lxHuVlXacbDtlA34Ocus6GO23sQq/pUyYZgtwwGW6MF6hJ0/sdtlC7F9TLt7pAgNJy1LMFeQKG0Kk/t27LOAmhwI/CXSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpUBkjQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A44C4CEC3;
	Sun, 27 Oct 2024 20:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730062474;
	bh=2/SY7cEbrOd1n+Q4oIA/+7D/s8Dxlqav5A6rulFeiwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpUBkjQKLIg/MxSaS7yQD2D3MK30x8PBJ+ulbTB2LMQYacegiKfSxp1WzW/QhvNfV
	 xLLC57Qy1aD8cd8EleiJvcrMPRoh4nUwCXdenM0NrP0vTw9f/aRwkW0N6cdm55DVVt
	 +RXTg3kc6t44DlBcR3roEi1j4P8RKlpHnL6T7lggwOMT5v8tzN9KJ6pdnCrICEeCDA
	 43rzYfvKfh/4zPQyofcirmId0kERVFshiiG+z/TAt5wRCcfo97LbizilGQ6sjwcQ7g
	 IWwYs8DcP+uVJ8STQnZrh7x8j25pGLnwYW/uQUlIG5p6rBKyjzEiPPx4Xg+BU+bLmq
	 JkWtuoB7gd+6A==
Date: Sun, 27 Oct 2024 21:54:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Wu <trevor.wu@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add adsp
 and dai-link properties
Message-ID: <5vmfh2nkxtpzt2vk4j6ghro7z5stoyvry3enzoqepg6hjxqrho@fofs5cwa2iqq>
References: <20241025104548.1220076-1-fshao@chromium.org>
 <20241025104548.1220076-2-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025104548.1220076-2-fshao@chromium.org>

On Fri, Oct 25, 2024 at 06:44:41PM +0800, Fei Shao wrote:
> Add "mediatek,adsp" property for the ADSP handle if ADSP is enabled on
> the platform.

We see this from the diff.

> Add "mediatek,dai-link" property for the required DAI links to configure
> sound card.

We see this from the diff.

> 
> Both properties are commonly used in the MediaTek sound card driver.

If they are used, why suddenly they are needed? What changed?

> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  .../bindings/sound/mediatek,mt8188-mt6359.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> index f94ad0715e32..701cedfa38d2 100644
> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> @@ -29,6 +29,16 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: The phandle of MT8188 ASoC platform.
>  
> +  mediatek,adsp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 ADSP platform.

And what is the difference between ASoC and ADSP platforms? What are
they used for?

> +
> +  mediatek,dai-link:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      A list of the desired dai-links in the sound card. Each entry is a
> +      name defined in the machine driver.

The list is provided below. I don't understand why do you need it. Your
msg is pretty useless - you describe what you do, instead of why.

Best regards,
Krzysztof


