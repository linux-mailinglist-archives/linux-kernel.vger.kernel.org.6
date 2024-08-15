Return-Path: <linux-kernel+bounces-288283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F4953854
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B22F1C22245
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841C1B9B4E;
	Thu, 15 Aug 2024 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mZ2l/0cH"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45401B1429;
	Thu, 15 Aug 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739711; cv=none; b=sIaPcEg+k2jcr9n+K6t7jALcFQyJXe70LtY0UxOvQxJc0DmwkYZJFvNv1GAi/3cBg6zrLykdjx+BXLYHdtkMD8SanbZL/IuVRm1dSvsDWbWDoZVl2K/6qAFsH64nte2UHDY/KJraf2PWjmQIt4Jj+q9xs3xQf5SBsOHnag+PmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739711; c=relaxed/simple;
	bh=N9f/bwuQjmLxt54o4T50nSsqV0nfi2NEMYTFGSszbDU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TDvJzpVbW6UItwLuRfRwqZe2ia6+zNbU+f5A92TDbPVGPX6lRU1N2qDoSWbtsNLp6E0kLzAKXgRU3Ky+rTBnE9ZlOM2wN6WFF+Et2AkyRzuaputvnudjs7NGu6YLajvU7CCHdsgxtcPBsr1jhBtkn2e5ru6/VF6XQ/LoOxUXD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mZ2l/0cH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723739699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VN1/j4uqLOPbbGvYolhoMo63BC9SAIydU2eoWe6Om/g=;
	b=mZ2l/0cHER7wOSfCJgOOqVUMT/Pb+JvBNey1+9ZDz8wxrIakJmXZkjnEsJaw55smVR1Cm0
	NvgKGVYB+6LFfDHq+GTQeQYfX3xUAi4nqTY8GIiiwhnBqGQEckF566oYJgeOE5F8DB0wt7
	ufsvvrhdBkVzZEjFvR35GZ7MFLs6n4A20xl/hKQoS6u84Om2sPEbKuXXC3hUM/rFxZhSdE
	VkbtKLDftwdd/4hPkKJKu5C3YrGrqHNXn3G0x4fCbwArpQcOhz3swsoa0h4K28+/3t4xiE
	NcCq12prFOvH032bAdwYMY5S5ZrVSmaJkX68wM0kqF/kehShjoAE71jhBZv/1g==
Date: Thu, 15 Aug 2024 18:34:58 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: wens@csie.org
Cc: linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi
 file
In-Reply-To: <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
 <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
Message-ID: <21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-08-14 18:11, Chen-Yu Tsai wrote:
> On Wed, Aug 14, 2024 at 1:52 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> Move the Allwinner A64 CPU OPPs to the A64 SoC dtsi file and, 
>> consequently,
>> adjust the contents of the affected board dts(i) files appropriately, 
>> to
>> "encapsulate" the CPU OPPs into the SoC dtsi file.
>> 
>> Moving the CPU OPPs to the SoC dtsi file, instead of requiring the 
>> board
>> dts(i) files to include both the SoC dtsi file and the CPU OPP dtsi 
>> file,
>> reduces the possibility for incomplete SoC data inclusion and improves 
>> the
>> overall hierarchical representation of data.  Moreover, the CPU OPPs 
>> are
>> not used anywhere but together with the SoC dtsi file, which 
>> additionally
>> justifies the folding of the CPU OPPs into the SoC dtsi file.
>> 
>> No functional changes are introduced, which was validated by 
>> decompiling and
>> comparing all affected board dtb files before and after these changes. 
>>  When
>> compared with the decompiled original dtb files, the updated dtb files 
>> have
>> some of their blocks shuffled around a bit and some of their phandles 
>> have
>> different values, as a result of the changes to the order in which the
>> building blocks from the parent dtsi files are included into them, but 
>> they
>> still effectively remain the same as the originals.
> 
> IIRC, this was a conscious decision requiring board dts files to set 
> their
> CPU supply before OPPs are given. The bootloader does not boot the SoC
> at the highest possible OPP / regulator voltage, so if the OPPs are 
> given
> but the supply is not, the kernel will attempt to raise the frequency
> beyond what the current voltage can supply, causing it to hang.
> 
> Now that all existing boards have it properly enabled, there should be 
> no
> need for this. However I would appreciate a second opinion.

Good point, thanks for the clarification.  This is quite similar to how
board dts(i) files for Rockchip SoCs need to enable the SoC's built-in
TSADC for temperature sensing, before the CPU thermal throttling can
actually work and prevent the SoC from overheating, etc.

The consensus for Rockchip boards is that it's up to the authors and
reviewers of the board dts(i) files to make sure that the built-in TSADC
is enabled, etc.  With that approach in mind, and knowing that all 
Allwinner
A64 board dts(i) files are in good shape when it comes to the associated
voltage regulators, I think it's fine to follow the same approach of
"encapsulating" the CPU OPPs into the A64 SoC dtsi file.


