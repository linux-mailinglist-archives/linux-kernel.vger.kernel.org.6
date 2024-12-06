Return-Path: <linux-kernel+bounces-435584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F39E79C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AB0285B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF721519C;
	Fri,  6 Dec 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MdOlHdZ3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04426207658
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515489; cv=none; b=S1gdrxIRMfewwQtiDomkQtTN7udeCdr0aAnD2q3HtcreCTLXk4pRLi4WCyE9EmdQmAWF99Ej0G/zMQ7fARf0lgCjMMCFjfN//wHsrHWTwk6XbwhWlDUzJlow/rpTePKy5Td8hNAl6b72nWx6URnKJxMS/OMQug/6Ni3Mhg1BRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515489; c=relaxed/simple;
	bh=hmsqwiQoFyVymGO/tJ3hsCNiyGGrTZsfN1G8UeJFit0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gu2K4IW6b59P3i+UeP5D4ikuQIj/hN8cZrdtVzR2LMghT34Gu2KKzc2UGsh8XPbCJHpF98BgkI7lDjys36h/qLKzVoAP5uWqatjt44ta3nukVBqk8A5pTo3tMhUIJD1luPIvrO42Sg3C4AbYM+wVPoWlmk+B0CtfPHKkr3m5KFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MdOlHdZ3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733515485;
	bh=hmsqwiQoFyVymGO/tJ3hsCNiyGGrTZsfN1G8UeJFit0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=MdOlHdZ39aR49HyyARCdN8GqayWyX3S3gNFi3AfBo95I76Vx5AeojrrgUcWCP07H4
	 62+hIdz87RNXToZDoXVyzBmDgMzI2cwhMnfzEf3NDQHEIMh+vy4KPwjiLOoEbBAtCY
	 NhD4rN3j3YDPQ8ftsYcMyK1DrBPFeoWOrgTTesX9Xfx3Y8DRNQNy4TnH4bmO3yd9KB
	 pE2XHHoPb1PNuymUEG3BGyVcl0RLF1F3bUJ8iVubzSBlxrETxSfLbJt8QQz1nEWIIm
	 kinst8ATPxw7FClsOF+fz/PfLmQ5d/FovaA1b4JD5B6qnB2ISVOCpXiV5G1Y5V/QA8
	 GPm/+O2z/LdtQ==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3CA6E17E37E9;
	Fri,  6 Dec 2024 21:04:45 +0100 (CET)
Message-ID: <d53a6509-1575-4c07-9680-c039ad357909@collabora.com>
Date: Fri, 6 Dec 2024 22:04:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge-connector: Prioritize supported_formats over
 ycbcr_420_allowed
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241130-bridge-conn-fmt-prio-v1-1-146b663f17f3@collabora.com>
Content-Language: en-US
In-Reply-To: <20241130-bridge-conn-fmt-prio-v1-1-146b663f17f3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/24 1:13 AM, Cristian Ciocaltea wrote:
> Bridges having the DRM_BRIDGE_OP_HDMI flag set in drm_bridge->ops are
> supposed to rely on drm_bridge->supported_formats bitmask to advertise
> the supported colorspaces, including HDMI_COLORSPACE_YUV420.  Therefore,
> the newly introduced drm_bridge->ycbcr_420_allowed flag becomes
> redundant in this particular context.
> 
> Moreover, when drm_bridge_connector gets initialised, only
> drm_bridge->ycbcr_420_allowed is considered in the process of adjusting
> the equivalent property of the base drm_connector, which effectively
> discards the formats advertised by the HDMI bridge.
> 
> Handle the inconsistency by ignoring ycbcr_420_allowed for HDMI bridges
> and, instead, make use of the supported_formats bitmask when setting up
> the bridge connector.
> 
> Fixes: 3ced1c687512 ("drm/display: bridge_connector: handle ycbcr_420_allowed")

Please ignore this and check v2 instead:

https://lore.kernel.org/all/20241206-bridge-conn-fmt-prio-v2-1-85c817529b88@collabora.com/

