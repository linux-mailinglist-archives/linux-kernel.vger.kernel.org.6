Return-Path: <linux-kernel+bounces-286343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAD9519DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A06282374
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B861AED39;
	Wed, 14 Aug 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="ZIa+7V6C"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4171AED3C;
	Wed, 14 Aug 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635006; cv=none; b=tZqUsGH6rve3pZciRe0+0SsbhVTZwd7SodfecHOUhAjnCDV9gFNkX3+bOl0TNk+/f5J3D/veJG4whIyqKU6jWt2Ko4+CiJj002du4/3z5jPuEt5+Av+zS2jUG20I2FUgAC0IWs+NxjnRpokDPNJoWzk9j7HtsOITYbAjxpELcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635006; c=relaxed/simple;
	bh=1EDs8kRLh7mgW5UZzQ2txFoMJMU6lDg1I+uVQdHyf3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz6P5+HSr1wZMC62BZMG5geeytRGCne0gZw38wqpgBXEfCvP0sOQ1NahHNVDkj8QXGL32R8VgDb5pt+71o1PZIy8P07ywZKYkJsNmC2ZAOeMjbafCvvzuZfHHpoetbqeBf0IErrlmQVe8JNL+zO3FhfbJLWrunfDWgfeiX0hadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=ZIa+7V6C; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id 10F804000222; Wed, 14 Aug 2024 11:21:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su 10F804000222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1723634498;
	bh=1EDs8kRLh7mgW5UZzQ2txFoMJMU6lDg1I+uVQdHyf3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIa+7V6CzQVmLEfyRocxCXUDp8da06kaoSgT2BM6jEqQeSFtbNaHhgRc6n7l08uIX
	 mThIHJ72bAWNOmcKNSQqKgN1YFtuz12rEs/llWM5gZ6WnqmsHppkCT36Q6viwVpxSj
	 Lim1XzifxxBjXBYFi1508bM0Mizxj1+noNAgGt3WNynV0ZwbmkHu+476TN3YJqLmkz
	 k+iaLYG7sts++140w3ppcdUaJJaSTMI1Bq+JJWFnsOpJd3u/MeBA4JMeO6XFr9Ym3I
	 MXxR6CNpwp1vC4aLGsvTeeyNb4GabvtzoGFthOWdSHNSkZ7lTKkkq02/l/QILonXJC
	 fOL+1vIF7qQTw==
Date: Wed, 14 Aug 2024 11:21:38 +0000
From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Daniel Golle <daniel@makrotopia.org>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2 RESEND] arm64: dts: rockchip: Add DTS for
 FriendlyARM NanoPi R2S Plus
Message-ID: <20240814112138.GA21761@ветеран.su>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <Zq7LBqKVvVVVLg7a@makrotopia.org>
 <2309282.ZQ0cqP7t2B@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2309282.ZQ0cqP7t2B@diego>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi,

