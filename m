Return-Path: <linux-kernel+bounces-273619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15AB946B90
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197381C213DB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECDD1C20;
	Sun,  4 Aug 2024 00:28:07 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12460138C;
	Sun,  4 Aug 2024 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722731286; cv=none; b=KXDbQLfKpedRkt6/KDPtYaoHPp63vW0J7gpYjACA6Rf9k2rKxkYZ0z7S44CBmg6274JWfNk4ZRMqqm8g7uA7O4J9W8IxXCxUVc/XKDaeq+6ytRqDU1dDgEpecKcXvO5qqEY8t4F8Fe1G8ciGRj69iSWwwrUWqKQmL0JPBhfiXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722731286; c=relaxed/simple;
	bh=5llG49YrGPoFYWPkv4FgKVoer70XEMlocCwipZhVGjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrZYb4by1YaoiVtFiWrBpGkJ3tQhxlMBE8MOIg/Q3SaedKrpwMVsXs8+5HDtfHIdgs8OqJ+a4yE4jyByD50+7zdw07nrCJu50KQ+0OugC3e8dKzr47+9YXIOIuNDO12PZew8s6ASk9h43orXg2RNfWA7IfjP0llMB0qz/C2BXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1saP6L-000000008CO-2Cfm;
	Sun, 04 Aug 2024 00:27:57 +0000
Date: Sun, 4 Aug 2024 01:27:50 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sergey Bostandzhyan <jin@mediatomb.cc>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2 RESEND] arm64: dts: rockchip: Add DTS for
 FriendlyARM NanoPi R2S Plus
Message-ID: <Zq7LBqKVvVVVLg7a@makrotopia.org>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <20240801175736.16591-1-jin@mediatomb.cc>
 <20240801175736.16591-2-jin@mediatomb.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801175736.16591-2-jin@mediatomb.cc>

On Thu, Aug 01, 2024 at 05:57:35PM +0000, Sergey Bostandzhyan wrote:
> The R2S Plus is basically an R2S with additional eMMC.
> 
> The eMMC configuration for the DTS has been extracted and copied from
> rk3328-nanopi-r2.dts, v2017.09 branch from the friendlyarm/uboot-rockchip
> repository.
> 
> Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 31 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index fda1b980eb4b..36258dc8dafd 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c-plus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s-plus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus-lts.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> new file mode 100644
> index 000000000000..7b83090a2145
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2018 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> + */
> +
> +/dts-v1/;
> +#include "rk3328-nanopi-r2s.dts"
> +
> +/ {
> +	model = "FriendlyElec NanoPi R2S Plus";
> +	compatible = "friendlyarm,nanopi-r2s-plus", "rockchip,rk3328";
> +
> +	aliases {
> +		mmc1 = &emmc;
> +	};
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	supports-emmc;
> +	disable-wp;
> +	non-removable;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;

I think it's worth adding

	mmc-hs200-1_8v;


I've tried getting the best speed possible and while HS400 with and
without enhanced strobe did NOT work, hs200 works just fine.
[    0.459863] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[    0.460884] mmc_host mmc1: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)
...
[    0.728220] dwmmc_rockchip ff520000.mmc: Successfully tuned phase to 194
[    0.728940] mmc1: new HS200 MMC card at address 0001
[    0.730774] mmcblk1: mmc1:0001 A3A551 28.9 GiB
[    0.733262]  mmcblk1: p1 p2
[    0.734562] mmcblk1boot0: mmc1:0001 A3A551 4.00 MiB
[    0.736818] mmcblk1boot1: mmc1:0001 A3A551 4.00 MiB
[    0.738503] mmcblk1rpmb: mmc1:0001 A3A551 16.0 MiB, chardev (245:0)

root@OpenWrt:/# hdparm -t /dev/mmcblk1

/dev/mmcblk1:
 Timing buffered disk reads: 342 MB in  3.00 seconds = 113.81 MB/sec


Without 'mmc-hs200-1_8v' property in DT the eMMC is detected as
[    0.440465] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[    0.442032] mmc1: new high speed MMC card at address 0001
[    0.444261] mmcblk1: mmc1:0001 A3A551 28.9 GiB
[    0.447388]  mmcblk1: p1 p2
[    0.448744] mmcblk1boot0: mmc1:0001 A3A551 4.00 MiB
[    0.451065] mmcblk1boot1: mmc1:0001 A3A551 4.00 MiB
[    0.452871] mmcblk1rpmb: mmc1:0001 A3A551 16.0 MiB, chardev (245:0)


root@OpenWrt:/# hdparm -t /dev/mmcblk1

/dev/mmcblk1:
 Timing buffered disk reads: 134 MB in  3.03 seconds =  44.18 MB/sec


> +	status = "okay";
> +};

I'm right now trying to get SDIO RTL8822CS working, so far I'm out of luck,
but it can be added later once we got it working.

