Return-Path: <linux-kernel+bounces-192695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FF8D20D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAC91C23601
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0400D171675;
	Tue, 28 May 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b="s1s48i0o"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0617167F;
	Tue, 28 May 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911566; cv=none; b=r8LDQwcD/gaYoLQ3ZVby9X2naccbwIv/JT0KkivIi0Xu7HWzNZ/xBvz+j8WFKlnR/la5x6Kwa49//C6y9L2BMe//xfbBTusneTh+s62mYcfNmjT2dvXkukow9PRmI0qt2Nv2h1Hx6GL06LrxJmc52OlxGn2uJq1xvPJ61QN7wgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911566; c=relaxed/simple;
	bh=zVL8rA7YugRIzcWTsqiDl3ZfDWX1aUtgkVP+Qi05VrE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tuxotvZ+r1bCFZSQ2WhXpKfRn0k7Z+B8hksz/wP/V5pml35NWE8sb4AP9ufstVS4X5FBjKIME09JaHm5h1khEWtD+I4ZXeq0HZN3QXsTabUEt/aam00CPnzxbeuIP9X1VKoYDQtfLOUzmLe7VNkjoe1SBFI72bBiENc4YPnxlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b=s1s48i0o; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716911526; x=1717516326; i=seb-dev@web.de;
	bh=UMkkYPs47/uTEUs8ecFzsdF74RnuWBCQH1eMZJaGv+c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s1s48i0ohxRydy+ffJji57Q95fA0mVU7D3Up0u4nB5XdoHr+2befBFbTGKksPUJN
	 Ak0riwEBjZtnaxMmSeZi0RL/wmnwKWaFFhZ9TKbldVbZDcc7q8KrVoF6HGrdPYjS1
	 Nb3fPpizRSODNamxaSMnoDhyf4QrUyDqPO5a40DCe4DEHgB0lm/SWdVSyc4GrkxP7
	 j+5TZF8te7YVKkvhcPr+NFv0/TUAkrn9NKa718kD4BxN7vUJhQl5Jjoo66sjBFtfQ
	 hyQYhDpIIY48ToU+3mmFePpfP2ktxW5WHWilhYDkxiWRywVyHlxiXiikczU040Ibt
	 pWAM5W0obuncS4Vz0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.24] ([84.155.184.248]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1sWLRr02zd-015TT2; Tue, 28
 May 2024 17:52:06 +0200
Message-ID: <d4a1d23b-e98b-4538-b2a6-4877da07da57@web.de>
Date: Tue, 28 May 2024 17:52:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sebastian Kropatsch <seb-dev@web.de>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add CM3588 NAS board
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UCcfYVtanpMp3J7FvurGpiQ3b2qBN/T4z1Hyh2lfpZ7MsRBJeUM
 /ipbT5UnE3k6x5DnBu4UCsvyoZjP5JV0pRRVCnmtAeHjonofy3pkZYnuHkKlZCWrdQAW1Eh
 5+nqgyq79BYFMkkTpcxCHXxS9p6AuFLTRxymflTAHWflw+f6mGvik+RjW9p1JOlIfK/KNCy
 gF3D2MHlZNe2X6sVuep6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q7mAapJYyGc=;/FCqlCj5xR/7vJpVpC+mR8UPE3I
 UYZsS8/Tnf/4BVTCKTluHE13EPAD29MZO40yvMvRuKvIwDUa/foFa4EYtkSa7Xm6MkwZpDA92
 kbUxTKfSxDr2Wnd5o2DMMUsja6PYnLDoMMYa7RGW75U34HSrqSkScVLybkh1wlIKM9dnKNW/4
 0CyJfdeTcqKrhOOUp/5x483HiJvK64DhC0bb7G+UftFj6z6Yu90YwULdtJua61eD5BxpuCSrV
 tP1Z4ncWi8cOMmydjbCZHPilJJ85lVYgr2hHVts5NWmwKRAIIQ4W6354EN7OmXGAsC6IHFBTP
 NRl8sDDSoJBFuYRP0scKNuVY3gRTwIxIVgy2XiSd5xfPd92+cLKb0+1E2NWEFXTdLnurPQXUL
 2vd05aNRId54CAxP/bouLIzd6zcNUJnNFpx6Vd97Bl5Y1uQm+ijZbxZc2PcvFOdhi4n5U6PuZ
 H9bKaxlk4SaJk6TjKnST1F2baPsglO+6B4l6U2DjnDQhGI4dPaY02BOXvHfTlxJO45ncusUwR
 rvSD5xxRbLTfWa62Evg3TXZF+cIr9wBcQxoOsevdvPc4nsRzhXbY312WBP8cVQ0zcev2G7BDQ
 zik7C4KwesZVP+Lhv89denLZCT8BwHB/AINwe77ccVJXafIUB0pcNxfZrUMGydaQV9IBL18NA
 gD8vnE7ve+uM1RulwTuqSJ+ZqOJj6mZHiJPELQ/iCHw1MndWo0nEzKQx9I5I1MkO90yPsBsg2
 cSQibRJk6PlTJN6L9TtC/iXqPmNt0p+CFiML92v/FcqHtloz9Rg5Rzk/QuhU6Xot70uaLDSH4
 pw5+D5Nth0bhl6z8So6DIPaCLbd/W7FHhE7j4sRM1eSLM=

Hi Jonas,

thanks for your feedback!

Am 27.05.2024 um 21:02 schrieb Jonas Karlman:
> Hi Sebastian,
>
> On 2024-05-26 23:48, Sebastian Kropatsch wrote:
>> The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based o=
n
>> the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
>>
>> Hardware features:
>>      - Rockchip RK3588 SoC
>>      - 4GB/8GB/16GB LPDDR4x RAM
>>      - 64GB eMMC
>>      - MicroSD card slot
>>      - 1x RTL8125B 2.5G Ethernet
>>      - 4x M.2 M-Key with PCIe 3.0 x1 (via bifurcation) for NVMe SSDs
>>      - 2x USB 3.0 (USB 3.1 Gen1) Type-A, 1x USB 2.0 Type-A
>>      - 1x USB 3.0 Type-C with DP AltMode support
>>      - 2x HDMI 2.1 out, 1x HDMI in
>>      - MIPI-CSI Connector, MIPI-DSI Connector
>>      - 40-pin GPIO header
>>      - 4 buttons: power, reset, recovery, MASK, user button
>>      - 3.5mm Headphone out, 2.0mm PH-2A Mic in
>>      - 5V Fan connector, PWM buzzer, IR receiver, RTC battery connector
>>
>> PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 x1
>> speed. Data lane mapping in the DT is done like described in commit
>> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588").
>>
>> This device tree includes support for eMMC, SD card, ethernet, all USB2
>> and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging as
>> well as the buttons and LEDs.
>> The GPIOs are labeled according to the schematics.
>>
>> Signed-off-by: Sebastian Kropatsch <seb-dev@web.de>
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>>   .../boot/dts/rockchip/rk3588-cm3588-nas.dts   | 1269 ++++++++++++++++=
+
>>   2 files changed, 1270 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
>
> Because the CM3588 is a SoM and the NAS is a carrier board this should
> probably be split in two, cm3588.dtsi and cm3588-nas.dts.
>

I thought about this before submitting. My reason for not splitting this
into two files for now was that as far as I know this board is the only
combination for the CM, maybe no other daughter board will ever get
released. If another carrier board compatible with the CM3588 is
released, the splitting could be done at that point in time.

But since both you and Heiko prefer to have it split, I will figure out
a way how and which parts will have to split up to the CM so we can
have two files in the end. I guess most things will go into the NAS dts
anyway.
I'll have a look how other Rockchip compute modules with split device
trees were done in the past and orient myself by that.

>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
>> index c544ff507d20..f1ff58bdf2cd 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -114,6 +114,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-=
pf5.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-display-vz.dtb=
o
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-io-expander.dt=
bo
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-armsom-sige7.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-cm3588-nas.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-coolpi-cm5-evb.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a-io.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a-wifi.dtbo
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts b/arch/=
arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
>> new file mode 100644
>> index 000000000000..6c45b376d001
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
>> @@ -0,0 +1,1269 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
>> + * Copyright (c) 2023 FriendlyElec Computer Tech. Co., Ltd.
>> + * Copyright (c) 2023 Thomas McKahan
>> + * Copyright (c) 2024 Sebastian Kropatsch
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,vop2.h>
>> +#include <dt-bindings/usb/pd.h>
>> +#include "rk3588.dtsi"
>> +
>> +/ {
>> +	model =3D "FriendlyElec CM3588 NAS";
>> +	compatible =3D "friendlyarm,cm3588-nas", "rockchip,rk3588";
>
> Maybe this should be something like:
>
>    "friendlyarm,cm3588-nas", "friendlyarm,cm3588", "rockchip,rk3588";
>
>> +
>> +	aliases {
>> +		mmc0 =3D &sdhci;
>> +		mmc1 =3D &sdmmc;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path =3D "serial2:1500000n8";
>> +	};
>> +
>> +	adc_keys: adc-keys {
>> +		compatible =3D "adc-keys";
>> +		io-channels =3D <&saradc 1>;
>> +		io-channel-names =3D "buttons";
>> +		keyup-threshold-microvolt =3D <1800000>;
>> +		poll-interval =3D <100>;
>> +
>> +		button-vol-up {
>> +			label =3D "Volume Up";
>> +			linux,code =3D <KEY_VOLUMEUP>;
>> +			press-threshold-microvolt =3D <17000>;
>> +		};
>> +	};
>> +
>> +	analog-sound {
>> +		compatible =3D "simple-audio-card";
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&headphone_detect>;
>> +
>> +		simple-audio-card,name =3D "realtek,rt5616-codec";
>> +		simple-audio-card,format =3D "i2s";
>> +		simple-audio-card,mclk-fs =3D <256>;
>> +
>> +		simple-audio-card,hp-det-gpio =3D <&gpio1 RK_PC4 GPIO_ACTIVE_LOW>;
>> +
>> +		simple-audio-card,routing =3D
>> +			"Headphones", "HPOL",
>> +			"Headphones", "HPOR",
>> +			"MIC1", "Microphone Jack",
>> +			"Microphone Jack", "micbias1";
>> +		simple-audio-card,widgets =3D
>> +			"Headphone", "Headphones",
>> +			"Microphone", "Microphone Jack";
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai =3D <&i2s0_8ch>;
>> +		};
>> +
>> +		simple-audio-card,codec {
>> +			sound-dai =3D <&rt5616>;
>> +		};
>> +	};
>> +
>> +	fan: pwm-fan {
>> +		compatible =3D "pwm-fan";
>> +		#cooling-cells =3D <2>;
>> +		cooling-levels =3D <0 50 80 120 160 220>;
>> +		fan-supply =3D <&vcc_5v0_sys>;
>> +		pwms =3D <&pwm1 0 50000 0>;
>> +	};
>> +
>> +	gpio_keys: gpio-keys {
>> +		compatible =3D "gpio-keys";
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&key1_pin>;
>> +
>> +		button-user {
>> +			debounce-interval =3D <50>;
>> +			gpios =3D <&gpio0 RK_PD5 GPIO_ACTIVE_LOW>;
>> +			label =3D "User Button";
>> +			linux,code =3D <BTN_1>;
>> +			wakeup-source;
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible =3D "gpio-leds";
>> +
>> +		led_sys: led-0 {
>> +			gpios =3D <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>;
>> +			label =3D "system-led";
>> +			linux,default-trigger =3D "heartbeat";
>> +			pinctrl-names =3D "default";
>> +			pinctrl-0 =3D <&led_sys_pin>;
>> +		};
>> +
>> +		led_usr: led-1 {
>> +			gpios =3D <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
>> +			label =3D "user-led";
>> +			pinctrl-names =3D "default";
>> +			pinctrl-0 =3D <&led_usr_pin>;
>> +		};
>> +	};
>> +
>> +	vcc_12v_dcin: vcc-12v-dcin-regulator {
>
> Fixed regulators should use the recommended nodename, i.e. a regulator-
> prefix.
>

Almost every Rockchip device tree that I checked is using a *-regulator
naming scheme instead of regulator-* , so I tried to blend it in.
But thanks for making me aware of the preferred naming scheme.

For anyone wondering, a very recent commit from 29/04/2024 b6d4b3500d57
("regulator: dt-bindings: fixed-regulator: Add a preferred node name"
[1]) defined "regulator-[0-9]v[0-9]" as the preferred node name for
fixed regulators.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?id=3Db6d=
4b3500d57370f5b3abf0701c9166b384db976

>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vcc_12v_dcin";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <12000000>;
>> +		regulator-max-microvolt =3D <12000000>;
>> +	};
>> +
>> +	/* vcc_5v0_sys powers the peripherals */
>> +	vcc_5v0_sys: vcc-5v0-sys-regulator {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vcc_5v0_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <5000000>;
>> +		regulator-max-microvolt =3D <5000000>;
>> +		vin-supply =3D <&vcc_12v_dcin>;
>> +	};
>> +
>> +	vcc_5v0_host_20: vcc-5v0-host-20 {
>> +		compatible =3D "regulator-fixed";
>> +		enable-active-high;
>> +		gpio =3D <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&vcc_5v0_host20_en>;
>> +		regulator-name =3D "vcc_5v0_host_20";
>> +		regulator-min-microvolt =3D <5000000>;
>> +		regulator-max-microvolt =3D <5000000>;
>> +		vin-supply =3D <&vcc_5v0_sys>;
>> +	};
>> +
>> +	vcc_5v0_host_30: vcc-5v0-host-30 {
>> +		compatible =3D "regulator-fixed";
>> +		enable-active-high;
>> +		gpio =3D <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
>
> Use the recommended gpios prop.

Also here, thanks for making me aware that 'gpios' is preferred
over 'gpio'. Can you point me to where the difference between these
two is documented and that 'gpios' is recommended?
I only found the information in the message of commit 12df2c182ccb
("regulator: dt-bindings: fixed-regulator: allow gpios property" [2]).
Dt-bindings 'fixed-regulator.yaml' doesn't have much info on this.

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?id=3D12d=
f2c182ccb850988d2680a422211a812fb5cb2

>
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&vcc_5v0_host30_en>;
>> +		regulator-name =3D "vcc_5v0_host_30";
>> +		regulator-min-microvolt =3D <5000000>;
>> +		regulator-max-microvolt =3D <5000000>;
>> +		vin-supply =3D <&vcc_5v0_sys>;
>> +	};
>> +
>> +	vcc_3v3_host_32: vcc-3v3-host-32-regulator {
>> +		compatible =3D "regulator-fixed";
>> +		enable-active-high;
>> +		gpios =3D <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&vcc_3v3_host32_en>;
>> +		regulator-name =3D "vcc_3v3_host_32";
>> +		regulator-min-microvolt =3D <3300000>;
>> +		regulator-max-microvolt =3D <3300000>;
>> +		vin-supply =3D <&vcc_5v0_sys>;
>> +	};
>> +
>> +	vbus_5v0_typec: vbus-5v0-typec-regulator {
>> +		compatible =3D "regulator-fixed";
>> +		enable-active-high;
>> +		gpio =3D <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
>
> Same, use the recommended gpios prop.
>
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&typec_5v_pwr_en>;
>> +		regulator-name =3D "vbus_5v0_typec";
>> +		regulator-min-microvolt =3D <5000000>;
>> +		regulator-max-microvolt =3D <5000000>;
>> +		vin-supply =3D <&vcc_5v0_sys>;
>> +	};
>> +
>> +	/* vcc_4v0_sys powers the RK806, RK860's */
>> +	vcc_4v0_sys: vcc-4v0-sys-regulator {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vcc_4v0_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <4000000>;
>> +		regulator-max-microvolt =3D <4000000>;
>> +		vin-supply =3D <&vcc_12v_dcin>;
>> +	};
>> +
>> +	vcc_3v3_pcie20: vcc-3v3-pcie20-regulator {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vcc_3v3_pcie20";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <3300000>;
>> +		regulator-max-microvolt =3D <3300000>;
>> +		vin-supply =3D <&vcc_3v3_s3>;
>> +	};
>> +
>> +	vcc_3v3_pcie30: vcc-3v3-pcie30-regulator {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vcc_3v3_pcie30";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <3300000>;
>> +		regulator-max-microvolt =3D <3300000>;
>> +		vin-supply =3D <&vcc_5v0_sys>;
>> +	};
>> +
>> +	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
>> +		compatible =3D "regulator-fixed";
>> +		gpio =3D <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&sd_s0_pwr>;
>> +		regulator-boot-on;
>> +		regulator-max-microvolt =3D <3300000>;
>> +		regulator-min-microvolt =3D <3300000>;
>> +		regulator-name =3D "vcc_3v3_sd_s0";
>> +		vin-supply =3D <&vcc_3v3_s3>;
>> +	};
>> +
>> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vcc-1v1-nldo-s3";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <1100000>;
>> +		regulator-max-microvolt =3D <1100000>;
>> +		vin-supply =3D <&vcc_4v0_sys>;
>> +	};
>> +};
>> +
>> +&combphy0_ps {
>> +	status =3D "okay";
>> +};
>> +
>> +&combphy1_ps {
>> +	status =3D "okay";
>> +};
>> +
>> +&combphy2_psu {
>> +	status =3D "okay";
>> +};
>> +
>> +&cpu_l0 {
>> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
>> +};
>> +
>> +&cpu_l1 {
>> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
>> +};
>> +
>> +&cpu_l2 {
>> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
>> +};
>> +
>> +&cpu_l3 {
>> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
>> +};
>> +
>> +&cpu_b0 {
>> +	cpu-supply =3D <&vdd_cpu_big0_s0>;
>> +};
>> +
>> +&cpu_b1 {
>> +	cpu-supply =3D <&vdd_cpu_big0_s0>;
>> +};
>> +
>> +&cpu_b2 {
>> +	cpu-supply =3D <&vdd_cpu_big1_s0>;
>> +};
>> +
>> +&cpu_b3 {
>> +	cpu-supply =3D <&vdd_cpu_big1_s0>;
>> +};
>> +
>> +/* GPIO names are in the format "Human-readable-name [SIGNAL_LABEL]" *=
/
>> +/* Signal labels match the official CM3588 NAS schematic revision 2309=
 */
