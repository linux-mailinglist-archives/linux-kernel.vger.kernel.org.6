Return-Path: <linux-kernel+bounces-286544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2DB951C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A406C288C51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6631B14E6;
	Wed, 14 Aug 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Q6MbG8pk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506C394;
	Wed, 14 Aug 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643640; cv=none; b=m7haSf/tTvUeeiWA3KTLcxYS5KEP/l1Lfv/n1UZUKc3Latxu+XELlVR9cItRuaJw2F9fuYAM1FGFyQ6rfKlO+lV+IHPAdDAqWr0OU208AOw3IVR8RQmZ3hSblaomgyS3t7dKLBHMlPW+JDfq941shTieJLIiQQbE26d8GjSSy4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643640; c=relaxed/simple;
	bh=G0592ODNMZ0FOLxBgE/OYbFmqxpKCrAF1mN/HNGFps4=;
	h=From:To:Cc:Subject:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=uZPfTLcUEPLkc9tg+yQYG7tZNSG0Zlj+yIxleK1Cf/RiVO+wSNgJkKkIGeIuIjxuW5zfGx8UmE8oJ8i/9JjiZbmU4VgfWWYVoHLroO0o1+nzUoVAuvZ/9rtRrmqi6t969Zt/n8kAuDdIX6sH8x4DQ2XHRrOqx010q9SkFBfcGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Q6MbG8pk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j2Lsb5odU7xswY1+GwKw+nWRQWuJgqe2YvXdnyLQ4Yw=; b=Q6MbG8pkvlyCyyw6banO2xDu07
	8ktD9nvRoMahDmrzjat9ZXg2jaZlEfpQSSbTLe+p/WdVOcmXinjO5vAxxtJmdWypmNxQ864kAmdIL
	hgYxOrCNp9eKUvoR60EswZKaztx4VVJrTqNTWO+Pdy0DblqsVnyQ6DvwuSP/1SYafF4POJZe3jPCL
	FhoUqljKDtlRTRLkpjqrvs2ouhnrxg3LTsoukBuLVDWE/QOdbnEbadRtSlWJOC9gRZ/WE6bJ7F1ht
	6AeQouuZVFi7YQyv4L/zlTpzaC/5dLftsQ9IANHBlniUrfw8y5X7Le9/dYAMwiswqxy8+yvo3uR84
	du7QsHmw==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seERR-00042s-Dz; Wed, 14 Aug 2024 15:53:33 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Cc: Daniel Golle <daniel@makrotopia.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH V2 1/2 RESEND] arm64: dts: rockchip: Add DTS for FriendlyARM
 NanoPi R2S Plus
Date: Wed, 14 Aug 2024 15:53:31 +0200
Message-ID: <2687101.CFs8Y8CuNP@diego>
References:
 <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org> <3733110.CjrmPviFsx@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 14. August 2024, 14:24:03 CEST schrieb Sergey 'Jin' Bostandzhy=
