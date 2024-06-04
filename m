Return-Path: <linux-kernel+bounces-201407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372DF8FBE16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631FC1C24006
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06DB14B97B;
	Tue,  4 Jun 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lR1C3lC0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25184E1C;
	Tue,  4 Jun 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536904; cv=none; b=D7ckiG94yyLsvueL0oLbWwxuC9DhhebYLeRyEfIotQLBmSQ9gU0LSPKYsCGbLTPDhBnpOFzpfbX9jhHbrUrmZ0TWZQEnfZhD0oQbXExTDrSF9eBqOLDT3ipJxU9CSsZNowhlwqbl/eZaenXo2iNvQ492sbea5faiXohkj5vIuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536904; c=relaxed/simple;
	bh=4j+xcEIW6UJVNE2Sr/TwZL1PpYm/E0XsZ43FgrExk3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1OQ5Vkg5rnzqPPKqkl0ZSgGWn/R/y9JBntl/kpier/odOSB4NyisqD+13fx2qZuXQcsAWKsg2PHxQ2RuHwp8RGXOl7lKBsLtsZa1vMfVNhnI/Jh0gavQDxja3ojLtnMTfr+3o4vlax9KbfTSnRT67Yokw02v3wRGO3l++plcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lR1C3lC0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717536900;
	bh=4j+xcEIW6UJVNE2Sr/TwZL1PpYm/E0XsZ43FgrExk3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lR1C3lC0F22dScTwYgb/PlbrW444zV6vG6SUqY30nK1kZczq4RMlbCtCHs3KNvVZC
	 OXriDU9xexPGxkACTS4+HrKgwgUQCRbj0za8jIGchpW/Q3wL+xGEVzhlmiMq9+O1Rr
	 8WnWurzV6iPf3gflmpmklD3ARSK5NRKFdy/S9MBqy3KhSoOTzAg8wZ1+zz31cljVxh
	 NJAG6eThabGJncG5AxcJpr2fixrSdnTpCLY6Y0NRXEPliU+jOuQdcUdI0r/nCIzjPx
	 RNREZde+ONgynJ+XqQ2Vp+WQLdTq0iiJ1guQgu6JTk6YSN8cpuspqEmlTHSKhYSK3x
	 py6phNsJD8jeA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E8AD37810EF;
	Tue,  4 Jun 2024 21:34:58 +0000 (UTC)
Message-ID: <f656c72e-fac8-4345-9b65-1031ebe81c25@collabora.com>
Date: Wed, 5 Jun 2024 00:34:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] drm/bridge: synopsys: Add DW HDMI QP TX controller
 driver
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
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20240604204110.GA84949@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 11:41 PM, Sam Ravnborg wrote:
> Hi Cristian.
> 
> On Tue, Jun 04, 2024 at 10:32:04PM +0300, Cristian Ciocaltea wrote:
>> Hi Sam,
>>
>> On 6/1/24 5:32 PM, Sam Ravnborg wrote:
>>> Hi Cristian,
>>>
>>> a few drive-by comments below.
>>>
>>> 	Sam
>>>
>>>
>>>> +
>>>> +static const struct drm_connector_funcs dw_hdmi_qp_connector_funcs = {
>>>> +	.fill_modes = drm_helper_probe_single_connector_modes,
>>>> +	.detect = dw_hdmi_connector_detect,
>>>> +	.destroy = drm_connector_cleanup,
>>>> +	.force = dw_hdmi_qp_connector_force,
>>>> +	.reset = drm_atomic_helper_connector_reset,
>>>> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>>>> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>>> +};
>>>> +
>>>> +static int dw_hdmi_qp_bridge_attach(struct drm_bridge *bridge,
>>>> +				    enum drm_bridge_attach_flags flags)
>>>> +{
>>>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>>>> +
>>>> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>>>> +		return drm_bridge_attach(bridge->encoder, hdmi->next_bridge,
>>>> +					 bridge, flags);
>>>> +
>>>> +	return dw_hdmi_connector_create(hdmi, &dw_hdmi_qp_connector_funcs);
>>>> +}
>>>
>>> Are there any users left that requires the display driver to create the
>>> connector?
>>> In other words - could this driver fail if DRM_BRIDGE_ATTACH_NO_CONNECTOR
>>> is not passed and drop dw_hdmi_connector_create()?
>>>
>>> I did not try to verify this - just a naive question.
>>
>> I've just tested this and it doesn't work - dw_hdmi_connector_create()
>> is still needed.
> 
> Hmm, seems the display driver or some other bridge driver fails to
> support "DRM_BRIDGE_ATTACH_NO_CONNECTOR".
> what other drivers are involved?

Could it be related to the glue driver (updated in the next patch) which
is also responsible for setting up the encoder?

> Note that my comments here should be seen as potential future
> improvements, and do not block the patch from being used.

Thanks for the heads up! Will try to get back to this soon and investigate.

Cristian

