Return-Path: <linux-kernel+bounces-286832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E19951F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CE0B20EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2B1B8EA5;
	Wed, 14 Aug 2024 16:11:31 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4511B583E;
	Wed, 14 Aug 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651890; cv=none; b=anSpAT55s/bkzwE6u8Pi2OumtZgOAyCbgMBpqunEg2owmNuPiPtOkUXt+2zJzvGBOv4e/qoAjKliAyLpquLI/WCuBgpGo5Yha5+9EK68wy7fFMpa16Xl0Z8jDMLkkJzdHNk8IyXaCrQKbcDJfz61tATIQYDcTGmc1oF7msQHff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651890; c=relaxed/simple;
	bh=Gk1OosMsUss4iWnFoDW5IsjmXZP2In+eGnGiTeGrzG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXAjOlQMHGVJfCnIPP5HvmugRzKvZnW4f8PMZCV/yadKG6/O0ZpiXzDevElgGZvDzgbvqpRNCn80D3GoW/RkNjOZeZPK+I8X6g5J+0nkA2nKt5flI4CJ7+VN6nBc6m045JAj9UOf87sKMoH+kPlvlqnlCVekK3qMtPvStPOiwE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so741811fa.3;
        Wed, 14 Aug 2024 09:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651885; x=1724256685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJL7VPhigo0b+evrEyM1rv9vsb52qtp5Wx/zKyZ/nKM=;
        b=WUpFkUznBNHVDIbUs3Lvb5jF0RN6CsoFrRjTz9QehiLxlJ6tD+XsfvKgZDxzmGAMJ7
         ZhDRUYRO0aBixqy84qXxV7fY1NEzzmcH40KhjbX2Ijh8Az6pzMkc3+jXuqq86rH0ytCO
         kaYvTZfiyT7bT3/AeM2cSXsQqudvgU70tQpLhCvqBKp15qMJ5iRw84guSG9wcnPqpBvD
         9HDLLfm9fBfKZvvgVYttHd+CjP8nESH6bB3nzBt0AAHxvlmj24q6/s3vPVTZF68CaQmv
         0Gl6d3ncIAVPKC6RoFWJB8RlagVcz+57ekcprVuVOgSfpp2rdZOEDoK1PysdE+dSfh09
         3bBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCuS34Ins4WKMl+lsfeYymE6S8E+sJsjUGX0FK1I5Zbyisq/HY3f4cZIbnymboN6XoSFG8/Np8vK3QvU669mA5UUi4yOUkBoWSoDao6npDTXDKMwO0y9SwC57BQDkTrv0+yv0tE8Bnzg==
X-Gm-Message-State: AOJu0YyaBt9AXqohdjMlWjP78IRBbhTJxEUzgVerxK5T8zdt8c2FFNoE
	IkXULSdTxzFtV65ZFvupDDJxJI38y4kt2Vw66YYvMLrzFPo03BlFYnYjxEMH
X-Google-Smtp-Source: AGHT+IGqWhBXxp63KCTvrdmUcQLfZR3LYuCyNs2mhM4oghBhxm+dz1yxDVY8xkKBh1NiNUVgNtOG2g==
X-Received: by 2002:a2e:b537:0:b0:2ef:22e5:b96b with SMTP id 38308e7fff4ca-2f3aa1c87d9mr20602951fa.19.1723651884373;
        Wed, 14 Aug 2024 09:11:24 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f29206895dsm14441491fa.132.2024.08.14.09.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:11:24 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f16767830dso855131fa.0;
        Wed, 14 Aug 2024 09:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFC4FPiGOtV66OcTzCbTHGBv/sMaVvgmvqwVjXdrTw11bTUqjH62p32l5c7ycv0c/WuxB5qixagiUsG5OM/j7SgV2h1hwd9/SFMDOJSZYiAIertbbaw6S1xyHFwhVW3vl4qII4wXp26w==
X-Received: by 2002:a2e:9f05:0:b0:2ec:500c:b2e0 with SMTP id
 38308e7fff4ca-2f3aa1c875amr19854291fa.22.1723651883658; Wed, 14 Aug 2024
 09:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
In-Reply-To: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 15 Aug 2024 00:11:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
Message-ID: <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi file
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 1:52=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Move the Allwinner A64 CPU OPPs to the A64 SoC dtsi file and, consequentl=
y,
> adjust the contents of the affected board dts(i) files appropriately, to
> "encapsulate" the CPU OPPs into the SoC dtsi file.
>
> Moving the CPU OPPs to the SoC dtsi file, instead of requiring the board
> dts(i) files to include both the SoC dtsi file and the CPU OPP dtsi file,
> reduces the possibility for incomplete SoC data inclusion and improves th=
e
> overall hierarchical representation of data.  Moreover, the CPU OPPs are
> not used anywhere but together with the SoC dtsi file, which additionally
> justifies the folding of the CPU OPPs into the SoC dtsi file.
>
> No functional changes are introduced, which was validated by decompiling =
and
> comparing all affected board dtb files before and after these changes.  W=
hen
> compared with the decompiled original dtb files, the updated dtb files ha=
ve
> some of their blocks shuffled around a bit and some of their phandles hav=
e
> different values, as a result of the changes to the order in which the
> building blocks from the parent dtsi files are included into them, but th=
ey
> still effectively remain the same as the originals.

