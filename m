Return-Path: <linux-kernel+bounces-424351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 424609DB357
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB36B21ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969221494B0;
	Thu, 28 Nov 2024 08:01:13 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED645C1C;
	Thu, 28 Nov 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732780873; cv=none; b=daT2wHfAbRSeG7D3+YmgTSXBnLo2m6isqCEMpOjk+WTRVP51s9i6gTnkp+ljGfQJlBAyiSN1nfEKL+UMBvQoyLF7SuDda2uzRbFJVG2C3CrZeJlpze+ELxVJpf78FaWZ9bH+hGzGVKtSOMKg5XmdgsH6CRGWCUp1r7e6AjUITFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732780873; c=relaxed/simple;
	bh=gb6wxy+zGtSUxL2Rne3z19bYYTMDiwzuGQ8CistPkms=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M0FWA/TubsBPeDz2H+9r53JyxVX9mA+KjWp65gVV0pTSUY44c+PwLBC5+GiI3VbV7c7gYsfbOU/6wa7IOWd4qTMhL+jEdoBo4POiVXYUG03om25YNe6bXIlSeALJlHTZhEpGz4IeLUsU3+oHXnkRpgGoW0xWVfNMxx1criLMuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 6D7D6B4B1AFA;
	Thu, 28 Nov 2024 09:01:05 +0100 (CET)