>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> 
>> Notes:
>>     These changes follow the general approach used for the Rockchip 
>> RK3588
>>     and RK3399 SoCs, which was introduced and described further in 
>> commits
>>     def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC dtsi files 
>> for
>>     per-variant OPPs") [1] and 296602b8e5f7 ("arm64: dts: rockchip: 
>> Move
>>     RK3399 OPPs to dtsi files for SoC variants"), [2] respectively.  
>> Please
>>     see those commits for a more detailed explanation.
>> 
>>     [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=def88eb4d8365a4aa064d28405d03550a9d0a3be
>>     [2] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=296602b8e5f715d6a0ccdcd37d57170c2c81d5e4
>> 
>>  .../allwinner/sun50i-a64-amarula-relic.dts    |  2 -
>>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  2 -
>>  .../dts/allwinner/sun50i-a64-cpu-opp.dtsi     | 75 
>> -------------------
>>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  2 -
>>  .../dts/allwinner/sun50i-a64-olinuxino.dts    |  2 -
>>  .../dts/allwinner/sun50i-a64-orangepi-win.dts |  2 -
>>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  2 -
>>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  2 -
>>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 -
>>  .../boot/dts/allwinner/sun50i-a64-pinetab.dts |  2 -
>>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  2 -
>>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  2 -
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 66 +++++++++++++++-
>>  .../allwinner/sun50i-h64-remix-mini-pc.dts    |  2 -
>>  14 files changed, 63 insertions(+), 102 deletions(-)
>>  delete mode 100644 
>> arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
>> 
>> diff --git 
>> a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>> index 8233582f6288..1590a455683f 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>> @@ -5,8 +5,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>> 
>>  / {
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>> index d1f415acd7b5..869fd4a50582 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>> @@ -4,8 +4,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>> 
>>  / {
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
>> deleted file mode 100644
>> index e39db51eb448..000000000000
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
>> +++ /dev/null
>> @@ -1,75 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -/*
>> - * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
>> - */
>> -
>> -/ {
>> -       cpu0_opp_table: opp-table-cpu {
>> -               compatible = "operating-points-v2";
>> -               opp-shared;
>> -
>> -               opp-648000000 {
>> -                       opp-hz = /bits/ 64 <648000000>;
>> -                       opp-microvolt = <1040000>;
>> -                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> -               };
>> -
>> -               opp-816000000 {
>> -                       opp-hz = /bits/ 64 <816000000>;
>> -                       opp-microvolt = <1100000>;
>> -                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> -               };
>> -
>> -               opp-912000000 {
>> -                       opp-hz = /bits/ 64 <912000000>;
>> -                       opp-microvolt = <1120000>;
>> -                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> -               };
>> -
>> -               opp-960000000 {
>> -                       opp-hz = /bits/ 64 <960000000>;
>> -                       opp-microvolt = <1160000>;
>> -                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> -               };
>> -
>> -               opp-1008000000 {
>> -                       opp-hz = /bits/ 64 <1008000000>;
>> -                       opp-microvolt = <1200000>;
>> -                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> -               };
>> -
>> -               opp-1056000000 {
>> -                       opp-hz = /bits/ 64 <1056000000>;
>> -                       opp-microvolt = <1240000>;
>> -                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> -               };
>> -
>> -               opp-1104000000 {
>> -                       opp-hz = /bits/ 64 <1104000000>;
>> -                       opp-microvolt = <1260000>;
>> -                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> -               };
>> -
>> -               opp-1152000000 {
>> -                       opp-hz = /bits/ 64 <1152000000>;
>> -                       opp-microvolt = <1300000>;
>> -                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> -               };
>> -       };
>> -};
>> -
>> -&cpu0 {
>> -       operating-points-v2 = <&cpu0_opp_table>;
>> -};
>> -
>> -&cpu1 {
>> -       operating-points-v2 = <&cpu0_opp_table>;
>> -};
>> -
>> -&cpu2 {
>> -       operating-points-v2 = <&cpu0_opp_table>;
>> -};
>> -
>> -&cpu3 {
>> -       operating-points-v2 = <&cpu0_opp_table>;
>> -};
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>> index dec9960a7440..e3b1943f7f63 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>> @@ -4,8 +4,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>> 
>>  / {
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> index fd3794678c33..f1a4a9ab295b 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> @@ -4,8 +4,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>> 
>>  / {
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>> index c8303a66438d..f3c9a3534612 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>> @@ -5,8 +5,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>> 
>>  / {
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> index 09e71fd60785..4f65eec043d0 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> @@ -4,8 +4,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>> 
>>  / {
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> index 379c2c8466f5..a06a0b34bd3f 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> @@ -5,8 +5,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/input/gpio-keys.h>
>>  #include <dt-bindings/input/input.h>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> index 6eab61a12cd8..0e38cd02a90a 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> @@ -4,8 +4,6 @@
>>  // Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/leds/common.h>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
>> index f5fb1ee32dad..4a49f137885b 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
>> @@ -7,8 +7,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/pwm/pwm.h>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
>> index 6d78a1c98f10..4ba5c11e6870 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
>> @@ -4,8 +4,6 @@
>>  //   Copyright (c) 2016 ARM Ltd.
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>> 
>>  &codec_analog {
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>> index b407e1dd08a7..61ccd90bae01 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>> @@ -5,8 +5,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/pwm/pwm.h>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index e868ca5ae753..f842e64562b7 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -1,7 +1,10 @@
>>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> -// Copyright (C) 2016 ARM Ltd.
>> -// based on the Allwinner H3 dtsi:
>> -//    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
>> +/*
>> + * Copyright (C) 2016 ARM Ltd.
>> + * based on the Allwinner H3 dtsi:
>> + *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
>> + * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
>> + */
>> 
>>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
>>  #include <dt-bindings/clock/sun6i-rtc.h>
>> @@ -54,6 +57,7 @@ cpu0: cpu@0 {
>>                         clocks = <&ccu CLK_CPUX>;
>>                         clock-names = "cpu";
>>                         #cooling-cells = <2>;
>> +                       operating-points-v2 = <&cpu_opp_table>;
>>                         i-cache-size = <0x8000>;
>>                         i-cache-line-size = <64>;
>>                         i-cache-sets = <256>;
>> @@ -71,6 +75,7 @@ cpu1: cpu@1 {
>>                         clocks = <&ccu CLK_CPUX>;
>>                         clock-names = "cpu";
>>                         #cooling-cells = <2>;
>> +                       operating-points-v2 = <&cpu_opp_table>;
>>                         i-cache-size = <0x8000>;
>>                         i-cache-line-size = <64>;
>>                         i-cache-sets = <256>;
>> @@ -88,6 +93,7 @@ cpu2: cpu@2 {
>>                         clocks = <&ccu CLK_CPUX>;
>>                         clock-names = "cpu";
>>                         #cooling-cells = <2>;
>> +                       operating-points-v2 = <&cpu_opp_table>;
>>                         i-cache-size = <0x8000>;
>>                         i-cache-line-size = <64>;
>>                         i-cache-sets = <256>;
>> @@ -105,6 +111,7 @@ cpu3: cpu@3 {
>>                         clocks = <&ccu CLK_CPUX>;
>>                         clock-names = "cpu";
>>                         #cooling-cells = <2>;
>> +                       operating-points-v2 = <&cpu_opp_table>;
>>                         i-cache-size = <0x8000>;
>>                         i-cache-line-size = <64>;
>>                         i-cache-sets = <256>;
>> @@ -124,6 +131,59 @@ l2_cache: l2-cache {
>>                 };
>>         };
>> 
>> +       cpu_opp_table: opp-table-cpu {
>> +               compatible = "operating-points-v2";
>> +               opp-shared;
>> +
>> +               opp-648000000 {
>> +                       opp-hz = /bits/ 64 <648000000>;
>> +                       opp-microvolt = <1040000>;
>> +                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> +               };
>> +
>> +               opp-816000000 {
>> +                       opp-hz = /bits/ 64 <816000000>;
>> +                       opp-microvolt = <1100000>;
>> +                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> +               };
>> +
>> +               opp-912000000 {
>> +                       opp-hz = /bits/ 64 <912000000>;
>> +                       opp-microvolt = <1120000>;
>> +                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> +               };
>> +
>> +               opp-960000000 {
>> +                       opp-hz = /bits/ 64 <960000000>;
>> +                       opp-microvolt = <1160000>;
>> +                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> +               };
>> +
>> +               opp-1008000000 {
>> +                       opp-hz = /bits/ 64 <1008000000>;
>> +                       opp-microvolt = <1200000>;
>> +                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> +               };
>> +
>> +               opp-1056000000 {
>> +                       opp-hz = /bits/ 64 <1056000000>;
>> +                       opp-microvolt = <1240000>;
>> +                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> +               };
>> +
>> +               opp-1104000000 {
>> +                       opp-hz = /bits/ 64 <1104000000>;
>> +                       opp-microvolt = <1260000>;
>> +                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> +               };
>> +
>> +               opp-1152000000 {
>> +                       opp-hz = /bits/ 64 <1152000000>;
>> +                       opp-microvolt = <1300000>;
>> +                       clock-latency-ns = <244144>; /* 8 32k periods 
>> */
>> +               };
>> +       };
>> +
>>         de: display-engine {
>>                 compatible = "allwinner,sun50i-a64-display-engine";
>>                 allwinner,pipelines = <&mixer0>,
>> diff --git 
>> a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
>> index ce90327e1b2e..19cb74cf1f57 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
>> @@ -4,8 +4,6 @@
>>  /dts-v1/;
>> 
>>  #include "sun50i-a64.dtsi"
>> -#include "sun50i-a64-cpu-opp.dtsi"
>> -
>>  #include <dt-bindings/gpio/gpio.h>
>> 
>>  / {

