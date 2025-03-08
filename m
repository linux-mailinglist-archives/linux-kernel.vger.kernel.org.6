Return-Path: <linux-kernel+bounces-552650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D9A57C51
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29AE3AC47E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446621E832D;
	Sat,  8 Mar 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="n8FJNvpW"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0765185B67
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741454637; cv=none; b=U8GF/hxUsVheKW8NkYjly+eVLzW9T3+YwmdLpZE5zX99HaJxCkFrctTXRWY6lulDJf555PAcngvZMPfcHhIiQbrhHcWaltmR/lM32liT8zN5yg/0Xa/kC/iBEXlQ71YBh+PhMSQfqNudMCt+Lq/aUNbGSgiNSESSAfbm5cfbJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741454637; c=relaxed/simple;
	bh=rphzLWt8qRKS8I5IQKDSTFV4IenJ2J85dPuChCgbMhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZYwbOhIHVinQyFpI+Kc0rzCtWcD5OxATEZWP9l6S7zx8ggSdesV8+e92LL0JdvmqN8bWhpSYgtFq0hiunBbMjPG8N5/h2rxFaNl/W8oUL5D2crXw1XA52nEKPBwGyDnVqIlmF2vqiHkfV+t45ANEEhrsCmgt/qXDZlFligdYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=n8FJNvpW; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741454629;
 bh=rdKpkKhc5DWF4kJy316aJ1WXtNP0Vx9DhX/sV/rVTxg=;
 b=n8FJNvpWe/wH14w7kuqQ5JU306orY2YJcoPTY4VmMZLE+4457aot5Zsb4DoY3k1ysBbEsfiRV
 c9swIV7FDSRlST85CEw4BNxxCsEJbKcLZ41aTLQ34DJjD+YG+/U/9RhJjlJ2yPppl53U3d1XI51
 hnmfL8s/mkDW3GWp1GT8jomO4zHj3VZFUagZ9eGTD96524lYOkF+AnC/e9eCsobINpvMgkr8Vm2
 Tk2TmRwk8GTCcPjRTxEfGnHtIDZP6IG6up9gI3TqollHwTqIDD4/ACToABmotJaj6nr3hHKa1DO
 ivctsJ0iA9FYksLfXUzDv2W1J5eilHoHJ62zzaHVlygQ==
X-Forward-Email-ID: 67cc7d1891daabb65c1b483f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8af199e4-90bb-4ad9-b0d3-84cf443b04bb@kwiboo.se>
Date: Sat, 8 Mar 2025 18:23:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
To: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
 detlev.casanova@collabora.com, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20250305194638.47187-1-ziyao@disroot.org>
 <20250307033508.656479-1-amadeus@jmu.edu.cn> <Z8qJqpUwi7VV8tJk@pie>
 <5a0a7ce1-1dfb-4d19-8a1e-0d89d177f5b8@kwiboo.se> <Z8xh2mE1BTE4co43@pie>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <Z8xh2mE1BTE4co43@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-03-08 16:27, Yao Zi wrote:
