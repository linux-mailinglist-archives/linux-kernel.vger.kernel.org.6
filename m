Return-Path: <linux-kernel+bounces-363354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359D199C137
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A14280A22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3714830A;
	Mon, 14 Oct 2024 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePnl1Bla"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC2231C9A;
	Mon, 14 Oct 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890734; cv=none; b=Q9mUgJGmllDMVDGT6oWFEsbEO67gonGsFdAoUnyGstuppv5kMRISmJBuPzrqOe9Le53K0m6mSVVEmN8W6bMl7d5MZpL4Kye/swdeYzcg9nOzdkOfVgcFU1GQR/2WVI4bwAxWdBvXPx4npI7BIPWsQi2XK10+dF769VJ4UIwn3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890734; c=relaxed/simple;
	bh=630SvYBhr24ZHoxQA3bnVprNqH9zzbLIObPGLAZTqE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQlDwryu/uZwnxJXYPSnTabOCNlDCUwWembF9P0iLsXp0v/ZgbAuvDMNdSJ8ec8W71hLa1uh53VHhr3WH5PK+G2BQ+958D1umKh7CMUK2xmI+KL5WA6yAs9AO8BCAy3h+mLj2qsAo70N+OZPqnmQxhLdqa1gWIqxytq6ZZ+05p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePnl1Bla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F8FC4CEC3;
	Mon, 14 Oct 2024 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728890734;
	bh=630SvYBhr24ZHoxQA3bnVprNqH9zzbLIObPGLAZTqE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePnl1BlaY3WYALF6Prgh22s0VdMLxU874Zzun9kHdOatYzYN4wHDkVRtA5usIrb6d
	 w69NwTm7Xh+WsBCsLn8pC9/r5xrs+/RneVsXhIOjOuGVDQQMi7rHhtXNPv3pBh5DIZ
	 WjqLUJ3g2vK4tJIyjUFtNGpaRp/dV0ByFIqP41DR6SurPamaJVDs2ocqwSPfOZZ+0z
	 DVVY5/vQ/u8rl4EuN3nQ0COSOSsr66SaQAu/Mu6tXiRs56ghMIt10Y7PRvX9UpUQx2
	 yALZbgrSScG64Jg0hHlIVpteDH2XUh83xMDsqLuZPlNUN26c0bsgkYvYKeHVBmrB+U
	 LVUi9q0jPMGqQ==
Date: Mon, 14 Oct 2024 09:25:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Michael Riesch <michael.riesch@wolfvision.net>, 
	Andy Yan <andyshrk@163.com>, Jimmy Hon <honyuenkwun@gmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Jing Luo <jing@jing.rocks>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] arm64: dts: rockchip: Add rk3588-orangepi-5b
 device tree and refactor
Message-ID: <owh5aru62opaqeyjmcmhqeljafpql52rfhulfpptwp3vutgrgf@bol6fkrxt33q>
References: <20241013213305.310844-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241013213305.310844-1-cenk.uluisik@googlemail.com>

On Sun, Oct 13, 2024 at 11:32:36PM +0200, Cenk Uluisik wrote:
> Implements a slightly modified rk3588s-orangepi-5b.dts from the vendor.
> Unfortunately the &wireless_bluetooth and &wireless_wlan overlays don't seem
> to compile, so I removed them for now:
> 
> Error: arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts:20.1-20 Label or path wireless_bluetooth not found
> Error: arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts:24.1-15 Label or path wireless_wlan not found
> 
> Bigger parts of the rk3588s-orangepi-5.dts file were moved into a new
> rk3588s-orangepi-5.dtsi file, so that both device trees from the orangepi-5 and 5b include from it and avoid including from the .dts.
> 
> How does this board differ from the original Orange Pi 5?
>   - builtin eMMC storage
>   - no SPI NOR flash (u-boot, preboot etc. initiates from within the eMMC
>     storage)
>   - ap6275p Wifi module (like the Orange Pi 5 Plus)
>   - builtin BlueTooth module
> 
> Beside that everything is exactly the same as far as I know.
> 
> Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 776 +-----------------
>  ...orangepi-5.dts => rk3588s-orangepi-5.dtsi} |   5 +-
>  .../boot/dts/rockchip/rk3588s-orangepi-5b.dts |  18 +
>  4 files changed, 30 insertions(+), 770 deletions(-)
>  rewrite arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts (99%)
>  copy arch/arm64/boot/dts/rockchip/{rk3588s-orangepi-5.dts => rk3588s-orangepi-5.dtsi} (99%)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts


> \ No newline at end of file

Hm?

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> similarity index 99%
> copy from arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> copy to arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> index feea6b20a6bf..739c4d9f58e0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> @@ -10,9 +10,6 @@
>  #include "rk3588s.dtsi"
>  
>  / {
> -	model = "Xunlong Orange Pi 5";
> -	compatible = "xunlong,orangepi-5", "rockchip,rk3588s";
> -
>  	aliases {
>  		ethernet0 = &gmac1;
>  		mmc0 = &sdmmc;
> @@ -763,4 +760,4 @@ &usb_host1_ohci {
>  
>  &usb_host2_xhci {
>  	status = "okay";
> -};
> +};
> \ No newline at end of file

And here


> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> new file mode 100644
> index 000000000000..049227af0252
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3588s-orangepi-5.dtsi"
> +
> +/ {
> +	model = "Xunlong Orange Pi 5B";
> +	compatible = "rockchip,rk3588s-orangepi-5b", "rockchip,rk3588";

Bindings are before users.

> +};
> +
> +&sdhci {
> +	status = "okay";
> +};
> +
> +&sfc {
> +	status = "disabled";
> +};
> \ No newline at end of file

Patch errors here and in other places.

> -- 
> 2.46.0
> 

