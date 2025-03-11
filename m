Return-Path: <linux-kernel+bounces-555965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C162A5BED4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC63C175483
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900D7252913;
	Tue, 11 Mar 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmOlMRpA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A029A1;
	Tue, 11 Mar 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692147; cv=none; b=jI6ET5ij8XUnfCk4McCFo9VDf4A/3sV9oms2QBWZ5mvLjpNdOtwwO4ywwyAMdvso2YemyUdxGLV+zQlBuRPJiEZcx2j4EEoHn1EjsypXGBwcQOfxYgfs/KYLgJR2PClspxBCYz613M7lEpqrxTb2B1Wf/fVwD4e6Nhm+zkVYXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692147; c=relaxed/simple;
	bh=lMU6ponq0xF7hfMuNjfylz3m1p39UzPIIE6c6X297+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6QiDovRMbq8L7dD+5YtsJA+YkY0mljeoWwjT45RpkhZ6khVKcpqRSWmaU67iKaM3dlmWQ0XvCVbV+QXcGe5bX+dT6HxZMKT0D0+QP5s55+JzJ8qWfF177wSqn37Xr6H68ZOsOmzN8ca1BgiHmrFzxCVk/aIohlLezXvko1NtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmOlMRpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6944C4CEE9;
	Tue, 11 Mar 2025 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741692146;
	bh=lMU6ponq0xF7hfMuNjfylz3m1p39UzPIIE6c6X297+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmOlMRpAXXcA7HM4xu9omX8AqdedevKRIxId0WOqOTno+zeda+2h8sy95HaIMCk+G
	 bUBrnjhfGBQGo06Bw9JqGY18N+soUJB+Q+oWBECAJcFlPJv8OiS7A0Ny6NXt0/wBzq
	 0YNWW3Ij51kn6LRNut5b9Ju5pcdI6doRnu+n1s/fHiL9NYqiXaYNhE0aLQH1r21Cg3
	 j8J4qHgQKVfEJVVARzlszEMPUZp2uQ7fxy8GCcW+LD5EUO+Pn14Yu/eEREWfZybWgI
	 lz4aNnFusUI5DLXQ29K1rVKM63ZON90uW6pR5HTjAMFFGPILh9fYyIrbB1hwGcpnvX
	 EeDnn5iHRQHWg==
Date: Tue, 11 Mar 2025 12:22:22 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-phy@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add rk3562
Message-ID: <Z9Ac7hhQj9J7sFwJ@vaman>
References: <20241224094240.3817261-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224094240.3817261-1-kever.yang@rock-chips.com>

On 24-12-24, 17:42, Kever Yang wrote:
> Add compatible for the USB2 phy in the Rockchip RK3562 SoC.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml         | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> index 6a7ef556414c..367297f6f8b5 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> @@ -19,6 +19,7 @@ properties:
>        - rockchip,rk3328-usb2phy
>        - rockchip,rk3366-usb2phy
>        - rockchip,rk3399-usb2phy
> +      - rockchip,rk3562-usb2phy
>        - rockchip,rk3568-usb2phy
>        - rockchip,rk3576-usb2phy
>        - rockchip,rk3588-usb2phy
> @@ -150,7 +151,6 @@ allOf:
>              enum:
>                - rockchip,rk3568-usb2phy
>                - rockchip,rk3588-usb2phy
> -

Unrelated change?

>      then:
>        properties:
>          host-port:
> @@ -190,6 +190,7 @@ allOf:
>                - rockchip,rk3328-usb2phy
>                - rockchip,rk3366-usb2phy
>                - rockchip,rk3399-usb2phy
> +              - rockchip,rk3562-usb2phy
>                - rockchip,rk3568-usb2phy
>                - rockchip,rk3588-usb2phy
>                - rockchip,rv1108-usb2phy
> -- 
> 2.25.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
~Vinod