Message-ID: <971ae8a4-1add-45ed-8daf-951aef013e64@freeshell.de>
Date: Thu, 28 Nov 2024 00:01:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: E Shattow <e@freeshell.de>
Subject: Re: [PATCH v5 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable
 usb0 host function
To: Minda Chen <minda.chen@starfivetech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hal Feng <hal.feng@starfivetech.com>
References: <20241126075740.17419-1-e@freeshell.de>
 <CAJM55Z9wWCaS+FxZ=Gg_RfXXafNEJZC1zHZoPWQ2Y9QYDf9OyA@mail.gmail.com>
 <eb06c8e0-ebda-47b9-94f6-6e6eca21097d@freeshell.de>
 <CAJM55Z_Cy2aAfWY-6csKBuv3AJ44h4fCCvJ0ZSbLOYcKw6g=bA@mail.gmail.com>
 <SHXPR01MB086308813C0B311845FDA2C7E629A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
In-Reply-To: <SHXPR01MB086308813C0B311845FDA2C7E629A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Re-sending my reply plain text not HTML format. -E

On 11/27/24 17:31, Minda Chen wrote:
>> E Shattow wrote:
>>> Hi Emil, thanks for taking time to review!
>>>
>>> Added CC: Minda Chen, Hal Feng
>>>
>>> Please Minda and Hal can you follow-up on Emil's comments as well?
>>>
>>> On 11/27/24 03:00, Emil Renner Berthing wrote:
>>>> E Shattow wrote:
>>>>> Enable host mode JH7110 on-chip USB for Milk-V Mars by setting host
>>>>> mode and connect vbus pinctrl.
>>>>>
>>>>> This functionality depends on setting the USB over-current register
>>>>> to disable at bootloader phase, for example U-Boot:
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.426
>>>>> 8-6-minda.chen@starfivetech.com/
>>>> Hi E,
>>>>
>>>> Ideally the JH7110 pinctrl driver would be updated, so Linux can do
>>>> this itself and doesn't need to rely on u-boot doing it. I already asked for this
>> here:
>> https://lore.kernel.org/all/CAJM55Z-+Cxdebcn4MLXfQdOVhx4c2SQ+zMH8cjn
>>>> -Yq35xO8g0A@mail.gmail.com/
>>> Yes, I agree, and Linux is not the only consumer of devicetree. I
>>> would like USB function to work for users of Linux and U-Boot on these
>>> boards by copying what the vendor Board Support Package does what is
>>> shipped with the products. If it is more in-depth than this I will
>>> defer to Hal or Minda.
>>>
>>>
>>> For some wider context, upstream U-Boot is about to adopt the
>>> dt-rebasing via Hal's OF_UPSTREAM for JH7110 boards series and then
>>> also there is a patch set from Minda Chen to add the on-chip JH7110
>>> USB support to U-Boot, and so then and there it will depend on these
>>> dts changes. If you have Milk-V Mars then already there are three of
>>> four USB-A receptacle ports which are functional on PCIe-connected
>>> VL805 USB chipset.
>>>
>>>>> If the over-current register is not prepared for us then the result
>>>>> is no change in functional outcome with this patch applied; there
>>>>> is an error visible to the user and this additional usb
>>>>> configuration fails (same as it is now). On Milk-V Mars with four
>>>>> USB-A ports this applies to one of the ports and the remaining three
>> VL805-connected ports via PCIe are not changed.
>>>> Thanks for the patches. I don't quite understand when you write "no
>>>> change in functional outcome with this patch applied". The USB-C
>>>> port is already configured as a peripheral, and I just tried setting
>>>> up an ethernet gadget on my VF2 running 6.12 and that works quite
>>>> well. Does it not work on the Milk-V Mars board? If it does then these
>> patches would break that functionality.
>>>> Here is the script I used for that:
>>>> https://paste.c-net.org/BravoLonely
>>>>
>>>> At the very least you'll need to explain in the commit message
>>>> itself why changing the USB-C port from peripheral mode to host mode
>>>> is OK. But ideally maybe you could make it work in OTG mode, so
>>>> userspace can choose how they want to use the port. The same goes for the
>> PINE64 board too.
>>>> /Emil
>>> USB-C port on Mars is not wired for data here, that is only true for
>>> VisionFive2. If the user wants to use their USB-A receptacle as OTG
>>> port I will not object to a future improvement, but here we want the
>>> basic expectations of users covered that they should have four working
>>> USB-A receptacle ports in U-Boot (and possibly in Linux, depending on
>>> the overcurrent register wherever it is set). This is what I am
>>> meaning, there may be somebody using a male-male USB-A USB-A cable for
>>> OTG but more likely is that people just want to plug in USB
>>> peripherals to host ports and use their mouse / keyboard / flash memory, I
>> think.
>>
>> You're right, sorry. I'm so used to the JH7110 boards being similar, but this is
>> actually one of the few differences between the Mars and VF2 that was not
>> caught when the Mars dts was first upstreamed.
>>
>> Yes, with 4 similar USB-A ports you'd definitely expect all of them to work in host
>> mode. With an explanation like the above in the commit message I (now) think
>> your changes makes sense.
>>
>> Thanks!
>> /Emil
>>
Hi Minda, thanks for taking time to review and explain the multiple USB 
configurations.

> Thanks. E Shadow
>
> The USB and PCIe0 setting in some JH7110 boards.
>                   PCIe0                                      cadence USB controller
> VF2:       connect with VL805 USB3.0 ( 4 USB 3.0 type A ports)       (USB 2.0)Type C port(role: peripheral)
> Milkv mars  connect with VL805 USB3.0 ( 3 USB 3.0 type A ports)       (USB 2.0)1 Type A port (role:host)
> Milkv cm    PCIe slot											(USB 2.0)micro B port (role:host)
> Star64       disabled（pcie PHY0 connect to cadence USB）         1 usb 3.0 port + USB 2.0 hub (role:host)
>
> H E Shadow
> I see you also add star64 USB configuration. I hope also add this to star64 board dts base on
> V6.13-rc1. Thanks.

Yes, on Star64 board I see there is one "blue colour" USB-A port and 
three "black colour" USB-A port. The product webpage 
https://wiki.pine64.org/wiki/STAR64 does say "1× USB3.0 Dedicated Host 
port / 3× USB2.0 Host port".

> &pcie0 {
> 	status = "disabled";
> };

For JH7110 is it allowed to have PCIe0 "okay" PCIe1 "okay" and also have 
USB 2.0?  We disable this PCIe0 here because of JH7110 USB3.0 design on 
Mars and on Star64?  Can JH7110 have USB 3.0 and USB 2.0 together (does 
Star64 do this, or is it USB 2.0 hub attach to JH7110 USB 3.0?)

> &pciephy0 {
> 	starfive,sys-syscon = <&sys_syscon 0x18>;
> 	starfive,stg-syscon = <&stg_syscon 0x148 0x1f4>;
> 	status = "okay";
> };

Minda, I need your help to make a good description of these numbers 0x18 
0x148 0x1f4, for the patch to Linux.


First is 'starfive,sys-sycon':

JH7110 Technical Reference Manual, Table 7. "SYS SYSCONSAIF SYSCFG 24 
Register Description"

https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/sys_syscon.html#sys_syscon__table_c3l_fqs_wsb

Register SYS SYSCONSAIF SYSCFG 24 at offset 0x18 why is this needed?  
Your patch series for Linux 6.12 "Fix configuration for on-chip USB 2.0 
support"

https://lore.kernel.org/lkml/20241015070444.20972-1-minda.chen@starfivetech.com/

changes u0_pdrstn_split_sw_usbpipe_plugen in the driver and why do we 
need this now in the Star64 USB 3.0 dts for Linux 6.13?  Is this needed 
for USB function only u0_pdrstn_split_sw_usbpipe_plugen or is more from 
this register important here ?  And, can you make an explanation so I 
can learn what is the purpose of "u0_pdrstn_split_sw_usbpipe_plugen" or 
any other part of this register we need here (for USB)?


Next is 'stg-syscon':

JH7110 Technical Reference Manual, Table 82. "STG SYSCONSAIF SYSCFG 328 
Register Description"

https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/stg_syscon.html#stg_syscon__table_mc4_n5s_wsb

Register STG SYSCONSAIF SYSCFG 328 at offset 0x148 what is this? 
Something PCIe?  Does this have to do with wires on the board going from 
USB-A port to PCIe? What is the explanation why we need this for USB?


JH7110 Technical Reference Manual, Table 125. "STG SYSCONSAIF SYSCFG 500 
Register Description"

https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/stg_syscon.html#stg_syscon__table_njd_45s_wsb

Register STG SYSCONSAIF SYSCFG 500 at offset 0x1f4 is more usb3 bitfield 
names, what is a general description why this is needed? Is this "all 
the Cadence IP USB3 things" ?

The documentation devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml 
is not enough information to make a good description. "Total 2 registers 
offset" is a description of the place where the numbers exist for the 
schema but does not say if there is an ordering first,last and the 
expected register names in JH7110 TRM.  Is there more than one 
possibility? or else, will it 100% be exactly STG SYSCONSAIF SYSCFG 
registers 328 and 500 at offsets 0x148 and 0x1f4?


> &usb0 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&usb_pins>;
> 	dr_mode = "host";
> 	status = "okay";
> };
>
> &usb_cdns3 {
> 	phys = <&usbphy0>, <&pciephy0>;
> 	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
> };
>
>>> There is no USB-C port on Star64.
>>>
>>>>> Changes since v4:
>>>>>    - Rebase on latest master
>>>>>
>>>>> Changes since v3:
>>>>>    - Rebase on linux-next/master
>>>>>    - use tabs for code indent
>>>>>
>>>>> Changes since v2:
>>>>>    - Rebase on 6.12
>>>>>
>>>>> E Shattow (1):
>>>>>     riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host
>>>>> function
>>>>>
>>>>>    .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18
>> +++++++++++++++++-
>>>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>>>
>>>>> --
>>>>> 2.45.2
>>>>>
>>> Thanks again Emil.  -E
>>>

For Emil, my patches of Star64 and Mars are limited in scope to do the 
work of turning up host mode and adding the necessary vbus GPIO 
assignment;  so it's not wrong, and given the advice from Minda it's 
also not the complete support for all USB-A ports that I would like. I 
can extend this series to also include this adjacent USB 3.0 
configuration, or follow up in another series that is specific in topic 
for USB 3.0? Where I'm at on this is the host mode and GPIO 
configuration clearly belongs in dts but I have questions about this 
additional (USB 3.0 specific) configuration. And if we do, what do you 
think about the addition of syscon register offset values in devicetree, 
should they be #define'd somewhere? When it is the vbus GPIO there's 
literal sequential number of GPIO's so I did not find it was any problem 
to use the value. But, when I read "0x1f4" I think, what is that?


Best regards,

-E Shattow "Shadow"


