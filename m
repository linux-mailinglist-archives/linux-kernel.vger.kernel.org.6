Return-Path: <linux-kernel+bounces-421959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529B9D929D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6F7283FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ED5194A44;
	Tue, 26 Nov 2024 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lITtXb/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8FC148FF9;
	Tue, 26 Nov 2024 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606718; cv=none; b=oRcg7c0x152TJ3nJMLb1kQ/Qr0lrprJ4aWDi0RyR84iQMHcRJq1V6Ni04/H1cPCu9j1nWlvFhIxyyO33HZgfsIhRNFLa3KioU/yQhLUjWq9NCnSViD8dLhz705hc65aUwtOgg9C4WPZ1U+ozSItl5ocbzE9LTCGK5Ln0EWSQ5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606718; c=relaxed/simple;
	bh=xDX7Py7JrUY2WP5pzg+vtaFdg33ZJL+szak3uKude4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsu+C9UDQ29vCxN9VPWZFdp81sDwsBpDObm5gDQ8WTEGCcgHj4SSgtq953l5JjdvxAne8kxGuvL/zgCV4uembeJLlEeDP3FxCwmgzVuouTJmNhUM1jFKmcB/mpkw6Y+Zlpj4G/4pjKC8iJVX35JRTkDV92U00UI+M7stYLe0od4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lITtXb/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B314BC4CECF;
	Tue, 26 Nov 2024 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732606717;
	bh=xDX7Py7JrUY2WP5pzg+vtaFdg33ZJL+szak3uKude4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lITtXb/95txvqxJqpVYepz23JkdUSnFZjSA0VCTHfuxQomF9GwPp6TuQeDtqsTMnM
	 bQv/UEIURBN4QNiyYZgRzqke0vWnox0lz9KEFcxE6r0tMq4vqS0AWu5CZ5I7SpGqgT
	 JgMd5ftXlUJq42hVxCDoeXcF47Y5TkrqSM1yOWl8UBIkAKRKoJ/9P/G3i/DSPnqzoM
	 WiwJ7YXhK+r4e7SBgC22Rzk/Nl+epwwSajHi4+7OvxoySrrRxgn0B8fsDvaEh9wt3b
	 MEgINWkvNzsWqQJyVPNQVxvQsF/CIaKJWMqnWMIpMf/YbybiUxt9c4tk4nP2C2AeFr
	 8BY+CwiGHBgDQ==
Date: Tue, 26 Nov 2024 08:38:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek,xsphy: add property to
 set disconnect threshold
Message-ID: <42p2d3zi6q2ohod6wqfhhp2g56hffftw2asuavtttzrtaa6x4a@qvc4zwkef5hq>
References: <20241126025859.29923-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126025859.29923-1-chunfeng.yun@mediatek.com>

On Tue, Nov 26, 2024 at 10:58:58AM +0800, Chunfeng Yun wrote:
> Add a property to tune usb2 phy's disconnect threshold.
> And add a compatible for mt8196.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> index a9e3139fd421..2e012d5e1da1 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> @@ -49,6 +49,7 @@ properties:
>        - enum:
>            - mediatek,mt3611-xsphy
>            - mediatek,mt3612-xsphy
> +          - mediatek,mt8196-xsphy

Keep order.

>        - const: mediatek,xsphy
>  
>    reg:
> @@ -129,6 +130,13 @@ patternProperties:
>          minimum: 1
>          maximum: 7
>  
> +      mediatek,discth:
> +        description:
> +          The selection of disconnect threshold (U2 phy)

Threshold in what units?

Best regards,
Krzysztof


