Return-Path: <linux-kernel+bounces-201290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0968FBC9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7FE2840D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07F14B07A;
	Tue,  4 Jun 2024 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TD10HMw/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8FB644;
	Tue,  4 Jun 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529532; cv=none; b=Oa7YtoOOIHbtS5zIEbrJt9lFEh8xVWAKqibmP3/YV4X5o1UHCVeUZelDg6e7m20lMdHtcRjY9Fgbu43Q+bHWZLvNTFkCGWPxTXdtT3w9IXlm0Kr/WGEwK4YurSTv/plzPfvwuSD1mSlytOkpmfgut9zzPe5PGqBRgMYQBkgk1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529532; c=relaxed/simple;
	bh=M1Gdn4asSpZpMWSj1SJTHfA7FUsIrefzLkYIEaSuPWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6kK43xB1Zuz8jezXSFubFevHHcqrNc06xdyQ5Tv3UhWWLiQeyjG7xeCFr42VT6o/UH/OrJOl+iDDdEyP+ayzGBX+4ZNXyiljZZXwME58Ga9m9ioLklsBVBXSckAK5VDJZI4gdCvv/XGqpVhewTXHlTaI7IjzYrpfSATj55STj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TD10HMw/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717529528;
	bh=M1Gdn4asSpZpMWSj1SJTHfA7FUsIrefzLkYIEaSuPWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TD10HMw/KC+Zeelk+t0a2mjwUXPzb3Hczj8F6WJBiKw0COfBZeFkF6EjH/qUi48qL
	 Oz9zz7uaYcFmKTLwBXh3XcgXxt1v4yBKJUYlHnXUWCjFRzo7dw+5/ivuKYGENSwMLJ
	 LvmenoFOnasGe9G3cgE4XwgWopGAd8Md2SRq71K7ijBmpjow3omaEht4KKbarw28ED
	 7H9raw9xn5TOhFMBmU/sLHCDNzg2KVLlll+mZxajs0X372UDLle9lEnVM2sQFZgwhG
	 5l7Olu+lbU/ZioZKr9kHyJk90sbdSWmxRprtzSCEwqySgumM/wxv/5/lO4SzBiDufs
	 eYIBVVVhmwMOA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 989343782172;
	Tue,  4 Jun 2024 19:32:06 +0000 (UTC)
Message-ID: <59519381-2729-4839-9882-65a981a0c551@collabora.com>
Date: Tue, 4 Jun 2024 22:32:04 +0300
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
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20240601143226.GA2003970@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sam,

On 6/1/24 5:32 PM, Sam Ravnborg wrote:
> Hi Cristian,
> 
> a few drive-by comments below.
> 
> 	Sam
> 
> 
>> +
>> +static const struct drm_connector_funcs dw_hdmi_qp_connector_funcs = {
>> +	.fill_modes = drm_helper_probe_single_connector_modes,
>> +	.detect = dw_hdmi_connector_detect,
>> +	.destroy = drm_connector_cleanup,
>> +	.force = dw_hdmi_qp_connector_force,
>> +	.reset = drm_atomic_helper_connector_reset,
>> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>> +};
>> +
>> +static int dw_hdmi_qp_bridge_attach(struct drm_bridge *bridge,
>> +				    enum drm_bridge_attach_flags flags)
>> +{
>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>> +
>> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>> +		return drm_bridge_attach(bridge->encoder, hdmi->next_bridge,
>> +					 bridge, flags);
>> +
>> +	return dw_hdmi_connector_create(hdmi, &dw_hdmi_qp_connector_funcs);
>> +}
> 
> Are there any users left that requires the display driver to create the
> connector?
> In other words - could this driver fail if DRM_BRIDGE_ATTACH_NO_CONNECTOR
> is not passed and drop dw_hdmi_connector_create()?
> 
> I did not try to verify this - just a naive question.

I've just tested this and it doesn't work - dw_hdmi_connector_create()
is still needed.

Regards,
Cristian

