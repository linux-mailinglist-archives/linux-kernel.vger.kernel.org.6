Return-Path: <linux-kernel+bounces-437135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063B99E8F83
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293FE1884D2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6852165EE;
	Mon,  9 Dec 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kncwX2M3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20342163A1;
	Mon,  9 Dec 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738183; cv=none; b=gJQ/JE6mC0/CiN6B3X4RhABsFu+6nivc4f9c71ETXIhWQTMjUDpzEezCxFuY9XXIirtKO9z9vXbjWXZ0GFIAZkdCFqrKxYRauTBaedpsjqPbFQt272CiF/yeNAewzYEwaKVzMBIB39UrWp1MZaso18UEDlfo1bLyMMxViQekW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738183; c=relaxed/simple;
	bh=nplaTSeRl93wINz5j7eOZBcNUOXjUDq4lRiwbGpfj40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+L2tXx+zRnBJrc4i9b7FtVOTsQ+WopNW1bqZjK0tKnjFSTXOJqRn8HkniXi2M2AKBOhmBzvdy8MIabg8gy8sNgQooJpGWf1ntCP/5dS0szE4xyOVGe5J3YZAEHTjMSZxN92/epTTwSyyEibOqPeRRkCtgmZem2UzUevmOvLsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kncwX2M3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733738179;
	bh=nplaTSeRl93wINz5j7eOZBcNUOXjUDq4lRiwbGpfj40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kncwX2M3cPzLj6tuhX7ozxLhSdFfurogINElznEJ+g7f7tM+P/eAKGHnGdO2vorCe
	 kxwU0+7WBu5ArBUSqC1m2Dw3O4Sso6GqPmeEIpalobzZylB+DhBy21U/t08dNFp3Sr
	 /4Wq/zD66z4WoCiWWsukZ0kzobBxXBa01prLQckoMIW42CkAqpLlrBNs76s6oU7km2
	 4/MHePcpGQHbePjsuT6w20n/C75bZwq1KTCamUDBDZMwBSiWpPeCRNzVsxqjXXduC7
	 s6yJULljut9HnPmo0aL3ALBzSm3uVlAh52VJ94o2UBwtGWqvtnODK9DxUFdphpoWRq
	 aItkqqgKTO5yA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8140817E3624;
	Mon,  9 Dec 2024 10:56:18 +0100 (CET)
Message-ID: <7a4f8b11-e840-4e33-a6e7-4f58601ed31c@collabora.com>
Date: Mon, 9 Dec 2024 10:56:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] drm/mediatek: mtk_hdmi_common: Add OP_HDMI,
 vendor and product strings
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
 <20241205114518.53527-15-angelogioacchino.delregno@collabora.com>
 <6697eef88677950d36fbfbd6676f82f291621159.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <6697eef88677950d36fbfbd6676f82f291621159.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/12/24 10:09, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Thu, 2024-12-05 at 12:45 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> In preparation for adding the HDMI TX v2 driver, and to allow
>> a future modernization of the HDMI v1 one, perform changes
>> that enable the usage of the HDMI Helpers provided by DRM.
>>
>> Check if the HDMI driver provides the function pointers to
>> hdmi_{clear,write}_infoframe used by the HDMI Helper API and,
>> if present, add DRM_BRIDGE_OP_HDMI to the drm_bridge ops,
>> enabling the drm API to register the bridge as HDMI and to use
>> the HDMI Helper functions.
>>
>> Moreover, as part of data exclusively used (in the context of
>> HDMI bridges) by the helpers, assign the vendor "MediaTek" and
>> product "On-Chip HDMI" strings to the drm_bridge struct.
>>
>> If the hdmi_{write,clear}_infoframe pointers are not assigned,
>> vendor and product strings and HDMI helpers will not be used,
>> hence this commit brings no functional changes to drivers that
>> have not been refactored to use the new helpers.
>>
>> This also means that, in the current state, there is effectively
>> no functional change to mtk_hdmi and its other components.
> 
> OP_HDMI is for v2.
> vendor and product strings is for both v1 and v2.
> So separate this patch to two patches.
> 

They're both for v2, because only v2 uses the HDMI helpers, while v1 does not.

Cheers,
Angelo

> Regards,
> CK
> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> index 4f708b04f5e8..0f60842462b0 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> @@ -408,9 +408,16 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
>>
>>          hdmi->bridge.funcs = ver_conf->bridge_funcs;
>>          hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
>> +
>> +       if (ver_conf->bridge_funcs->hdmi_write_infoframe &&
>> +           ver_conf->bridge_funcs->hdmi_clear_infoframe)
>> +               hdmi->bridge.ops |= DRM_BRIDGE_OP_HDMI;
>> +
>>          hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>>          hdmi->bridge.of_node = pdev->dev.of_node;
>>          hdmi->bridge.ddc = hdmi->ddc_adpt;
>> +       hdmi->bridge.vendor = "MediaTek";
>> +       hdmi->bridge.product = "On-Chip HDMI";
>>
>>          ret = devm_drm_bridge_add(dev, &hdmi->bridge);
>>          if (ret)
>> --
>> 2.47.0
>>
> 



