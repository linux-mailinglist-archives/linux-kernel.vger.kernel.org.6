Return-Path: <linux-kernel+bounces-274413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACA39477D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F62B23D1F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203D1509B6;
	Mon,  5 Aug 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="kddCsnBu"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54913D628;
	Mon,  5 Aug 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848401; cv=none; b=dyB5VkOtNY4cFfppPsWAQDDWjSfthVgfcjNWjtiIPTtqVPH3ftpoPqb9BGHRbbK/0DZ2jKXrRqoIhH6tKPqaObIsApgnrYmvXEhhmzcj4VfJWOF8Ix4oplvf4ouYXYYKM4MbkW5d3SqRq6yYXPvuES4/8YiJm68ukLZuW4kRyBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848401; c=relaxed/simple;
	bh=tmHgGf62PeYz9BY6aiMtg+20K319NfsqGiqHiVaLq7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqvU2DgkkN61CiYkGTSVgSIXalE/sYhuNFxD/A6+n7z0ALetPExEiDmOubAUtLMjqlrvWjqDJn4PQOq3eX8+Dl3BQaX2wE1QfeteWCdKq/acabGevkhOlbzzHSawLPh1uPohaFHI8D6i6P5uVr5sWy6ig7I9TEx7FFediAfpo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=kddCsnBu; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id 3C82F40438C0; Mon,  5 Aug 2024 08:59:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su 3C82F40438C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1722848375;
	bh=tmHgGf62PeYz9BY6aiMtg+20K319NfsqGiqHiVaLq7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kddCsnBu9RWy/QmNJ0vEK1WGes0SGvJGpwGqRyFVeRlqWMf+s+FvFH8y53OkcHDC0
	 r0MVhpUA0osJ93dJb3G+WOh+FHcmXzW4CmZxpKnuq7jXCaqeY/ab0WZ9XhFHZdseIT
	 zG6AliqSLvXBxxez+/J3oEpV5P5+rp/VLpKo1ZzFTaG1U0CfkXdtJjRRxxb9DZRzTH
	 XjS2XZaxUBIH5MLnF8M+QXKXDpFMCg2EIU+ngxG7U8uspGkVQaMdw2wpjAB8LMIGDv
	 9BdCiS7i55Evl6ISKvRsqqYi6Vi05SUmmv7MdLvNISANWyFaapaijMCHUxqAnb4gdI
	 xXxeTk7IxZyvA==
Date: Mon, 5 Aug 2024 08:59:35 +0000
From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
To: Daniel Golle <daniel@makrotopia.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2 RESEND] arm64: dts: rockchip: Add DTS for
 FriendlyARM NanoPi R2S Plus
Message-ID: <20240805085935.GA26754@ветеран.su>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <20240801175736.16591-1-jin@mediatomb.cc>
 <20240801175736.16591-2-jin@mediatomb.cc>
 <Zq7LBqKVvVVVLg7a@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq7LBqKVvVVVLg7a@makrotopia.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Daniel,

On Sun, Aug 04, 2024 at 01:27:50AM +0100, Daniel Golle wrote:
> On Thu, Aug 01, 2024 at 05:57:35PM +0000, Sergey Bostandzhyan wrote:
> > The R2S Plus is basically an R2S with additional eMMC.
> > 
> > The eMMC configuration for the DTS has been extracted and copied from
> > rk3328-nanopi-r2.dts, v2017.09 branch from the friendlyarm/uboot-rockchip
> > repository.
> > 
> > Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
> >  .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 31 +++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index fda1b980eb4b..36258dc8dafd 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c-plus.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s-plus.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus-lts.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> > new file mode 100644
> > index 000000000000..7b83090a2145
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * (C) Copyright 2018 FriendlyElec Computer Tech. Co., Ltd.
> > + * (http://www.friendlyarm.com)
> > + *
> > + * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> > + */
> > +
> > +/dts-v1/;
> > +#include "rk3328-nanopi-r2s.dts"
> > +
> > +/ {
> > +	model = "FriendlyElec NanoPi R2S Plus";
> > +	compatible = "friendlyarm,nanopi-r2s-plus", "rockchip,rk3328";
> > +
> > +	aliases {
> > +		mmc1 = &emmc;
> > +	};
> > +};
> > +
> > +&emmc {
> > +	bus-width = <8>;
> > +	cap-mmc-highspeed;
> > +	supports-emmc;
> > +	disable-wp;
> > +	non-removable;
> > +	num-slots = <1>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> 
> I think it's worth adding
> 
> 	mmc-hs200-1_8v;
> 
> 
> I've tried getting the best speed possible and while HS400 with and
> without enhanced strobe did NOT work, hs200 works just fine.
> [    0.459863] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> [    0.460884] mmc_host mmc1: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)
> ...
> [    0.728220] dwmmc_rockchip ff520000.mmc: Successfully tuned phase to 194
> [    0.728940] mmc1: new HS200 MMC card at address 0001
> [    0.730774] mmcblk1: mmc1:0001 A3A551 28.9 GiB
> [    0.733262]  mmcblk1: p1 p2
> [    0.734562] mmcblk1boot0: mmc1:0001 A3A551 4.00 MiB
> [    0.736818] mmcblk1boot1: mmc1:0001 A3A551 4.00 MiB
> [    0.738503] mmcblk1rpmb: mmc1:0001 A3A551 16.0 MiB, chardev (245:0)
> 
> root@OpenWrt:/# hdparm -t /dev/mmcblk1
> 
> /dev/mmcblk1:
>  Timing buffered disk reads: 342 MB in  3.00 seconds = 113.81 MB/sec
> 
> 
> Without 'mmc-hs200-1_8v' property in DT the eMMC is detected as
> [    0.440465] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> [    0.442032] mmc1: new high speed MMC card at address 0001
> [    0.444261] mmcblk1: mmc1:0001 A3A551 28.9 GiB
> [    0.447388]  mmcblk1: p1 p2
> [    0.448744] mmcblk1boot0: mmc1:0001 A3A551 4.00 MiB
> [    0.451065] mmcblk1boot1: mmc1:0001 A3A551 4.00 MiB
> [    0.452871] mmcblk1rpmb: mmc1:0001 A3A551 16.0 MiB, chardev (245:0)
> 
> 
> root@OpenWrt:/# hdparm -t /dev/mmcblk1
> 
> /dev/mmcblk1:
>  Timing buffered disk reads: 134 MB in  3.03 seconds =  44.18 MB/sec
> 
> 
> > +	status = "okay";
> > +};
> 
> I'm right now trying to get SDIO RTL8822CS working, so far I'm out of luck,
> but it can be added later once we got it working.

would you be interested in taking over my attempted patches? Thing is,
that I am a userspace guy who only copy-pasted some entries from
FriendlyElec and things happened to work, but I really have no clue what I am
doing when it comes to hardware and DTS. I see that some changes were suggested, 
not only by you above, but also by others earlier and I have little
understanding of where I should be inserting what and how.

At this point I think it would make more sense if someone who actually
understands what they are doing would continue to tune the DTS :)

So it'd be great if either you or anyone else would be willing to take
over?

Kind regards,
Sergey




