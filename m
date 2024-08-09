Return-Path: <linux-kernel+bounces-280800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA494CF64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6101F22712
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54009192B89;
	Fri,  9 Aug 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wQcd7h+3"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [164.92.70.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7C18F2E8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.92.70.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203346; cv=none; b=lgLPwNRCDzA3zSLFN1ghK3qfV+8tx8LGryhg8tic3hKFFTFxiykUhwcoV0/UEkuwo/YIVusn3QiPQHu8+il6ZBKMxBUzhfJU1Mz2FOQF5nD33ndK4qQ8haqrXui5/uqxOfVcRPtYwTWYYm6d4K37ya/2J2VnCAovJ6RR2e0N/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203346; c=relaxed/simple;
	bh=jVP4JRVTqAnHhup/RA+oeK7tVqk6XHXSneAgsF4Fcr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3ljB1wxcjb/mmcOqwxgk8Ip3mEseEfKzKoygGjAG/Qsl4EIoLZtcJ6vf4nC4/7STGtS7Ns9yrpyrggnc4mTAeFnOhQYGTu8F3DI1Ogq0SG/D9ObU5xQ/wJfkrvQbLY6l3lrDTxZxQwwh75674FBWJBauMeY01XH0LrugkXQOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wQcd7h+3; arc=none smtp.client-ip=164.92.70.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1723203338;
 bh=DlyRQzJH5IivPa9jJ+fvrG6L0V2KTPAwiDw4riGftvU=;
 b=wQcd7h+3pxX4k2xvRs7yl78r6kqZiqZS5b46CGRJ8w0tMyYnwp/8EId32R7JghrCEsgvrz9eV
 9wez1Homi+ilqba5np+yXoNB9ibnN+7nGMXcvN7TMOfHTIPky917NnhWLio99ElkiKdfh5hKSgK
 SI/yIGZugaZmZdNO/wmx5L5hnlqzx1Ffmn9e7ItFSCYPpKnd1XieJKHffa2MnN3X79xQswOpEy3
 xVTyKl3f+yOlIe7fdZg0iVW8GMnD7qqpoJSKJkPnZULdw8rdNgLi11TgCpNhMERQJJrxmSxVsSD
 rVRLS84khoEJI9lX0xfO2uTyjgiUTf4ffFCMeMB9EfLA==
Message-ID: <a0963a8c-ae1b-4146-8b39-17bd3e864457@kwiboo.se>
Date: Fri, 9 Aug 2024 13:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: rockchip: Add missing pinctrl wake and
 clkreq for PCIe node
To: Anand Moon <linux.amoon@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240729123709.2981-1-linux.amoon@gmail.com>
 <17c5e90e-a99d-4e4d-bc18-0366019f0bcf@kwiboo.se>
 <CANAwSgTr-FAF63LK3Ac5fTMFYcS3caUXWY5PQSWYDxCwFdDgyA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CANAwSgTr-FAF63LK3Ac5fTMFYcS3caUXWY5PQSWYDxCwFdDgyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 164.92.70.200
X-ForwardEmail-ID: 66b5ff08ff1349a011d42282

Hi Anand,