> Hi Jonas,
> 
> On Fri, Mar 07, 2025 at 07:45:00AM +0100, Jonas Karlman wrote:
>> Hi Chukun,
>>
>> On 2025-03-07 06:52, Yao Zi wrote:
>>> On Fri, Mar 07, 2025 at 11:35:08AM +0800, Chukun Pan wrote:
>>>> Hi,
>>>>
>>>>> +&sdmmc {
>>>>> +	bus-width = <4>;
>>>>> +	cap-mmc-highspeed;
>>>>> +	cap-sd-highspeed;
>>>>> +	disable-wp;
>>>>> +	no-sdio;
>>>>
>>>> With 'no-sdio' property:
>>>> [  129.608986] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>>>> [  130.711168] mmc1: Card stuck being busy! __mmc_poll_for_busy
>>>> [  130.725536] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
>>>> [  131.751240] mmc1: Card stuck being busy! __mmc_poll_for_busy
>>>> [  131.765608] mmc_host mmc1: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
>>>> [  132.825083] mmc1: Card stuck being busy! __mmc_poll_for_busy
>>>> [  132.839413] mmc_host mmc1: Bus speed (slot 0) = 187500Hz (slot req 187500Hz, actual 187500HZ div = 0)
>>>> [  133.960141] mmc1: Card stuck being busy! __mmc_poll_for_busy
>>>>
>>>> Without 'no-sdio' property:
>>>> [  105.224019] mmc1: error -22 whilst initialising SDIO card
>>>> [  106.290838] mmc1: Card stuck being busy! __mmc_poll_for_busy
>>>> [  106.801931] dwmmc_rockchip ffc30000.mmc: Busy; trying anyway
>>>> [  107.385835] mmc_host mmc1: Timeou sending command (cmd 0x202000 arg 0x0 status 0x80202000)
>>>> [  107.400425] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
>>>> [  107.431561] mmc_host mmc1: Bus speed (slot 0) = 49800000Hz (slot req 50000000Hz, actual 49800000HZ div = 0)
>>>> [  107.433107] mmc1: new high speed SDIO card at address 0001
>>>
>>> So it seems the sdmmc controller actually works with SDIO commands as
>>> well? I don't expect that since the datasheet says RK3528 has only two
>>> SDIO 3.0 controllers.
>>>
>>> We could remove the "no-sdio" property if SDIO actually works. Will
>>> apply it in the next version if there's no objection against this.
>>
>> On the E20C the sdmmc controller is routed to a microSD card slot mainly
>> intended for use with microSD-cards and should normally not need SDIO.
> 
> As pointed out by Chukun, I found the hardware design guide for
> RK3528[1] (in Chinese) does claim that SDIO 3.0 is supported on all
> these three controllers in Chapter 2.3.1 (SDMMC/SDIO),
> 
>   RK3528 集成了 1 个 SDMMC 控制器和 2 个 SDIO 控制器，均可支持 SDIO3.0 协
>   议，以及 MMC V4.51 协议。其中 SDIO0 和 SDIO1 最高可支持 200MHz，SDMMC
>   最高只支持到 150MHz
> 
> translated to English,
> 
>   RK3528 integrates one SDMMC controller and two SDIO controllers, all
>   support SDIO3.0 protocol and MMC V4.51 protocol. Among them SDIO0 and
>   SDIO1 support 200MHz frequency at maximum, and SDMMC supports up to
>   150MHz.
> 
> So I think there's no reason to explicitly deny SDIO initialization
> sequence for the controller on Radxa E20C. imho this won't break
> anything even for a sdcard slot, will it?

I have no strong opinion on this, just something I have done on a few
boards recently.

When sd/sdio/mmc controller is attached to a microSD card slot I add
no-sdio, when my uSD to eMMC adapter is not working I also add no-mmc.

Similar if the controller is attached to emmc, I add no-sd and no-sdio,
and if used for sdio wifi, I add no-sd and no-mmc.

Mostly to minimize initialization time when slot is unpopulated or card
or module is faulty.

Not sure how common it is to use a microSD to SDIO adapter, sound like
an uncommon edge case, possible by someone who would know how to create
and use a dt-overlay. I also do not think there will be a common use
case with a uSD to eMMC adapter, however that is something this board
vendor sell themself [3], so may be a slightly more likely use case.

[3] https://radxa.com/products/accessories/emmc-to-usd

Use of these no- props could possible be considered configuration
and not information about the board hw design, so I am torn and as
mentioned above, I have no strong opinion about keeping no-sdio or not.

> 
> Additionally, this piece of information points out that wrong
> max-frequency is set for SDIO{0,1}. Rockchip overrides the frequency in
> devicetrees for the demo boards[2], I'm not sure whether it's for some
> speical reason or not.
> 
> Since I don't have a SDIO-capable board on hand, could you please test
> whether 200MHz actually works? If so I'll correct the SoC devicetree in
> v3.

I would change to use default 200MHz as stated in the HW design guide.

Did a short boot test on my Sige1 board and the SDIO module can at
least be identified using 200 MHz:

  dwmmc_rockchip ffc10000.mmc: IDMAC supports 32-bit address mode.
  dwmmc_rockchip ffc10000.mmc: Using internal DMA controller.
  dwmmc_rockchip ffc10000.mmc: Version ID is 270a
  dwmmc_rockchip ffc10000.mmc: DW MMC controller at irq 35,32 bit host data width,256 deep fifo
  mmc_host mmc2: card is non-removable.
  mmc_host mmc2: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
  mmc_host mmc2: Bus speed (slot 0) = 198000000Hz (slot req 200000000Hz, actual 198000000HZ div = 0)
  dwmmc_rockchip ffc10000.mmc: Successfully tuned phase to 30
  mmc2: new UHS-I speed SDR104 SDIO card at address 0001
  brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43752-sdio for chip BCM43752/2
  brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac43752-sdio.armsom,sige1.bin failed with error -2
  brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac43752-sdio.bin failed with error -2
  brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50

  ~ # cat /sys/kernel/debug/mmc2/ios
  clock:          200000000 Hz
  actual clock:   198000000 Hz
  vdd:            21 (3.3 ~ 3.4 V)
  bus mode:       2 (push-pull)
  chip select:    0 (don't care)
  power mode:     2 (on)
  bus width:      2 (4 bits)
  timing spec:    6 (sd uhs SDR104)
  signal voltage: 1 (1.80 V)
  driver type:    0 (driver type B)

If it turns out to be any instability issues for a specific board using
default 200 MHz, such board can always define a lower max-frequency in
its board .dts-file.

Regards,
Jonas

> 
>> What card/adapter do you have inserted in the microSD card slot that
>> requires use of SDIO instead of just SD or MMC? What is the use case you
>> have that requires removal of no-sdio on E20C?
>>
>> Regards,
>> Jonas
>>
>>>
>>> Further tests about the capabilities of the controller are welcome.
>>>
>>>> # cat /sys/kernel/debug/mmc1/ios
>>>> clock:          50000000 Hz
>>>> vdd:            21 (3.3 ~ 3.4 V)
>>>> bus mode:       2 (push-pull)
>>>> chip select:    0 (don't care)
>>>> power mode:     2 (on)
>>>> bus width:      2 (4 bits)
>>>> timing spec:    2 (sd high-speed)
>>>> signal voltage: 0 (3.30 V)
>>>> driver type:    0 (driver type B)
>>>>
>>>> Thanks,
>>>> Chukun
>>>>
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>> Best regards,
>>> Yao Zi
>>
> 
> Thanks,
> Yao Zi
> 
> [1]: https://github.com/DeciHD/rockchip_docs/blob/main/rk3528/RK3528%20Hardware%20Design%20Guide-CN-V1.0-20230525.pdf
> [2]: https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3528-demo1-lp4-v10.dtsi#L47


