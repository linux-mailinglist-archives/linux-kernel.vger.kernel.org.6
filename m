Return-Path: <linux-kernel+bounces-317002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E3996D822
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B7D1F22A02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2B719AD8B;
	Thu,  5 Sep 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rGCk6WKe"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317419A2A2;
	Thu,  5 Sep 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538662; cv=none; b=bLgc7glOGYfVQFoh16Bxy4CMK2tNR6nIw+jCsEDx5ywWKhw9MZ3sAE3ut3J9dedl306wUbtAV5+SVWCHCQhwbbNKisVPuvGQbO511Omgna+o1ujetIFuXtTUOZbJCD89zFv7kkf5mQzT9NSEs8Jg9Ir2FcxIr8pn2g/IwRppBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538662; c=relaxed/simple;
	bh=4VrT9BkixL2DCBfHlKRpm6cnX1Y9wxqeSesLrNC28so=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SUH/XKzgI123D9kaPyJwDbm8K9e38YvHJf1cCmMQHef/AEuBLYduN95yDWAodaUzVZwmmGglW+/wmbE2TvcVn+W5Tesr36nLgmhYAjeVFaIBqj/lHHhxpK6jQuUCzvdzZPyqOTlDLZQfyd6Idq+9V0U4kBEXl7wO2qRk3NEf0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rGCk6WKe; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725538655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsMJCI0iSMHtatyyZk7Dfxo+dW1e6qn5kA3GKgoXEeU=;
	b=rGCk6WKerpLORZeRJkwjbDdo9lkVZ2bnAXxMkS6iaWT6y0fObUDuNBhJKi8nY9Kx8yx7QJ
	eR9LlUwtki/8OVIo0qe87nwI+s6QitZ9sRl5/w2yCGsw3mVfDgDdGJOyyaGB1dbLZStatn
	qroZ/hwBlg2MCv9nXdBwrM0V6PMEd/xCQqjYu02HZqjIvx7wIUQxsYXk/WJnutlk9vingd
	YzpIKeL87lZi7/PHDsDpOE3Uyd8WcMXeu322VlnQ8CRCvgsTQRQD9iuegD2BbzyCn3l+kV
	Q/cTdxYRoGIaml97Oc90Uay14EtYTR1gFGaJ+a8MaHnWFzuj6wwXgn3aFVUEsg==
Date: Thu, 05 Sep 2024 14:17:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: wens@csie.org, linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi
 file
In-Reply-To: <06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
 <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
 <21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
 <20240815181508.6800e205@donnerap.manchester.arm.com>
 <06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org>
Message-ID: <0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

Just checking, any further thoughts about this patch?

