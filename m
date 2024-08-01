Return-Path: <linux-kernel+bounces-270545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF7944132
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657451C226A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82701EB4AC;
	Thu,  1 Aug 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="C1G+RTTD"
Received: from mail-m3276.qiye.163.com (mail-m3276.qiye.163.com [220.197.32.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54280367;
	Thu,  1 Aug 2024 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479431; cv=none; b=ai14ayiPpSDGLQmTopzi3E45Ai7H5u75snAsCWqo7f0ELZAVdQURWYOOdse1+Des9XmwocSHD0RTkoVINlQ/YJ+3JRF2OGGMu3ovs3O82/BeMIvnbCrEpe0TXn912lhoWwCRSkFYgJYfwDKN0rVZLJPcJUYR987VWTTN6d1u0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479431; c=relaxed/simple;
	bh=+sxLNRF7oFl2XCGvHHLYZUI22KCgmrpppedRnpOl7mQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QXiWyJw4B+IMPiRkxsthQhWF3HDtXxosfzgj3EJUsw0gR7lECC1g+r2xPCVn3cLo3+oeATQZG+K6aid8PAQFO5IrWHK4O2WrU8ryK+IEkKxeunP91iTOl0w1vJjGLBnLQCS7vZDSmRa7uzQemS9dBACpiR03CSlwa96RTQxaSsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=C1G+RTTD; arc=none smtp.client-ip=220.197.32.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=C1G+RTTDBunZ0iZ1mpZWDGnZMAMjXDBk1fORX1EZWWTcYVnZQMzNXRwAjNL0MgDxaZ+Gx5Th2KGAvdve35BASoGgbiwKaMMyh1oMI3zHp7yxwxcJIcNGvUabXk8THm+DRaTZaRHJd9qDhYRIa+TVAgXaUhvDnfRTL0Tc2CTzgp4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=9lurVAzzVNkLf/T6OA5qeOAz22bqJP8dlqU3S35by5Q=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 8D10190038E;
	Thu,  1 Aug 2024 10:23:01 +0800 (CST)
Message-ID: <394ad670-c4ea-432b-8737-89720c526653@rock-chips.com>
Date: Thu, 1 Aug 2024 10:23:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4
 node
To: Jonas Karlman <jonas@kwiboo.se>, Anand Moon <linux.amoon@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240711060939.1128-1-linux.amoon@gmail.com>
 <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
 <CANAwSgQCn3jgiruiLs0cu-C+DguLtnk=msboAh8jNSF4P28gjA@mail.gmail.com>
 <6250fa05-7a06-4fa1-a2be-9cb66a2d2822@kwiboo.se>
Content-Language: en-US
In-Reply-To: <6250fa05-7a06-4fa1-a2be-9cb66a2d2822@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0YQ1YYTk4fGkkeTRpLTB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a910bbf73ce03a9kunm8d10190038e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Izo5IjI2OS8YMQkUNAk0
	NTwaCg1VSlVKTElJT0xDQkNJTUJOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTkxDNwY+

Hi Anand, Jonas,

On 2024/7/11 17:44, Jonas Karlman wrote:
> Hi Anand,
>
> On 2024-07-11 11:09, Anand Moon wrote:
>> Hi Jonas,
>>
>> Thanks for your review comments.
>>
>> On Thu, 11 Jul 2024 at 14:13, Jonas Karlman<jonas@kwiboo.se>  wrote:
>>> Hi Anand,
>>>
>>> On 2024-07-11 08:09, Anand Moon wrote:
>>>> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
>>>> signals.Each component of PCIe communication have the following control
>>>> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
>>>> high-speed signals and communicate with other PCIe devices.
>>>> Used by root complex to endpoint depending on the power state.
>>>>
>>>> PERST is referred to as a fundamental reset. PERST should be held low
>>>> until all the power rails in the system and the reference clock are stable.
>>>> A transition from low to high in this signal usually indicates the
>>>> beginning of link initialization.
>>>>
>>>> WAKE signal is an active-low signal that is used to return the PCIe
>>>> interface to an active state when in a low-power state.
>>>>
>>>> CLKREQ signal is also an active-low signal and is used to request the
>>>> reference clock.
>>>>
>>>> Signed-off-by: Anand Moon<linux.amoon@gmail.com>
>>>> ---
>>>> V2: Update the commit messge to describe the changs.
>>>>      use pinctl group as its pre define in pinctl dtsi
>>>> ---
>>>>   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
>>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>> index 2e7512676b7e..ab3a20986c6a 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>> @@ -301,7 +301,7 @@ &pcie30phy {
>>>>
>>>>   &pcie3x4 {
>>>>        pinctrl-names = "default";
>>>> -     pinctrl-0 = <&pcie3_rst>;
>>>> +     pinctrl-0 = <&pcie30x4m1_pins>;
>>> Use of the existing pcie30x4m1_pins group may not be fully accurate for
>>> the PERST pin. The use of reset-gpios indicate that the PERST pin is
>>> used with GPIO function and the driver will implicitly change the
>>> function from perstn_m1 to GPIO. So this may not be best representation
>>> of the hw, hence my initial suggestion, something like:
>>>
>>>          pcie30x4_pins: pcie30x4-pins {
>>>                  rockchip,pins =
>>>                          <4 RK_PB4 4 &pcfg_pull_none>,
>>>                          <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
>>>                          <4 RK_PB5 4 &pcfg_pull_none>;
>>>          };
>>>
>>> Similar change should probably also be done for pcie2x1l0 and pcie2x1l2,
>>> not just pcie3x4.
>>>
>> Ok but it is better to update this in rk3588s-pinctrl.dtsi otherwise
>> the pcie30x4m1_pins
>> will not be used at all on all the boards
> I agree that it is unfortunate that the PERST pin is included in the
> groups in pinctrl.dtsi, however, for pcie ep mode the pins should more
> than likely be using the perstn_m1 function and not GPIO, so there are
> uses for the existing pin groups for ep mode.
Please note that the pcie30x4m1_pins define in pinctrl.dtsi is somehow 
not correct due to the TRM.
- The WAKE should always work in GPIO mode, this is totally support by 
SoC, not PCIe controller;
- The PERST should always work in GPIO mode in PCIe RC mode; and for all 
the rk3588 EP mode
hardware I have seem, the PERST from RC connect in to board POR instead 
of SoC PERST;
The PCIe in most of boards works in RC mode, so we should make PERST 
default as GPIO;
- CLKREQ, it depends on boards, if the board need to support L1SS or 
not, most of the boards
does not support L1SS, which means CLKREQ works in GPIO mode instead of 
PCIe function.

Thanks,
- Kever
> In my opinion using pcie30x4m1_pins as-is and having implicitly changing
> to GPIO function when driver/usage in the software require it is an okay
> description of the hw.
>
> However, seeing how use of pcie ep is described using its own node in DT
> I can understand that for rc mode the pin should be changed to GPIO to
> properly describe the expected usage.
>
> When I tried to add similar implicit change to use GPIO function in
> U-Boot to fix system freeze when improper pinctrl was used, it resulted
> in some discussions, see [1] ;-)
>
> [1]https://lore.kernel.org/u-boot/20240511112821.1156519-1-jonas@kwiboo.se/t/#u
>
>> I will update the PERST pin to RK_FUNC_GPIO on all the pcie2x1l0,
>> pcie2x1l2 and  pcie30x4
>> is this ok for you?
> This should probably be reworked in pinctrl.dtsi together with all
> affected boards and/or use a group override in the board dts.
>
> Regards,
> Jonas
>
>>> Regards,
>>> Jonas
>> Thanks
>> -Anand
>>>>        reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>>>>        vpcie3v3-supply = <&vcc3v3_pcie30>;
>>>>        status = "okay";
>>>> @@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
>>>>        };
>>>>
>>>>        pcie3 {
>>>> -             pcie3_rst: pcie3-rst {
>>>> -                     rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
>>>> -             };
>>>> -
>>>>                pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>>>>                        rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>>>>                };
>>>>
>>>> base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