>> +&gpio0 {
>> +	gpio-line-names =3D
>> +		/* GPIO0 A0-A7 */
>> +		"", "", "", "",
>> +		"MicroSD detect [SDMMC_DET_L]", "", "", "",
>> +		/* GPIO0 B0-B7 */
>> +		"", "", "", "",
>> +		"", "", "", "",
>> +		/* GPIO0 C0-C7 */
>> +		"", "", "", "",
>> +		"Pin 10 [UART0_RX_M0]", "Pin 08 [UART0_TX_M0/PWM4_M0]", "Pin 32 [PWM=
5_M1]", "",
>> +		/* GPIO0 D0-D7 */
>> +		"", "", "", "USB3 Type-C [CC_INT_L]",
>> +		"IR sensor [PWM3_IR_M0]", "User Button", "", "";
>> +};
>> +
>> +&gpio1 {
>> +	gpio-line-names =3D
>> +		/* GPIO1 A0-A7 */
>> +		"Pin 27 [UART6_RX_M1]", "Pin 28 [UART6_TX_M1]", "", "",
>> +		"USB2 Type-A [USB2_PWREN]", "", "", "Pin 15",
>> +		/* GPIO1 B0-B7 */
>> +		"Pin 26", "Pin 21 [SPI0_MISO_M2]", "Pin 19 [SPI0_MOSI_M2/UART4_RX_M2=
]", "Pin 23 [SPI0_CLK_M2/UART4_TX_M2]",
>> +		"Pin 24 [SPI0_CS0_M2/UART7_RX_M2]", "Pin 22 [SPI0_CS1_M0/UART7_TX_M2=
]", "", "CSI-Pin 14 [MIPI_CAM2_CLKOUT]",
>> +		/* GPIO1 C0-C7 */
>> +		"", "", "", "",
>> +		"Headphone detect [HP_DET_L]", "", "", "",
>> +		/* GPIO1 D0-D7 */
>> +		"", "", "[TYPEC5V_PW REN_H]", "5V Fan [PWM1_M1]",
>> +		"", "HDMI-in detect[HDMIIRX_DET_L]", "Pin 05 [I2C8_SCL_M2]", "Pin 03=
 [I2C8_SDA_M2]";
