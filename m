Return-Path: <linux-kernel+bounces-528451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74960A417CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631971896E68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442A2191F6D;
	Mon, 24 Feb 2025 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oHtW+b+y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342523C393;
	Mon, 24 Feb 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387025; cv=none; b=jbRfuY/Uf4wT2ljnqwzM9jZJbqOEYqVAa7oknkxN8vw7HSMX1NJvXdRIBGsYklYnJE3vFViTO6KCfj3f5Y4mALe8RVzfrSJwmuMp4j9/ka7M+xybxlzIz9ti74dXiowhXIKxS+ZtiiTZda5AQMWzQR353/EMq0UaYSnffGZ31ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387025; c=relaxed/simple;
	bh=ImnSkDvCyNzWrsxhRq8yrR/K/8hCkVqMMnOSMPJSgKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEjNGPmo0438NlT0Qtzp/Aqgiy8nZ2KXvnkelB0s1e502qPDxUS39daIcsysRzZS5kZDa9V8YLYWmjkNzkt3ny8eprxlbtnUq0+GK53waXdqLrakinH5hxW1dSm9V9tDFQwMvfL2uGqF9p2SJm8eskR8HSBMvldU4Rt1Tnhd8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oHtW+b+y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740387022;
	bh=ImnSkDvCyNzWrsxhRq8yrR/K/8hCkVqMMnOSMPJSgKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oHtW+b+yNkL+q1CHUWFn0ieZHUza/61O+G4CcpW1+kGwZUKbRuylTrG1l/CQl9Y4n
	 EAbSEPdPGp2XDLmJLGbPR1NO2Y48alxQ6QJVFPqfTosGHpp2AckGElZBRbg4UBAfiJ
	 2CqRV8RmGsLlv8gxKaydQvvJeeNMvKo2FFIGEVK7xZbmO0RfotU/MvW8fbUlhf0PXq
	 jaAYtMim1zopKUeYWiwlMh06TwY76HEwRytSBH5koZu4XL3uD8d+1E3Jm4WiAz/Bdd
	 wFNwzuI+pNaQUKIjIT6TVgRUeFJQxOu0Wp0IfkKMGwGI9NPP2F06SFjj/+SyTqZC1c
	 RtoPpVsL5w/zA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5727617E001F;
	Mon, 24 Feb 2025 09:50:21 +0100 (CET)
Message-ID: <b37788f6-7aa6-46c6-993c-fa30fcaba4c9@collabora.com>
Date: Mon, 24 Feb 2025 09:50:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] MediaTek MT8188 MTU3 USB and Genio 510/700 TypeC
To: =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
Cc: =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
 <790ebe87fdaa8d785813a46269036562c405fb01.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <790ebe87fdaa8d785813a46269036562c405fb01.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/02/25 09:45, Chunfeng Yun (云春峰) ha scritto:
> Hi Angelo
> On Thu, 2025-02-20 at 11:55 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> This series adds MTU3 nodes to the MT8188 base devicetree, fixes the
>> Geralt Chromebooks to use it, and adds support for all of the USB
>> ports, including TypeC Power Delivery, Alternate Modes, etc, found
>> on the MediaTek Genio 510 and Genio 700 Evaluation Kits.
>>
>> This also adds the missing SuperSpeed port to the mtk-xhci binding.
>>
>> AngeloGioacchino Del Regno (3):
>>    dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP
>>    arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describe
>>      USB
>>    arm64: dts: mediatek: mt8390-genio-700: Add USB, TypeC Controller,
>> MUX
>>
>>   .../bindings/usb/mediatek,mtk-xhci.yaml       |   4 +
>>   .../boot/dts/mediatek/mt8188-geralt.dtsi      |  18 +++
>>   arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 121 +++++++++-----
>>   .../dts/mediatek/mt8390-genio-common.dtsi     | 151
>> +++++++++++++++++-
>>   4 files changed, 251 insertions(+), 43 deletions(-)
> Do these patch have also changed the chromebook's dts?

Yes

> 
> if changed it, do test it on chromebook?

Yes, and there's no need to hide the MTU3 hardware on Chromebooks,
as I already mentioned multiple times.

Just lock it to host mode and it's always fine :-)

Cheers,
Angelo

> 
> Thanks
> 
> 
>>
>> --
>> 2.48.1
>>