On 2024-08-17 06:25, Dragan Simic wrote:
> Hello Andre,
> 
> On 2024-08-15 19:15, Andre Przywara wrote:
>> On Thu, 15 Aug 2024 18:34:58 +0200
>> Dragan Simic <dsimic@manjaro.org> wrote:
>>> On 2024-08-14 18:11, Chen-Yu Tsai wrote:
>>> > On Wed, Aug 14, 2024 at 1:52 PM Dragan Simic <dsimic@manjaro.org>
>>> > wrote:
>>> >>
>>> >> Move the Allwinner A64 CPU OPPs to the A64 SoC dtsi file and,
>>> >> consequently,
>>> >> adjust the contents of the affected board dts(i) files appropriately,
>>> >> to
>>> >> "encapsulate" the CPU OPPs into the SoC dtsi file.
>>> >>
>>> >> Moving the CPU OPPs to the SoC dtsi file, instead of requiring the
>>> >> board
>>> >> dts(i) files to include both the SoC dtsi file and the CPU OPP dtsi
>>> >> file,
>>> >> reduces the possibility for incomplete SoC data inclusion and improves
>>> >> the
>>> >> overall hierarchical representation of data.  Moreover, the CPU OPPs
>>> >> are
>>> >> not used anywhere but together with the SoC dtsi file, which
>>> >> additionally
>>> >> justifies the folding of the CPU OPPs into the SoC dtsi file.
>>> >>
>>> >> No functional changes are introduced, which was validated by
>>> >> decompiling and
>>> >> comparing all affected board dtb files before and after these changes.
>>> >>  When
>>> >> compared with the decompiled original dtb files, the updated dtb files
>>> >> have
>>> >> some of their blocks shuffled around a bit and some of their phandles
>>> >> have
>>> >> different values, as a result of the changes to the order in which the
>>> >> building blocks from the parent dtsi files are included into them, but
>>> >> they
>>> >> still effectively remain the same as the originals.
>>> >
>>> > IIRC, this was a conscious decision requiring board dts files to set
>>> > their
>>> > CPU supply before OPPs are given. The bootloader does not boot the SoC
>>> > at the highest possible OPP / regulator voltage, so if the OPPs are
>>> > given
>>> > but the supply is not, the kernel will attempt to raise the frequency
>>> > beyond what the current voltage can supply, causing it to hang.
>> 
>> Yes, this is what I remember as well: this forces boards to opt in to
>> DVFS, otherwise they get a fixed 816 MHz. Since there is only one OPP
>> table for all boards with that SoC, I think it's reasonable to ask for
>> this, since the cooling could not be adequate for higher frequencies 
>> in
>> the first place, or the power supply is not up to par.
> 
> If the cooling isn't capable enough to dissipate the additional heat
> generated at higher frequencies, the thermal governor is there to 
> handle
> that by lowering the operating frequency.  If the PSU isn't capable to
> provide an additional watt or two, I think a better PSU is needed. :)
> No reasonably sized PSU should work at ~100% of its power output.
> 
> On top of that, all currently supported A64-based boards have the CPU
> OPPs defined and CPU DVFS enabled, so no such issues are possible 
> there.
> Though, there could be some issues with new A64-based boards, which is
> discussed further below.
> 
>>> > Now that all existing boards have it properly enabled, there should be
>>> > no
>>> > need for this. However I would appreciate a second opinion.
>> 
>> Well, since there is no way to opt *out* now, I am somewhat reluctant 
>> to
>> just have this. What is the actual problem we are solving here? After 
>> all
>> there is just one OPP table for all A64 boards, so there is less 
>> confusion
>> about what to include in each board file. Which IIUC is a more 
>> complicated
>> situation on the Rockchip side.
> 
> Well, this patch doesn't solve some real problem, but it makes the 
> things
> neater and a bit more clean.  The things are more complicated with 
> Rockchip
> SoCs, but following the concept of "encapsulating" the CPU OPPs into 
> the
> A64 SoC dtsi makes things neater.  Moreover, the A64 GPU OPPs are 
> already
> in the A64 SoC dtsi, so we could also say that folding the A64 CPU OPPs
> into the SoC dtsi follows the A64 GPU OPPs.
> 
>> I still have to try "operating-points-v2", but at least on the H616 
>> side
>> putting a 'status = "disabled";' into the OPP node didn't prevent it 
>> from
>> probing. Otherwise this would have been a nice compromise, I think.
>> 
>>> Good point, thanks for the clarification.  This is quite similar to 
>>> how
>>> board dts(i) files for Rockchip SoCs need to enable the SoC's 
>>> built-in
>>> TSADC for temperature sensing, before the CPU thermal throttling can
>>> actually work and prevent the SoC from overheating, etc.
>>> 
>>> The consensus for Rockchip boards is that it's up to the authors and
>>> reviewers of the board dts(i) files to make sure that the built-in 
>>> TSADC
>>> is enabled, etc.  With that approach in mind, and knowing that all
>>> Allwinner
>>> A64 board dts(i) files are in good shape when it comes to the 
>>> associated
>>> voltage regulators, I think it's fine to follow the same approach of
>>> "encapsulating" the CPU OPPs into the A64 SoC dtsi file.
>> 
>> As mentioned above, I am not so sure about this. With this patch here,
>> *every* board gets DVFS. And while this seems to be fine when looking 
>> at
>> the current DTs in the tree (which have it anyway), it creates a
>> potentially dangerous situation for new boards.
>> 
>> So pragmatically speaking, this patch would be fine, but it leaves me 
>> a
>> bit uneasy about future or downstream boards.
> 
> Frankly, I wouldn't be worried about that.  When a new A64-based board
> is added, it should be verified that CPU DVFS works as expected, etc.,
> before the new board dts file is accepted upstream.
> 
> Maybe we could take into account some possible issues when someone 
> starts
> putting together a new A64-based board dts file, but there are already
> many dangerous things that someone can do in the process, such as 
> messing
> up various regulators and voltages unrelated to the CPU DVFS, so 
> everyone
> putting a new board dts file together simply have to know what are they
> doing.  I see no way for escaping from that need.
> 
>>> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>> >> ---
>>> >>
>>> >> Notes:
>>> >>     These changes follow the general approach used for the Rockchip
>>> >> RK3588
>>> >>     and RK3399 SoCs, which was introduced and described further in
>>> >> commits
>>> >>     def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC dtsi files
>>> >> for
>>> >>     per-variant OPPs") [1] and 296602b8e5f7 ("arm64: dts: rockchip:
>>> >> Move
>>> >>     RK3399 OPPs to dtsi files for SoC variants"), [2] respectively.
>>> >> Please
>>> >>     see those commits for a more detailed explanation.
>>> >>
>>> >>     [1]
>>> >> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=def88eb4d8365a4aa064d28405d03550a9d0a3be
>>> >>     [2]
>>> >> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=296602b8e5f715d6a0ccdcd37d57170c2c81d5e4
>>> >>
>>> >>  .../allwinner/sun50i-a64-amarula-relic.dts    |  2 -
>>> >>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  2 -
>>> >>  .../dts/allwinner/sun50i-a64-cpu-opp.dtsi     | 75
>>> >> -------------------
>>> >>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  2 -
>>> >>  .../dts/allwinner/sun50i-a64-olinuxino.dts    |  2 -
>>> >>  .../dts/allwinner/sun50i-a64-orangepi-win.dts |  2 -
>>> >>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  2 -
>>> >>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  2 -
>>> >>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 -
>>> >>  .../boot/dts/allwinner/sun50i-a64-pinetab.dts |  2 -
>>> >>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  2 -
>>> >>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  2 -
>>> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 66 +++++++++++++++-
>>> >>  .../allwinner/sun50i-h64-remix-mini-pc.dts    |  2 -
>>> >>  14 files changed, 63 insertions(+), 102 deletions(-)
>>> >>  delete mode 100644
>>> >> arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
>>> >>
>>> >> diff --git
>>> >> a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>> >> index 8233582f6288..1590a455683f 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>> >> @@ -5,8 +5,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>
>>> >>  / {
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>>> >> index d1f415acd7b5..869fd4a50582 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>>> >> @@ -4,8 +4,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>
>>> >>  / {
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
>>> >> deleted file mode 100644
>>> >> index e39db51eb448..000000000000
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
>>> >> +++ /dev/null
>>> >> @@ -1,75 +0,0 @@
>>> >> -// SPDX-License-Identifier: GPL-2.0
>>> >> -/*
>>> >> - * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
>>> >> - */
>>> >> -
>>> >> -/ {
>>> >> -       cpu0_opp_table: opp-table-cpu {
>>> >> -               compatible = "operating-points-v2";
>>> >> -               opp-shared;
>>> >> -
>>> >> -               opp-648000000 {
>>> >> -                       opp-hz = /bits/ 64 <648000000>;
>>> >> -                       opp-microvolt = <1040000>;
>>> >> -                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> -               };
>>> >> -
>>> >> -               opp-816000000 {
>>> >> -                       opp-hz = /bits/ 64 <816000000>;
>>> >> -                       opp-microvolt = <1100000>;
>>> >> -                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> -               };
>>> >> -
>>> >> -               opp-912000000 {
>>> >> -                       opp-hz = /bits/ 64 <912000000>;
>>> >> -                       opp-microvolt = <1120000>;
>>> >> -                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> -               };
>>> >> -
>>> >> -               opp-960000000 {
>>> >> -                       opp-hz = /bits/ 64 <960000000>;
>>> >> -                       opp-microvolt = <1160000>;
>>> >> -                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> -               };
>>> >> -
>>> >> -               opp-1008000000 {
>>> >> -                       opp-hz = /bits/ 64 <1008000000>;
>>> >> -                       opp-microvolt = <1200000>;
>>> >> -                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> -               };
>>> >> -
>>> >> -               opp-1056000000 {
>>> >> -                       opp-hz = /bits/ 64 <1056000000>;
>>> >> -                       opp-microvolt = <1240000>;
>>> >> -                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> -               };
>>> >> -
>>> >> -               opp-1104000000 {
>>> >> -                       opp-hz = /bits/ 64 <1104000000>;
>>> >> -                       opp-microvolt = <1260000>;
>>> >> -                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> -               };
>>> >> -
>>> >> -               opp-1152000000 {
>>> >> -                       opp-hz = /bits/ 64 <1152000000>;
>>> >> -                       opp-microvolt = <1300000>;
>>> >> -                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> -               };
>>> >> -       };
>>> >> -};
>>> >> -
>>> >> -&cpu0 {
>>> >> -       operating-points-v2 = <&cpu0_opp_table>;
>>> >> -};
>>> >> -
>>> >> -&cpu1 {
>>> >> -       operating-points-v2 = <&cpu0_opp_table>;
>>> >> -};
>>> >> -
>>> >> -&cpu2 {
>>> >> -       operating-points-v2 = <&cpu0_opp_table>;
>>> >> -};
>>> >> -
>>> >> -&cpu3 {
>>> >> -       operating-points-v2 = <&cpu0_opp_table>;
>>> >> -};
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>> >> index dec9960a7440..e3b1943f7f63 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>> >> @@ -4,8 +4,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>
>>> >>  / {
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>>> >> index fd3794678c33..f1a4a9ab295b 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>>> >> @@ -4,8 +4,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>
>>> >>  / {
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>> >> index c8303a66438d..f3c9a3534612 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>> >> @@ -5,8 +5,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>
>>> >>  / {
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> >> index 09e71fd60785..4f65eec043d0 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> >> @@ -4,8 +4,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>
>>> >>  / {
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>>> >> index 379c2c8466f5..a06a0b34bd3f 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>>> >> @@ -5,8 +5,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>  #include <dt-bindings/input/gpio-keys.h>
>>> >>  #include <dt-bindings/input/input.h>
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>>> >> index 6eab61a12cd8..0e38cd02a90a 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>>> >> @@ -4,8 +4,6 @@
>>> >>  // Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>  #include <dt-bindings/input/input.h>
>>> >>  #include <dt-bindings/leds/common.h>
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
>>> >> index f5fb1ee32dad..4a49f137885b 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
>>> >> @@ -7,8 +7,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>  #include <dt-bindings/input/input.h>
>>> >>  #include <dt-bindings/pwm/pwm.h>
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
>>> >> index 6d78a1c98f10..4ba5c11e6870 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
>>> >> @@ -4,8 +4,6 @@
>>> >>  //   Copyright (c) 2016 ARM Ltd.
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>
>>> >>  &codec_analog {
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>>> >> index b407e1dd08a7..61ccd90bae01 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>>> >> @@ -5,8 +5,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>  #include <dt-bindings/input/input.h>
>>> >>  #include <dt-bindings/pwm/pwm.h>
>>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> >> index e868ca5ae753..f842e64562b7 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> >> @@ -1,7 +1,10 @@
>>> >>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> >> -// Copyright (C) 2016 ARM Ltd.
>>> >> -// based on the Allwinner H3 dtsi:
>>> >> -//    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
>>> >> +/*
>>> >> + * Copyright (C) 2016 ARM Ltd.
>>> >> + * based on the Allwinner H3 dtsi:
>>> >> + *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
>>> >> + * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
>>> >> + */
>>> >>
>>> >>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
>>> >>  #include <dt-bindings/clock/sun6i-rtc.h>
>>> >> @@ -54,6 +57,7 @@ cpu0: cpu@0 {
>>> >>                         clocks = <&ccu CLK_CPUX>;
>>> >>                         clock-names = "cpu";
>>> >>                         #cooling-cells = <2>;
>>> >> +                       operating-points-v2 = <&cpu_opp_table>;
>>> >>                         i-cache-size = <0x8000>;
>>> >>                         i-cache-line-size = <64>;
>>> >>                         i-cache-sets = <256>;
>>> >> @@ -71,6 +75,7 @@ cpu1: cpu@1 {
>>> >>                         clocks = <&ccu CLK_CPUX>;
>>> >>                         clock-names = "cpu";
>>> >>                         #cooling-cells = <2>;
>>> >> +                       operating-points-v2 = <&cpu_opp_table>;
>>> >>                         i-cache-size = <0x8000>;
>>> >>                         i-cache-line-size = <64>;
>>> >>                         i-cache-sets = <256>;
>>> >> @@ -88,6 +93,7 @@ cpu2: cpu@2 {
>>> >>                         clocks = <&ccu CLK_CPUX>;
>>> >>                         clock-names = "cpu";
>>> >>                         #cooling-cells = <2>;
>>> >> +                       operating-points-v2 = <&cpu_opp_table>;
>>> >>                         i-cache-size = <0x8000>;
>>> >>                         i-cache-line-size = <64>;
>>> >>                         i-cache-sets = <256>;
>>> >> @@ -105,6 +111,7 @@ cpu3: cpu@3 {
>>> >>                         clocks = <&ccu CLK_CPUX>;
>>> >>                         clock-names = "cpu";
>>> >>                         #cooling-cells = <2>;
>>> >> +                       operating-points-v2 = <&cpu_opp_table>;
>>> >>                         i-cache-size = <0x8000>;
>>> >>                         i-cache-line-size = <64>;
>>> >>                         i-cache-sets = <256>;
>>> >> @@ -124,6 +131,59 @@ l2_cache: l2-cache {
>>> >>                 };
>>> >>         };
>>> >>
>>> >> +       cpu_opp_table: opp-table-cpu {
>>> >> +               compatible = "operating-points-v2";
>>> >> +               opp-shared;
>>> >> +
>>> >> +               opp-648000000 {
>>> >> +                       opp-hz = /bits/ 64 <648000000>;
>>> >> +                       opp-microvolt = <1040000>;
>>> >> +                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> +               };
>>> >> +
>>> >> +               opp-816000000 {
>>> >> +                       opp-hz = /bits/ 64 <816000000>;
>>> >> +                       opp-microvolt = <1100000>;
>>> >> +                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> +               };
>>> >> +
>>> >> +               opp-912000000 {
>>> >> +                       opp-hz = /bits/ 64 <912000000>;
>>> >> +                       opp-microvolt = <1120000>;
>>> >> +                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> +               };
>>> >> +
>>> >> +               opp-960000000 {
>>> >> +                       opp-hz = /bits/ 64 <960000000>;
>>> >> +                       opp-microvolt = <1160000>;
>>> >> +                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> +               };
>>> >> +
>>> >> +               opp-1008000000 {
>>> >> +                       opp-hz = /bits/ 64 <1008000000>;
>>> >> +                       opp-microvolt = <1200000>;
>>> >> +                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> +               };
>>> >> +
>>> >> +               opp-1056000000 {
>>> >> +                       opp-hz = /bits/ 64 <1056000000>;
>>> >> +                       opp-microvolt = <1240000>;
>>> >> +                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> +               };
>>> >> +
>>> >> +               opp-1104000000 {
>>> >> +                       opp-hz = /bits/ 64 <1104000000>;
>>> >> +                       opp-microvolt = <1260000>;
>>> >> +                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> +               };
>>> >> +
>>> >> +               opp-1152000000 {
>>> >> +                       opp-hz = /bits/ 64 <1152000000>;
>>> >> +                       opp-microvolt = <1300000>;
>>> >> +                       clock-latency-ns = <244144>; /* 8 32k periods
>>> >> */
>>> >> +               };
>>> >> +       };
>>> >> +
>>> >>         de: display-engine {
>>> >>                 compatible = "allwinner,sun50i-a64-display-engine";
>>> >>                 allwinner,pipelines = <&mixer0>,
>>> >> diff --git
>>> >> a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
>>> >> b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
>>> >> index ce90327e1b2e..19cb74cf1f57 100644
>>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
>>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
>>> >> @@ -4,8 +4,6 @@
>>> >>  /dts-v1/;
>>> >>
>>> >>  #include "sun50i-a64.dtsi"
>>> >> -#include "sun50i-a64-cpu-opp.dtsi"
>>> >> -
>>> >>  #include <dt-bindings/gpio/gpio.h>
>>> >>
>>> >>  / {
>>> 

