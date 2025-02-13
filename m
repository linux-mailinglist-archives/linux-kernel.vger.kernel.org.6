Return-Path: <linux-kernel+bounces-512708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86345A33CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F81164ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83D212FA6;
	Thu, 13 Feb 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jyapWIhM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984D1FAC42;
	Thu, 13 Feb 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443093; cv=none; b=QfGIZoxNeZFzmaVoTuwO5EKJS+iN9U1ZHvtcPv59QoT9972VUzVGpB9jxyQuQTXLb78gBaYnXQuwj+OCJZakhPQ1xaFzwFevCGz9kUWP5BU+1p6z2+ucUWWPvxxEJpQfWj85q10YnxDeP97ek0zMAUAbS9AX5GOqqrf7jtFZu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443093; c=relaxed/simple;
	bh=tPc0mtOSvvNjsiyZamSxUZlYBtpbVsuKn6yjNRsFneg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQyXmH1dRWhyEjtojhUICven5Dgp7I3GBtmCwWPLOyw1oKgpMC4xMBvhEhfk3DUQOcZ3HFpKk+l6KrVJv6X3Su2fBTGpCs1mrwaz0gM3OWDgHhvOH37HuysJDg4ZR5PQThAknpM43C6y2QFEjLVDvpn2i0r5uIrcRCnWSvCPkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jyapWIhM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739443089;
	bh=tPc0mtOSvvNjsiyZamSxUZlYBtpbVsuKn6yjNRsFneg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jyapWIhMsPTIC4FGk8FX0VVGQrKTcLx1TT3roWkmt8cBuNb/NifXwpN8sVEN7lgrI
	 eZyAehAbaVhgz1D8F7v6nKC4LpR6kTbo0pIXD3/eeiu2hipqaxTrWHCl6x8v6J+Rot
	 VfvDhqdurU2GdHkxQZCvvP9u2NyZoh24EmqR3ZxzCujWhOyRs7GU8V9GDbmYzIE0BY
	 vHv+G59h8jfkdSrp6c/f65FHTwLUYv7mrkjdbr+JMAanEcnTeBQv16mfXK8nH3XbU+
	 XflDFDPaurrGr5Y8o+8vLeuYh7pVPL/jjTKGC72Xx2ax4eif+muPolU8H0hyipPFIB
	 0trke5SdKUQuQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F62717E00A3;
	Thu, 13 Feb 2025 11:38:08 +0100 (CET)
Message-ID: <1eff72da-c88f-46bc-aa0a-4e7615184202@collabora.com>
Date: Thu, 13 Feb 2025 11:38:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 37/42] drm/mediatek: mtk_hdmi_common: Assign DDC
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
 "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?UTF-8?B?TGV3aXMgTGlhbyAo5buW5p+P6YieKQ==?= <Lewis.Liao@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 =?UTF-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?= <TommyYL.Chen@mediatek.com>,
 =?UTF-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?= <Ives.Chenjh@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "junzhi.zhao@mediatek.com" <junzhi.zhao@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
 <20250211113409.1517534-38-angelogioacchino.delregno@collabora.com>
 <4ff6d01a040b37d4f581ea3808db4851e555a4fe.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <4ff6d01a040b37d4f581ea3808db4851e555a4fe.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/25 10:20, CK Hu (胡俊光) ha scritto:
> On Tue, 2025-02-11 at 12:34 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> In preparation for adding the new HDMI TX v2 IP driver, assign the
>> pointer to the DDC adapter to struct drm_bridge during probe.
> 
> I could not find where to use hdmi->bridge.ddc in the patch of adding hdmi v2.
> Could you describe more about where or which function would use this?
> 

I have already replied to this exact question a long time ago.

https://lore.kernel.org/all/b5a77637-64b0-4ed3-9619-e76d094505af@collabora.com/

Regards,
Angelo

> Regards,
> CK
> 
>>
>> This commit brings no functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> index 5ea45608921c..2c91f65f26fa 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
>> @@ -411,6 +411,7 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
>>          hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
>>                           | DRM_BRIDGE_OP_HPD;
>>          hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>> +       hdmi->bridge.ddc = hdmi->ddc_adpt;
>>          hdmi->bridge.vendor = "MediaTek";
>>          hdmi->bridge.product = "On-Chip HDMI";
>>
>> --
>> 2.48.1
>>
> 



