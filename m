Return-Path: <linux-kernel+bounces-267132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF5940D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6F71C21350
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555EC194133;
	Tue, 30 Jul 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="t4I8lzRx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4546190053;
	Tue, 30 Jul 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330606; cv=none; b=GscSo5F/QdIFKQtCr+t7qtMXVF9V8ID5aggkFLP3gIczpt6SIf8awpij0T5uFQn+j30HXro0s2MBGNaqcFLY55flAsFQnftqvejDxTBGAdzivZRGeAKFF28soTHQ+LfVsPpMAQJ/BXSY6+GCyWsxu160uiEGSEWRrLMnUFutzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330606; c=relaxed/simple;
	bh=g5zASnwUhqABB8AiTnlNqyPjhXEMSOhFOC44f1Jxv/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obRFnN79TpYhv0GwqUW6IBPzEVhLa3YIZ4LSAzBzUZStPZ4MvgkoZ5gRdKsH6rnXnn2+s8b/WPzqTedSsCxWwrrwN/FkEKBPm0vh/SX3Px7Qx2akVTpi928tWeBqrXYq2h+951NnR98n8ZDY9czueUgsECDyjVw/mVa3ZyP+ndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=t4I8lzRx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722330601;
	bh=g5zASnwUhqABB8AiTnlNqyPjhXEMSOhFOC44f1Jxv/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t4I8lzRxaNhVGQAl3kwBSHOhMik/SZSlcUHGdpHApo3Snaw6tBcBArZS2LbCTN7L4
	 utg0qHx1jxKLL8K06zXvO/lBPnDwfIn0gSMy9gxdxO6sL0K/VUmQBmej+M6l9Tmirj
	 +kcdTkLaw91nJGCnbzidpRgpSekyLDVPtSG1+TPL+0bFeEoPqkQ2c8svGpLcaMfdBE
	 siubDkNhMf/VU+LWuoxHUldvThoC/u46WOlixGLRgVqeXTjvEMK6NKkzu4LctfpGnO
	 82vw8CbV3dchg8L2ZvMoc39WVb1oGZT558FlchHoIp2jKWfM9YYFl7MlGZN17KFt8Y
	 S1ic020JLJitw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8C0F23780BC9;
	Tue, 30 Jul 2024 09:10:00 +0000 (UTC)
Message-ID: <c6400b3c-109b-4f40-9163-88ae2b53c73b@collabora.com>
Date: Tue, 30 Jul 2024 11:09:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add missing clock for xhci1
 controller
To: Chen-Yu Tsai <wenst@chromium.org>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Macpaul Lin <macpaul.lin@mediatek.com>
References: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
 <CAGXv+5H_pxR18sHeqdWPy9_FARrnLwyyOHV4VXCn9p5OExseiQ@mail.gmail.com>
 <f12ba385-090b-4772-8c52-e515e25b00ac@collabora.com>
 <CAGXv+5G92=-k5MDH4BPcM8tgPwcGTJ60trJwr7BwTGHD=wpnDw@mail.gmail.com>
 <51f0f4f3-11a5-4d74-981e-3f24f8475c7f@collabora.com>
 <CAGXv+5F-U6O3dQdU2L8bR5V+D=PLreACZYCh5sxBY3PFrex1zg@mail.gmail.com>
 <de0b0daa-2a35-4286-b4db-4f646073a04c@collabora.com>
 <CAGXv+5EvzRr8h5vnuV2h=zkVwkVp3fShDP_45BpaO0HkivuDtQ@mail.gmail.com>
 <c3e38dae-646f-471a-ae40-150b8f86cac0@collabora.com>
 <be8a0047-3a37-4e25-b4aa-ab34adff4418@notapiano>
 <CAGXv+5EybBNiapMDcnvW5kMKm_ig8kta6-XsGYAFss8EOyKCCg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5EybBNiapMDcnvW5kMKm_ig8kta6-XsGYAFss8EOyKCCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 30/07/24 06:17, Chen-Yu Tsai ha scritto:
> On Tue, Jul 30, 2024 at 2:14 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>> On Mon, Jul 29, 2024 at 02:34:27PM +0200, AngeloGioacchino Del Regno wrote:
>>> Il 29/07/24 12:48, Chen-Yu Tsai ha scritto:
>>>> On Mon, Jul 29, 2024 at 4:54 PM AngeloGioacchino Del Regno
>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>
>>>>> Il 29/07/24 10:07, Chen-Yu Tsai ha scritto:
>>>>>> On Mon, Jul 29, 2024 at 3:59 PM AngeloGioacchino Del Regno
>>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>>
>>>>>>> Il 26/07/24 17:11, Chen-Yu Tsai ha scritto:
>>>>>>>> On Fri, Jul 26, 2024 at 8:11 PM AngeloGioacchino Del Regno
>>>>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>>>>
>>>>>>>>> Il 25/07/24 12:34, Chen-Yu Tsai ha scritto:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On Mon, Jul 22, 2024 at 11:27 PM Nícolas F. R. A. Prado
>>>>>>>>>> <nfraprado@collabora.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Currently if the xhci1 controller happens to probe before the pcie1
>>>>>>>>>>> controller then it fails with the following errors:
>>>>>>>>>>>
>>>>>>>>>>> xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
>>>>>>>>>>> xhci-mtk 11290000.usb: can't setup: -110
>>>>>>>>>>> xhci-mtk: probe of 11290000.usb failed with error -110
>>>>>>>>>>>
>>>>>>>>>>> The issue has been tracked down to the CLK_INFRA_AO_PCIE_P1_TL_96M
>>>>>>>>>>> clock, although exactly why this pcie clock is needed for the usb
>>>>>>>>>>> controller is still unknown. Add the clock to the xhci1 controller so it
>>>>>>>>>>> always probes successfully and use a placeholder clock name for it.
>>>>>>>>>>>
>>>>>>>>>>> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
>>>>>>>>>>> Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
>>>>>>>>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>>>>>>>
>>>>>>>>>> So I asked MediaTek about this, and it seems the correct thing to do is
>>>>>>>>>> disable USB 3 on this host controller using the following snippet. The
>>>>>>>>>> snippet is copy-pasted from our issue tracker and won't apply directly.
>>>>>>>>>>
>>>>>>>>>> This is also seen in mt8395-kontron-3-5-sbc-i1200.dts, on which xhci1
>>>>>>>>>> is used only for USB 2.0 on an M.2 slot.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Uhm, okay, but why should USB3 be disabled on a controller that supports USB3?
>>>>>>>>>
>>>>>>>>> I agree about disabling it on specific boards that use only the USB 2.0 lines of
>>>>>>>>> this controller, but doing that globally looks wrong... and looks like being a
>>>>>>>>> workaround for an error that gets solved with adding a clock as well.
>>>>>>>>>
>>>>>>>>> In short, the question is: why would that be the correct thing to do?
>>>>>>>>
>>>>>>>> We can disable it in mt8195-cherry.dtsi then?
>>>>>>>
>>>>>>> That device does not use this controller, so yes we can disable it, but that still
>>>>>>> doesn't resolve the issue pointed out by Nicolas...!
>>>>>>
>>>>>> No. I mean disable USB3 on this port. Also see the next paragraph.
>>>>>>
>>>>>
>>>>> Yes, sorry I was meaning the same - but I effectively wrote "disable controller"
>>>>> instead, my bad.
>>>>>
>>>>>>> Please note that the issue that he sees doesn't happen only on Tomato, but also on
>>>>>>> other MediaTek MT8195/MT8395 boards - and applying this commit makes disabling the
>>>>>>> controller, or disabling the USB 3 lines on the controller, kinda redundant, as
>>>>>>> this will effectively fix probing it... but again, fixing the actual issue with
>>>>>>> this controller is something that must be done.
>>>>>>
>>>>>> If those other boards use the XHCI1 USB3 lines for ... USB3, then the USB3
>>>>>> PHY should also be tied to XHCI1, right now due to the Cherry Chromebook
>>>>>> design, only the USB2 PHY is tied to it.
>>>>>>
>>>>>
>>>>> Yes, I am aware of that.
>>>>>
>>>>>>> Disabling the controller on Tomato is a different topic - here we are discussing
>>>>>>> about fixing the issue, and that will happen, again, on any board that has this
>>>>>>> controller enabled with USB3 lines. :-)
>>>>>>>
>>>>>>> So, unless there is any specific reason for which applying this commit is a bad
>>>>>>> idea, or any alternative fix to this that is better than the proposed one, and
>>>>>>> not a workaround... I'm applying this one.
>>>>>>
>>>>>> Didn't I just relay what MediaTek says is the correct fix? Disable USB3
>>>>>> for this port on devices where the serial pairs are used for PCIe instead
>>>>>> of USB3.
>>>>>>
>>>>>
>>>>> I think there must've been some misunderstanding here.
>>>>>
>>>>> Yes you did relay what MediaTek is the correct fix, and I agree that the USB3 must
>>>>> be disabled on devices where those serial pairs are used for PCIe instead of USB,
>>>>> or on devices where those are completely unused.
>>>>
>>>> OK. I will send a patch for Tomato as you asked.
>>>>
>>>>> This, though, will fix the issue only on those devices (because we are disabling
>>>>> those lines entirely, so depending on how we see it, this might not be a fix but
>>>>> rather a workaround).
>>>>
>>>> I would say that is a more accurate description of the hardware, so a fix.
>>>>
>>>
>>> I can accept a patch for Tomato with a Fixes tag. Yes.
>>>
>>>>> If we don't apply this fix, any board that uses those pairs for USB 3 instead will
>>>>> still show the same "clocks are not stable" error, leaving them with a broken port.
>>>>>
>>>>> And I believe that because the clocks are not routed externally but rather are
>>>>> internal to the SoC, so, if INFRA_AO_PCIE_P1_TL_96M is necessary for that USB 3
>>>>> port to work, a board that intends to use those pairs for USB3 would still need
>>>>> this exact clock to actually get that port to work.
>>>>
>>>> I couldn't reproduce the issue by disabling pcie1 as Nicolas mentioned.
>>>> I don't have any more to add to this though. Sorry for the noise.
>>
>> Huh, that's surprising. FWIW I just reproduced with kernel next-20240729,
>> upstream defconfig (besides a CONFIG_USB_ONBOARD_DEV=n to be able to boot from
>> my USB drive), and the pcie1 node in mt8195-cherry.dtsi disabled. Hardware is
>> mt8195-cherry-tomato-r2.
>>
>> Also, I just tested adding
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> index fe5400e17b0f..a60c4d1419df 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> @@ -1401,6 +1401,7 @@ &xhci0 {
>>   &xhci1 {
>>          status = "okay";
>>
>> +       mediatek,u3p-dis-msk = <0x1>;
>>          rx-fifo-depth = <3072>;
>>          vusb33-supply = <&mt6359_vusb_ldo_reg>;
>>          vbus-supply = <&usb_vbus>;
>>
>> And that fixed the issue as well. So as far as fixing the error on Tomato, this
>> patch works too, and makes more sense.
> 
> Could you also try adding the USB3 PHY instead of disabling U3 on the
> controller? As:
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 2ee45752583c..61b3c202a8cd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1444,7 +1444,7 @@ xhci1: usb@11290000 {
>                                <0 0x11293e00 0 0x0100>;
>                          reg-names = "mac", "ippc";
>                          interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
> -                       phys = <&u2port1 PHY_TYPE_USB2>;
> +                       phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1
> PHY_TYPE_USB3>;
>                          assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
>                                            <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
>                          assigned-clock-parents = <&topckgen
> CLK_TOP_UNIVPLL_D5_D4>,
> 
> I wanted to test this, but I couldn't actually reproduce the error.
> 
>> However I agree with Angelo that a board that does use USB3 on this controller
>> would still need the original patch adding the PCIE clock to work. But such a
>> board doesn't currently exist, does it? And we don't actually know if USB3
>> really works in that case. Or why this clock is needed. So there are a few
>> unknowns...
> 
> MacPaul seems to have one. He mentioned to me that he doesn't need the patch
> adding the PCIE clock, but needs "mediatek,force-mode" instead.
> 
> Looking at the comments around "mediatek,force-mode" in the driver, it
> seems that the PHY defaults to PCIe mode. A combination of not initializing
> the PHY to USB3 and turning on the PCIe related clock might be what is
> allowing the PHY to respond to the controller? This is just a guess though.
> 

I was just about to pick this patch, but now with this comment making a lot of
sense... I'm not sure that picking this is the right thing to do anymore :-)

Nicolas, can you please check if "mediatek,force-mode" makes it to work without
said clock?

If it works, this means that the PHY driver (or something else) is, and has always
been, at fault - so there's a bug elsewhere and must be fixed.

Cheers,
Angelo

>> Anyway, I really don't know what option would be better. Just let me know if I
>> should resend a patch or CC me in any alternative patch.
> 
> I'll send the patches to fix up pure USB2 usage. Given we have conflicting
> reports on whether the PCIe clock is needed, I ask that you try the PHY
> assignment change first.
> 
> 
> Thanks
> ChenYu
> 
>> Thanks,
>> Nícolas
>>
>>>>
>>>
>>> Sometimes the noise actually opens some eyes around (be it mine or whoever else's),
>>> so as long as it is constructive, I don't see it as noise.
>>>
>>> In short: no worries! :-)
>>>
>>>>> As for Tomato itself - I agree that we must add the u3p-dis-msk=0x1 flag, yes,
>>>>> and we will, but I'm purely talking about - again - an eventual board that would
>>>>> not have that property because USB3 is exposed/used for real.
>>>>
>>>> I think it would make more sense to fix the `phys = ` statement in mt8195.dtsi
>>>> to list both the USB2 and USB3 PHYs. At the board level, for boards only
>>>> using USB2, we would have the overriding `phys = ` statement alongside the
>>>> `mediatek,u3p-dis-mask` property. Does that make sense to you?
>>>>
>>>
>>> Yeah, that'd make sense, though I'm not sure if the driver can cope with that: in
>>> that case, we'd obviously need "two" patches and not one :-)
>>>
>>> Cheers!
>>>
>>>>
>>>> Thanks
>>>> ChenYu
>>>>
>>>>> Cheers,
>>>>> Angelo
>>>>>
>>>>>>
>>>>>> Regards
>>>>>> ChenYu
>>>>>>
>>>>>>> Cheers,
>>>>>>> Angelo
>>>>>>>
>>>>>>>>
>>>>>>>> ChenYu
>>>>>>>>
>>>>>>>>> Cheers,
>>>>>>>>> Angelo
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> ChenYu
>>>>>>>>>>
>>>>>>>>>> index 8b7307cdefc6..2dac9f706a58
>>>>>>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>>>>> @@ -1447,6 +1447,7 @@
>>>>>>>>>>                                            "xhci_ck";
>>>>>>>>>>                              mediatek,syscon-wakeup = <&pericfg 0x400 104>;
>>>>>>>>>>                              wakeup-source;
>>>>>>>>>> +                       mediatek,u3p-dis-msk = <0x1>;
>>>>>>>>>>                              status = "disabled";
>>>>>>>>>>                      };
>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>       arch/arm64/boot/dts/mediatek/mt8195.dtsi | 10 ++++++++--
>>>>>>>>>>>       1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>>>>>> index 2ee45752583c..cc5169871f1c 100644
>>>>>>>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>>>>>> @@ -1453,9 +1453,15 @@ xhci1: usb@11290000 {
>>>>>>>>>>>                                       <&topckgen CLK_TOP_SSUSB_P1_REF>,
>>>>>>>>>>>                                       <&apmixedsys CLK_APMIXED_USB1PLL>,
>>>>>>>>>>>                                       <&clk26m>,
>>>>>>>>>>> -                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>;
>>>>>>>>>>> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
>>>>>>>>>>> +                                /*
>>>>>>>>>>> +                                 * This clock is required due to a hardware
>>>>>>>>>>> +                                 * bug. The 'frmcnt_ck' clock name is used as a
>>>>>>>>>>> +                                 * placeholder.
>>>>>>>>>>> +                                 */
>>>>>>>>>>> +                                <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>;
>>>>>>>>>>>                              clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
>>>>>>>>>>> -                                     "xhci_ck";
>>>>>>>>>>> +                                     "xhci_ck", "frmcnt_ck";
>>>>>>>>>>>                              mediatek,syscon-wakeup = <&pericfg 0x400 104>;
>>>>>>>>>>>                              wakeup-source;
>>>>>>>>>>>                              status = "disabled";
>>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>> base-commit: dee7f101b64219f512bb2f842227bd04c14efe30
>>>>>>>>>>> change-id: 20240722-usb-1129-probe-pci-clk-fix-ef8646f46aac
>>>>>>>>>>>
>>>>>>>>>>> Best regards,
>>>>>>>>>>> --
>>>>>>>>>>> Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>>>
>>>


