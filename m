Return-Path: <linux-kernel+bounces-406801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E439C6472
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994F2B2C7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223D219C9E;
	Tue, 12 Nov 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="V31rFO1C"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3DD1C0DD6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450138; cv=none; b=uCfF0l4oYQT4YKxU6WYRD3GU5XaypNKWDN7zlGKtzCRWMxzIhV/072XD2nJfS6vWsHwx0VZMkiEi/e28NqlWXWPjSW2Ut7IDQ1WFw+oeaQULcFIsbanEt5vowdzCAgs3hx1rOWq3lbYMMfnDRYHpPsH+efD4LhUAa4v4rgQ2PEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450138; c=relaxed/simple;
	bh=XvcRH2z9Mk+KcQ/n1l1PXqkDGa7TDpKW5lJrqcOjVQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+1Gtavh1IulhWlF18UzxZ+CxUFPIXyQu8kNsntMyD+D93A5Q7z5kBlp/ljSNsOTdytX69udrNUn4ig8p/Nb8UzafcJ3oe28QVazm9LGeggVlb8ZIdYwzuKqlglJWs4UMcPk1mKMxIhMjOy2w5fSNw97wxNWZmpGCT+/dnhE+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=V31rFO1C; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1731450113;
 bh=AuUhsWmnwS3Wq04jwBtV8xlb7rkCU2Qg5LzNdH/FNA4=;
 b=V31rFO1Cs7EX8K1z/q0Z0B+MvegdFxr9jea0Z53oW3CjvNvvaf0N84dNRTFF/ecESeUL4ecU2
 TgUtD12239FwfIO3uJWdKyAwZM3Qzt8x/ix7XlAkK2OPQ/9kOTJvnFRFtEmszlYhV7BBeKW59Du
 tmOIcssHgcwBtTTX7im0mnMmCUO760w0q6/W5YlZhH8si3SyvDURRhIm8WYigKUbYSc3fT/P0aI
 dw0SphJ9zNJ516rAPeYLWy+HBa12R2bdQMdAqyml/7IiiyF/E2HW77KbRS5KGvfo9cRg8Ktc0Oc
 kbB+GXkCv1Pq/zdci3ssnHeVZEWTIhMfOHiohVX9+ECg==
Message-ID: <79f13cef-1630-491f-8525-b2b44c0d42fb@kwiboo.se>
Date: Tue, 12 Nov 2024 23:21:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable UART8 on rock-3b
To: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 FUKAUMI Naoki <naoki@radxa.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241111181807.13211-1-tszucs@linux.com>
 <20241111181807.13211-4-tszucs@linux.com>
 <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se>
 <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
 <9330ebb370780c001fd2aaee49aec9e8@manjaro.org>
 <CA+GksrJjDPve29Vh7ZFhM+JFp058xmXZAPeuLuFth7v=JeiH2w@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CA+GksrJjDPve29Vh7ZFhM+JFp058xmXZAPeuLuFth7v=JeiH2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6733d4fe9402f7538d196cc3

Hi Tamás,

On 2024-11-12 22:04, Tamás Szűcs wrote:
> Hi Dragan,
> 
> On Tue, Nov 12, 2024 at 4:07 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> Please correct me if I'm wrong, but isn't this UART supposed to be
>> used for the Bluetooth part of an SDIO WiFi + Bluetooth module, in
>> form of a non-standard M.2 module that Radxa sells?
> 
> UART8 is supposed to be used for any radio module connected to the M2E
> connector.
> It will typically be responsible for Bluetooth or BLE but it could be
> 802.15.4 or whatever. In any case, all wanting to use it will need the
> uart8 node enabled.

Do you have any specific sdio+uart module you are testing these changes
with? The pinout for sdio+uart on Radxa's M.2 Key E slot is their own,
pinout for pcie and usb should be closer to a common standard.

https://dl.radxa.com/accessories/wireless-module/ROCKPi_M2_Wireless_Module_Pinout_v10.xlsx

> 
>>
>> With that in mind, I see very little sense in just enabling the UART,
>> without defining the entire Bluetooth interface, which AFAIK produces
> 
> Defining a bluetooth node would hardwire idiosyncrasies of a given
> radio module's Bluetooth core. Sure you could add a sleep clock, all
> kind of sideband signals for wakeups, reset, power down, etc. But hey,
> some will use them, some won't. I think it's undesirable and
> unnecessary. You can hciattach from here and most will work just like
> that. Tighter integration or anything special, module specific on top
> should be handled individially, on a case-by-case basis. This is a dev
> board after all. I say trick of all trades.

Changing to status=okay for sdmmc2 and uart8 should be fine, it does not
cause any issue for my pcie wifi module testing with a Radxa A8 module.

Testing with a Radxa A2 module (sdio+uart), the sdio/wifi part is
automatically discovered, however bluetooth require a DT overlay for
automatic probe. Something like this seem to work:

diff --git a/rk3568-rock-3b-radxa-a2.dtso b/rk3568-rock-3b-radxa-a2.dtso
new file mode 100644
index 000000000000..746b04e601af
--- /dev/null
+++ b/dts/rk3568-rock-3b-radxa-a2.dtso
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * DT-overlay for Radxa ROCK Pi Wireless Module A2.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+&sdmmc2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PD6 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_wake_host_h>;
+	};
+};
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&rk809 1>;
+		clock-names = "lpo";
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PB5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wakeup";
+		device-wakeup-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reg_on_h &bt_wake_host_h &host_wake_bt_h>;
+		vbat-supply = <&vcc3v3_sys2>;
+		vddio-supply = <&vcc_1v8>;
+	};
+};

With that applied wifi and bt module is detected and firmware loaded
during startup:

[    4.684687] mmc_host mmc2: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)
[    4.699412] dwmmc_rockchip fe000000.mmc: Successfully tuned phase to 360
[    4.707429] mmc2: new ultra high speed SDR104 SDIO card at address 0001
[    4.717034] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43456-sdio for chip BCM4345/9
[    4.760907] Bluetooth: hci0: BCM: chip id 130
[    4.763736] Bluetooth: hci0: BCM: features 0x0f
[    4.787714] Bluetooth: hci0: BCM4345C5
[    4.788482] Bluetooth: hci0: BCM4345C5 (003.006.006) build 0000
[   11.417553] Bluetooth: hci0: BCM: features 0x0f
[   11.441621] Bluetooth: hci0: BCM4345C5 Ampak_CL1 UART 37.4 MHz BT 5.2 [Version: 1039.1086]
[   11.442423] Bluetooth: hci0: BCM4345C5 (003.006.006) build 1086

Regards,
Jonas

> 
>> nasty looking error messages in the kernel log when there's actually
>> nothing connected to the UART.
> 
> My dmesg is clean as a whistle
> root@rock-3b:~# dmesg | grep -E 'fe6c0000|ttyS0'
> [    0.344818] fe6c0000.serial: ttyS0 at MMIO 0xfe6c0000 (irq = 26,
> base_baud = 1500000) is a 16550A
> What kind of nasty errors do you recall?
> 
> Kind regards,
> Tamas


