Return-Path: <linux-kernel+bounces-244571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B656D92A629
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55EEBB22401
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C4414532B;
	Mon,  8 Jul 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjMzMrs9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902F143896;
	Mon,  8 Jul 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453982; cv=none; b=J3xHsCvreg7hYu9rQH9am6D2waMVIH91JNtGx533NNYMdUIj0a9Qr+9Ta2Ya1LXCXibSEji2p2ZrJs4ZB1d7ujAN9hN0o8EPyOs8E3bIEmW3TbQK3E8uASSUaUh5W0G5wwpp20eFgV61NCunOJIIOKHuSkkCHngfFWGago/8hkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453982; c=relaxed/simple;
	bh=0HrPjlJWsxacB9uG1Q86CrjZXSRsLTHehpJ1rWsU/xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETAFgaOo4cqnV5oa49pv7E5IrgfKTr5RxJuA/sKw90U6lZHJU50MVEyj1/palhYnQx6JCUA2tKa3b7dw+imoey4CKN1T3A3yfYeIloYsVlDJxgwGtCeHeM/Y/GrMBdhtkSrpT9VoLiUetdVg3Q28ycAHhSxFJirLzAH/Bohsp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjMzMrs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C17C116B1;
	Mon,  8 Jul 2024 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720453982;
	bh=0HrPjlJWsxacB9uG1Q86CrjZXSRsLTHehpJ1rWsU/xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjMzMrs99MxACaxMv27c0vfzCn+8st0eVD9Oc1uOLIT6C1tUfF3Gex5VqHVfjDH0O
	 r49dGOZaQlUMDzq4o1D0c97Gsok5+e4yVcI+YAqwm2X7DLnNMVBmk3lMgKzTs8aLFJ
	 04BYJcodpR5rAtAtI129nKv4xZ/yWGWY0u95CmOzi/jDCgvX+Qa369McO98HmTqjCD
	 M7PlGgBis6Jj2XU5CMml2NCAvrFRIrvMB27drQGT6RJPNFUuOCk1xznQbmzANt6jW4
	 T+o4SMNSgIKgLlsRB5cfUCWG9+hQGUQecmkY/O0LmRujm62ZzA3nuZ3Y0CQqKwqbLH
	 x/O2b2aLnQL/A==
Date: Mon, 8 Jul 2024 09:53:00 -0600
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
Message-ID: <20240708155300.GB3239782-robh@kernel.org>
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

Also, in the subject and here drop 'and DT bindings'.

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
> +          - enum:
> +              - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
> +              - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
> +              - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
> +              - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
> +              - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> +              - amlogic,t7-reset
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

