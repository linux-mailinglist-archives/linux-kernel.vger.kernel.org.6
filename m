Return-Path: <linux-kernel+bounces-256092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4E39348D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237061C212F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB0770E5;
	Thu, 18 Jul 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vKdU09kP"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3A18059;
	Thu, 18 Jul 2024 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287965; cv=none; b=LU46Gc+zcrEGMkPcKnSdmYQwb/eya6aWHX1WSfwJByZPi82cn/8LanRPDwgFcBIDOpkb28hYsK8xRY5WfF7tt/aQEreuLqJSS5Gkrm1cH3uI7h/UFFpEw1WNfxbWvKNUHfL1j8jkD6ZC5Dy9JT4HCR2C4o3hA3XbuFej8ywJBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287965; c=relaxed/simple;
	bh=+7Y3LFgbbncCojZpFrvW1G08HFQyJI5GDnvzgLQQws4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tIlK78aukhLDYODqR6NJ7YUXLD2Q9/gMdRCX5TV38ch1bYxNnas3inxFfgftE/dCjYL4odH4lgZrUJPPXEWndLENZcOvquk4l+rh1KFvlMK+2XEFbz00nXI+OAqY3cMln/jPaINrhJ4KhD7sKHwzttmM4S8I3rnm5fI+XwUbXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vKdU09kP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721287960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YINdvKD33YyTGfXnNe9yIHuIAJ1Y5P1g98Nd0MhEVhE=;
	b=vKdU09kP8ThxaRAAaUhbYImsfIb0nVxvGBahcIUzlA+IHpR3PJtZkglH71/3xCFf9kY3Fe
	2c6oX6bCCVHqMFJqKEbF8k6yeuTt1FLUzYX/cOad1/FNt20v5nS843N467FbJjKbhe+Kxz
	V4VBFn9rbhPk4KhuVZvqkppPGOafjeJ2DRR2M47aOQILjAngtj44v/c76kvEGUg0C+M+MS
	lmEKAGCCd4YNAHLkRsKK2reD2HETFHK8nikimMYPMNxTUaLDZqavuDaJdQCITelFNVyjUB
	WJVp/2UI3jHGXpP2OzegQpF47KIzwtpA7wHIyLfhAhqjYX00lUn1zLJ5fy9CcQ==
Date: Thu, 18 Jul 2024 09:32:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: fix the pcie refclock
 oscillator on Rock 5 ITX
In-Reply-To: <CANAwSgS_ZaEkt5-kKud9OwdN4za+xvW5SoBr34EmOdU2OQJWnw@mail.gmail.com>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-4-heiko@sntech.de>
 <CANAwSgS_ZaEkt5-kKud9OwdN4za+xvW5SoBr34EmOdU2OQJWnw@mail.gmail.com>
Message-ID: <8a16eb6a29a39719ba4e4c43bae3b6ec@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Anand,

On 2024-07-18 09:26, Anand Moon wrote:
> On Mon, 15 Jul 2024 at 16:35, Heiko Stuebner <heiko@sntech.de> wrote:
>> 
>> The Rock 5 ITX uses two PCIe controllers to drive both a M.2 slot and 
>> its
>> SATA controller with 2 lanes each. The supply for the refclk 
>> oscillator is
>> the same that supplies the M.2 slot, but the SATA controller port is
>> supplied by a different rail.
>> 
>> This leads to the effect that if the PCIe30x4 controller for the M.2
>> probes first, everything works normally. But if the PCIe30x2 
>> controller
>> that is connected to the SATA controller probes first, it will hang on
>> the first DBI read as nothing will have enabled the refclock before.
> 
> I just checked the rk3588-rock-5-itx.dts in the linux-next.
> You have not enabled sata0 and sata2, which might be the problem
> for the SATA controller not getting initialized.

Rock 5 ITX doesn't use RK5588's built-in SATA interfaces, so that's 
fine.
Please have a look at the board schematic, it uses a separate PCI 
Express
SATA controller for its four SATA ports.

>> Fix this by describing the clock generator with its supplies so that
>> both controllers can reference it as needed.
>> 
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 38 
>> ++++++++++++++++++-
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
>> index d0b922b8d67e8..37bc53f2796fc 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
>> @@ -72,6 +72,15 @@ hdd-led2 {
>>                 };
>>         };
>> 
>> +       /* Unnamed voltage oscillator: 100MHz,3.3V,3225 */
>> +       pcie30_port0_refclk: pcie30_port1_refclk: 
>> pcie-voltage-oscillator {
>> +               compatible = "voltage-oscillator";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <100000000>;
>> +               clock-output-names = "pcie30_refclk";
>> +               vdd-supply = <&vcc3v3_pi6c_05>;
>> +       };
>> +
>>         fan0: pwm-fan {
>>                 compatible = "pwm-fan";
>>                 #cooling-cells = <2>;
>> @@ -146,13 +155,14 @@ vcc3v3_lan: vcc3v3_lan_phy2: 
>> regulator-vcc3v3-lan {
>>                 vin-supply = <&vcc_3v3_s3>;
>>         };
>> 
>> -       vcc3v3_mkey: regulator-vcc3v3-mkey {
>> +       /* The PCIE30x4_PWREN_H controls two regulators */
>> +       vcc3v3_mkey: vcc3v3_pi6c_05: regulator-vcc3v3-pi6c-05 {
>>                 compatible = "regulator-fixed";
>>                 enable-active-high;
>>                 gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&pcie30x4_pwren_h>;
>> -               regulator-name = "vcc3v3_mkey";
>> +               regulator-name = "vcc3v3_pi6c_05";
>>                 regulator-min-microvolt = <3300000>;
>>                 regulator-max-microvolt = <3300000>;
>>                 startup-delay-us = <5000>;
>> @@ -513,6 +523,18 @@ &pcie30phy {
>> 
>>  /* ASMedia ASM1164 Sata controller */
>>  &pcie3x2 {
>> +       /*
>> +        * The board has a "pcie_refclk" oscillator that needs 
>> enabling,
>> +        * so add it to the list of clocks.
>> +        */
>> +       clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
>> +                <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
>> +                <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>,
>> +                <&pcie30_port1_refclk>;
>> +       clock-names = "aclk_mst", "aclk_slv",
>> +                     "aclk_dbi", "pclk",
>> +                     "aux", "pipe",
>> +                     "ref";
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&pcie30x2_perstn_m1_l>;
>>         reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
>> @@ -522,6 +544,18 @@ &pcie3x2 {
>> 
>>  /* M.2 M.key */
>>  &pcie3x4 {
>> +       /*
>> +        * The board has a "pcie_refclk" oscillator that needs 
>> enabling,
>> +        * so add it to the list of clocks.
>> +        */
>> +       clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
>> +                <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
>> +                <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
>> +                <&pcie30_port0_refclk>;
>> +       clock-names = "aclk_mst", "aclk_slv",
>> +                     "aclk_dbi", "pclk",
>> +                     "aux", "pipe",
>> +                     "ref";
>>         num-lanes = <2>;
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&pcie30x4_perstn_m1_l>;
>> --
>> 2.39.2