On Sat, Aug 10, 2024 at 09:11:56PM +0200, Heiko St�bner wrote:
> Am Montag, 5. August 2024, 10:59:35 CEST schrieb Sergey 'Jin' Bostandzhyan:
> > On Sun, Aug 04, 2024 at 01:27:50AM +0100, Daniel Golle wrote:
> > > On Thu, Aug 01, 2024 at 05:57:35PM +0000, Sergey Bostandzhyan wrote:
> > > > The R2S Plus is basically an R2S with additional eMMC.
> > > > 
> > > > The eMMC configuration for the DTS has been extracted and copied from
> > > > rk3328-nanopi-r2.dts, v2017.09 branch from the friendlyarm/uboot-rockchip
> > > > repository.
> > > > 
> > > > Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
> > > > ---
> > > >  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
> > > >  .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 31 +++++++++++++++++++
> > > >  2 files changed, 32 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > > > index fda1b980eb4b..36258dc8dafd 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > > @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c-plus.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
> > > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s-plus.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus-lts.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> > > > new file mode 100644
> > > > index 000000000000..7b83090a2145
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> > > > @@ -0,0 +1,31 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * (C) Copyright 2018 FriendlyElec Computer Tech. Co., Ltd.
> > > > + * (http://www.friendlyarm.com)
> > > > + *
> > > > + * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +#include "rk3328-nanopi-r2s.dts"
> > > > +
> > > > +/ {
> > > > +	model = "FriendlyElec NanoPi R2S Plus";
> > > > +	compatible = "friendlyarm,nanopi-r2s-plus", "rockchip,rk3328";
> > > > +
> > > > +	aliases {
> > > > +		mmc1 = &emmc;
> > > > +	};
> > > > +};
> > > > +
> > > > +&emmc {
> > > > +	bus-width = <8>;
> > > > +	cap-mmc-highspeed;
> > > > +	supports-emmc;
> > > > +	disable-wp;
> > > > +	non-removable;
> > > > +	num-slots = <1>;
> > > > +	pinctrl-names = "default";
> > > > +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> > > 
> > > I think it's worth adding
> > > 
> > > 	mmc-hs200-1_8v;
> > > 
> > > 
> > > I've tried getting the best speed possible and while HS400 with and
> > > without enhanced strobe did NOT work, hs200 works just fine.
> > > [    0.459863] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> > > [    0.460884] mmc_host mmc1: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)
> > > ...
> > > [    0.728220] dwmmc_rockchip ff520000.mmc: Successfully tuned phase to 194
> > > [    0.728940] mmc1: new HS200 MMC card at address 0001
> > > [    0.730774] mmcblk1: mmc1:0001 A3A551 28.9 GiB
> > > [    0.733262]  mmcblk1: p1 p2
> > > [    0.734562] mmcblk1boot0: mmc1:0001 A3A551 4.00 MiB
> > > [    0.736818] mmcblk1boot1: mmc1:0001 A3A551 4.00 MiB
> > > [    0.738503] mmcblk1rpmb: mmc1:0001 A3A551 16.0 MiB, chardev (245:0)
> > > 
> > > root@OpenWrt:/# hdparm -t /dev/mmcblk1
> > > 
> > > /dev/mmcblk1:
> > >  Timing buffered disk reads: 342 MB in  3.00 seconds = 113.81 MB/sec
> > > 
> > > 
> > > Without 'mmc-hs200-1_8v' property in DT the eMMC is detected as
> > > [    0.440465] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> > > [    0.442032] mmc1: new high speed MMC card at address 0001
> > > [    0.444261] mmcblk1: mmc1:0001 A3A551 28.9 GiB
> > > [    0.447388]  mmcblk1: p1 p2
> > > [    0.448744] mmcblk1boot0: mmc1:0001 A3A551 4.00 MiB
> > > [    0.451065] mmcblk1boot1: mmc1:0001 A3A551 4.00 MiB
> > > [    0.452871] mmcblk1rpmb: mmc1:0001 A3A551 16.0 MiB, chardev (245:0)
> > > 
> > > 
> > > root@OpenWrt:/# hdparm -t /dev/mmcblk1
> > > 
> > > /dev/mmcblk1:
> > >  Timing buffered disk reads: 134 MB in  3.03 seconds =  44.18 MB/sec
> > > 
> > > 
> > > > +	status = "okay";
> > > > +};
> > > 
> > > I'm right now trying to get SDIO RTL8822CS working, so far I'm out of luck,
> > > but it can be added later once we got it working.
> > 
> > would you be interested in taking over my attempted patches? Thing is,
> > that I am a userspace guy who only copy-pasted some entries from
> > FriendlyElec and things happened to work, but I really have no clue what I am
> > doing when it comes to hardware and DTS. I see that some changes were suggested, 
> > not only by you above, but also by others earlier and I have little
> > understanding of where I should be inserting what and how.
> > 
> > At this point I think it would make more sense if someone who actually
> > understands what they are doing would continue to tune the DTS :)
> > 
> > So it'd be great if either you or anyone else would be willing to take
> > over?
> 
> Though, a board devicetree is a nice way to get "your feet wet" in the
> kernel :-) and for a lot of people scratching ones own itches gets them
> started.

While this may very well be true, my main issue is not the DT syntax,
but the lack of understanding of the underlying hardware and also a lack of
enthusiasm to dive into the hardware topics - I prefer to stay in
userspace where the kernel provides a very nice abstraction to all those 
details ;)

> The devicetree is easy enough, also looks correct and you even got the
> binding change correct - and you're the person with the actual board :-) .
> 
> Could you possibly test if the   mmc-hs200-1_8v; property works for you?

It does, I get pretty much the same results as Daniel:

root@nanopi-r2s-plus:~# hdparm -t /dev/mmcblk1
/dev/mmcblk1:
 Timing buffered disk reads: 134 MB in  3.04 seconds =  44.13 MB/sec

With mmc-hs200-1_8v:

root@nanopi-r2s-plus:~# hdparm -t /dev/mmcblk1
 /dev/mmcblk1:
  Timing buffered disk reads: 340 MB in  3.01 seconds = 113.08 MB/sec

Should I add a commit on top with this change and submit a v3 patchset?

On Thu, Aug 01, 2024 at 11:22:27PM +0200, Heiko St�bner wrote:
> general remark, please don't send new versions as threaded replies to
> old
> versions. The normal case for git-send-email is to create a new thread
> and this continuing inside the old thread confues tooling.

In case you tell me to go ahead with a v3 set, should it be in this
thread or not? I understood RESEND's should be new, but updates should
stay in the thread, right?

Sorry, I actually did read the guides, but seems misunderstood what I should
be doing as I inserted the in-reply-to header in my last RESEND.

Kind regards,
Sergey



