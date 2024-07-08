Return-Path: <linux-kernel+bounces-244569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BED92A626
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F281F22306
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010CA1459EB;
	Mon,  8 Jul 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCI4ytXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324614532B;
	Mon,  8 Jul 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453931; cv=none; b=GyFdrHMFeKiiOmoe6tKJ/7aQJiTNqeC/xzmc3QbA22W0xAzkaSW8kNtlyalsuCqsG3saXT06RRtMD6qpi3WPUn7AF8aVkpK/rbhr0UNp3B8lw9xUZk0SXvuSx96d4JgozuIvnd354aw3kL4Iko9EIPnbXn8bZoXjo9kpXP9eC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453931; c=relaxed/simple;
	bh=BQg4ZdFzDwwDN7evDXN3MBq4j4BMw5MqDlE19xZONW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilFrqfkMpCFGkwja1oZUpjLjDdpdA67rn14Yy3eaYcgC9+PdeB3hI9dyT8fwUW/T57er6FxpqJW2wMQfDrsO/1yY4i6W5bHYxpOo+I6EikW7Xhr0PHN657bVVIpVw7SUgY58HqQwcNMEZQnha5NRpxhdfyoHqQni2sslim2cgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCI4ytXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8FBC4AF0C;
	Mon,  8 Jul 2024 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720453930;
	bh=BQg4ZdFzDwwDN7evDXN3MBq4j4BMw5MqDlE19xZONW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCI4ytXTNkR9PaCDa+HL4hGXYk74jmyFJjyEHZ8b1Nl99+m+jrKjckKYKxgVDab/g
	 O/fiJ8kHbHNmkQtvW/1YECiEhHcZl4nIXtEa1SG2Jw3rBYlGB7nHb/eeDakJFJSRh9
	 cagcXBekLdu7wSQ+F55DedMIGn5xuSofvYxA9/M8sQwX6iymHci/kS7+jnvvl+YBOL
	 1q5fRoJBM1v6WW0Aa7tjAM+YwSufIL0U4XEABU2+kboVBYEU6FmUBAxB3Fh4TUBKKe
	 8IsCtTlLtEDbRL3HTGHf4ZLR/hrJwXW103Twy7Eo/50gsfzeQpntlrBbY33X8itaRh
	 YwU4bSmcmT72w==
Date: Mon, 8 Jul 2024 09:52:09 -0600
From: Rob Herring <robh@kernel.org>
To: zelong dong <zelong.dong@amlogic.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	kelvin.zhang@amlogic.com
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic A4/A5 Reset Controller
Message-ID: <20240708155209.GA3239782-robh@kernel.org>
References: <20240703061610.37217-1-zelong.dong@amlogic.com>
 <20240703061610.37217-2-zelong.dong@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703061610.37217-2-zelong.dong@amlogic.com>

On Wed, Jul 03, 2024 at 02:16:08PM +0800, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add new compatible and DT bindings for Amlogic A4/A5 Reset Controller
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.yaml   | 22 +++++++++++++------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> index f0c6c0df0ce3..80345af81d5a 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> @@ -12,13 +12,21 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
> -      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
> -      - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
> -      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
> -      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> -      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
> +    oneOf:
> +      - items:

Don't need items here.

> +          - enum:
> +              - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
> +              - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
> +              - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
> +              - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
> +              - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> +              - amlogic,t7-reset

What's t7?

> +      - items:
> +          - enum:
> +              - amlogic,a4-reset
> +              - amlogic,a5-reset
> +              - amlogic,c3-reset
> +          - const: amlogic,meson-s4-reset
>  
>    reg:
>      maxItems: 1
> -- 
> 2.35.1
> 

