Return-Path: <linux-kernel+bounces-439098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F49EAAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89F1282A42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75A2309A6;
	Tue, 10 Dec 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZjWTYFMC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4322F3A9;
	Tue, 10 Dec 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819607; cv=none; b=PUpX9nvhqb5KkTrFh/iaqhXFwWv/DXTomtG0dKcxoADumQRWXKTrB3UycTeKZjrHAPoDFetMO+VCVNaRfZOGx6vHA4RYTaN32OdO0+QVgHUgkf/nbkHFHxiyMsp65Tze3QzSBrBFV5KGPwQ//9j5QbN5MP1IC1BCn3fqsE78C78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819607; c=relaxed/simple;
	bh=X+tjjsPeLh8i0QPWhtWxfKi4DcKHgKLE/YTGz/q1zQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eetdv7eTrC7Yf2wEk9cA8cHgST9jEUwqDfN4wtx3jJuXCo95cKEfEW8XSolnRaazC93cunIDCFO8jWNJ2Rkwr22ahc8EPATTeSYgLBqA5B8Xs88KY5iXcTXXc6KOgyG7rGUhbRUhTeiYTLe7XjY7KOUDirZVtuzDDGFgIem85Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZjWTYFMC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819603;
	bh=X+tjjsPeLh8i0QPWhtWxfKi4DcKHgKLE/YTGz/q1zQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZjWTYFMCoXfrQyc3DurtEHV5N+EJaJmZTDdkMUzgAq4y1tvzfERQm5BnIgsoPNmGq
	 H9e952yr6xN+Zy9soveXM1Zt1n0td6BWZmEbFRTUvIlS9M8B36AQEpGaCOD8tNUqdS
	 AsLqs05j7z8OrHuXy9njoTMzYGUXCUNScoc/o0ffiHkUvcvnsjqnWk16n9l6qmE5Tf
	 3R9zDYq7VNIPqj7bnG3AtyjdJgktDfg6UhkR8T4drqg8sXXuafEupGI5JqTVHIksKD
	 OzOQK1lE4ms8rI541oJtzb9pBAHvUqfrdbPOXwJKEnqeiHieUZYLM30V3DLt9fzN2b
	 GZd1u5Ff3hZUQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E967017E14EA;
	Tue, 10 Dec 2024 09:33:22 +0100 (CET)
Message-ID: <50757699-aca2-423a-b463-5a4d74d63447@collabora.com>
Date: Tue, 10 Dec 2024 09:33:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
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
 <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
 <631fdcdfd44e0d401e62df67acc206b0762248c7.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <631fdcdfd44e0d401e62df67acc206b0762248c7.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/12/24 04:28, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Thu, 2024-12-05 at 12:45 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> Add support for the newer HDMI-TX (Encoder) v2 and DDC v2 IPs
>> found in MediaTek's MT8195, MT8188 SoC and their variants, and
>> including support for display modes up to 4k60 and for HDMI
>> Audio, as per the HDMI 2.0 spec.
>>
>> HDCP and CEC functionalities are also supported by this hardware,
>> but are not included in this commit and that also poses a slight
>> difference between the V2 and V1 controllers in how they handle
>> Hotplug Detection (HPD).
>>
>> While the v1 controller was using the CEC controller to check
>> HDMI cable connection and disconnection, in this driver the v2
>> one does not.
>>
>> This is due to the fact that on parts with v2 designs, like the
>> MT8195 SoC, there is one CEC controller shared between the HDMI
>> Transmitter (HDMI-TX) and Receiver (HDMI-RX): before eventually
>> adding support to use the CEC HW to wake up the HDMI controllers
>> it is necessary to have support for one TX, one RX *and* for both
>> at the same time.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> [snip]
> 
>> +static void mtk_hdmi_v2_bridge_enable(struct drm_bridge *bridge,
>> +                                     struct drm_bridge_state *old_state)
>> +{
>> +       struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>> +       struct drm_atomic_state *state = old_state->base.state;
>> +       int ret;
>> +
>> +       ret = drm_atomic_helper_connector_hdmi_update_infoframes(hdmi->curr_conn, state);
>> +       if (ret)
>> +               dev_err(hdmi->dev, "Could not update infoframes: %d\n", ret);
>> +
>> +       mtk_hdmi_v2_hw_vid_mute(hdmi, false);
>> +       mtk_hdmi_v2_hw_aud_mute(hdmi, false);
> 
> In v1, it does not unmute when bridge enable.
> I would like v1 and v2 has the same behavior.
> If possible, remove these code.
> If remove thee code would result in some problem,
> add comment to describe why need these code.
> 

I think you even said that in the first review...

Thanks for repeating, and sorry for missing that in v2, will be done
for v3

Cheers,
Angelo

> Regards,
> CK
> 
>> +
>> +       /* signal the connect event to audio codec */
>> +       mtk_hdmi_v2_handle_plugged_change(hdmi, true);
>> +
>> +       hdmi->enabled = true;
>> +}
>> +
> 




