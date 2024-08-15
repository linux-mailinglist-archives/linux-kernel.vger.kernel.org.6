Return-Path: <linux-kernel+bounces-288324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF89538D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900671C23D15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC6F1B3F2D;
	Thu, 15 Aug 2024 17:15:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177924211;
	Thu, 15 Aug 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742117; cv=none; b=enm+mBYahum1QXeRI6G9f8mATFUTiLnE37q60gSz1QgOJ9O4/jq0JWfSfayOs9gDpnFaslXpl8GelfM8P++ZgQuYHtHRoWq52pa+Ui7a6IuMGzu4zFFuICKdsVdne4em2nxyAHuXwqAsYLWJT1IAFdKw2GkZvjaZSggHLOLl9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742117; c=relaxed/simple;
	bh=+DaSHYTLdnX2FNUtkjGkSi+7M4tTcDVZY7eAo6CSZQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqHmww41oqkrKFY3gD7MKfPWebRQ/DNOONZDysKVhJj3I3soE6L48ny9OLW/mtC2vqwIQVZvAlKq8MrBdTL99pXJqanJEobNhN+Yzmnz3UYoZb98RlorS5KOce3KaJbfyHFnDjM1pcJWSFL/KFpLT+r9O7d7/rgKjhA6f+Kg64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E42F914BF;
	Thu, 15 Aug 2024 10:15:38 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B9663F58B;
	Thu, 15 Aug 2024 10:15:11 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:15:08 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: wens@csie.org, linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC
 dtsi file
Message-ID: <20240815181508.6800e205@donnerap.manchester.arm.com>
In-Reply-To: <21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
	<CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
	<21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Aug 2024 18:34:58 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

Hi,

> On 2024-08-14 18:11, Chen-Yu Tsai wrote:
> > On Wed, Aug 14, 2024 at 1:52=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>=20
> > wrote: =20
> >>=20
> >> Move the Allwinner A64 CPU OPPs to the A64 SoC dtsi file and,=20
> >> consequently,
> >> adjust the contents of the affected board dts(i) files appropriately,=
=20
> >> to
> >> "encapsulate" the CPU OPPs into the SoC dtsi file.
> >>=20
> >> Moving the CPU OPPs to the SoC dtsi file, instead of requiring the=20
> >> board
> >> dts(i) files to include both the SoC dtsi file and the CPU OPP dtsi=20
> >> file,
> >> reduces the possibility for incomplete SoC data inclusion and improves=
=20
> >> the
> >> overall hierarchical representation of data.  Moreover, the CPU OPPs=20
> >> are
> >> not used anywhere but together with the SoC dtsi file, which=20
> >> additionally
> >> justifies the folding of the CPU OPPs into the SoC dtsi file.
> >>=20
> >> No functional changes are introduced, which was validated by=20
> >> decompiling and
> >> comparing all affected board dtb files before and after these changes.=
=20
> >>  When
> >> compared with the decompiled original dtb files, the updated dtb files=
=20
> >> have
> >> some of their blocks shuffled around a bit and some of their phandles=
=20
> >> have
> >> different values, as a result of the changes to the order in which the
> >> building blocks from the parent dtsi files are included into them, but=
=20
> >> they
> >> still effectively remain the same as the originals. =20
> >=20
> > IIRC, this was a conscious decision requiring board dts files to set=20
> > their
> > CPU supply before OPPs are given. The bootloader does not boot the SoC
> > at the highest possible OPP / regulator voltage, so if the OPPs are=20
> > given
> > but the supply is not, the kernel will attempt to raise the frequency
> > beyond what the current voltage can supply, causing it to hang.

Yes, this is what I remember as well: this forces boards to opt in to
DVFS, otherwise they get a fixed 816 MHz. Since there is only one OPP
table for all boards with that SoC, I think it's reasonable to ask for
this, since the cooling could not be adequate for higher frequencies in
the first place, or the power supply is not up to par.

> > Now that all existing boards have it properly enabled, there should be=
=20
> > no
> > need for this. However I would appreciate a second opinion. =20

Well, since there is no way to opt *out* now, I am somewhat reluctant to
just have this. What is the actual problem we are solving here? After all
there is just one OPP table for all A64 boards, so there is less confusion
about what to include in each board file. Which IIUC is a more complicated
situation on the Rockchip side.

