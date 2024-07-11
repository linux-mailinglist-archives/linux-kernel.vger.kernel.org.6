Return-Path: <linux-kernel+bounces-249453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D6092EBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B876B285856
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607F16C856;
	Thu, 11 Jul 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I1RFhTyJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0618479;
	Thu, 11 Jul 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712849; cv=none; b=QgwQkUS0lWIdJYCmgJYjJ0Fh2EygKdr4GzgU5M1fqsyhD9x3iF+cRUCH0eGyE7D+/C9Id7p9IxYquFmfy3DH8YuaMkIPkGWRMXgGB4KOINxN5nnaX1YrYov52xN+32uVWO188OlxIIJyVTqy0S9SDBYOs00FVbvwgZiJGHjThjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712849; c=relaxed/simple;
	bh=L+LYclixtCcrtlqbI+TdhTA4XOTPSUYDQzsfnwjFUJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gL6oRab9ROmV7jM9ER4gpe7xG5/QxGF1oUjZEcDO+cD2KvrYI6PGY2cHAriJTBwV9bAtj8bzQS8+LVF5jHfhg3qEGuANIL2Kr2HCxljr+kACFwn8H6I5UKLsJ2d/tAwnZpydRD6EcyY2oRK+EJx4d8ywQb1WxoFZhf2MCEsnAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I1RFhTyJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720712846;
	bh=L+LYclixtCcrtlqbI+TdhTA4XOTPSUYDQzsfnwjFUJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I1RFhTyJH74XM5imDRCJNROAmCZgab1GXYa2MWRxwmRrHCozts5rTL0A0IYQsdxsk
	 stdikU3aRtK6JUZzo9eBZpz7v9mupwSECQO7BUqWdhsa+PuEVfNj5CI/5qYfJHheiV
	 6rk1rUuIhsdsk269Kb6VEA6P+t2ssW7YFOlZLGtSJ9eDkpQBmyFjhUqYGbes4b3DSR
	 jl1SSKKXZiDhmkyadI+/TrUGWa2RsjuSHn+wybOsfRhG+F96b7xGUsti7d2zfCKyUy
	 R+a4h+TaWN2Tw0XsoiP3DW+guDEhXvQ1KhjyXbqdTMeigN92JCT6IRig/u2GU0DlBv
	 nDjDrwTafHbCg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5426F3782207;
	Thu, 11 Jul 2024 15:47:25 +0000 (UTC)
Message-ID: <f9e2605d-3931-4b59-81e9-8fe9329f05cb@collabora.com>
Date: Thu, 11 Jul 2024 17:47:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add power domain to
 secondary XHCI
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, tinghan.shen@mediatek.com,
 seiya.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org
References: <20240711093230.118534-1-angelogioacchino.delregno@collabora.com>
 <4ac0e464-5ef6-445d-a784-fe367ea23a2d@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <4ac0e464-5ef6-445d-a784-fe367ea23a2d@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 11/07/24 17:00, Nícolas F. R. A. Prado ha scritto:
> On Thu, Jul 11, 2024 at 11:32:30AM +0200, AngeloGioacchino Del Regno wrote:
>> The secondary XHCI controller, using a PHY that is shared between
>> it and the secondary PCI-Express controller, gets powered by the
>> PCIE_MAC_P1 power domain.
>>
>> Add this power domain to the usb@11290000 node to fix probe.
>>
>> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
>> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Hi Angelo,
> 
> thanks for the patch, but unfortunately it doesn't fix the issue:
> 
> [   10.772128] mtk-pcie-gen3 112f8000.pcie: host bridge /soc/pcie@112f8000 ranges:
> [   10.788914] mtk-pcie-gen3 112f8000.pcie:       IO 0x0024000000..0x00241fffff -> 0x0024000000
> [   10.802111] mtk-pcie-gen3 112f8000.pcie:      MEM 0x0024200000..0x0027ffffff -> 0x0024200000
> [   10.941278] mtk-pcie-gen3 112f8000.pcie: PCI host bridge to bus 0000:00
> 
> [   10.785937] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
> [   10.796352] xhci-mtk 11290000.usb: xHCI Host Controller
> [   10.810530] xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
> [   10.844258] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> [   10.844262] xhci-mtk 11290000.usb: can't setup: -110
> [   10.844266] xhci-mtk 11290000.usb: USB bus 5 deregistered
> [   10.861969] xhci-mtk 11290000.usb: probe with driver xhci-mtk failed with error -110
> 
> In fact it seems to have made the issue more frequent, as it happened every time
> for the 5 boots I tried.
> 

Oddly this did fix the issue on my Tomato R3.... but there's clearly something else
that is going on.

Let's keep trying.

Thanks!
Angelo

> But that gives me idea to try booting with clk_ignore_unused and
> pd_ignore_unused. I'll update the report with the results.
> 
> Thanks,
> Nícolas
> 
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> index 2ee45752583c..96ad1b14626e 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> @@ -1445,6 +1445,7 @@ xhci1: usb@11290000 {
>>   			reg-names = "mac", "ippc";
>>   			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
>>   			phys = <&u2port1 PHY_TYPE_USB2>;
>> +			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
>>   			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
>>   					  <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
>>   			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
>> -- 
>> 2.45.2
>>



