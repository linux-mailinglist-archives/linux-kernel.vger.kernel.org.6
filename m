Return-Path: <linux-kernel+bounces-537944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB56A492C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD3816F687
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC71C8636;
	Fri, 28 Feb 2025 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="wqUWew5O"
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7E10E5;
	Fri, 28 Feb 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729822; cv=none; b=ewJLBFykgRESBTapMF0PMaUdMxZue6zYkuvtEfW3gz7MfMJKxkJ/Zbwt6tKTSJdFMkEjiJ4SvTeR0k2WmYsdzFa5RtxNqgmI1aEC3VuT7t03Ui0nV/YyLRmDqKkRzH0xRab5rPTS2RUGsze+yG/cEVcQz58rnDcg9SPxYbXe33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729822; c=relaxed/simple;
	bh=+DQElHBvDKNGBcoSETty3Z7XBYvwn9DMo8M0nqGqAyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1xsfCiwVQsUySpt/zbawAraMG8RwcRqRkwAFUi5I63N7mdYjWB8bINXW04KD6BHfWDvSwm8FVydRoWC1FiLlAjJ10A3eF8kStA80diTiUxerYqlNFNGuzRoIl7XgZVHJypR7YTpNVr0xt4uR1lk2nsyZkCjb0m88Z3iveUMZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (1024-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=wqUWew5O; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.197])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 4DA9AB4C0592;
	Fri, 28 Feb 2025 08:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=mail; t=1740729229;
	bh=AXDPsPyWvICXScXCh1eSoBQkEfWfZVi/WOVQ1cYJJA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wqUWew5OisMsHSP6/g5SkINKU6ork8UBayx98V8axC131N69Yk1QeqoyWXNjeEgvt
	 40lVl7yRhMKKK+PFm+KKucXVZdg4CeEXBznZCvkjMMDMJ3jlEP67YeFQoIj2eu4swq
	 2+I0mynKl/NAZKTr/6jgGYlyflKKGWXVAM34zzwU=
Message-ID: <8b0f7b4f-e58a-45ae-931f-2b2853918ab4@freeshell.de>
Date: Thu, 27 Feb 2025 23:53:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] riscv: dts: starfive: jh7110-common:
 bootph-pre-ram hinting needed by boot loader
To: Hal Feng <hal.feng@starfivetech.com>,
 Hal Feng <hal.feng@linux.starfivetech.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20250203013730.269558-1-e@freeshell.de>
 <20250203013730.269558-6-e@freeshell.de>
 <25B3D8909DBCC21B+43663a76-4afa-44ae-95e2-3a8792de614c@linux.starfivetech.com>
 <206a6ada-1ef9-47f3-b1cf-fb1a1540e95c@canonical.com>
 <62D89163A60680E7+f0f5a4d4-42f1-454d-9dfe-cf53e2aca4ac@linux.starfivetech.com>
 <cba21857-7eb2-4f10-a1bd-6743ce63dfa6@freeshell.de>
 <ZQ2PR01MB1307ECDF175D20547AC69287E6F1A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB1307ECDF175D20547AC69287E6F1A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/6/25 19:01, Hal Feng wrote:
>> On 06.02.25 19:17, E Shattow wrote:
>> On 2/5/25 18:59, Hal Feng wrote:
>>> On 2/5/2025 6:01 PM, Heinrich Schuchardt wrote:
>>>> On 2/5/25 08:57, Hal Feng wrote:
>>>>> On 2/3/2025 9:37 AM, E Shattow wrote:
>>>>>> Add bootph-pre-ram hinting to jh7110-common.dtsi:
>>>>>>    - i2c5_pins and i2c-pins subnode for connection to eeprom
>>>>>>    - eeprom node
>>>>>>    - qspi flash configuration subnode
>>>>>>    - memory node
>>>>>>    - uart0 for serial console
>>>>>>
>>>>>>    With this the U-Boot SPL secondary program loader may drop such
>>>>>>    overrides when using dt-rebasing with JH7110 OF_UPSTREAM board
>> targets.
>>>>>>
>>>>>> Signed-off-by: E Shattow <e@freeshell.de>
>>>>>> ---
>>>>>>   arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 6 ++++++
>>>>>>   1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> index 30c5f3487c8b..c9e7ae59ee7c 100644
>>>>>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> @@ -28,6 +28,7 @@ chosen {
>>>>>>       memory@40000000 {
>>>>>>           device_type = "memory";
>>>>>>           reg = <0x0 0x40000000 0x1 0x0>;
>>>>>> +        bootph-pre-ram;
>>>>>>       };
>>>>>>         gpio-restart {
>>>>>> @@ -247,6 +248,7 @@ emmc_vdd: aldo4 {
>>>>>>       };
>>>>>>         eeprom@50 {
>>>>>> +        bootph-pre-ram;
>>>>>>           compatible = "atmel,24c04";
>>>>>>           reg = <0x50>;
>>>>>>           pagesize = <16>;
>>>>>> @@ -323,6 +325,7 @@ &qspi {
>>>>>>       nor_flash: flash@0 {
>>>>>>           compatible = "jedec,spi-nor";
>>>>>>           reg = <0>;
>>>>>> +        bootph-pre-ram;
>>>>>>           cdns,read-delay = <2>;
>>>>>>           spi-max-frequency = <100000000>;
>>>>>>           cdns,tshsl-ns = <1>;
>>>>>> @@ -405,6 +408,7 @@ GPOEN_SYS_I2C2_DATA,
>>>>>>       };
>>>>>>         i2c5_pins: i2c5-0 {
>>>>>> +        bootph-pre-ram;
>>>>>>           i2c-pins {
>>>>>>               pinmux = <GPIOMUX(19, GPOUT_LOW,
>>>>>>                             GPOEN_SYS_I2C5_CLK, @@ -413,6 +417,7 @@
>>>>>> GPI_SYS_I2C5_CLK)>,
>>>>>>                             GPOEN_SYS_I2C5_DATA,
>>>>>>                             GPI_SYS_I2C5_DATA)>;
>>>>>>               bias-disable; /* external pull-up */
>>>>>> +            bootph-pre-ram;
>>>>>>               input-enable;
>>>>>>               input-schmitt-enable;
>>>>>>           };
>>>>>> @@ -641,6 +646,7 @@ GPOEN_DISABLE,
>>>>>>   };
>>>>>>     &uart0 {
>>>>>> +    bootph-pre-ram;
>>>>>>       clock-frequency = <24000000>;
>>>>>>       pinctrl-names = "default";
>>>>>>       pinctrl-0 = <&uart0_pins>;
>>>>>
>>>>> What about &mmc0, &mmc1, &qspi, &sysgpio, &mmc0_pins,
>> &mmc1_pins, &i2c5?
>>>>> Why not add "bootph-pre-ram;" for them?
>>>>
>>>> Would they be needed before relocation of U-Boot to DRAM?
>>>
>>> Yeah, they are needed by SPL and they are set in U-Boot
>>> arch/riscv/dts/jh7110-common-u-boot.dtsi.
>>>
>>> Best regards,
>>> Hal
>>>
>>
>> When I tested on Star64 there was none of those needed to boot. We can add
>> more bootph-pre-ram as needed but I want to know how to test (because I
>> did not see any need for these).
>>
>> How do you test that these are needed?
> 
> In my opinion, SPL need to read U-Boot from EMMC (mmc0) or SDcard (mmc1) or
> QSPI flash (qspi). Also it need to choose the correct DTB by reading EEPROM
> mounted on i2c5. To run mmc / i2c drivers, the pin configurations (sysgpio, mmc0/1_pins)
> are also needed.
> 
> Best regards,
> Hal

EMMC or SDcard are not possible to boot (via JH7110 boot ROM, distinct
from QSPI boot of U-Boot and later EMMC or SDcard capability) in this
way on some of the boards where transistor logic pairs GPIO0 and GPIO1
both-off or both-on. SDcard boot is officially recommended against as
"not supported" by the StarFive reference documentation, and I suppose
what remains is EMMC boot as valid though I have not heard of any users
for this.

What is the test procedure for EMMC boot, can you explain and I will try
it on the Star64?

-E

