Return-Path: <linux-kernel+bounces-335663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A4297E8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EA0280A21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A721194A61;
	Mon, 23 Sep 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awA5lsEk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651BA5339E;
	Mon, 23 Sep 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083872; cv=none; b=ExQOwG/I3FQePat1KN8T0HaP6jh4F+G0eGbXLG5RHV+vXXqydKaN7nzZoieEIAkebx//x4cf3eL6e3ZQSgbQ2szRWsGLOOUb2V+v6q1QHXBxJ8Yjh3Tr0Y87CJQs1QxhPpacQqGWypOCqeqCEnj8aCJwXSNm+6VVQVtrWDTStgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083872; c=relaxed/simple;
	bh=b4o15KHRrP7eUWmz7hmE5pW+X7JxqTAywAB5EhIEuAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUHIyoHhF382KZF16zPAQaxVU9cCU+ZF/vEWKCTg43XjoBvbhYcisqRrXPG40QhUaUdE5GQv4ZI+Fs1+BG3CWgc4Rfp3W587wHYrefFzHJjW9dxMLfBsbbxWjzeI7T2Xs9+89WyBSsfyps6Fph5OisoKUReSehUvac5X9gqk0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awA5lsEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE056C4CEC4;
	Mon, 23 Sep 2024 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727083871;
	bh=b4o15KHRrP7eUWmz7hmE5pW+X7JxqTAywAB5EhIEuAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awA5lsEkDZFpaofCD/CcAcMlFtcVwR97wCkFpUR08+GMJr2cHAEA0lWPx/vzw4Jn7
	 0nxuD6VhstBY6jYyvbHWQLtst7ZOqnb4NSvnCXhjp8MaVI6dP4NT6t8oQEEm1mfOQF
	 JHzdD9Huv1fLxiR0gZoWFN+1HuA4/1pd8xv7BeOhQ51hDM0qOW06AMpqpN+cgzQ54U
	 DX/0LV+j0g+nbTV5nATm1ULfNYtsP7or/hAMQP4mmcDhikaRyM/z3DEVZIM7cbUfWs
	 p6+KGAhIgRneZ/hs24beE5yrCGSdIoq+IVZQ8EgQ5xDqRdh9pkyXaaWB7JCNbSlo0r
	 wOnf0ghRP4f5Q==
Date: Mon, 23 Sep 2024 11:31:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wang <frank.wang@rock-chips.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
	tim.chen@rock-chips.com, wmc@rock-chips.com
Subject: Re: [RESEND PATCH 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
Message-ID: <snccizbw6thn3lhwad4xppp7vqii4p56ttl2gufwc3ke7vfckf@e4b7nvwwtdfr>
References: <20240923025326.10467-1-frank.wang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923025326.10467-1-frank.wang@rock-chips.com>

On Mon, Sep 23, 2024 at 10:53:25AM +0800, Frank Wang wrote:
> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> index 5254413137c64..214917e55c0b6 100644
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
> @@ -34,10 +35,16 @@ properties:
>      const: 0
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: phyclk - PHY input reference clocks.
> +      - description: aclk and aclk_slv are optional and used for USB MMU.
>  
>    clock-names:
> +    minItems: 1
>      const: phyclk
> +    const: aclk
> +    const: aclk_slv

Please test... Not sure what you wanted to achieve here, but maybe
oneOf?

Best regards,
Krzysztof


