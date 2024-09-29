Return-Path: <linux-kernel+bounces-343135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4207898971A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B331F2166D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF8574059;
	Sun, 29 Sep 2024 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdyoV0uR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A546434;
	Sun, 29 Sep 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727638576; cv=none; b=sq3gBIr3avEZFJ+WX6TUO3HmJ3Pgv1MXUxhGYaIQ68daj1nOzkYhlbotwu86tDMn4AKI4dXuF464PjP1t33ncAOccVjkC5F+9dPlOlS6fqhnHngcpNc0y1YyeA6MZy3ZpdKkP7vu+lb8O12inA1RF2t8NkzgvVaTNEKVTTp/rY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727638576; c=relaxed/simple;
	bh=/EaBVv2a4Fe/hoiGw4sg1HJ8A8Ac1/Nx8XyQX1oMtlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOR+jlebr5uNjhYfARImhuR/Onoxv2c4lEBhCTCyP7YdpEnVnw3+9LjfXCKTc60OChhFC1E1giztjpS9oS4RAJMAYMgDvwZGo5p0/7WfN4jLpVYxSx0THd2+rGXuAZQ/DKVBpLEpM2R/QIHLHW+JVLh7t8vrzuPJK6zGTUYlK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdyoV0uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF16C4CEC5;
	Sun, 29 Sep 2024 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727638576;
	bh=/EaBVv2a4Fe/hoiGw4sg1HJ8A8Ac1/Nx8XyQX1oMtlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdyoV0uRm1LVGn9+OsksAYWNCgMMr1fSt7a2yZlHrbDmhtBDzR8LTQADbJUkiGYOw
	 bles+aF+JoR4NIWTpY2e/4KhgSnnc1f5UqQRDKh4iWJcnmbVIW81b+7LBjXP5umoUb
	 AzmNRHa6L11TL6GjAnZjOLjM6jWDlSkUWaa25eVCYzElJYgAsA2ge+2kmTI8G1T1Wl
	 KHnwbycgESAPSOfcKdPo5tY9Cg/wTW9hZloVcyl3aki+2tLOvoB957l8WWVMW09sWS
	 HbaLtnyKyPgsKjmDb12iDcuh4oJIw0Xo4Ba2Zol6JGK0PU2PCDz/Ky3QYsRJ03FEJG
	 HjhvjxFO32GZA==
Date: Sun, 29 Sep 2024 21:36:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
	tim.chen@rock-chips.com, frank.wang@rock-chips.com
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
Message-ID: <4czjtesext2ulsmcym2cpjavni7zuve2sdgyiqxkjkaxrl2gpf@7nqylzgd5f55>
References: <20240929061025.3704-1-frawang.cn@gmail.com>
 <20240929061025.3704-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240929061025.3704-2-frawang.cn@gmail.com>

On Sun, Sep 29, 2024 at 02:10:24PM +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
> 
> This change also refactor the clocks list as there are new clocks
> adding used for the USB MMU in RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
> Changelog:
> v4:
>  - refactor the clocks list used if:then:
> 
> v3:
>  - narrowed rk3576 clocks by compatible property.
> 
> v2:
>  - Categorize clock names by oneOf keyword.
> 
> v1:
>  - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/
> 
>  .../bindings/phy/rockchip,inno-usb2phy.yaml   | 46 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> index 5254413137c6..fc2c03d01a20 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> @@ -20,6 +20,7 @@ properties:
>        - rockchip,rk3366-usb2phy
>        - rockchip,rk3399-usb2phy
>        - rockchip,rk3568-usb2phy
> +      - rockchip,rk3576-usb2phy
>        - rockchip,rk3588-usb2phy
>        - rockchip,rv1108-usb2phy
>  
> @@ -34,10 +35,12 @@ properties:
>      const: 0
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
>  
>    clock-names:
> -    const: phyclk
> +    minItems: 1
> +    maxItems: 3
>  
>    assigned-clocks:
>      description:
> @@ -172,6 +175,45 @@ allOf:
>              - interrupts
>              - interrupt-names
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-usb2phy
> +              - rockchip,rk3128-usb2phy
> +              - rockchip,rk3228-usb2phy
> +              - rockchip,rk3308-usb2phy
> +              - rockchip,rk3328-usb2phy
> +              - rockchip,rk3366-usb2phy
> +              - rockchip,rk3399-usb2phy
> +              - rockchip,rk3568-usb2phy
> +              - rockchip,rk3588-usb2phy
> +              - rockchip,rv1108-usb2phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          const: phyclk

maxItems: 1 instead

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3576-usb2phy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: phyclk
> +            - const: aclk
> +            - const: aclk_slv

This list goes to the top property with minItems: 1. Here you have only
minItems: 3.

This way you have only one definition of entire list with same order of
items between variants.

Best regards,
Krzysztof


