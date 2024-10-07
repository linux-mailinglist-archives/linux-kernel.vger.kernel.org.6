Return-Path: <linux-kernel+bounces-354118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697C993800
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A947283D20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E341DE4DC;
	Mon,  7 Oct 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nul5W41n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E21DE2A6;
	Mon,  7 Oct 2024 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331952; cv=none; b=SuZJVwyWdzYFu1ameqXucXxWSRDP1qe44F8Z2ireIRUOWoaiaP1RWlTVJjxzvjA90Huhv6hXFPhHuybpWZEJ7qhBlr+KjzPhkXhC9TMSkeO+VcRzHCSu5Ktc9n770p7MKuAPKYJys/FbjlgNDH3F8euilMTmt14S1nPUUvWawIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331952; c=relaxed/simple;
	bh=P/kHnetBdIsGBFCP1NvFa4+vN0jKSHqmt655ZBl1uDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6ptt5IPfZqIjiifDhyIRZ808y+Zh9LatYoDol8hez5l0EX5L2MjHZD/NZ5LHrMGf/qPdM/EARXdtlVkzBgcRyuDoMoA/5FW0H984VHHEIMbi3mLJMd87PjorAhNmW4KwWxNzJCgA3Rr9ZdzON6ALbpPKct+hDLLMeLR3qP8QXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nul5W41n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBBAC4CEC6;
	Mon,  7 Oct 2024 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331952;
	bh=P/kHnetBdIsGBFCP1NvFa4+vN0jKSHqmt655ZBl1uDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nul5W41ngFclqhvsFMGe8YBLxc6DMnoZ1jKiOUO+sr299GAnmTsOhmJ5TBsLtr4Cw
	 9JBzR7m4E5nksLFXSvUoN/0DRMmPOnbdRiTb+NQTfIVjJeO3YBllQXVW2L3Jm8rzPA
	 s5MNd89XqPB/JoAGnq+2KN3By4120lQxyRApzjEpEcyZeJYYtoDy1rTcydxQjxb1fP
	 jJR+HDJHUNZa86p1Lu7suD1Yyt9TnB0rOl5Aucybu6CtPdsKFCupJMTb/tKrgJojeC
	 OtXqE6735OVZ/7AWcpLp7Ph27Nq9CpU5YOUV7KIzmLReWEqwQkGAE8jO3AALqWdRvZ
	 M1gWD1fvAR3/g==
Date: Mon, 7 Oct 2024 15:12:31 -0500
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] ASoC: dt-bindings: rockchip,rk3036-codec: convert to yaml
Message-ID: <20241007201231.GA2321041-robh@kernel.org>
References: <20241007164542.2452315-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007164542.2452315-1-heiko@sntech.de>

On Mon, Oct 07, 2024 at 06:45:42PM +0200, Heiko Stuebner wrote:
> Convert the binding to yaml.
> 
> The codec seems to be from Innosilicon, but the compatible has ever only
> been rockchip-based, as they sythesized the codec for the rk3036.
> 
> So the yaml file gets a name matching that compatible.
> The only other notable change is the addition of the #sound-dai-cells
> property, that is always required.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../devicetree/bindings/sound/inno-rk3036.txt | 20 -------
>  .../bindings/sound/rockchip,rk3036-codec.yaml | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/inno-rk3036.txt b/Documentation/devicetree/bindings/sound/inno-rk3036.txt
> deleted file mode 100644
> index 758de8e27561..000000000000
> --- a/Documentation/devicetree/bindings/sound/inno-rk3036.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Inno audio codec for RK3036
> -
> -Inno audio codec is integrated inside RK3036 SoC.
> -
> -Required properties:
> -- compatible : Should be "rockchip,rk3036-codec".
> -- reg : The registers of codec.
> -- clock-names : Should be "acodec_pclk".
> -- clocks : The clock of codec.
> -- rockchip,grf : The phandle of grf device node.
> -
> -Example:
> -
> -	acodec: acodec-ana@20030000 {
> -		compatible = "rk3036-codec";
> -		reg = <0x20030000 0x4000>;
> -		rockchip,grf = <&grf>;
> -		clock-names = "acodec_pclk";
> -		clocks = <&cru ACLK_VCODEC>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml
> new file mode 100644
> index 000000000000..786b1ec41999
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/rockchip,rk3036-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3036 internal codec
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>

Blank line

> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3036-codec
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock for audio codec
> +
> +  clock-names:
> +    items:
> +      - const: acodec_pclk
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle of the syscon node for the GRF register.
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - rockchip,grf
> +  - "#sound-dai-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3036-cru.h>
> +    acodec: audio-codec@20030000 {
> +      compatible = "rockchip,rk3036-codec";
> +      reg = <0x20030000 0x4000>;
> +      rockchip,grf = <&grf>;
> +      clock-names = "acodec_pclk";
> +      clocks = <&cru ACLK_VCODEC>;
> +      #sound-dai-cells = <0>;
> +    };
> -- 
> 2.43.0
> 