>> +};
>> +
>> +&gpio2 {
>> +	gpio-line-names =3D
>> +		/* GPIO2 A0-A7 */
>> +		"", "", "", "",
>> +		"", "", "SPI NOR Flash [FSPI_D0_M1]", "SPI NOR Flash [FSPI_D1_M1]",
>> +		/* GPIO2 B0-B7 */
>> +		"SPI NOR Flash [FSPI_D2_M1]", "SPI NOR Flash [FSPI_D3_M1]", "", "SPI=
 NOR Flash [FSPI_CLK_M1]",
>> +		"SPI NOR Flash [FSPI_CSN0_M1]", "", "", "",
>> +		/* GPIO2 C0-C7 */
>> +		"", "CSI-Pin 11 [MIPI_CAM2_RESET_L]", "CSI-Pin 12 [MIPI_CAM2_PDN_L]"=
, "",
>> +		"", "", "", "",
>> +		/* GPIO2 D0-D7 */
>> +		"", "", "", "",
>> +		"", "", "", "";
>> +};
>> +
>> +&gpio3 {
>> +	gpio-line-names =3D
>> +		/* GPIO3 A0-A7 */
>> +		"Pin 35 [SPI4_MISO_M1/PW M10_M0]", "Pin 38 [SPI4_MOSI_M1]", "Pin 40 =
[SPI4_CLK_M1/UART8_TX_M1]", "Pin 36 [SPI4_CS0_M1/UART8_RX_M1]",
>> +		"Pin 37 [SPI4_CS1_M1]", "USB3 Type-A Port 2 [USB3_2_PWREN]", "DSI-Pi=
n 12 [LCD_RST]", "Buzzer [PW M8_M0]",
>> +		/* GPIO3 B0-B7 */
>> +		"Pin 33 [PW M9_M0]", "DSI-Pin 10 [PW M2_M1/LCD_BL]", "Pin 07", "Pin =
16",
>> +		"Pin 18", "Pin 29 [UART3_TX_M1/PW M12_M0]", "Pin 31 [UART3_RX_M1/PW =
M13_M0]", "Pin 12",
>> +		/* GPIO3 C0-C7 */
>> +		"DSI-Pin 08 [TP_INT_L]", "DSI-Pin 14 [TP_RST_L]", "Pin 11 [PWM14_M0]=
", "Pin 13 [PWM15_IR_M0]",
>> +		"", "", "", "DSI-Pin 06 [I2C5_SCL_M0_TP]",
>> +		/* GPIO3 D0-D7 */
>> +		"DSI-Pin 05 [I2C5_SDA_M0_TP]", "", "", "",
>> +		"", "", "", "";
>> +};
>> +
>> +&gpio4 {
>> +	gpio-line-names =3D
>> +		/* GPIO4 A0-A7 */
>> +		"", "", "M.2 M-Key Socket 4 [M2_D_PERST_L]", "",
>> +		"", "", "", "",
>> +		/* GPIO4 B0-B7 */
>> +		"USB3 Type-A Port 1 [USB3_TYPEC1_PWREN]", "", "", "M.2 M-Key Socket =
3 [M2_C_PERST_L]",
>> +		"M.2 M-Key Socket 2 [M2_B_PERST_L]", "M.2 M-Key Socket 1 [M2_A_CLKRE=
Q_L]", "M.2 M-Key Socket 1 [M2_A_PERST_L]", "",
>> +		/* GPIO4 C0-C7 */
>> +		"", "", "", "",
>> +		"", "", "", "",
>> +		/* GPIO4 D0-D7 */
>> +		"", "", "", "",
>> +		"", "", "", "";
>> +};
>> +
>> +&gpu {
>> +	mali-supply =3D <&vdd_gpu_s0>;
>> +	sram-supply =3D <&vdd_gpu_mem_s0>;
>> +	status =3D "okay";
>> +};
>> +
>> +&hdptxphy_hdmi0 {
>> +	status =3D "okay";
>
> HDMI support is not ready for RK3588 and no other board enable the HDMI
> PHY yet, maybe wait with this?
>

The PHY node is in rk3588s.dtsi already, so I thought it was okay to
include. But I can remove it for now until HDMI is fully supported.

>> +};
>> +
>> +&i2c0 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&i2c0m2_xfer>;
>> +	status =3D "okay";
>> +
>> +	vdd_cpu_big0_s0: regulator@42 {
>> +		compatible =3D "rockchip,rk8602";
>> +		reg =3D <0x42>;
>> +		fcs,suspend-voltage-selector =3D <1>;
>> +		regulator-name =3D "vdd_cpu_big0_s0";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <550000>;
>> +		regulator-max-microvolt =3D <1050000>;
>> +		regulator-ramp-delay =3D <2300>;
>> +		vin-supply =3D <&vcc_4v0_sys>;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +
>> +	vdd_cpu_big1_s0: regulator@43 {
>> +		compatible =3D "rockchip,rk8603", "rockchip,rk8602";
>> +		reg =3D <0x43>;
>> +		fcs,suspend-voltage-selector =3D <1>;
>> +		regulator-name =3D "vdd_cpu_big1_s0";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <550000>;
>> +		regulator-max-microvolt =3D <1050000>;
>> +		regulator-ramp-delay =3D <2300>;
>> +		vin-supply =3D <&vcc_4v0_sys>;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	status =3D "okay";
>> +
>> +	vdd_npu_s0: regulator@42 {
>> +		compatible =3D "rockchip,rk8602";
>> +		reg =3D <0x42>;
>> +		fcs,suspend-voltage-selector =3D <1>;
>> +		regulator-name =3D "vdd_npu_s0";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <550000>;
>> +		regulator-max-microvolt =3D <950000>;
>> +		regulator-ramp-delay =3D <2300>;
>> +		vin-supply =3D <&vcc_4v0_sys>;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c4 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&i2c4m3_xfer>;
>> +	status =3D "disabled";
>> +};
>> +
>> +/* Connected to MIPI-DSI0 */
>> +&i2c5 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&i2c5m0_xfer>;
>> +	status =3D "disabled";
>> +};
>> +
>> +&i2c6 {
>> +	clock-frequency =3D <200000>;
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&i2c6m0_xfer>;
>> +	status =3D "okay";
>> +
>> +	fusb302: typec-portc@22 {
>> +		compatible =3D "fcs,fusb302";
>> +		reg =3D <0x22>;
>> +		interrupt-parent =3D <&gpio0>;
>> +		interrupts =3D <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-0 =3D <&usbc0_int>;
>> +		pinctrl-names =3D "default";
>> +		vbus-supply =3D <&vbus_5v0_typec>;
>> +
>> +		usb_con: connector {
>> +			compatible =3D "usb-c-connector";
>> +			data-role =3D "dual";
>> +			label =3D "USB-C";
>> +			op-sink-microwatt =3D <1000000>;
>> +			power-role =3D "dual";
>> +			source-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
>> +			sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
>> +			try-power-role =3D "sink";
>> +
>> +			ports {
>> +				#address-cells =3D <1>;
>> +				#size-cells =3D <0>;
>> +
>> +				port@0 {
>> +					reg =3D <0>;
>> +
>> +					usbc0_orien_sw: endpoint {
>> +						remote-endpoint =3D <&usbdp_phy0_orientation_switch>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg =3D <1>;
>> +
>> +					usbc0_role_sw: endpoint {
>> +						remote-endpoint =3D <&dwc3_0_role_switch>;
>> +					};
>> +				};
>> +
>> +				port@2 {
>> +					reg =3D <2>;
>> +
>> +					dp_altmode_mux: endpoint {
>> +						remote-endpoint =3D <&usbdp_phy0_dp_altmode_mux>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	hym8563: rtc@51 {
>> +		compatible =3D "haoyu,hym8563";
>> +		reg =3D <0x51>;
>> +		#clock-cells =3D <0>;
>> +		clock-output-names =3D "hym8563";
>> +		interrupt-parent =3D <&gpio0>;
>> +		interrupts =3D <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&hym8563_int>;
>> +		wakeup-source;
>> +	};
>> +};
>> +
>> +/* Connected to MIPI-CSI1 */
>> +&i2c7 {
>> +	clock-frequency =3D <200000>;
>> +	status =3D "okay";
>> +
>> +	rt5616: audio-codec@1b {
>> +		compatible =3D "realtek,rt5616";
>> +		reg =3D <0x1b>;
>> +		#sound-dai-cells =3D <0>;
>> +	};
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&i2c8 {
>> +	pinctrl-0 =3D <&i2c8m2_xfer>;
>> +	status =3D "okay";
>> +};
>> +
>> +&i2s0_8ch {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&i2s0_lrck
>> +				&i2s0_mclk
>> +				&i2s0_sclk
>> +				&i2s0_sdi0
>> +				&i2s0_sdo0>;
>> +	status =3D "okay";
>> +};
>> +
>> +&i2s5_8ch {
>> +	status =3D "okay";
>> +};
>> +
>> +&i2s6_8ch {
>> +	status =3D "okay";
>> +};
>> +
>> +&i2s7_8ch {
>> +	status =3D "okay";
>> +};
>> +
>> +&pcie2x1l0 {
>> +	/* 2. M.2 slot, CON14: pcie30phy port0 lane1, @fe170000 */
>> +	max-link-speed =3D <3>;
>> +	num-lanes =3D <1>;
>> +	phys =3D <&pcie30phy>;
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&pcie2_0_rst>;
>> +	reset-gpios =3D <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply =3D <&vcc_3v3_pcie30>;
>> +	status =3D "okay";
>> +};
>> +
>> +&pcie2x1l1 {
>> +	/* 4. M.2 slot, CON16: pcie30phy port1 lane1, @fe180000 */
>> +	max-link-speed =3D <3>;
>> +	num-lanes =3D <1>;
>> +	phys =3D <&pcie30phy>;
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&pcie2_1_rst>;
>> +	reset-gpios =3D <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply =3D <&vcc_3v3_pcie30>;
>> +	status =3D "okay";
>> +};
>> +
>> +&pcie2x1l2 {
>> +	/* r8125 ethernet, @fe190000 */
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&pcie2_2_rst>;
>> +	reset-gpios =3D <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply =3D <&vcc_3v3_pcie20>;
>> +	status =3D "okay";
>> +};
>> +
>> +&pcie30phy {
>> +	/*
>> +	* Data lane mapping <1 3 2 4> =3D x1x1 x1x1 (bifurcation of both port=
s)
>> +	* port 0 lane 0 - always mapped to controller 0 (4L)
>> +	* port 0 lane 1 - map to controller 2 (1L0)
>> +	* port 1 lane 0 - map to controller 1 (2L)
>> +	* port 1 lane 1 - map to controller 3 (1L1)
>> +	*/
>> +	data-lanes =3D <1 3 2 4>;
>> +	status =3D "okay";
>> +};
>> +
>> +&pcie3x4 {
>> +	/* 1. M.2 slot, CON13: pcie30phy port0 lane0, @fe150000 */
>> +	max-link-speed =3D <3>;
>> +	num-lanes =3D <1>;
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&pcie3x4_rst>;
>> +	reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply =3D <&vcc_3v3_pcie30>;
>> +	status =3D "okay";
>> +};
>> +
>> +&pcie3x2 {
>> +	/* 3. M.2 slot, CON15: pcie30phy port1 lane0, @fe160000 */
>> +	max-link-speed =3D <3>;
>> +	num-lanes =3D <1>;
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&pcie3x2_rst>;
>> +	reset-gpios =3D <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply =3D <&vcc_3v3_pcie30>;
>> +	status =3D "okay";
>> +};
>> +
>> +&pinctrl {
>> +	audio {
>> +		headphone_detect: headphone-detect {
>> +			rockchip,pins =3D <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	gpio-key {
>> +		key1_pin: key1-pin {
>> +			rockchip,pins =3D <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	gpio-leds {
>> +		led_sys_pin: led-sys-pin {
>> +			rockchip,pins =3D <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		led_usr_pin: led-usr-pin {
>> +			rockchip,pins =3D <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	hym8563 {
>> +		hym8563_int: hym8563-int {
>> +			rockchip,pins =3D <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	pcie {
>> +		pcie2_0_rst: pcie2-0-rst {
>> +			rockchip,pins =3D <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		pcie2_1_rst: pcie2-1-rst {
>> +			rockchip,pins =3D <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		pcie2_2_rst: pcie2-2-rst {
>> +			rockchip,pins =3D <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		pcie3x2_rst: pcie3x2-rst {
>> +			rockchip,pins =3D <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		pcie3x4_rst: pcie3x4-rst {
>> +			rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	sdmmc {
>> +		sd_s0_pwr: sd-s0-pwr {
>> +			rockchip,pins =3D <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	usb {
>> +		vcc_5v0_host20_en: vcc-5v0-host20-en {
>> +			rockchip,pins =3D <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		vcc_5v0_host30_en: vcc-5v0-host30-en {
>> +			rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		vcc_3v3_host32_en: vcc-3v3-host32-en {
>> +			rockchip,pins =3D <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	usb-typec {
>> +		usbc0_int: usbc0-int {
>> +			rockchip,pins =3D <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +
>> +		typec_5v_pwr_en: typec-5v-pwr-en {
>> +			rockchip,pins =3D <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +};
>> +
>> +/* Connected to 5V Fan */
>> +&pwm1 {
>> +	pinctrl-0 =3D <&pwm1m1_pins>;
>
> pinctrl-names is missing, should typically always be defined together
> with pinctrl-X props, same for multiple nodes.
>
>> +	status =3D "okay";
>> +};
>> +
>> +/* Connected to MIPI-DSI0 */
>> +&pwm2 {
>> +	pinctrl-0 =3D <&pwm2m1_pins>;
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&pwm5 {
>> +	pinctrl-0 =3D <&pwm5m1_pins>;
>> +	status =3D "okay";
>> +};
>> +
>> +/* GPIO Connector */
>> +&pwm8 {
>> +	pinctrl-0 =3D <&pwm8m0_pins>;
>> +	status =3D "okay";
>> +};
>> +
>> +/* GPIO Connector */
>> +&pwm9 {
>> +	pinctrl-0 =3D <&pwm9m0_pins>;
>> +	status =3D "okay";
>> +};
>> +
>> +&saradc {
>> +	vref-supply =3D <&avcc_1v8_s0>;
>> +	status =3D "okay";
>> +};
>> +
>> +/* eMMC */
>> +&sdhci {
>> +	bus-width =3D <8>;
>> +	full-pwr-cycle-in-suspend;
>
> Is this really necessary?
>

This flag stems from vendor's device tree.
Dt-bindings doc says "Full power cycle of the card is supported."
for this property.
I am unsure how to properly test this though. But if this flag
is not needed in your opinion, I'll remove it.

>> +	mmc-hs400-1_8v;
>> +	mmc-hs400-enhanced-strobe;
>> +	no-sd;
>> +	no-sdio;
>> +	non-removable;
>> +	status =3D "okay";
>> +};
>> +
>> +/* microSD card */
>> +&sdmmc {
>> +	bus-width =3D <4>;
>> +	cap-mmc-highspeed;
>
> Should not be needed because of no-mmc.
>
>> +	cap-sd-highspeed;
>> +	cd-gpios =3D <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>
> Please drop, not needed with sdmmc_det pinctrl being used.
>

Will do.

>> +	disable-wp;
>> +	max-frequency =3D <150000000>;
>> +	no-mmc;
>> +	no-sdio;
>> +	sd-uhs-sdr104;
>> +	vmmc-supply =3D <&vcc_3v3_sd_s0>;
>> +	vqmmc-supply =3D <&vccio_sd_s0>;
>> +	status =3D "okay";
>> +};
>> +
>> +/* GPIO Connector */
>> +&spi0 {
>> +	num-cs =3D <1>;
>> +	pinctrl-0 =3D <&spi0m2_cs0 &spi0m2_pins>;
>> +	status =3D "disabled";
>> +};
>> +
>> +&spi2 {
>> +	status =3D "okay";
>> +	assigned-clocks =3D <&cru CLK_SPI2>;
>> +	assigned-clock-rates =3D <200000000>;
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&spi2m2_cs0 &spi2m2_pins>;
>> +	num-cs =3D <1>;
>> +
>> +	rk806_single: pmic@0 {
>> +		compatible =3D "rockchip,rk806";
>> +		reg =3D <0x0>;
>> +
>> +		interrupt-parent =3D <&gpio0>;
>> +		interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&pmic_pins>, <&rk806_dvs1_null>,
>> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
>> +
>> +		spi-max-frequency =3D <1000000>;
>> +
>> +		system-power-controller;
>> +
>> +		vcc1-supply =3D <&vcc_4v0_sys>;
>> +		vcc2-supply =3D <&vcc_4v0_sys>;
>> +		vcc3-supply =3D <&vcc_4v0_sys>;
>> +		vcc4-supply =3D <&vcc_4v0_sys>;
>> +		vcc5-supply =3D <&vcc_4v0_sys>;
>> +		vcc6-supply =3D <&vcc_4v0_sys>;
>> +		vcc7-supply =3D <&vcc_4v0_sys>;
>> +		vcc8-supply =3D <&vcc_4v0_sys>;
>> +		vcc9-supply =3D <&vcc_4v0_sys>;
>> +		vcc10-supply =3D <&vcc_4v0_sys>;
>> +		vcc11-supply =3D <&vcc_2v0_pldo_s3>;
>> +		vcc12-supply =3D <&vcc_4v0_sys>;
>> +		vcc13-supply =3D <&vcc_1v1_nldo_s3>;
>> +		vcc14-supply =3D <&vcc_1v1_nldo_s3>;
>> +		vcca-supply =3D <&vcc_4v0_sys>;
>> +
>> +		gpio-controller;
>> +		#gpio-cells =3D <2>;
>> +
>> +		rk806_dvs1_null: dvs1-null-pins {
>> +			pins =3D "gpio_pwrctrl1";
>> +			function =3D "pin_fun0";
>> +		};
>> +
>> +		rk806_dvs2_null: dvs2-null-pins {
>> +			pins =3D "gpio_pwrctrl2";
>> +			function =3D "pin_fun0";
>> +		};
>> +
>> +		rk806_dvs3_null: dvs3-null-pins {
>> +			pins =3D "gpio_pwrctrl3";
>> +			function =3D "pin_fun0";
>> +		};
>> +
>> +		regulators {
>> +			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <550000>;
>> +				regulator-max-microvolt =3D <950000>;
>> +				regulator-ramp-delay =3D <12500>;
>> +				regulator-name =3D "vdd_gpu_s0";
>> +				regulator-enable-ramp-delay =3D <400>;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <550000>;
>> +				regulator-max-microvolt =3D <950000>;
>> +				regulator-ramp-delay =3D <12500>;
>> +				regulator-name =3D "vdd_cpu_lit_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_log_s0: dcdc-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <675000>;
>> +				regulator-max-microvolt =3D <750000>;
>> +				regulator-ramp-delay =3D <12500>;
>> +				regulator-name =3D "vdd_log_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +					regulator-suspend-microvolt =3D <750000>;
>> +				};
>> +			};
>> +
>> +			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <550000>;
>> +				regulator-max-microvolt =3D <950000>;
>> +				regulator-ramp-delay =3D <12500>;
>> +				regulator-name =3D "vdd_vdenc_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_ddr_s0: dcdc-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <675000>;
>> +				regulator-max-microvolt =3D <900000>;
>> +				regulator-ramp-delay =3D <12500>;
>> +				regulator-name =3D "vdd_ddr_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +					regulator-suspend-microvolt =3D <850000>;
>> +				};
>> +			};
>> +
>> +			vdd2_ddr_s3: dcdc-reg6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name =3D "vdd2_ddr_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_2v0_pldo_s3: dcdc-reg7 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <2000000>;
>> +				regulator-max-microvolt =3D <2000000>;
>> +				regulator-ramp-delay =3D <12500>;
>> +				regulator-name =3D "vdd_2v0_pldo_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt =3D <2000000>;
>> +				};
>> +			};
>> +
>> +			vcc_3v3_s3: dcdc-reg8 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <3300000>;
>> +				regulator-max-microvolt =3D <3300000>;
>> +				regulator-name =3D "vcc_3v3_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt =3D <3300000>;
>> +				};
>> +			};
>> +
>> +			vddq_ddr_s0: dcdc-reg9 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name =3D "vddq_ddr_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v8_s3: dcdc-reg10 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <1800000>;
>> +				regulator-max-microvolt =3D <1800000>;
>> +				regulator-name =3D "vcc_1v8_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt =3D <1800000>;
>> +				};
>> +			};
>> +
>> +			avcc_1v8_s0: pldo-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <1800000>;
>> +				regulator-max-microvolt =3D <1800000>;
>> +				regulator-name =3D "avcc_1v8_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v8_s0: pldo-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <1800000>;
>> +				regulator-max-microvolt =3D <1800000>;
>> +				regulator-name =3D "vcc_1v8_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +					regulator-suspend-microvolt =3D <1800000>;
>> +				};
>> +			};
>> +
>> +			avdd_1v2_s0: pldo-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <1200000>;
>> +				regulator-max-microvolt =3D <1200000>;
>> +				regulator-name =3D "avdd_1v2_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_3v3_s0: pldo-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <3300000>;
>> +				regulator-max-microvolt =3D <3300000>;
>> +				regulator-ramp-delay =3D <12500>;
>> +				regulator-name =3D "vcc_3v3_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vccio_sd_s0: pldo-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <1800000>;
>> +				regulator-max-microvolt =3D <3300000>;
>> +				regulator-ramp-delay =3D <12500>;
>> +				regulator-name =3D "vccio_sd_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			pldo6_s3: pldo-reg6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <1800000>;
>> +				regulator-max-microvolt =3D <1800000>;
>> +				regulator-name =3D "pldo6_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt =3D <1800000>;
>> +				};
>> +			};
>> +
>> +			vdd_0v75_s3: nldo-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <750000>;
>> +				regulator-max-microvolt =3D <750000>;
>> +				regulator-name =3D "vdd_0v75_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt =3D <750000>;
>> +				};
>> +			};
>> +
>> +			vdd_ddr_pll_s0: nldo-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <850000>;
>> +				regulator-max-microvolt =3D <850000>;
>> +				regulator-name =3D "vdd_ddr_pll_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +					regulator-suspend-microvolt =3D <850000>;
>> +				};
>> +			};
>> +
>> +			avdd_0v75_s0: nldo-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <750000>;
>> +				regulator-max-microvolt =3D <750000>;
>> +				regulator-name =3D "avdd_0v75_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_0v85_s0: nldo-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <850000>;
>> +				regulator-max-microvolt =3D <850000>;
>> +				regulator-name =3D "vdd_0v85_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_0v75_s0: nldo-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <750000>;
>> +				regulator-max-microvolt =3D <750000>;
>> +				regulator-name =3D "vdd_0v75_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&spi4 {
>> +	num-cs =3D <1>;
>> +	pinctrl-0 =3D <&spi4m1_cs0 &spi4m1_pins>;
>> +	status =3D "disabled";
>> +};
>> +
>> +&tsadc {
>> +	status =3D "okay";
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&uart0 {
>> +	pinctrl-0 =3D <&uart0m0_xfer>;
>> +	status =3D "disabled";
>> +};
>> +
>> +/* Debug UART */
>> +&uart2 {
>> +	pinctrl-0 =3D <&uart2m0_xfer>;
>> +	status =3D "okay";
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&uart3 {
>> +	pinctrl-0 =3D <&uart3m1_xfer>;
>> +	status =3D "disabled";
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&uart4 {
>> +	pinctrl-0 =3D <&uart4m2_xfer>;
>> +	status =3D "disabled";
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&uart6 {
>> +	pinctrl-0 =3D <&uart6m1_xfer>;
>> +	status =3D "okay";
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&uart7 {
>> +	pinctrl-0 =3D <&uart7m2_xfer>;
>> +	status =3D "disabled";
>> +};
>> +
>> +/* GPIO Connector, connected to 40-pin GPIO header */
>> +&uart8 {
>> +	pinctrl-0 =3D <&uart8m1_xfer>;
>> +	status =3D "disabled";
>> +};
>> +
>> +&u2phy0 {
>> +	status =3D "okay";
>> +};
>> +
>> +&u2phy0_otg {
>> +	status =3D "okay";
>> +};
>> +
>> +&u2phy1 {
>> +	status =3D "okay";
>> +};
>> +
>> +&u2phy1_otg {
>> +	phy-supply =3D <&vcc_5v0_host_30>;
>> +	status =3D "okay";
>> +};
>> +
>> +&u2phy2 {
>> +	status =3D "okay";
>> +};
>> +
>> +&u2phy2_host {
>> +	phy-supply =3D <&vcc_5v0_host_20>;
>> +	status =3D "okay";
>> +};
>> +
>> +&u2phy3 {
>> +	status =3D "okay";
>> +};
>> +
>> +&u2phy3_host {
>> +	phy-supply =3D <&vcc_3v3_host_32>;
>> +	status =3D "okay";
>> +};
>> +
>> +&usb_host0_ehci {
>> +	status =3D "okay";
>> +};
>> +
>> +&usb_host0_ohci {
>> +	status =3D "okay";
>> +};
>> +
>> +&usb_host0_xhci {
>> +	dr_mode =3D "otg";
>
> This is already default dr_mode for usb_host0_xhci.
>

Thanks, will drop.

>> +	usb-role-switch;
>> +	status =3D "okay";
>> +
>> +	port {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +
>> +		dwc3_0_role_switch: endpoint@0 {
>> +			reg =3D <0>;
>> +			remote-endpoint =3D <&usbc0_role_sw>;
>> +		};
>> +	};
>> +};
>> +
>> +&usb_host1_ehci {
>> +	status =3D "okay";
>> +};
>> +
>> +&usb_host1_ohci {
>> +	status =3D "okay";
>> +};
>> +
>> +/* Upper USB 3.0 port */
>> +&usb_host1_xhci {
>> +	dr_mode =3D "host";
>> +	status =3D "okay";
>> +};
>> +
>> +/* Lower USB 3.0 port */
>> +&usb_host2_xhci {
>> +	dr_mode =3D "host";
>
> This is already default dr_mode for usb_host2_xhci.
>

Will remove this as well.

>> +	status =3D "okay";
>> +};
>> +
>> +&usbdp_phy0 {
>> +	orientation-switch;
>> +	sbu1-dc-gpios =3D <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
>> +	sbu2-dc-gpios =3D <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
>> +	status =3D "okay";
>> +
>> +	port {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +
>> +		usbdp_phy0_orientation_switch: endpoint@0 {
>> +			reg =3D <0>;
>> +			remote-endpoint =3D <&usbc0_orien_sw>;
>> +		};
>> +
>> +		usbdp_phy0_dp_altmode_mux: endpoint@1 {
>> +			reg =3D <1>;
>> +			remote-endpoint =3D <&dp_altmode_mux>;
>> +		};
>> +	};
>> +};
>> +
>> +&usbdp_phy1 {
>> +	status =3D "okay";
>> +};
>> +
>> +&vop {
>> +	status =3D "okay";
>> +};
>> +
>> +&vop_mmu {
>> +	status =3D "okay";
>> +};
>
> vop and vop_mmu node can probably be skipped for now.
>
> Regards,
> Jonas
>

I'll drop this together with HDMI PHY.

>> +
>> +&wdt {
>> +	status =3D "okay";
>> +};
>> --
>> 2.43.0
>

I just saw that the 'wdt' node in rk3588s.dtsi does not have
a status property, therefore it can be assumed 'status=3D"okay"'.
Do I assume correctly that it is recommended to remove this node
from here as well?

Best regards,
Sebastian


