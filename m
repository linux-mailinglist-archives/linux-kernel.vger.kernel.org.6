Return-Path: <linux-kernel+bounces-271033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA59448AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08572832D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3797170A15;
	Thu,  1 Aug 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3DSbziDZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC916FF39;
	Thu,  1 Aug 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505402; cv=none; b=H411LO2/VxchFfObqiZqusvA3FC46Y3OboS9RZzlE1k8J27J9x3vWRC6SmCLdW3cArVpJzTojYNkwGThOQm8jAVnJWVZMNEkX6zscLYvxqCX+KExnNKVINipVzxq4vvwZGnGA+7REg09Bwf/7e+CKJSmbkhidlVEvuEEUwcVAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505402; c=relaxed/simple;
	bh=RIgEcQ8M7T7AXs8bBHXfSd4MAegcWjerjXlyDp/HZv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0l0I9rXYSde2CtH1UMWmey+gMe3jjjuV+Jm7YsMDAEi/Y0MvABE2uG1hWa+2LCU8tWNWeyO0aM+7C4r+/8AevYxTci5qXCu33bY+p1X1B7RSf6SMTxnEh+N6ibzHmZtCGZcmIkVnLBLOE0v5o3mJ3dZmX2PFolGaQ15mUdvf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3DSbziDZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722505399;
	bh=RIgEcQ8M7T7AXs8bBHXfSd4MAegcWjerjXlyDp/HZv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3DSbziDZU5+TjBC5B8vDpoOw8aCNIr06i23+pSszqinx/BJSCcsQoIuowNZ44OKL7
	 1+xyZVsNbnfJBmOJouCnaqvlVLl7rsyQUBoG3XAB/Q07/6Fw5qapAeNkMDa7V/a4mq
	 n53FxVfZK/mxesyVGKqhS/DJkhmqGh/zEOw4uH8qk+WTvpTFWG4inTBU5IrHzjPGmO
	 G0vnnRn6ckmOMSXN55kO5NZVE9iiByTno1gT5r3c688A1zUSS3t0hnPlOD+0xHwF3+
	 k72WpBfsEH5xBWZZBGka4LjZRGlygQK13crS9cX+YrrE2S63fYfnrnfwAZNBrrMR5s
	 vYzudfUVd60mw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DCAE8378220A;
	Thu,  1 Aug 2024 09:43:17 +0000 (UTC)
Message-ID: <274a023a-de27-49e7-aa03-7fd60ddfcb87@collabora.com>
Date: Thu, 1 Aug 2024 12:43:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/bridge: synopsys: Add DW HDMI QP TX Controller
 driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
References: <20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@collabora.com>
 <20240801-dw-hdmi-qp-tx-v1-2-148f542de5fd@collabora.com>
 <19af747f-0911-4896-afba-b63c585554d4@kernel.org>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <19af747f-0911-4896-afba-b63c585554d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/24 11:50 AM, Krzysztof Kozlowski wrote:
> On 01/08/2024 04:05, Cristian Ciocaltea wrote:
>> The Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX Controller supports
>> the following features, among others:
> 
> ...
> 
>> +
>> +void dw_hdmi_qp_unbind(struct dw_hdmi_qp *hdmi)
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(dw_hdmi_qp_unbind);
> 
> This looks like quite useless export. Drop.
> 
> 
>> +
>> +void dw_hdmi_qp_resume(struct device *dev, struct dw_hdmi_qp *hdmi)
>> +{
>> +	dw_hdmi_qp_init_hw(hdmi);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_hdmi_qp_resume);
>> +
>> +MODULE_AUTHOR("Algea Cao <algea.cao@rock-chips.com>");
>> +MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@collabora.com>");
>> +MODULE_DESCRIPTION("DW HDMI QP transmitter driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:dw-hdmi-qp");
> 
> That's not a platform driver. That does not look like driver at all,
> just some helper code without any user

This is actually used to provide RK3588 HDMI output support:

https://lore.kernel.org/lkml/20240801-b4-rk3588-bridge-upstream-v2-3-9fa657a4e15b@collabora.com/

> 1. Drop alias.
> 2. Provide users for this code. You cannot add some helper functions
> which nothing uses.
> 3. Fix subject, commit msg, module description - there is no driver
> here, but helper functions. Otherwise how does it bind?

Indeed, that's just a left over from the initial dw-hdmi based 
implementation.  Will clean this up for v2.

Thanks for reviewing,
Cristian