I still have to try "operating-points-v2", but at least on the H616 side
putting a 'status =3D "disabled";' into the OPP node didn't prevent it from
probing. Otherwise this would have been a nice compromise, I think.

> Good point, thanks for the clarification.  This is quite similar to how
> board dts(i) files for Rockchip SoCs need to enable the SoC's built-in
> TSADC for temperature sensing, before the CPU thermal throttling can
> actually work and prevent the SoC from overheating, etc.
>=20
> The consensus for Rockchip boards is that it's up to the authors and
> reviewers of the board dts(i) files to make sure that the built-in TSADC
> is enabled, etc.  With that approach in mind, and knowing that all=20
> Allwinner
> A64 board dts(i) files are in good shape when it comes to the associated
> voltage regulators, I think it's fine to follow the same approach of
> "encapsulating" the CPU OPPs into the A64 SoC dtsi file.

As mentioned above, I am not so sure about this. With this patch here,
*every* board gets DVFS. And while this seems to be fine when looking at
the current DTs in the tree (which have it anyway), it creates a
potentially dangerous situation for new boards.

So pragmatically speaking, this patch would be fine, but it leaves me a
bit uneasy about future or downstream boards.

Cheers,
Andre

> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>=20
> >> Notes:
> >>     These changes follow the general approach used for the Rockchip=20
> >> RK3588
> >>     and RK3399 SoCs, which was introduced and described further in=20
> >> commits
> >>     def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC dtsi files=
=20
> >> for
> >>     per-variant OPPs") [1] and 296602b8e5f7 ("arm64: dts: rockchip:=20
> >> Move
> >>     RK3399 OPPs to dtsi files for SoC variants"), [2] respectively. =20
> >> Please
> >>     see those commits for a more detailed explanation.
> >>=20
> >>     [1]=20
> >> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.g=
it/commit/?h=3Dfor-next&id=3Ddef88eb4d8365a4aa064d28405d03550a9d0a3be
> >>     [2]=20
> >> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.g=
it/commit/?h=3Dfor-next&id=3D296602b8e5f715d6a0ccdcd37d57170c2c81d5e4
> >>=20
> >>  .../allwinner/sun50i-a64-amarula-relic.dts    |  2 -
> >>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  2 -
> >>  .../dts/allwinner/sun50i-a64-cpu-opp.dtsi     | 75=20
> >> -------------------
> >>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  2 -
> >>  .../dts/allwinner/sun50i-a64-olinuxino.dts    |  2 -
> >>  .../dts/allwinner/sun50i-a64-orangepi-win.dts |  2 -
> >>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  2 -
> >>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  2 -
> >>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 -
> >>  .../boot/dts/allwinner/sun50i-a64-pinetab.dts |  2 -
> >>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  2 -
> >>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  2 -
> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 66 +++++++++++++++-
> >>  .../allwinner/sun50i-h64-remix-mini-pc.dts    |  2 -
> >>  14 files changed, 63 insertions(+), 102 deletions(-)
> >>  delete mode 100644=20
> >> arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
> >>=20
> >> diff --git=20
> >> a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> >> index 8233582f6288..1590a455683f 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> >> @@ -5,8 +5,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>=20
> >>  / {
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts=
=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> >> index d1f415acd7b5..869fd4a50582 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> >> @@ -4,8 +4,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>=20
> >>  / {
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
> >> deleted file mode 100644
> >> index e39db51eb448..000000000000
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
> >> +++ /dev/null
> >> @@ -1,75 +0,0 @@
> >> -// SPDX-License-Identifier: GPL-2.0
> >> -/*
> >> - * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
> >> - */
> >> -
> >> -/ {
> >> -       cpu0_opp_table: opp-table-cpu {
> >> -               compatible =3D "operating-points-v2";
> >> -               opp-shared;
> >> -
> >> -               opp-648000000 {
> >> -                       opp-hz =3D /bits/ 64 <648000000>;
> >> -                       opp-microvolt =3D <1040000>;
> >> -                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> -               };
> >> -
> >> -               opp-816000000 {
> >> -                       opp-hz =3D /bits/ 64 <816000000>;
> >> -                       opp-microvolt =3D <1100000>;
> >> -                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> -               };
> >> -
> >> -               opp-912000000 {
> >> -                       opp-hz =3D /bits/ 64 <912000000>;
> >> -                       opp-microvolt =3D <1120000>;
> >> -                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> -               };
> >> -
> >> -               opp-960000000 {
> >> -                       opp-hz =3D /bits/ 64 <960000000>;
> >> -                       opp-microvolt =3D <1160000>;
> >> -                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> -               };
> >> -
> >> -               opp-1008000000 {
> >> -                       opp-hz =3D /bits/ 64 <1008000000>;
> >> -                       opp-microvolt =3D <1200000>;
> >> -                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> -               };
> >> -
> >> -               opp-1056000000 {
> >> -                       opp-hz =3D /bits/ 64 <1056000000>;
> >> -                       opp-microvolt =3D <1240000>;
> >> -                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> -               };
> >> -
> >> -               opp-1104000000 {
> >> -                       opp-hz =3D /bits/ 64 <1104000000>;
> >> -                       opp-microvolt =3D <1260000>;
> >> -                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> -               };
> >> -
> >> -               opp-1152000000 {
> >> -                       opp-hz =3D /bits/ 64 <1152000000>;
> >> -                       opp-microvolt =3D <1300000>;
> >> -                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> -               };
> >> -       };
> >> -};
> >> -
> >> -&cpu0 {
> >> -       operating-points-v2 =3D <&cpu0_opp_table>;
> >> -};
> >> -
> >> -&cpu1 {
> >> -       operating-points-v2 =3D <&cpu0_opp_table>;
> >> -};
> >> -
> >> -&cpu2 {
> >> -       operating-points-v2 =3D <&cpu0_opp_table>;
> >> -};
> >> -
> >> -&cpu3 {
> >> -       operating-points-v2 =3D <&cpu0_opp_table>;
> >> -};
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> >> index dec9960a7440..e3b1943f7f63 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> >> @@ -4,8 +4,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>=20
> >>  / {
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> >> index fd3794678c33..f1a4a9ab295b 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> >> @@ -4,8 +4,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>=20
> >>  / {
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts=
=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> >> index c8303a66438d..f3c9a3534612 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> >> @@ -5,8 +5,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>=20
> >>  / {
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> index 09e71fd60785..4f65eec043d0 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> @@ -4,8 +4,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>=20
> >>  / {
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >> index 379c2c8466f5..a06a0b34bd3f 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >> @@ -5,8 +5,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>  #include <dt-bindings/input/gpio-keys.h>
> >>  #include <dt-bindings/input/input.h>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >> index 6eab61a12cd8..0e38cd02a90a 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >> @@ -4,8 +4,6 @@
> >>  // Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>  #include <dt-bindings/input/input.h>
> >>  #include <dt-bindings/leds/common.h>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> >> index f5fb1ee32dad..4a49f137885b 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> >> @@ -7,8 +7,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>  #include <dt-bindings/input/input.h>
> >>  #include <dt-bindings/pwm/pwm.h>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> >> index 6d78a1c98f10..4ba5c11e6870 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> >> @@ -4,8 +4,6 @@
> >>  //   Copyright (c) 2016 ARM Ltd.
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>=20
> >>  &codec_analog {
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> >> index b407e1dd08a7..61ccd90bae01 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> >> @@ -5,8 +5,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>  #include <dt-bindings/input/input.h>
> >>  #include <dt-bindings/pwm/pwm.h>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> index e868ca5ae753..f842e64562b7 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> @@ -1,7 +1,10 @@
> >>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> -// Copyright (C) 2016 ARM Ltd.
> >> -// based on the Allwinner H3 dtsi:
> >> -//    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
> >> +/*
> >> + * Copyright (C) 2016 ARM Ltd.
> >> + * based on the Allwinner H3 dtsi:
> >> + *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
> >> + * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
> >> + */
> >>=20
> >>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
> >>  #include <dt-bindings/clock/sun6i-rtc.h>
> >> @@ -54,6 +57,7 @@ cpu0: cpu@0 {
> >>                         clocks =3D <&ccu CLK_CPUX>;
> >>                         clock-names =3D "cpu";
> >>                         #cooling-cells =3D <2>;
> >> +                       operating-points-v2 =3D <&cpu_opp_table>;
> >>                         i-cache-size =3D <0x8000>;
> >>                         i-cache-line-size =3D <64>;
> >>                         i-cache-sets =3D <256>;
> >> @@ -71,6 +75,7 @@ cpu1: cpu@1 {
> >>                         clocks =3D <&ccu CLK_CPUX>;
> >>                         clock-names =3D "cpu";
> >>                         #cooling-cells =3D <2>;
> >> +                       operating-points-v2 =3D <&cpu_opp_table>;
> >>                         i-cache-size =3D <0x8000>;
> >>                         i-cache-line-size =3D <64>;
> >>                         i-cache-sets =3D <256>;
> >> @@ -88,6 +93,7 @@ cpu2: cpu@2 {
> >>                         clocks =3D <&ccu CLK_CPUX>;
> >>                         clock-names =3D "cpu";
> >>                         #cooling-cells =3D <2>;
> >> +                       operating-points-v2 =3D <&cpu_opp_table>;
> >>                         i-cache-size =3D <0x8000>;
> >>                         i-cache-line-size =3D <64>;
> >>                         i-cache-sets =3D <256>;
> >> @@ -105,6 +111,7 @@ cpu3: cpu@3 {
> >>                         clocks =3D <&ccu CLK_CPUX>;
> >>                         clock-names =3D "cpu";
> >>                         #cooling-cells =3D <2>;
> >> +                       operating-points-v2 =3D <&cpu_opp_table>;
> >>                         i-cache-size =3D <0x8000>;
> >>                         i-cache-line-size =3D <64>;
> >>                         i-cache-sets =3D <256>;
> >> @@ -124,6 +131,59 @@ l2_cache: l2-cache {
> >>                 };
> >>         };
> >>=20
> >> +       cpu_opp_table: opp-table-cpu {
> >> +               compatible =3D "operating-points-v2";
> >> +               opp-shared;
> >> +
> >> +               opp-648000000 {
> >> +                       opp-hz =3D /bits/ 64 <648000000>;
> >> +                       opp-microvolt =3D <1040000>;
> >> +                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> +               };
> >> +
> >> +               opp-816000000 {
> >> +                       opp-hz =3D /bits/ 64 <816000000>;
> >> +                       opp-microvolt =3D <1100000>;
> >> +                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> +               };
> >> +
> >> +               opp-912000000 {
> >> +                       opp-hz =3D /bits/ 64 <912000000>;
> >> +                       opp-microvolt =3D <1120000>;
> >> +                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> +               };
> >> +
> >> +               opp-960000000 {
> >> +                       opp-hz =3D /bits/ 64 <960000000>;
> >> +                       opp-microvolt =3D <1160000>;
> >> +                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> +               };
> >> +
> >> +               opp-1008000000 {
> >> +                       opp-hz =3D /bits/ 64 <1008000000>;
> >> +                       opp-microvolt =3D <1200000>;
> >> +                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> +               };
> >> +
> >> +               opp-1056000000 {
> >> +                       opp-hz =3D /bits/ 64 <1056000000>;
> >> +                       opp-microvolt =3D <1240000>;
> >> +                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> +               };
> >> +
> >> +               opp-1104000000 {
> >> +                       opp-hz =3D /bits/ 64 <1104000000>;
> >> +                       opp-microvolt =3D <1260000>;
> >> +                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> +               };
> >> +
> >> +               opp-1152000000 {
> >> +                       opp-hz =3D /bits/ 64 <1152000000>;
> >> +                       opp-microvolt =3D <1300000>;
> >> +                       clock-latency-ns =3D <244144>; /* 8 32k period=
s=20
> >> */
> >> +               };
> >> +       };
> >> +
> >>         de: display-engine {
> >>                 compatible =3D "allwinner,sun50i-a64-display-engine";
> >>                 allwinner,pipelines =3D <&mixer0>,
> >> diff --git=20
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> >> index ce90327e1b2e..19cb74cf1f57 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> >> @@ -4,8 +4,6 @@
> >>  /dts-v1/;
> >>=20
> >>  #include "sun50i-a64.dtsi"
> >> -#include "sun50i-a64-cpu-opp.dtsi"
> >> -
> >>  #include <dt-bindings/gpio/gpio.h>
> >>=20
> >>  / { =20
>=20


