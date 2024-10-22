Return-Path: <linux-kernel+bounces-376808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D919AB612
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48665B23C67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1701C9ED2;
	Tue, 22 Oct 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="d7pOzWg0"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E61C9DFF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622654; cv=none; b=tKU8B2NU4KMfb9taCMfVX+n4smjH7ygmdyIliC7BzeiWY86+HUyXSVjBPvKEMQhsQiJWO/+cYDL/G3aQzVkPQPrN4MRHz1oBE7NhuMCzDrLod9rJ7mKwKD8KqMz6bb/wXxvsyC1qs33ytMSJLaWUuxc0s3es9uMq0qxdx/qGb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622654; c=relaxed/simple;
	bh=v4HfjTF4MidBS+yjpbvbjuBPMx3neUkNC0tI2L7+jLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jg0ItPE4P2o3n895fjFSPVXh9osfDGXKc7Z4mCVhn8VAImNfRxce5DsBYEqnfDXjPEz3rP/yBdgVhscUiLwbnPNeRaOZM794oiwQNGHBtTYy6YgvE4bz1OS9JFOz6dBSphQrU3fInW+zbaa+lOc2C8vmQOTtF3B8fesbppdIX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=d7pOzWg0; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729622639;
 bh=y9CSSJn0ti9P2PomuGM1IpvY2dY35KS2ng6g8SPbTBs=;
 b=d7pOzWg0+Q3Kq5Whfwa4M7VV1ObjDnnaSHt5KjJ0yOehtub2K5RT2Rqe5f2a+yM3Ei1kHGCuQ
 mnBytlTMoUvqjtsI4w6bfY4uSrhFvOJ28opfUZ1nFczyIfbqgbKTryHtPcmJpYaV1ks7G4bWx5A
 L8fGjntoIBAWHTaojoqOZ3WtbnVFqZ6BCQVKAI4zTcxNKXr3I96SXXJ9ZTMVfaPe3IKMHQNhl9w
 nZb6z56DIe1Vh84MjztyhF8KHEo7xTROW+oICrIs184bzr/Hmpbaf3FIQWOYEKDUr0C0O4t8jaw
 k+MuYFHO6CgbbJUYbpxSf/txnxabQbLz0jpHhHf0w8FA==
Message-ID: <3669d2de-5324-4f48-a55c-942ce61d19bb@kwiboo.se>
Date: Tue, 22 Oct 2024 20:43:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R3S
 board
To: Tianling Shen <cnsztl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andyshrk@163.com>,
 Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <c2a4e8a8-9466-41c4-83b3-57210fdf5a5c@kwiboo.se>
 <20241022181829.897547-1-cnsztl@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241022181829.897547-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6717f26eb5b2c22e6f61965d

Hi Tianling,

On 2024-10-22 20:18, Tianling Shen wrote:
> Hi Jonas,
> 
> On Wed, Oct 23, 2024 at 1:56 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Tianling,
>>
>> On 2024-10-22 19:38, Tianling Shen wrote:
>>> Hi Jonas,
>>>
>>> On Wed, Oct 23, 2024 at 12:49â€¯AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> Hi Tianling,
>>>>
>>>> On 2024-10-20 19:39, Tianling Shen wrote:
>>>>> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
>>>>> Ethernet ports designed and developed by FriendlyElec for IoT
>>>>> applications.
>>>>>
>>>>> Specification:
>>>>> - Rockchip RK3566
>>>>> - 2GB LPDDR4X RAM
>>>>> - optional 32GB eMMC module
>>>>> - SD card slot
>>>>> - 2x 1000 Base-T
>>>>> - 3x LEDs (POWER, LAN, WAN)
>>>>> - 2x Buttons (Reset, MaskROM)
>>>>> - 1x USB 3.0 Port
>>>>> - Type-C 5V 2A Power
>>>>>
>>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>>> ---
>>>>> Â arch/arm64/boot/dts/rockchip/Makefile Â  Â  Â  Â  | Â  1 +
>>>>> Â .../boot/dts/rockchip/rk3566-nanopi-r3s.dts Â  | 554 ++++++++++++++++++
>>>>> Â 2 files changed, 555 insertions(+)
>>>>> Â create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>>>>> index 8e1025cb5d20..e641033d23d1 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>>>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>>>>> @@ -109,6 +109,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-model-a.dtb
>>>>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
>>>>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lckfb-tspi.dtb
>>>>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
>>>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-nanopi-r3s.dtb
>>>>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>>>>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>>>>> Â dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
>>>>> new file mode 100644
>>>>> index 000000000000..951dd9bcb4b0
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
>>>>> @@ -0,0 +1,554 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>>>>> +/*
>>>>> + * Copyright (c) 2020 Rockchip Electronics Co., Ltd.
>>>>> + *
>>>>> + * Copyright (c) 2024 FriendlyElec Computer Tech. Co., Ltd.
>>>>> + * (http://www.friendlyarm.com/
>>
>> This could probably be updated to use https://www.friendlyelec.com/
> 
> Yes!
> 
>>
>>>>> + *
>>>>> + * Copyright (c) 2024 Tianling Shen <cnsztl@gmail.com>
>>>>> + */
>>>>> +
>>>>> +/dts-v1/;
>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>> +#include <dt-bindings/input/input.h>
>>>>> +#include <dt-bindings/leds/common.h>
>>>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>>>> +#include <dt-bindings/soc/rockchip,vop2.h>
>>>>> +#include "rk3566.dtsi"
>>>>> +
>>>>> +/ {
>>>>> + Â  Â  model = "FriendlyARM NanoPi R3S";
>>>>
>>>> Please use the marketing name, and the name added in binding:
>>>>
>>>> Â  Â FriendlyElec NanoPi R3S
>>>
>>> Sorry for the copy & paste error, will fix it in new patch.
>>
>> The commit subject could probably also be updated :-)
>>
>>>
>>>>
>>>>> + Â  Â  compatible = "friendlyarm,nanopi-r3s", "rockchip,rk3566";
>>>>> +
>>>>> + Â  Â  aliases {
>>>>> + Â  Â  Â  Â  Â  Â  ethernet0 = &gmac1;
>>>>> + Â  Â  Â  Â  Â  Â  mmc0 = &sdmmc0;
>>>>> + Â  Â  Â  Â  Â  Â  mmc1 = &sdhci;
>>>>
>>>> This board comes with on-board eMMC this please use mmc0 as alias for
>>>> &sdhci; and mmc1 for sd-card.
>>>
>>> Is using mmc0 for sdhci a common practice for eMMC boards?
>>> The eMMC module on R3S is optional and users may get boards without it.
>>
>> Typically any non-removable storage (emmc) is listed before removable
>> storage (sd-card) options. Also U-Boot will try to override and use
>> mmc0=sdhci and mmc1=sdmmc0 for all rk356x boards, so for EFI booing
>> using control FDT the alias may be different.
>>
> 
> Thank you for the details! May I have your Suggested-by tag for all
> of these fixes?

Sure,

Suggested-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> 
> Thanks,
> Tianling.
> 
>> Regards,
>> Jonas
>>
>> [snip]


