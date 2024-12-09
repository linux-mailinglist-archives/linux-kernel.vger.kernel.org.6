Return-Path: <linux-kernel+bounces-437101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DAF9E8F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EDD1885E36
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753392165EB;
	Mon,  9 Dec 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gLAlzeCQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2092165E9;
	Mon,  9 Dec 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737774; cv=none; b=WdC3NCt77kfVeFpVG9SDtpRlzJ0goi/u5fifF3aRZ+SSQXrM5T19epbsi8NeYNVlB/0znlcSTs0wjd5+OTnB+4xacJ+YSuxAlFeRUcpwgSnj/wvq4/8xdEDdrTYIPQ6iNzYX+EfWE998QmzMXbB+iXrxmXOw8otdrWY2ZFxN4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737774; c=relaxed/simple;
	bh=vDVoR6QJHDbAwKUmHAbTLSwKdLlywl2nMTNdrlzT7ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8df98ccjrawouFShcTJtFkaK1UHBeTso5fcBIXHYE8YrKS5Abtf0HApPSpQFZHk+MlHbQSpTzWvqvNMOS0WNiaajWahEU5b0yoOgYR6M8gTXqcLd1tR+i81PJybmz9NYiGGJY5F5mvbrll4ovzUUM5I07IxOMdfYe3Wd/Wa4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gLAlzeCQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733737770;
	bh=vDVoR6QJHDbAwKUmHAbTLSwKdLlywl2nMTNdrlzT7ps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gLAlzeCQfkpTQp2EmlKFXooBQiBUryzCmDJjPB+gfcQaqEw9EgdVaJvhwctpQkX/J
	 Ob4ObKCYSBfEZ3dkPmuc9169HstBj8Ik0XVxy/ySYno8CqPJGYv60WspYpeKEoWNci
	 MrsJaNcevihSx7KjRvZH0SRmaI9Yt4Nl+pgIep0xDJZYhpyoJ+/Fm4Jlmq77RVkBjI
	 kmpgr6Ww4ESZP+Yr5sExjFYAKcqexK6sXrZm+aWPfdb4E/fcN5azk1XtffGLoF8cn7
	 GTpBsrD7cM8xOqhgz6HUMcTXtlXvEIy11dXbFRfJIryJtBZoQw1fZGF5cvK+M0xd/i
	 sdm6z27mHpq6Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F2EB17E3615;
	Mon,  9 Dec 2024 10:49:29 +0100 (CET)
Message-ID: <b5a77637-64b0-4ed3-9619-e76d094505af@collabora.com>
Date: Mon, 9 Dec 2024 10:49:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] drm/mediatek: mtk_hdmi_common: Assign DDC
 adapter pointer to bridge
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "jie.qiu@mediatek.com" <jie.qiu@mediatek.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "junzhi.zhao@mediatek.com" <junzhi.zhao@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
 <20241205114518.53527-14-angelogioacchino.delregno@collabora.com>
 <c0e144b3a90881066d0974157e66ac23f09a0fc5.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <c0e144b3a90881066d0974157e66ac23f09a0fc5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/12/24 09:17, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Thu, 2024-12-05 at 12:45 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> In preparation for adding the new HDMI TX v2 IP driver, assign the
>> pointer to the DDC adapter to struct drm_bridge during probe.
>>
>> This commit brings no functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> index 1b23ab6969ec..4f708b04f5e8 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> @@ -410,6 +410,7 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
>>          hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
>>          hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>>          hdmi->bridge.of_node = pdev->dev.of_node;
>> +       hdmi->bridge.ddc = hdmi->ddc_adpt;
> 
> I don't know why only v2 driver need to assign this?
> Could you point out the code where access this value?
> 

v2 uses hdmi helpers, which make use of bridge->ddc.
mtk_hdmi_v2_bridge_edid_read() calls drm_edid_read().

drm_edid.c -> drm_edid_read()
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/drm_edid.c?h=next-20241209#n2704

...while v1 feeds the (internal) ddc pointer to drm_edid_read_ddc() instead.

Cheers,
Angelo

> Regards,
> CK
> 
>>
>>          ret = devm_drm_bridge_add(dev, &hdmi->bridge);
>>          if (ret)
>> --
>> 2.47.0
>>
> 



