Return-Path: <linux-kernel+bounces-415334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0999D34AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC231F2104B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB90170A15;
	Wed, 20 Nov 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZaBgB2V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347EC15E5BB;
	Wed, 20 Nov 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088750; cv=none; b=OIzOGK1mIOQJVJsiTVU25VknDVcKnrheqA8D0/h4RDzJ3BUHmxKUm6o2drgqZBwjOI6CNQe7S4RhZTSd2WpUCRS6R3wpwYcVB0WTqxWhP08DO+LQPeZNLPjdedOnGFIoyc+ZEPe2Ce6tKUyhXlxCxkLM6vcmk84aQZtCDRQkH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088750; c=relaxed/simple;
	bh=fjhBEYx2+afIi+KL8loGQ8+CDYzRWRrIJw9D5zLDK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ3PTXDPrOuf9gru4UpO1mzPiF4DxqKDEKRRnPoF/ryqtCWnd0eEu0XCHBq4wvsmAxqVRSsAi8B71yQZoN9Zs8/p3t5LftEw8l+/lCOUvLvowi5o4lifzeOZR4+EBry4WbBV4ma2BsNc2wNZP/uNJn3jNolWSHkEUP44/Tu0yWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZaBgB2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DCFC4CECD;
	Wed, 20 Nov 2024 07:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732088749;
	bh=fjhBEYx2+afIi+KL8loGQ8+CDYzRWRrIJw9D5zLDK9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZaBgB2VIcQGe+Ss2zbba1wZONI2E0rh2QotSmj7sa81JjGRxAMy0L0I/H0ncP+OI
	 RQJnujcn6neY1JK16kne36IJ5EVN1fhAaOzBjyZE7d7eUoHM5yyJuRceZnJedb1ppU
	 aO3JLfvf5jP0+RjvRa/P+mHy5dd9hSZBzmMqjOPMFNoqDa2ARgsC+3IMEworbOUBP4
	 yrnfC6enJIDG+7TmDZT92rSP05zRssnEbp8WHS8dnGYxm0P/PPECFmzcV3Sf5jRau3
	 Z/NnjOzs7yLS23/NfHfn2RkbESSO9u7NxemRByy7jVu+nWZwGVMiPEAJ42HJadmhy7
	 OiQ0kE46HxaOw==
Date: Wed, 20 Nov 2024 08:45:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Friday Yang <friday.yang@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp related property
Message-ID: <mnbc33u3ohncqmhyftag26sttqif24mjadnlg2btx7tc3dmowj@6bfh2lb7ekud>
References: <20241120063701.8194-1-friday.yang@mediatek.com>
 <20241120063701.8194-2-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120063701.8194-2-friday.yang@mediatek.com>

On Wed, Nov 20, 2024 at 02:36:38PM +0800, Friday Yang wrote:
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index 2381660b324c..302c0f93b49d 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -69,6 +69,18 @@ properties:
>      description: the hardware id of this larb. It's only required when this
>        hardware id is not consecutive from its M4U point of view.
> 
> +  resets:
> +    maxItems: 1
> +    description: This contains a phandle to the reset controller node and an index
> +      to a reset signal. SMI larbs need to get the reset controller by the node.

First sentence is 100% redundant. Arguments depend on the reset-cells,
not this binding.

> +      SMI could get the reset signal by the index number defined in the header
> +      include/dt-bindings/reset/mt8188-resets.h.

What? How this can depend on consumer? Drop entire description, it is
useless.

> +
> +  reset-names:
> +    const: larb
> +    description: The name of reset controller. SMI driver need to obtain the
> +      reset controller based on this.

Drop description, useless.

> +
>  required:
>    - compatible
>    - reg
> @@ -125,19 +137,38 @@ allOf:
>        required:
>          - mediatek,larb-id
> 
> +  - if:  # only for camera and image subsys
> +      properties:
> +        mediatek,smi:
> +            contains:

Never tested.

> +              enum:
> +                - smi_sub_common_img0_4x1
> +                - smi_sub_common_img1_4x1
> +                - smi_sub_common_cam_5x1
> +                - smi_sub_common_cam_8x1

Does not work. Test your code before you send it. No clue what you want
to achieve, so not sure how to help.


> +
> +    then:
> +      required:
> +        - resets
> +        - reset-names
> +
>  additionalProperties: false
> 
>  examples:
>    - |+
> -    #include <dt-bindings/clock/mt8173-clk.h>
> -    #include <dt-bindings/power/mt8173-power.h>
> -
> -    larb1: larb@16010000 {
> -      compatible = "mediatek,mt8173-smi-larb";
> -      reg = <0x16010000 0x1000>;
> -      mediatek,smi = <&smi_common>;
> -      power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> -      clocks = <&vdecsys CLK_VDEC_CKEN>,
> -               <&vdecsys CLK_VDEC_LARB_CKEN>;
> -      clock-names = "apb", "smi";
> +    #include <dt-bindings/clock/mediatek,mt8188-clk.h>
> +    #include <dt-bindings/power/mediatek,mt8188-power.h>
> +    #include <dt-bindings/reset/mt8188-resets.h>

This is some total mess. Never tested, not correct. Sorry, run it
internally through some sort of review or internal checklist which will
ask you to test the code before sending.

Best regards,
Krzysztof


