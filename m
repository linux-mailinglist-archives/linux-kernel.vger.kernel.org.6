Return-Path: <linux-kernel+bounces-519013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C198A39712
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978541896A53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1446232368;
	Tue, 18 Feb 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qX5QQxHI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3423027C;
	Tue, 18 Feb 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870824; cv=none; b=XXzT60GfeXO7fI+qzw6gdKqqel1OCWfTDM5Zev/7LXlIl0mEN8KEKuufye/nmphxLSvtTL+PraCfJf5A1dl2unjOvnSX7nKpjsB+htt0i5FoC0JkgwGA8tMdUY4BDWaHMqmFKS7b70ItQ0Y1V9eIO6GiUt28LEvkGw0pt7HrT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870824; c=relaxed/simple;
	bh=13RAFqO4JxKpY86E13TVG4O698Z/xjNecRvH9AgjNaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbXrZ9xNsAPqIhPLRGI0ZzKc+aMs4phoWjMPFU95O0oChKHAQ5+9fG/HB5N4D0EnKPZ1TO3Rql+eacRm29R62Z2V+qzFlpyZetpe4UxCLk0WkykHuYi8Qc21cmLzfGQo3vYEDjq9C2QeXz7ROIYyQX9qNsfM5PG9PvAL95GBYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qX5QQxHI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739870820;
	bh=13RAFqO4JxKpY86E13TVG4O698Z/xjNecRvH9AgjNaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qX5QQxHIowTOTnz9Li60/jzpzEyrmVKngsv1UdK5BflNfVIsKlkYXPG7WDiqBtW0N
	 wrlwfNZICsMYgYLLCSDCZFgoggqWPGoNAzQNV12S1LSHlQdA7zF+X5A+PMDUAFnfN9
	 UP6nY/ePSd7y/OWZAQHdvs3CvlriheHERJNRRwawHDev7Ij+DEltRFnDLwEC9HpdbS
	 W7Gaa/kPKTVIoHDN79HMcjiz9A28S92w9F2kejmJVPjqsVVytQ9iMbpyPkPsR/XaXP
	 melHDDbYycMbcLfXgf+kh+GIi4/QYUOWSq5WrWX/11u/L8rBITZ6U2NKD3pjt3xCHE
	 QEyqpJK0Qc49A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 34DE217E0391;
	Tue, 18 Feb 2025 10:27:00 +0100 (CET)
Message-ID: <a286cb5c-40f8-48ec-921d-bcf0b67728ed@collabora.com>
Date: Tue, 18 Feb 2025 10:26:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] usb: mtu3: add support remote wakeup of mt8196
To: =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>
References: <20250121145008.22936-1-chunfeng.yun@mediatek.com>
 <20250121145008.22936-4-chunfeng.yun@mediatek.com>
 <e63fdeba-04dd-4b88-a6d6-ca8a64e28e36@collabora.com>
 <a689f7d25fb05ba83ac2de6ba879998fe2e21bcb.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a689f7d25fb05ba83ac2de6ba879998fe2e21bcb.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/02/25 04:31, Chunfeng Yun (云春峰) ha scritto:
> On Wed, 2025-01-22 at 10:30 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 21/01/25 15:50, Chunfeng Yun ha scritto:
>>> There are three USB controllers on mt8196, each controller's wakeup
>>> control is different, add some specific versions for them.
>>> Here add only for dual-role controllers.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>
>>   From the datasheets, I can read the following:
>>
>> IP0: host -> 0x1670_0000  device(mtu3) -> 0x1670_1000
>> IP1: host -> 0x1671_0000  device(mtu3) -> 0x1671_1000
>> IP2: host -> 0x1672_0000  device(mtu3) -> 0x1672_1000
>>
> I'll check it.
> 
>> ...this means that you're missing the IP2 here, which you did not
>> miss in the
>> commit adding the wakeup control in mtk-xhci instead.
>>
>> So, since I see that all of the USB IPs are behind MTU3, and that
>> there is no
>> USB IP that does *not* support gadget mode (so, there's no USB IP
>> that does NOT
>> support MTU3), you shall add all three here, and you shall drop the
>> commit that
>> adds the wakeup control in mtk-xhci entirely.
> No, I'll still add them in mtk-xhci driver as before for the cases that
> only use xhci only, no need use mtu3 driver.
> 
> As I said before, event the controller supports dual-role mode, which
> don't mean that it can use this upstream mtu3 driver, some SoC have
> limitation and can't support the dual-role mode switch used in upstream
> driver. but all SoC can use upstream xhci-mtk driver. that why I add
> some SoC's wakeup control in xhci-mtk, but not in mtu3 driver.
> 
>>
>> This is because there will be no DT node declaring only XHCI.
>>
>> Since after the proposed change all controllers will be MTU3 -> XHCI,
>> there's
>> no need to add the same in the mtk-xhci driver.
> I think it's better to leave the selection to the customer, for
> example, on chromebook, we only use xhci driver and do not enable mtu3.
> 

Chromebooks can use MTU3 and lock it in HOST mode only.

The MTU3 hardware is there - don't hide it.

Regards,
Angelo

> Thanks
> 
>>
>> Cheers,
>> Angelo
>>
>>> ---
>>> v2: add wakeup for dual-role controllers
>>> ---
>>>    drivers/usb/mtu3/mtu3_host.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/usb/mtu3/mtu3_host.c
>>> b/drivers/usb/mtu3/mtu3_host.c
>>> index 7c657ea2dabd..d65b0f318436 100644
>>> --- a/drivers/usb/mtu3/mtu3_host.c
>>> +++ b/drivers/usb/mtu3/mtu3_host.c
>>> @@ -46,6 +46,11 @@
>>>    #define WC1_IS_P_95         BIT(12)
>>>    #define WC1_IS_EN_P0_95             BIT(6)
>>>
>>> +/* mt8196 */
>>> +#define PERI_WK_CTRL0_8196   0x08
>>> +#define WC0_IS_EN_P0_96              BIT(0)
>>> +#define WC0_IS_EN_P1_96              BIT(7)
>>> +
>>>    /* mt2712 etc */
>>>    #define PERI_SSUSB_SPM_CTRL 0x0
>>>    #define SSC_IP_SLEEP_EN     BIT(4)
>>> @@ -59,6 +64,8 @@ enum ssusb_uwk_vers {
>>>        SSUSB_UWK_V1_3,         /* mt8195 IP0 */
>>>        SSUSB_UWK_V1_5 = 105,   /* mt8195 IP2 */
>>>        SSUSB_UWK_V1_6,         /* mt8195 IP3 */
>>> +     SSUSB_UWK_V1_7,         /* mt8196 IP0 */
>>> +     SSUSB_UWK_V1_8,         /* mt8196 IP1 */
>>>    };
>>>
>>>    /*
>>> @@ -100,6 +107,16 @@ static void ssusb_wakeup_ip_sleep_set(struct
>>> ssusb_mtk *ssusb, bool enable)
>>>                msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) |
>>> WC0_IS_P_95;
>>>                val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) :
>>> 0;
>>>                break;
>>> +     case SSUSB_UWK_V1_7:
>>> +             reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8196;
>>> +             msk = WC0_IS_EN_P0_96;
>>> +             val = enable ? msk : 0;
>>> +             break;
>>> +     case SSUSB_UWK_V1_8:
>>> +             reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8196;
>>> +             msk = WC0_IS_EN_P1_96;
>>> +             val = enable ? msk : 0;
>>> +             break;
>>>        case SSUSB_UWK_V2:
>>>                reg = ssusb->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>>>                msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
>>
>>
>>