IIRC, this was a conscious decision requiring board dts files to set their
CPU supply before OPPs are given. The bootloader does not boot the SoC
at the highest possible OPP / regulator voltage, so if the OPPs are given
but the supply is not, the kernel will attempt to raise the frequency
beyond what the current voltage can supply, causing it to hang.

Now that all existing boards have it properly enabled, there should be no
need for this. However I would appreciate a second opinion.


ChenYu


> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>
> Notes:
>     These changes follow the general approach used for the Rockchip RK358=
8
>     and RK3399 SoCs, which was introduced and described further in commit=
s
>     def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC dtsi files fo=
r
>     per-variant OPPs") [1] and 296602b8e5f7 ("arm64: dts: rockchip: Move
>     RK3399 OPPs to dtsi files for SoC variants"), [2] respectively.  Plea=
se
>     see those commits for a more detailed explanation.
>
>     [1] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockc=
hip.git/commit/?h=3Dfor-next&id=3Ddef88eb4d8365a4aa064d28405d03550a9d0a3be
>     [2] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockc=
hip.git/commit/?h=3Dfor-next&id=3D296602b8e5f715d6a0ccdcd37d57170c2c81d5e4
>
>  .../allwinner/sun50i-a64-amarula-relic.dts    |  2 -
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  2 -
>  .../dts/allwinner/sun50i-a64-cpu-opp.dtsi     | 75 -------------------
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  2 -
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    |  2 -
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts |  2 -
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  2 -
>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  2 -
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 -
>  .../boot/dts/allwinner/sun50i-a64-pinetab.dts |  2 -
>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  2 -
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  2 -
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 66 +++++++++++++++-
>  .../allwinner/sun50i-h64-remix-mini-pc.dts    |  2 -
>  14 files changed, 63 insertions(+), 102 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index 8233582f6288..1590a455683f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -5,8 +5,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index d1f415acd7b5..869fd4a50582 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -4,8 +4,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
> deleted file mode 100644
> index e39db51eb448..000000000000
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
> - */
> -
> -/ {
> -       cpu0_opp_table: opp-table-cpu {
> -               compatible =3D "operating-points-v2";
> -               opp-shared;
> -
> -               opp-648000000 {
> -                       opp-hz =3D /bits/ 64 <648000000>;
> -                       opp-microvolt =3D <1040000>;
> -                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -               };
> -
> -               opp-816000000 {
> -                       opp-hz =3D /bits/ 64 <816000000>;
> -                       opp-microvolt =3D <1100000>;
> -                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -               };
> -
> -               opp-912000000 {
> -                       opp-hz =3D /bits/ 64 <912000000>;
> -                       opp-microvolt =3D <1120000>;
> -                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -               };
> -
> -               opp-960000000 {
> -                       opp-hz =3D /bits/ 64 <960000000>;
> -                       opp-microvolt =3D <1160000>;
> -                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -               };
> -
> -               opp-1008000000 {
> -                       opp-hz =3D /bits/ 64 <1008000000>;
> -                       opp-microvolt =3D <1200000>;
> -                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -               };
> -
> -               opp-1056000000 {
> -                       opp-hz =3D /bits/ 64 <1056000000>;
> -                       opp-microvolt =3D <1240000>;
> -                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -               };
> -
> -               opp-1104000000 {
> -                       opp-hz =3D /bits/ 64 <1104000000>;
> -                       opp-microvolt =3D <1260000>;
> -                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -               };
> -
> -               opp-1152000000 {
> -                       opp-hz =3D /bits/ 64 <1152000000>;
> -                       opp-microvolt =3D <1300000>;
> -                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -               };
> -       };
> -};
> -
> -&cpu0 {
> -       operating-points-v2 =3D <&cpu0_opp_table>;
> -};
> -
> -&cpu1 {
> -       operating-points-v2 =3D <&cpu0_opp_table>;
> -};
> -
> -&cpu2 {
> -       operating-points-v2 =3D <&cpu0_opp_table>;
> -};
> -
> -&cpu3 {
> -       operating-points-v2 =3D <&cpu0_opp_table>;
> -};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> index dec9960a7440..e3b1943f7f63 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> @@ -4,8 +4,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arc=
h/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> index fd3794678c33..f1a4a9ab295b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -4,8 +4,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index c8303a66438d..f3c9a3534612 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -5,8 +5,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/a=
rm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 09e71fd60785..4f65eec043d0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -4,8 +4,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch=
/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 379c2c8466f5..a06a0b34bd3f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -5,8 +5,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/gpio-keys.h>
>  #include <dt-bindings/input/input.h>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 6eab61a12cd8..0e38cd02a90a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -4,8 +4,6 @@
>  // Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/leds/common.h>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> index f5fb1ee32dad..4a49f137885b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> @@ -7,8 +7,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/pwm/pwm.h>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/=
arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> index 6d78a1c98f10..4ba5c11e6870 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> @@ -4,8 +4,6 @@
>  //   Copyright (c) 2016 ARM Ltd.
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>
>  &codec_analog {
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> index b407e1dd08a7..61ccd90bae01 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -5,8 +5,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/pwm/pwm.h>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index e868ca5ae753..f842e64562b7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -1,7 +1,10 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -// Copyright (C) 2016 ARM Ltd.
> -// based on the Allwinner H3 dtsi:
> -//    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
> +/*
> + * Copyright (C) 2016 ARM Ltd.
> + * based on the Allwinner H3 dtsi:
> + *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
> + * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
> + */
>
>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
>  #include <dt-bindings/clock/sun6i-rtc.h>
> @@ -54,6 +57,7 @@ cpu0: cpu@0 {
>                         clocks =3D <&ccu CLK_CPUX>;
>                         clock-names =3D "cpu";
>                         #cooling-cells =3D <2>;
> +                       operating-points-v2 =3D <&cpu_opp_table>;
>                         i-cache-size =3D <0x8000>;
>                         i-cache-line-size =3D <64>;
>                         i-cache-sets =3D <256>;
> @@ -71,6 +75,7 @@ cpu1: cpu@1 {
>                         clocks =3D <&ccu CLK_CPUX>;
>                         clock-names =3D "cpu";
>                         #cooling-cells =3D <2>;
> +                       operating-points-v2 =3D <&cpu_opp_table>;
>                         i-cache-size =3D <0x8000>;
>                         i-cache-line-size =3D <64>;
>                         i-cache-sets =3D <256>;
> @@ -88,6 +93,7 @@ cpu2: cpu@2 {
>                         clocks =3D <&ccu CLK_CPUX>;
>                         clock-names =3D "cpu";
>                         #cooling-cells =3D <2>;
> +                       operating-points-v2 =3D <&cpu_opp_table>;
>                         i-cache-size =3D <0x8000>;
>                         i-cache-line-size =3D <64>;
>                         i-cache-sets =3D <256>;
> @@ -105,6 +111,7 @@ cpu3: cpu@3 {
>                         clocks =3D <&ccu CLK_CPUX>;
>                         clock-names =3D "cpu";
>                         #cooling-cells =3D <2>;
> +                       operating-points-v2 =3D <&cpu_opp_table>;
>                         i-cache-size =3D <0x8000>;
>                         i-cache-line-size =3D <64>;
>                         i-cache-sets =3D <256>;
> @@ -124,6 +131,59 @@ l2_cache: l2-cache {
>                 };
>         };
>
> +       cpu_opp_table: opp-table-cpu {
> +               compatible =3D "operating-points-v2";
> +               opp-shared;
> +
> +               opp-648000000 {
> +                       opp-hz =3D /bits/ 64 <648000000>;
> +                       opp-microvolt =3D <1040000>;
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +               };
> +
> +               opp-816000000 {
> +                       opp-hz =3D /bits/ 64 <816000000>;
> +                       opp-microvolt =3D <1100000>;
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +               };
> +
> +               opp-912000000 {
> +                       opp-hz =3D /bits/ 64 <912000000>;
> +                       opp-microvolt =3D <1120000>;
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +               };
> +
> +               opp-960000000 {
> +                       opp-hz =3D /bits/ 64 <960000000>;
> +                       opp-microvolt =3D <1160000>;
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +               };
> +
> +               opp-1008000000 {
> +                       opp-hz =3D /bits/ 64 <1008000000>;
> +                       opp-microvolt =3D <1200000>;
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +               };
> +
> +               opp-1056000000 {
> +                       opp-hz =3D /bits/ 64 <1056000000>;
> +                       opp-microvolt =3D <1240000>;
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +               };
> +
> +               opp-1104000000 {
> +                       opp-hz =3D /bits/ 64 <1104000000>;
> +                       opp-microvolt =3D <1260000>;
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +               };
> +
> +               opp-1152000000 {
> +                       opp-hz =3D /bits/ 64 <1152000000>;
> +                       opp-microvolt =3D <1300000>;
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +               };
> +       };
> +
>         de: display-engine {
>                 compatible =3D "allwinner,sun50i-a64-display-engine";
>                 allwinner,pipelines =3D <&mixer0>,
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> index ce90327e1b2e..19cb74cf1f57 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> @@ -4,8 +4,6 @@
>  /dts-v1/;
>
>  #include "sun50i-a64.dtsi"
> -#include "sun50i-a64-cpu-opp.dtsi"
> -
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {

