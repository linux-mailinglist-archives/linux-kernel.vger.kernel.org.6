Return-Path: <linux-kernel+bounces-202174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19178FC8B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D3D1C20EFE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1004190069;
	Wed,  5 Jun 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FI6ulCea"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51297BE5A;
	Wed,  5 Jun 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582317; cv=none; b=C1Lqty+URPIGQ2K4uqcA5qblZNaaRYpXZXX2bITAQRbNSXkNurHZGK7n8k6uLUgZrwWfrfpB9AQf2NOPbEYYMH7U97yGsI9Gp+CxMoMBWVVB5tR9zNApRaVCekf9i2dXGrzEfucp5lrqaKfTtIPATcANMtpO7d5itg4p+oKp01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582317; c=relaxed/simple;
	bh=oFJxlZFjj3Jn2dbeE5l6hjEsMDGGXCv5/naNuZE41UY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OqCxKnXQ6MAgOWVW8dQyxcOcGMg1ib8gNbp6tfH2byhXmWCdAmqH5wUo5+eJgvW4/KSUJ3QgQu0iQBTe/J7tpDhPAczZ+sHflTgyNpQDPUDvlSQs2zKQ4u1LU6DSJtgo5g/GaymM051ZfAsw8NTxfJob4xIcCHrxclJ3myNcqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FI6ulCea; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717582313;
	bh=oFJxlZFjj3Jn2dbeE5l6hjEsMDGGXCv5/naNuZE41UY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FI6ulCeaae5oi8t3k9x8v4hHVXmpnQgo066sVXpN+frVP9OLZbcAmOQEv1P08D8ED
	 heHY/zQ9zKVYfnjVR98gMHcmcMqE0gd35D1SYRhxuK0QKuGAiXQcZHNrnBlw4Zd53S
	 Qx7HrpJjs2p9Rf6vOT1IsSwzJ0DHQSlSTmJIwJN/vt2EKQwrKMkp9EE7E17p3GRubG
	 vfceAPMvc//1GDDAc1AFvmYDPWlg8vUA9obvP29yNnPPCkTrd1Nwz59Sag3I1zyDLg
	 Ssneevvrr8v9TygU1knrHfleOM23E1L5+rc4/8Fs+C9DjvPc44duSh+BZnwnnT2VkQ
	 Sdat6IQrS/fyw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 79CFE378020A;
	Wed,  5 Jun 2024 10:11:51 +0000 (UTC)
Message-ID: <304b4602-8722-4ed0-a555-8dada573ee79@collabora.com>
Date: Wed, 5 Jun 2024 13:11:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] drm/bridge: synopsys: Add DW HDMI QP TX controller
 driver
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <20240601-b4-rk3588-bridge-upstream-v1-13-f6203753232b@collabora.com>
 <20240601143226.GA2003970@ravnborg.org>
 <59519381-2729-4839-9882-65a981a0c551@collabora.com>
 <20240604204110.GA84949@ravnborg.org>
 <f656c72e-fac8-4345-9b65-1031ebe81c25@collabora.com>
Content-Language: en-US
In-Reply-To: <f656c72e-fac8-4345-9b65-1031ebe81c25@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 12:34 AM, Cristian Ciocaltea wrote:
> On 6/4/24 11:41 PM, Sam Ravnborg wrote:
>> Hi Cristian.
>>
>> On Tue, Jun 04, 2024 at 10:32:04PM +0300, Cristian Ciocaltea wrote:
>>> Hi Sam,
>>>
>>> On 6/1/24 5:32 PM, Sam Ravnborg wrote:
>>>> Hi Cristian,
>>>>
>>>> a few drive-by comments below.
>>>>
>>>> 	Sam
>>>>
>>>>
>>>>> +
>>>>> +static const struct drm_connector_funcs dw_hdmi_qp_connector_funcs = {
>>>>> +	.fill_modes = drm_helper_probe_single_connector_modes,
>>>>> +	.detect = dw_hdmi_connector_detect,
>>>>> +	.destroy = drm_connector_cleanup,
>>>>> +	.force = dw_hdmi_qp_connector_force,
>>>>> +	.reset = drm_atomic_helper_connector_reset,
>>>>> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>>>>> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>>>> +};
>>>>> +
>>>>> +static int dw_hdmi_qp_bridge_attach(struct drm_bridge *bridge,
>>>>> +				    enum drm_bridge_attach_flags flags)
>>>>> +{
>>>>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>>>>> +
>>>>> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>>>>> +		return drm_bridge_attach(bridge->encoder, hdmi->next_bridge,
>>>>> +					 bridge, flags);
>>>>> +
>>>>> +	return dw_hdmi_connector_create(hdmi, &dw_hdmi_qp_connector_funcs);
>>>>> +}
>>>>
>>>> Are there any users left that requires the display driver to create the
>>>> connector?
>>>> In other words - could this driver fail if DRM_BRIDGE_ATTACH_NO_CONNECTOR
>>>> is not passed and drop dw_hdmi_connector_create()?
>>>>
>>>> I did not try to verify this - just a naive question.
>>>
>>> I've just tested this and it doesn't work - dw_hdmi_connector_create()
>>> is still needed.
>>
>> Hmm, seems the display driver or some other bridge driver fails to
>> support "DRM_BRIDGE_ATTACH_NO_CONNECTOR".
>> what other drivers are involved?
> 
> Could it be related to the glue driver (updated in the next patch) which
> is also responsible for setting up the encoder?
> 
>> Note that my comments here should be seen as potential future
>> improvements, and do not block the patch from being used.
> 
> Thanks for the heads up! Will try to get back to this soon and investigate.
 
IIUC, modern bridges should not create the connector but rely on display
drivers to take care of, which in this case is the VOP2 driver. However,
it also handles some of the older SoCs relying on the non-QP variant of
DW HDMI IP. Hence the existing dw-hdmi driver would be also impacted in
order to come up with a proper solution.

A quick check shows there are several users of this IP:

$ git grep -E '= dw_hdmi_(bind|probe)\('
drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c:    hdmi->dw_hdmi = dw_hdmi_probe(pdev, plat_data);
drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:      hdmi = dw_hdmi_probe(pdev, plat_data);
drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c:        hdmi->hdmi = dw_hdmi_probe(pdev, match->data);
drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c:      hdmi = dw_hdmi_probe(pdev, &ingenic_dw_hdmi_plat_data);
drivers/gpu/drm/meson/meson_dw_hdmi.c:  meson_dw_hdmi->hdmi = dw_hdmi_probe(pdev, &meson_dw_hdmi->dw_plat_data);
drivers/gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c: hdmi = dw_hdmi_probe(pdev, &rcar_dw_hdmi_plat_data);
drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c:            hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c:  hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);

I didn't check which display drivers would be involved, I'd guess there
are quite a few of them as well. So it seems this ends up being a pretty
complex task.

Cristian

