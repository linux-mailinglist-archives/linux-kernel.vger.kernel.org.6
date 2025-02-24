Return-Path: <linux-kernel+bounces-529008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BED1A41EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5531889EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073E233713;
	Mon, 24 Feb 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z/8RGydi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31D219301;
	Mon, 24 Feb 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399416; cv=none; b=jNZHhKwVD6afn+dWvYr3B2N9R1e0WLyDA+IKqdUdTzQoa6vnthNIaDbdxEQPGnUPEbD1cvewfCrOZRo9rgDM/uKcEn5+ZV45/QGX5P9dLQMCGSPJFc6UFLcZsBDP1PMldHcIeGaqMXUonk6cjzxNTloFRMVLYNcm2GZih76X6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399416; c=relaxed/simple;
	bh=Y15ZhHu7iJ6ibqKhdC9DV8IKCHSBdZW414wrmaSvjaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxLWIWBPtVORJ1WG33dguNN2YLzExDLj++dGeHf63R7NTZtZrUIRHXm64egX3HS9E+a1OPSkOhSRHi3X0ruXco/WoLRnic1NGOlMWmfaH0qSGRxRaLHuEoD8aJ+WGAVGqhhX/PJ2t2HX/RTTJ0LCi1cklTGnCTY90CVRIJL3yeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z/8RGydi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740399412;
	bh=Y15ZhHu7iJ6ibqKhdC9DV8IKCHSBdZW414wrmaSvjaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z/8RGydiMIaU4nW0aucQVnOld8I6EDs6fJF5nbrLaiDbJ6y/7rjkEsVSm4uAWLmiB
	 QnkDqiA73KIG9bqh7Mo7hqY5uMYmh9r6xvbAfh2NG/XeG/B6djdCwc7KfPQ4xHT/TC
	 127MIVYEkRtBccJhFirtGLPi1rE9oyssDPtIXPl/DIZ2+fUHcZMP6HTNZvhfRQTMOi
	 KjusILL3zxuCLLoWcnJt1/R9aAFeQ29boM0W3BllfYRzmw1uehpP89yNYNa+PE8GjT
	 nmMZhBuX5UwIVhYFwfBgNhiHORSU8APTKLmCJjtWGsbkzfXHZvvkejx5hDgaJqiHDQ
	 bAmQIbXHd5DFg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 289C517E0DE7;
	Mon, 24 Feb 2025 13:16:52 +0100 (CET)
Message-ID: <faba9d7a-077d-4372-b4de-0f2da06d3418@collabora.com>
Date: Mon, 24 Feb 2025 13:16:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] usb: mtk-xhci: add support remote wakeup of mt8196
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
References: <20250215100615.808-1-chunfeng.yun@mediatek.com>
 <20250215100615.808-3-chunfeng.yun@mediatek.com>
 <7804ef70-efe7-476b-ae5e-bf665bfb4a47@collabora.com>
 <91de8a46de1f41462ea8aab138e47d75f11e17b9.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <91de8a46de1f41462ea8aab138e47d75f11e17b9.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/02/25 09:33, Chunfeng Yun (云春峰) ha scritto:
> On Tue, 2025-02-18 at 09:57 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 15/02/25 11:06, Chunfeng Yun ha scritto:
>>> There are three USB controllers on mt8196, each controller's wakeup
>>> control is different, add some specific versions for them.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>
>> Since all of the USB controllers of the MT8196 SoC are behind MTU3,
>> and
>> since the wakeup control for all of them will be handled by the MTU3
>> driver
>> and *not* by the xhci-mtk driver....
>>
>> NACK!
>>
>> Please drop this commit.
> Please help to pick up these patches, I also hate to add these specific
> wakeup ways, but our haredware designer do not follow the hwip rules
> sometimes.
> 

That makes this commit have sense, then.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Thank you.
> 
>>
>> Cheers,
>> Angelo
>>
>>> ---
>>> v3: no changes
>>> v2: modify marcos name
>>> ---
>>>    drivers/usb/host/xhci-mtk.c | 26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-
>>> mtk.c
>>> index 904831344440..3f8e37b25322 100644
>>> --- a/drivers/usb/host/xhci-mtk.c
>>> +++ b/drivers/usb/host/xhci-mtk.c
>>> @@ -113,6 +113,14 @@
>>>    #define WC1_IS_P_95         BIT(12)
>>>    #define WC1_IS_EN_P0_95             BIT(6)
>>>
>>> +/* mt8196 */
>>> +#define PERI_WK_CTRL0_8196   0x08
>>> +#define WC0_IS_EN_P0_96              BIT(0)
>>> +#define WC0_IS_EN_P1_96              BIT(7)
>>> +
>>> +#define PERI_WK_CTRL1_8196   0x10
>>> +#define WC1_IS_EN_P2_96              BIT(0)
>>> +
>>>    /* mt2712 etc */
>>>    #define PERI_SSUSB_SPM_CTRL 0x0
>>>    #define SSC_IP_SLEEP_EN     BIT(4)
>>> @@ -129,6 +137,9 @@ enum ssusb_uwk_vers {
>>>        SSUSB_UWK_V1_4,         /* mt8195 IP1 */
>>>        SSUSB_UWK_V1_5,         /* mt8195 IP2 */
>>>        SSUSB_UWK_V1_6,         /* mt8195 IP3 */
>>> +     SSUSB_UWK_V1_7,         /* mt8196 IP0 */
>>> +     SSUSB_UWK_V1_8,         /* mt8196 IP1 */
>>> +     SSUSB_UWK_V1_9,         /* mt8196 IP2 */
>>>    };
>>>
>>>    /*
>>> @@ -381,6 +392,21 @@ static void usb_wakeup_ip_sleep_set(struct
>>> xhci_hcd_mtk *mtk, bool enable)
>>>                msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) |
>>> WC0_IS_P_95;
>>>                val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) :
>>> 0;
>>>                break;
>>> +     case SSUSB_UWK_V1_7:
>>> +             reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8196;
>>> +             msk = WC0_IS_EN_P0_96;
>>> +             val = enable ? msk : 0;
>>> +             break;
>>> +     case SSUSB_UWK_V1_8:
>>> +             reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8196;
>>> +             msk = WC0_IS_EN_P1_96;
>>> +             val = enable ? msk : 0;
>>> +             break;
>>> +     case SSUSB_UWK_V1_9:
>>> +             reg = mtk->uwk_reg_base + PERI_WK_CTRL1_8196;
>>> +             msk = WC1_IS_EN_P2_96;
>>> +             val = enable ? msk : 0;
>>> +             break;
>>>        case SSUSB_UWK_V2:
>>>                reg = mtk->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>>>                msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
>>
>>
>>

