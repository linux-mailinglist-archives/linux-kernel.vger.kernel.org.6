Return-Path: <linux-kernel+bounces-322569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF08972AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3F21C21846
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1763417E472;
	Tue, 10 Sep 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUVVggDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5A17DFEF;
	Tue, 10 Sep 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954015; cv=none; b=B0Mjth+Yiz331bgb5oXl4FAJYtOKbqbJuWFhjzY0EhXvm8FxU+q4RffHmy/Les77apOS8jWI7uO6c+ohkqzo9jnoxxwoyETl5Wx/uxRusts9SKNUYMwuQqy0dnWbxaeJfzdK99WhoeD78P9eXezh35RH6FuX0qEDySSgU9BQ1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954015; c=relaxed/simple;
	bh=wlTegC/QTFnptw7DuqNfzDPNGm8rVd8/JkWhJcVsykE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7oLCC7O7PwneY5a1NDdIW9+d/x7wD/IrYLnjwwzqE5qotfs/khd3TBODkQ8Li0jo1BYb4P5mI4qfu5ABXteb3/iGwBjvFSVPuUio2+7dYLjlgtPnSgI5fmuu5ZoEBn4eCaZiW96m4hIzNq+haqWMH2OrVPd6rZ0nk5hiufdyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUVVggDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD13C4CEC3;
	Tue, 10 Sep 2024 07:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725954015;
	bh=wlTegC/QTFnptw7DuqNfzDPNGm8rVd8/JkWhJcVsykE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUVVggDMNXJs62VS/eSboCHyfFHuOPAwRp9z9KEZBHZbsWXqa9aQ9pxfdA0J+etxi
	 F69wIVikd8TqxQtoQOZd+llfFFqk8sSAu41T7qR2/VfyOrEILVlV99FzENUdY/hRuv
	 4Hx8PzOVx53DC3JzumRAOOcezfflc2JOC7/gsrumyogTjS60YES34eJ0mkoulQjqzn
	 xaAoO28415NSwD4e1Xb1XhblcMJhTjG6g5fOC7brr4pmHKKji2sm3YAswqjAqPWizP
	 9cGVWXHHar4GW0kMpWKT+Mi2Exc7G5HO3OQSzJb0kTfws1/hzSUUJec4kA4rZFayY7
	 YbI/NZv5MwJTg==
Date: Tue, 10 Sep 2024 09:40:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 8/9] dt-bindings: phy: sparx5: document lan969x
Message-ID: <wd3gzn3lpmw64qor3xslif6rnp7htycfhu33pa2xpxvv6mrwqe@nv6pcwkstywe>
References: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
 <20240909-sparx5-lan969x-serdes-driver-v2-8-d695bcb57b84@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909-sparx5-lan969x-serdes-driver-v2-8-d695bcb57b84@microchip.com>

On Mon, Sep 09, 2024 at 05:14:48PM +0200, Daniel Machon wrote:
> Lan969x is going to reuse the existing Sparx5 SERDES driver - document
> that by adding compatible strings for the different SKU's that we
> support, and a short description of the SERDES types and data rates
> supported.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> ---
>  .../bindings/phy/microchip,sparx5-serdes.yaml           | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> index bdbdb3bbddbe..fa0b02916dac 100644
> --- a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> +++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> @@ -8,6 +8,7 @@ title: Microchip Sparx5 Serdes controller
>  
>  maintainers:
>    - Steen Hegelund <steen.hegelund@microchip.com>
> +  - Daniel Machon <daniel.machon@microchip.com>
>  
>  description: |
>    The Sparx5 SERDES interfaces share the same basic functionality, but
> @@ -62,12 +63,26 @@ description: |
>    * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
>    * 25.78125 Gbps (25GBASE-KR/25GBASE-CR/25GBASE-SR/25GBASE-LR/25GBASE-ER)
>  
> +  lan969x has ten SERDES10G interfaces that share the same features, operating
> +  modes and data rates as the equivalent Sparx5 SERDES10G interfaces.
> +
>  properties:
>    $nodename:
>      pattern: "^serdes@[0-9a-f]+$"
>  
>    compatible:
> -    const: microchip,sparx5-serdes
> +    oneOf:
> +      - enum:
> +          - microchip,sparx5-serdes
> +          - microchip,lan9691-serdes
> +      - items:
> +          - enum:
> +              - microchip,lan9698-serdes
> +              - microchip,lan9696-serdes
> +              - microchip,lan9694-serdes
> +              - microchip,lan9693-serdes
> +              - microchip,lan9692-serdes

If there is going to be a new version, keep rather increasing/growing
alphanumerical order, but no need to resend just for this.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


