Return-Path: <linux-kernel+bounces-415434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EAD9D3612
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3811F25219
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E718BBA8;
	Wed, 20 Nov 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoeKGvDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4D1487C5;
	Wed, 20 Nov 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093038; cv=none; b=hEl382VOC2qUKRw9GZKn5MCSIRzAUD4uk8t1Hp5HefUQL5++XfhQTr8RJxIdykEC7ViLWglZPxFSp6cAmXrr0IpK3a+fzNWk4yPqrtk8chUJ63xhiBfigG2JMD8Edj1W7qr0EWp757aMmL0nel1OuCQDwXdgFqVBaNrDDdK8bIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093038; c=relaxed/simple;
	bh=NZWLHSmz7z/5yxwdahzySA58S6IipEOZgQkNj1QBZoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WllkXqW3X0DcttocUFk/YD+yomZRoh2Vk2dOkTwASl8X0FJ8sJSEPhtyDLamrhuzbfAPopafcpY/xlwZGJyJGUeXqr0SgkSje9QwUnEadVfZ7FjcktasyZupqcnhFX3WuyxkN/mF3/ea6+6DJ0cJA1QUhjXjt0wxrcXhkKFLJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoeKGvDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7FBC4CED0;
	Wed, 20 Nov 2024 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093038;
	bh=NZWLHSmz7z/5yxwdahzySA58S6IipEOZgQkNj1QBZoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoeKGvDaprjf76dmMdBAlNpU2M7hSfpNcB5GHqeXIhiwgROPYsijW1r9yn1ZsskmX
	 Dp9fDygOYV+8xnJjV4FeWiYbxU7msG4gezmHvRp0lNnO+0KGOgi0GPiARxcjImLFeD
	 xzIhOxZAodkRSgmNRd96bh6ohyUJhFp5A2o+P++4uWN1lfwU7ea7yRQ1vkta2/xWXp
	 oCFEvEDmhzykOLJr/hg7erK2Gll0nlHkDrDPPEUI52IU9YhhtNaT/XVLZIIRqfFhJr
	 uZgo8HFuJ9rVup/zWjbBi9f34Gd+BxHk769dtF98lzFaaLWQ5HuyBvxXRAOGXKRIMs
	 7tpgsjKfUwhlw==
Date: Wed, 20 Nov 2024 09:57:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, detlev.casanova@collabora.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, sebastian.reichel@collabora.com
Subject: Re: [PATCH 3/5] dt-bindings: nvmem: rockchip,otp: Add compatible for
 RK3576
Message-ID: <uzqdch4xiesvc3wq6fcpv7ulw3g7olvyxed7s5payhlddgubiq@apnlq7xgzrjo>
References: <20241119132916.1057797-1-heiko@sntech.de>
 <20241119132916.1057797-4-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119132916.1057797-4-heiko@sntech.de>

On Tue, Nov 19, 2024 at 02:29:14PM +0100, Heiko Stuebner wrote:
> Document the OTP memory found on Rockchip RK3576 SoC.
> 
> The RK3576 uses the same set of clocks as the px30/rk3308
> but has one reset more, so adapt the binding to handle this
> variant as well.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/nvmem/rockchip,otp.yaml           | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> index a44d44b32809..dae7543a0179 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - rockchip,px30-otp
>        - rockchip,rk3308-otp
> +      - rockchip,rk3576-otp
>        - rockchip,rk3588-otp
>  
>    reg:
> @@ -68,6 +69,23 @@ allOf:
>            items:
>              - const: phy
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3576-otp
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3

That's redundant. 3 is there already. You wanted maxItems?

Missing constraint on clock-names (existing binding should be fixed as
well, separate patch).

> +        resets:
> +          minItems: 2

missing maxItems

> +        reset-names:
> +          items:
> +            - const: otp
> +            - const: apb

Best regards,
Krzysztof