an:
> On Wed, Aug 14, 2024 at 01:36:43PM +0200, Heiko St=FCbner wrote:
> > Am Mittwoch, 14. August 2024, 13:21:38 CEST schrieb Sergey 'Jin' Bostan=
dzhyan:
> > > Hi,
> > >=20
> > > On Sat, Aug 10, 2024 at 09:11:56PM +0200, Heiko St=FCbner wrote:
> > > > Am Montag, 5. August 2024, 10:59:35 CEST schrieb Sergey 'Jin' Bosta=
ndzhyan:
> > > > > On Sun, Aug 04, 2024 at 01:27:50AM +0100, Daniel Golle wrote:
> > > > > > On Thu, Aug 01, 2024 at 05:57:35PM +0000, Sergey Bostandzhyan w=
rote:
> > > > > > > The R2S Plus is basically an R2S with additional eMMC.
> > > > > > >=20
> > > > > > > The eMMC configuration for the DTS has been extracted and cop=
ied from
> > > > > > > rk3328-nanopi-r2.dts, v2017.09 branch from the friendlyarm/ub=
oot-rockchip
> > > > > > > repository.
> > > > > > >=20
> > > > > > > Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
> > > > > > >  .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 31 +++++++++=
++++++++++
> > > > > > >  2 files changed, 32 insertions(+)
> > > > > > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanop=
i-r2s-plus.dts
> > > > > > >=20
> > > > > > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm=
64/boot/dts/rockchip/Makefile
> > > > > > > index fda1b980eb4b..36258dc8dafd 100644
> > > > > > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > > > > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > > > > > @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-evb=
=2Edtb
> > > > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-nanopi-r2c.dtb
> > > > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-nanopi-r2c-plus.dtb
> > > > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-nanopi-r2s.dtb
> > > > > > > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-nanopi-r2s-plus.dtb
> > > > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-orangepi-r1-plus.dtb
> > > > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-orangepi-r1-plus-lts=
=2Edtb
> > > > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-rock64.dtb
> > > > > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-p=
lus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..7b83090a2145
> > > > > > > --- /dev/null
> > > > > > > +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> > > > > > > @@ -0,0 +1,31 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > > +/*
> > > > > > > + * (C) Copyright 2018 FriendlyElec Computer Tech. Co., Ltd.
> > > > > > > + * (http://www.friendlyarm.com)
> > > > > > > + *
> > > > > > > + * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> > > > > > > + */
> > > > > > > +
> > > > > > > +/dts-v1/;
> > > > > > > +#include "rk3328-nanopi-r2s.dts"
> > > > > > > +
> > > > > > > +/ {
> > > > > > > +	model =3D "FriendlyElec NanoPi R2S Plus";
> > > > > > > +	compatible =3D "friendlyarm,nanopi-r2s-plus", "rockchip,rk3=
328";
> > > > > > > +
> > > > > > > +	aliases {
> > > > > > > +		mmc1 =3D &emmc;
> > > > > > > +	};
> > > > > > > +};
> > > > > > > +
> > > > > > > +&emmc {
> > > > > > > +	bus-width =3D <8>;
> > > > > > > +	cap-mmc-highspeed;
> > > > > > > +	supports-emmc;
> > > > > > > +	disable-wp;
> > > > > > > +	non-removable;
> > > > > > > +	num-slots =3D <1>;
> > > > > > > +	pinctrl-names =3D "default";
> > > > > > > +	pinctrl-0 =3D <&emmc_clk &emmc_cmd &emmc_bus8>;
> > > > > >=20
> > > > > > I think it's worth adding
> > > > > >=20
> > > > > > 	mmc-hs200-1_8v;
> > > > > >=20
> > > > > >=20
> > > > > > I've tried getting the best speed possible and while HS400 with=
 and
> > > > > > without enhanced strobe did NOT work, hs200 works just fine.
> > > > > > [    0.459863] mmc_host mmc1: Bus speed (slot 0) =3D 50000000Hz=
 (slot req 52000000Hz, actual 50000000HZ div =3D 0)
> > > > > > [    0.460884] mmc_host mmc1: Bus speed (slot 0) =3D 150000000H=
z (slot req 150000000Hz, actual 150000000HZ div =3D 0)
> > > > > > ...
> > > > > > [    0.728220] dwmmc_rockchip ff520000.mmc: Successfully tuned =
phase to 194
> > > > > > [    0.728940] mmc1: new HS200 MMC card at address 0001
> > > > > > [    0.730774] mmcblk1: mmc1:0001 A3A551 28.9 GiB
> > > > > > [    0.733262]  mmcblk1: p1 p2
> > > > > > [    0.734562] mmcblk1boot0: mmc1:0001 A3A551 4.00 MiB
> > > > > > [    0.736818] mmcblk1boot1: mmc1:0001 A3A551 4.00 MiB
> > > > > > [    0.738503] mmcblk1rpmb: mmc1:0001 A3A551 16.0 MiB, chardev =
(245:0)
> > > > > >=20
> > > > > > root@OpenWrt:/# hdparm -t /dev/mmcblk1
> > > > > >=20
> > > > > > /dev/mmcblk1:
> > > > > >  Timing buffered disk reads: 342 MB in  3.00 seconds =3D 113.81=
 MB/sec
> > > > > >=20
> > > > > >=20
> > > > > > Without 'mmc-hs200-1_8v' property in DT the eMMC is detected as
> > > > > > [    0.440465] mmc_host mmc1: Bus speed (slot 0) =3D 50000000Hz=
 (slot req 52000000Hz, actual 50000000HZ div =3D 0)
> > > > > > [    0.442032] mmc1: new high speed MMC card at address 0001
> > > > > > [    0.444261] mmcblk1: mmc1:0001 A3A551 28.9 GiB
> > > > > > [    0.447388]  mmcblk1: p1 p2
> > > > > > [    0.448744] mmcblk1boot0: mmc1:0001 A3A551 4.00 MiB
> > > > > > [    0.451065] mmcblk1boot1: mmc1:0001 A3A551 4.00 MiB
> > > > > > [    0.452871] mmcblk1rpmb: mmc1:0001 A3A551 16.0 MiB, chardev =
(245:0)
> > > > > >=20
> > > > > >=20
> > > > > > root@OpenWrt:/# hdparm -t /dev/mmcblk1
> > > > > >=20
> > > > > > /dev/mmcblk1:
> > > > > >  Timing buffered disk reads: 134 MB in  3.03 seconds =3D  44.18=
 MB/sec
> > > > > >=20
> > > > > >=20
> > > > > > > +	status =3D "okay";
> > > > > > > +};
> > > > > >=20
> > > > > > I'm right now trying to get SDIO RTL8822CS working, so far I'm =
out of luck,
> > > > > > but it can be added later once we got it working.
> > > > >=20
> > > > > would you be interested in taking over my attempted patches? Thin=
g is,
> > > > > that I am a userspace guy who only copy-pasted some entries from
> > > > > FriendlyElec and things happened to work, but I really have no cl=
ue what I am
> > > > > doing when it comes to hardware and DTS. I see that some changes =
were suggested,=20
> > > > > not only by you above, but also by others earlier and I have litt=
le
> > > > > understanding of where I should be inserting what and how.
> > > > >=20
> > > > > At this point I think it would make more sense if someone who act=
ually
> > > > > understands what they are doing would continue to tune the DTS :)
> > > > >=20
> > > > > So it'd be great if either you or anyone else would be willing to=
 take
