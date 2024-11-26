Return-Path: <linux-kernel+bounces-422037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3129D93A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1F1167BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6691B4129;
	Tue, 26 Nov 2024 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JateNvsE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95131A0BEE;
	Tue, 26 Nov 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611455; cv=none; b=D6N/HxJ4Ixm3xPnWYmyOYYeik8Lg3FUxC/8OCvvU7TBMkfT2uorGC8kNBKaWoXNOGAgowAtiDHIUXlyEbje0I2XHy0gjRQa/3qW8hLDGvRxT+qKj3EPY4t/bjPGw6OEkWxTcss7Fo0gb0J8722qBMG2A75IF/yGVvgzvnCbhc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611455; c=relaxed/simple;
	bh=xu1mpesbXHDe4ZbnZl7wZhH0nVldF/t4bC46HVCJJ9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/YE9Hx2CjSc5ebo1rJguLcAemUCKEKvajBECguO+RR+ag0euNCBO9o8Jrp+41YIQ1dizQ+F1HQcSOap/QPVnTZDIu3EHLkIqOlu5JlmDaN23Noe040kfx6hGougvFMctEP+pw/8rmdabZtiDDe7cZLNWwVBoAHfk2GgiDSPxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JateNvsE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732611451;
	bh=xu1mpesbXHDe4ZbnZl7wZhH0nVldF/t4bC46HVCJJ9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JateNvsEkisnZPfVx1ad1SH0szm2p5O7MLcKnO5dLra6JY2iGU0RPj/SD2ZypXTT5
	 lzcCSqNTo4uC7y10Hww/cEmRE58Cm2ooWTTjpM6Hn2pJukx4I7mLWEXlK3my3R8hMI
	 n/JdCMknyt7P0yQrVX793J4zQA46DEwRxhiVnjtoZpN4/zeV0LCsltxxBwc1LVD0ho
	 u2AcoRO5zcwyQAh3ABRGwOyPP6pIZ+X8oW9TorOo55BLO9X/v4l1UWMGWRQVmLEnRZ
	 PTUInkonFgJivtMqLLqEYUaxJ/XEH9/dUN/PaHAOpp9LoOtviCFou1gVfLRe8uA+iX
	 Px1lyoEC+a6LQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A4EB717E137D;
	Tue, 26 Nov 2024 09:57:30 +0100 (CET)
Message-ID: <4143b793-c5b1-4b6d-8547-26a9dc526957@collabora.com>
Date: Tue, 26 Nov 2024 09:57:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
 <133167aa2a3fab40547f5dc6602adf2c3d9e01e5.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <133167aa2a3fab40547f5dc6602adf2c3d9e01e5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/11/24 08:42, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Wed, 2024-11-20 at 13:45 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> Add support for the newer HDMI-TX (Encoder) v2 and DDC v2 IPs
>> found in MediaTek's MT8195, MT8188 SoC and their variants, and
>> including support for display modes up to 4k60 and for HDMI
>> Audio, as per the HDMI 2.0 spec.
>>
>> HDCP and CEC functionalities are also supported by this hardware,
>> but are not included in this commit.
> 
> Both MT8173 HDMI and MT8173 CEC has hot plug detection interrupt.
> I don't know why but MT8173 choose CEC to detect hot plug.
> 
> Does MT8195 CEC has hot plug detection interrupt?
> If it has, may we align the hot plug detection flow with MT8173?
> 

The CEC on MT8195 does have an hotplug detection interrupt, but that *must* be
used exclusively for CEC for one important reason.

While on MT8188 we only have the HDMI (TX) Encoder, MT8195 features both HDMI TX
and HDMI RX and in the specific case of this SoCs, the CEC block is shared between
the two controllers.

If we use the CEC hotplug detection for HDMI-TX, we wouldn't be able to share the
block with the HDMI-RX without hacks.

This is why we need to use the HTPLG/PORD provided by the HDMI-TX block instead of
the CEC one.

> This is not a strong suggestion because I don't know why MT8173 choose CEC to detect.
> I just want more function to be common.

Yeah, I got the point and I would've asked the same question, but for the reasons
that I explained, that's unfortunately not possible :-)

Cheers,
Angelo

> 
> Regards,
> CK
> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
>>




