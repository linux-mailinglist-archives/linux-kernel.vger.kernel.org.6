Return-Path: <linux-kernel+bounces-383828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26EC9B209F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5987B1F21B0D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C376185B58;
	Sun, 27 Oct 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIZQ3Ir2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C511DFE8;
	Sun, 27 Oct 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062608; cv=none; b=hcsRFqSZeZrg7iXtuLqWGDgJqumSsAMR3x6ENqhrBk7fKaRnZ1DJgBTYHxCXUiN2S6BbxZqcaRYFs5jznuBuQ9+WVVPvC12zykjjQ7WMprQViTWhAzorv4wLHlqVcRZJz2YQi6Pbb79+4jsk6y/mUu+BT/92a/G1RAQT6GJwl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062608; c=relaxed/simple;
	bh=wiW1+9/2t2c3YZRGJvpPEpiy2DceUIZ9uZej5DwHoas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNOARXoDq3BP2xCC/dSDwlTe22XCWhq1r9BJm0xKL/xcXfow767WHemWCJuaDJ7eP2g3gx0HvcI5eLNw3wAU0iPSYoX3/BDrzdGYtw4ypjsUxC4wIP4ww2fCDMgH/UxI3GCu7OptdT99nJJ0unJDm9zlF3DXH1PGSAr06+HjSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIZQ3Ir2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7907DC4CEC3;
	Sun, 27 Oct 2024 20:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730062608;
	bh=wiW1+9/2t2c3YZRGJvpPEpiy2DceUIZ9uZej5DwHoas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIZQ3Ir2v1baN+g79ZQtOPKDXApQwMCW86W0NTfi+Fa+fm8SCl89IDDW2M8+tAwG7
	 0p7umh6jVs2kC9JZ2z3rJfbycyispjtNuZsqglNvlmn5/No4GY9fmAcLBfq5++hovF
	 B7X0Mv6gn7hoSyuLOtTAKfyIq1q/jTijW/JWpKkwxKZytzL/mDuudVAytLUzVejZyw
	 ecZa8E+RRr21YNtxAfucZqXhUjNkgCAToQ1XkEctl8UjVV1Zcbh9J/pKzBWHTDJ5Wj
	 ZcoyHpzFXVJm8lf/Xc2Uuw9AqFD0vQkUPMPlfw2JcSNgqi6m65Fiv7OKUEi3WmvqCu
	 lwGqYPIuRiIeQ==
Date: Sun, 27 Oct 2024 21:56:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Wu <trevor.wu@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Update
 DAI link node pattern
Message-ID: <j5qw52grlce63mccduvryx467h4hvcnqrxrova74d52izq3g5r@wjiflssmq6a5>
References: <20241025104548.1220076-1-fshao@chromium.org>
 <20241025104548.1220076-3-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025104548.1220076-3-fshao@chromium.org>

On Fri, Oct 25, 2024 at 06:44:42PM +0800, Fei Shao wrote:
> The associated machine driver is not dependent on the format of DAI link
> node names. This means we are allowed to use more descriptive names
> instead of indices without impacting functionality.
> 
> Update the binding to accept arbitrary DAI link names with a "-dai-link"
> suffix. This is the common pattern used by the target (MT8188) and other
> (MT8195, MT8186 etc.) MediaTek-based Chromebooks.

We do not want arbitrary names. Why for example green-batman-dai-link
should be correct? The existing pattern looks wrong. Please read DT spec
and chapter about recommended names.


> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> index 701cedfa38d2..2da34b66818f 100644
> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> @@ -40,7 +40,7 @@ properties:
>        name defined in the machine driver.
>  
>  patternProperties:
> -  "^dai-link-[0-9]+$":
> +  ".*-dai-link$":

This breaks existing users.

>      type: object
>      description:
>        Container for dai-link level properties and CODEC sub-nodes.
> @@ -112,7 +112,7 @@ examples:
>              "Headphone", "Headphone L",
>              "Headphone", "Headphone R",
>              "AIN1", "Headset Mic";
> -        dai-link-0 {
> +        hdmi-dai-link {

No. Not really justified.

Best regards,
Krzysztof