> > > > > over?
> > > >=20
> > > > Though, a board devicetree is a nice way to get "your feet wet" in =
the
> > > > kernel :-) and for a lot of people scratching ones own itches gets =
them
> > > > started.
> > >=20
> > > While this may very well be true, my main issue is not the DT syntax,
> > > but the lack of understanding of the underlying hardware and also a l=
ack of
> > > enthusiasm to dive into the hardware topics - I prefer to stay in
> > > userspace where the kernel provides a very nice abstraction to all th=
ose=20
> > > details ;)
> >=20
> > No worries :-) .
> >=20
> > Though in this case you're "on the hook" for the board devicetree :-D .
> >=20
> >=20
> > > > The devicetree is easy enough, also looks correct and you even got =
the
> > > > binding change correct - and you're the person with the actual boar=
d :-) .
> > > >=20
> > > > Could you possibly test if the   mmc-hs200-1_8v; property works for=
 you?
> > >=20
> > > It does, I get pretty much the same results as Daniel:
> > >=20
> > > root@nanopi-r2s-plus:~# hdparm -t /dev/mmcblk1
> > > /dev/mmcblk1:
> > >  Timing buffered disk reads: 134 MB in  3.04 seconds =3D  44.13 MB/sec
> > >=20
> > > With mmc-hs200-1_8v:
> > >=20
> > > root@nanopi-r2s-plus:~# hdparm -t /dev/mmcblk1
> > >  /dev/mmcblk1:
> > >   Timing buffered disk reads: 340 MB in  3.01 seconds =3D 113.08 MB/s=
ec
> > >=20
> > > Should I add a commit on top with this change and submit a v3 patchse=
t?
> > >=20
> > > On Thu, Aug 01, 2024 at 11:22:27PM +0200, Heiko St=FCbner wrote:
> > > > general remark, please don't send new versions as threaded replies =
to
> > > > old
> > > > versions. The normal case for git-send-email is to create a new thr=
ead
> > > > and this continuing inside the old thread confues tooling.
> > >=20
> > > In case you tell me to go ahead with a v3 set, should it be in this
> > > thread or not? I understood RESEND's should be new, but updates should
> > > stay in the thread, right?
> > >=20
> > > Sorry, I actually did read the guides, but seems misunderstood what I=
 should
> > > be doing as I inserted the in-reply-to header in my last RESEND.
> >=20
> > Please do a v3 ... in a new thread.
>=20
> There was one other note though to which I did not receive a clear
> repsonse. Bjoern A. Zeeb noticed, that the newer version from the
> rockhip repo has // SPDX-License-Identifier: (GPL-2.0+ OR MIT) while the
> one which I copied the code from did not have the "OR MIT" part, hence I
> also did not have it in my patch.
>=20
> Am I supposed to leave it as is, since I copied the block from the
> sources which indeed were GP-2.0 only or should I add the "OR MIT" part
> as it is apparently the case in newer versions of the dts file from
> rockhcip?

the code you based your dts on changed licenses, so I guess you're also
allowed to change. You could very well also just have "copied it again"
from those new sources under GPL+MIT ;-)

And yep, dual licensing is preferred.

> > Also for the process, please add the Ack you received for patch 2
> > in that v3.
>=20
> You mean, ammend the appropriate commit and add the Acked-By to the
> commit message? OK, will do.

correct. That is the expecting thing to do. DT maintainers see so many
patches that they won't keep track of "oh I have seen that already", so
would in the worst case, re-review the binding patch. By adding the Ack
they can just see (and probably tooling can simply filter out) those that
are already done.


> On Wed, Aug 14, 2024 at 01:34:13PM +0200, Diederik de Haas wrote:
> > On Wed Aug 14, 2024 at 1:30 PM CEST, Diederik de Haas wrote:
> > > On Wed Aug 14, 2024 at 1:21 PM CEST, Sergey 'Jin' Bostandzhyan
> > > wrote:
> > > > In case you tell me to go ahead with a v3 set, should it be in
> > > > this
> > > > thread or not? I understood RESEND's should be new, but updates
> > > > should
> > > > stay in the thread, right?
> > >
> > > No, a new series should be its own thread too.
> >=20
> > More correctly and hopefully more clearly:
>=20
> Understood, thank you!
>=20
> Kind regards,
> Sergey
>=20
>=20