On 2024-08-09 12:41, Anand Moon wrote:
> Hi Jonas
> 
> On Fri, 9 Aug 2024 at 15:29, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Anand,
>>
>> On 2024-07-29 14:37, Anand Moon wrote:
>>> Add missing pinctrl settings WAKE and CLKREQ for PCIe 3.0 x4, PCIe 3.0 x1
>>> and PCIe 2.1 x1 nodes. Each component of PCIe communication have the
>>> following control signals: PERST, WAKE, CLKREQ, and REFCLK.
>>> These signals work to generate high-speed signals and communicate with
>>> other PCIe devices. Used by root complex to endpoint depending on
>>> the power state.
>>>
>>> PERST# is referred to as a fundamental reset. PERST should be held
>>> low until all the power rails in the system and the reference clock
>>> are stable. A transition from low to high in this signal usually
>>> indicates the beginning of link initialization.
>>>
>>> WAKE# signal is an active-low signal that is used to return the PCIe
>>> interface to an active state when in a low-power state.
>>>
>>> CLKREQ# signal is also an active-low signal and is used to request the
>>> reference clock.  L1 sub-states is providing a digital signal
>>> (CLKREQ#) for PHYs to use to wake up and resume normal operation.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> v5: Merged all 3 patch into single patch, reabse on master
>>>     Fix the $subject and commit message.
>>>     Drop the RK_FUNC_GPIO for WAKE and CLKREQ as these seignal are
>>>     ment for was introduced to allow PCI Express devices to enter
>>>     even deeper power savings states (“L1.1” and “L1.2”) while still
>>>      appearing to legacy software to be in the “L1” state
>>> ---
>>>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 46 +++++++++++++------
>>>  1 file changed, 33 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> index 966bbc582d89..a1e83546f1be 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> @@ -318,7 +318,7 @@ map2 {
>>>
>>>  &pcie2x1l0 {
>>>       pinctrl-names = "default";
>>> -     pinctrl-0 = <&pcie2_0_rst>;
>>> +     pinctrl-0 = <&pcie30x1_pins>;
>>>       reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
>>>       vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
>>>       status = "okay";
>>> @@ -326,7 +326,7 @@ &pcie2x1l0 {
>>>
>>>  &pcie2x1l2 {
>>>       pinctrl-names = "default";
>>> -     pinctrl-0 = <&pcie2_2_rst>;
>>> +     pinctrl-0 = <&pcie20x12_pins>;
>>>       reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
>>>       vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
>>>       status = "okay";
>>> @@ -338,7 +338,7 @@ &pcie30phy {
>>>
>>>  &pcie3x4 {
>>>       pinctrl-names = "default";
>>> -     pinctrl-0 = <&pcie3_rst>;
>>> +     pinctrl-0 = <&pcie30x4_pins>;
>>>       reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>>>       vpcie3v3-supply = <&vcc3v3_pcie30>;
>>>       status = "okay";
>>> @@ -363,28 +363,48 @@ hp_detect: hp-detect {
>>>               };
>>>       };
>>>
>>> -     pcie2 {
>>> -             pcie2_0_rst: pcie2-0-rst {
>>> -                     rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +     pcie20x1 {
>>> +             pcie20x12_pins: pcie20x12-pins {
>>> +                     rockchip,pins =
>>> +                             /* PCIE20_1_2_CLKREQn_M1_L */
>>> +                             <3 RK_PC7 4 &pcfg_pull_up>,
>>> +                             /* PCIE_PERST_L */
>>> +                             <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>,
>>> +                             /* PCIE20_1_2_WAKEn_M1_L */
>>> +                             <3 RK_PD0 4 &pcfg_pull_up>;
>>
>> Some unanswered questions from v4:
>>
>> How come you use internal pull-up/down on these pins?
> 
> As per the schematic radxa_rock5b_v13_sch.pdf [1] pin description
> 
> GPIO3_B0_u    pin for PCIE_PERST_L                      (pcfg_pull_up)
> GPIO3_D0_u    pin for PCIE20_1_2_WAKEn_M1_L  (pcfg_pull_up)
> GPIO4_A4_d    pin for PCIE30x1_0_WAKEn_M1_L  (pcfg_pull_down)

The highlighting of GPIO3_B0_u etc typically only refers to the default
value at SoC reset, and the pinctrl should describe how the pin should
be configured, not the default value (unless it happens to match).

The schematic tells us that the GPIO3_B0 pin is used for PERST# signal,
your description of this signal tells us that the PERST# should be held
low and a transition from low to high in this signal usually indicates
the beginning of link initialization, so stand to reason that an
internal or external pull-down may be used on a PERST# signal.

Similarly the WAKE# and CLKREQ# signal is an active-low signal, so
use of internal or external pull-up may be correct.

However the mixed use of bias-pull-up/down as pinconf for a pin used
for same signal on different pcie controllers does not make that much
sense to me.

pcie2x1l0 WAKE# use pcfg_pull_down (bias-pull-down)
pcie2x1l2 WAKE# use pcfg_pull_up (bias-pull-up)
pcie3x4 WAKE# use pcfg_pull_down (bias-pull-down)

And similar it is mixed for CLKREQ# and PERST# across the different pcie
controllers.

I am no expert in this area but this mixed bias pinconf of these signals
look strange to me.

> 
> [1] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock5b_v13_sch.pdf
> 
>> And why do they differ for each pcie node in this series?
> 
> It also depends on how the pins are defined in the schematics.
> I have not made many changes in this series combined in a single patch.

The internal pull is different compared to how the default pcie pins is
configured from rk3588 pinctrl.dtsi, where they are all bias-disable.

And my wondering is why this deviate from the use of pcfg_pull_none from
those existing pcie pins pin groups?

Regards,
Jonas

> 
>>
>> Regards,
>> Jonas
> 
> Thanks
> -Anand
>>
>>>               };
>>> +     };
>>>
>>> +     pcie30x1 {
>>>               pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
>>>                       rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
>>>               };
>>>
>>> -             pcie2_2_rst: pcie2-2-rst {
>>> -                     rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +             pcie30x1_pins: pcie30x1-pins {
>>> +                     rockchip,pins =
>>> +                             /* PCIE30x1_0_CLKREQn_M1_L */
>>> +                             <4 RK_PA3 4 &pcfg_pull_down>,
>>> +                             /* PCIE30x1_0_PERSTn_M1_L */
>>> +                             <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>,
>>> +                             /* PCIE30x1_0_WAKEn_M1_L */
>>> +                             <4 RK_PA4 4 &pcfg_pull_down>;
>>>               };
>>>       };
>>>
>>> -     pcie3 {
>>> -             pcie3_rst: pcie3-rst {
>>> -                     rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
>>> -             };
>>> -
>>> +     pcie30x4 {
>>>               pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>>>                       rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>>>               };
>>> +
>>> +             pcie30x4_pins: pcie30x4-pins {
>>> +                     rockchip,pins =
>>> +                             /* PCIE30X4_CLKREQn_M1_L */
>>> +                             <4 RK_PB4 4 &pcfg_pull_up>,
>>> +                             /* PCIE30X4_PERSTn_M1_L */
>>> +                             <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>,
>>> +                             /* PCIE30X4_WAKEn_M1_L */
>>> +                             <4 RK_PB5 4 &pcfg_pull_down>;
>>> +             };
>>>       };
>>>
>>>       usb {
>>>
>>> base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9
>>


