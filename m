Return-Path: <linux-kernel+bounces-192701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192688D20E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E6B21FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8438172760;
	Tue, 28 May 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b="oRRt3bjz"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76632171E4A;
	Tue, 28 May 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911775; cv=none; b=a79VrqeVX8U2x1bjezXFwUCd7soFuwwOA8q8d9KW4Z/1RQp1qLoLMWpUQLw1y83N+Xgmd5HvMRlk2n3MgJkSLUiISB35aOWZi3TzxgWo5BAvm/gO2rZepPanlNfDWniZBvRzQKf0sLoPBo0sMpOnRIydyQX4Uau8s6cf2VwpLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911775; c=relaxed/simple;
	bh=LpFfjqJEb5Utbsv4ps7Mbt9R0UrBkPM8RBYJWHFSnqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/gwVdSenzMMbXfeQD/dOMIIgozztjlGVe6FKKTSJc72rVTJW5hKkrAtAjwiKqTrd69CxfUr7QvB93jO65rnIWXkHPf8HMGj2DF0udgG+n6py0wXC3jvqU9XXFQcYj0T5mkpsZQ0qtG1dWiM+jimo7cwQilMBioU+7pUBkQ9TMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b=oRRt3bjz; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716911757; x=1717516557; i=seb-dev@web.de;
	bh=SLpCY5iAkNSozHA+0OixQxTvLA9+SRS92cd7bDIVTiE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oRRt3bjzTyaqgEP7l2mx7p/34JoMYhP6ZQoHTkdJdefvLAPhiRv7NRvMFlFZ1Xhr
	 V4ELNoCJikFzrzqmTgajBCitwtjWR88VUEsHlc9IHonbHjx0490L607bQw8wFpVn5
	 1EUBt14tS3Aa+Ex9OBn++3wVxrZRTpimbSIf8kllzxtThdRI0ZGVN7/uSHPZE6E48
	 E9qSfAh+1ibqrDWLVrVtZJKUk2gljJ1mW9M6YoF0+EWZeKZA6lq6H8+HJWxCDMDO+
	 qqF7e0zyWDJk9kOw6hRB5ZKeZEKnHOYgu2FM9MKMEGLbh5s5sPSbTPnjXB9QNRdoI
	 szt4oxcBvN866z989A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.24] ([84.155.184.248]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4621-1sbrxs1QMj-00svbj; Tue, 28
 May 2024 17:55:57 +0200
Message-ID: <ac376b42-a52f-4fef-8543-b961becd5f4d@web.de>
Date: Tue, 28 May 2024 17:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add CM3588 NAS board
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240526214340.8459-1-seb-dev@web.de>
 <20240526214820.9381-1-seb-dev@web.de>
 <9f40c748-691b-4a03-bbd6-54870f46bf05@kwiboo.se> <3609340.LM0AJKV5NW@diego>
From: Sebastian Kropatsch <seb-dev@web.de>
In-Reply-To: <3609340.LM0AJKV5NW@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xDS8GPsegG9dkIa+wdXLc9cG/3EXP2kVobbXMWRqDmOHKNzJFe4
 q16Up9Y+VeUfp7balurnNiWEwYgoqDQNTfki71XwjPRw7cMBskGdeJULmZjCCZoywuG9B74
 m3WIfYdTId4C+1lWDTJxHld4f9StQpD81IW3i8GZYulJyNUE7hvDc7E4oVkVv1CeaeBIBZo
 NUCr5E7iGFOZ2OOhc8dbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ytcgTq2A+7o=;4JV0lqdnnZBkoGFdqOZHQv7NZRm
 9luj6HScnkUaJZSc5K0DN3LZzNQwiFHNe15TjlSrWjDMduZfsZ40i5M3jsJ9g4JHcp9q3+yzh
 fF1ykeYlWySNaRiH0EzfKVwthsE7m00HotQZ4XQ5vTXy8Hsjg3rbXGGEVlm1AibYVxX9HxCVy
 jq+ySgXIG8atrepWQl5UCCo1AKocrDW/ubG7RFR88DCygyR6UIwYRvfXaypXD/t/ZDN47eRxJ
 eDPq0WL/wbCrMwuCWh5VqHjtdGNUeCstLPaMOlYB1rnhuNLATbdICz8eWbIzxyByzhE6ZhYqB
 LSfHJssxZ+voG+lerO26T42le5YafGZuEIfUlgnP6YLq7q1go8bPTseupkfpydYydsgowT9JC
 VjKsGc8U02C1CQti1bU3F7Y973Sul0lLb6PbSvrhz0M0J3TrmrXGNb3o+hxebEOXtN83mzbK/
 B7rUg3tPDkARxzsmEj1zg87y6CA/Vcz1doXu8sF/B8+t0wEDma/vtG8EBz+ycCpzErfE3MsIN
 7LdA3ETJqfv0TOK6fBSXfL+lgYwWS8fO4ctQGzLqhMQ9RCUEAzHJ33ckrM/JQDDqckcRIqgwZ
 kwAjx2fiJV2VrdDqPtPH2IpXima1/W2EU0J0e6K4schc1hPw5AZMOJcbMrjvlQ1flZFOSKAzj
 krhUIuw0KL4OoJhBzYOneafc9GUp5JKw3NmWn1v/TOM3CYK1QqNtVj3TGmN1zaDgVpDehRhN+
 dfPvhMIK2F1GsK0PRMTssF9pcsjRy61cQNR0TzodVcrFhaw2mT9c8Zl4cbiSAHVwnyfAo7DJM
 xjdEzjXHkwF5HdgVtzDmDq6CMceVWzYYflZg/sD+jR1Y4=

Hello Heiko,

Am 27.05.2024 um 22:54 schrieb Heiko St=C3=BCbner:
> Am Montag, 27. Mai 2024, 21:02:02 CEST schrieb Jonas Karlman:
>> Hi Sebastian,
>>
>> On 2024-05-26 23:48, Sebastian Kropatsch wrote:
>>> The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based =
on
>>> the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
>>>
>>> Hardware features:
>>>      - Rockchip RK3588 SoC
>>>      - 4GB/8GB/16GB LPDDR4x RAM
>>>      - 64GB eMMC
>>>      - MicroSD card slot
>>>      - 1x RTL8125B 2.5G Ethernet
>>>      - 4x M.2 M-Key with PCIe 3.0 x1 (via bifurcation) for NVMe SSDs
>>>      - 2x USB 3.0 (USB 3.1 Gen1) Type-A, 1x USB 2.0 Type-A
>>>      - 1x USB 3.0 Type-C with DP AltMode support
>>>      - 2x HDMI 2.1 out, 1x HDMI in
>>>      - MIPI-CSI Connector, MIPI-DSI Connector
>>>      - 40-pin GPIO header
>>>      - 4 buttons: power, reset, recovery, MASK, user button
>>>      - 3.5mm Headphone out, 2.0mm PH-2A Mic in
>>>      - 5V Fan connector, PWM buzzer, IR receiver, RTC battery connecto=
r
>>>
>>> PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 x1
>>> speed. Data lane mapping in the DT is done like described in commit
>>> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588").
>>>
>>> This device tree includes support for eMMC, SD card, ethernet, all USB=
2
>>> and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging a=
s
>>> well as the buttons and LEDs.
>>> The GPIOs are labeled according to the schematics.
>>>
>>> Signed-off-by: Sebastian Kropatsch <seb-dev@web.de>
>>> ---
>>>   arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>>>   .../boot/dts/rockchip/rk3588-cm3588-nas.dts   | 1269 +++++++++++++++=
++
>>>   2 files changed, 1270 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dt=
s
>>
>> Because the CM3588 is a SoM and the NAS is a carrier board this should
>> probably be split in two, cm3588.dtsi and cm3588-nas.dts.
>
> also, because of that way too generic name "cm", please incorporate the
> company name in the filename as well. For the same reason we named
> the rk3568-wolfvision-pf5.dts that way ;-) [Wolfvision being the company=
]
>
> So maybe:
> rk3588-friendlyelec-cm3588.dtsi and rk3588-friendlyelec-cm3588-nas.dts
>

Yes, I agree that the name is very generic. I struggled with this as
well, but your suggestion sounds good!

In this case, is it also preferred to change the commit message to
include the company name event though the commit message subject exceeds
50 characters this way?
("arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board")

>
>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/d=
ts/rockchip/Makefile
>>> index c544ff507d20..f1ff58bdf2cd 100644
>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>>> @@ -114,6 +114,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision=
-pf5.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-display-vz.dt=
bo
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-io-expander.d=
tbo
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-armsom-sige7.dtb
>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-cm3588-nas.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-coolpi-cm5-evb.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a-io.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a-wifi.dtbo
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts b/arch=
/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
>>> new file mode 100644
>>> index 000000000000..6c45b376d001
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
>>> @@ -0,0 +1,1269 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
>>> + * Copyright (c) 2023 FriendlyElec Computer Tech. Co., Ltd.
>>> + * Copyright (c) 2023 Thomas McKahan
>>> + * Copyright (c) 2024 Sebastian Kropatsch
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>> +#include <dt-bindings/soc/rockchip,vop2.h>
>>> +#include <dt-bindings/usb/pd.h>
>>> +#include "rk3588.dtsi"
>>> +
>>> +/ {
>>> +	model =3D "FriendlyElec CM3588 NAS";
>>> +	compatible =3D "friendlyarm,cm3588-nas", "rockchip,rk3588";
>>
>> Maybe this should be something like:
>>
>>    "friendlyarm,cm3588-nas", "friendlyarm,cm3588", "rockchip,rk3588";
>
> This also needs an update of the binding document. Please use a similar
> notion as the other som + baseboard entries
> (const for the som + enum with one entry with the baseboard)
>

Yes, will do!

> [...]
>
>
>>> +/* Connected to 5V Fan */
>>> +&pwm1 {
>>> +	pinctrl-0 =3D <&pwm1m1_pins>;
>>
>> pinctrl-names is missing, should typically always be defined together
>> with pinctrl-X props, same for multiple nodes.
>
> A rationale being that you don't want the soc dtsi in a later stage addi=
ng
> a possible pinctrl-1 with the board only overriding the pinctrl-0.
> When you set the pinctrl-names as well, you get independent from that.
>
>
> Thanks
> Heiko
>

Thank you for exmplaining the retionale behind this! I'll add
pinctrl-names on every instance where pinctrl-0 is present.

Best regards,
Sebastian



