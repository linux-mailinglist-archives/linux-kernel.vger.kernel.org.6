Return-Path: <linux-kernel+bounces-448345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFF89F3EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CD716E039
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F515AF6;
	Tue, 17 Dec 2024 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZLRPrlzf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659A8C0B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395940; cv=none; b=KEQ4CqRvXtvBW4LAnkj2JDS6r2xZwkF9AZtiDtWx0fzSVV2Ee/TgRr4+qi04o1WnzgSQk+rHrYssV3PStgDD8G9sHQHHO8Q2c9wcm+GCWMgj3MnnLsv+e4anwR8ttixibGtqydzkAp9UU1MW4bnekZ5kuod9rGA50zS+sYZ8ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395940; c=relaxed/simple;
	bh=cCT7yCvueY9SltdJob3Us/rABE/fV3u5HIoVCezbvm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVGmhHpvgStBI9KWPsy1QvRNA0H93NcvIY2BjMTVcGpQxl9W3tfaqZyeljLNmUITLobX0zB58kwuPWgUDJQgbZfPP0eRuI5u9im17l2xcAlFcnP0QKGi8so+WLS5DDEzPoWCeRAH5BnArEuDDMzsQUxUxUJOdLrP6W5u/JyTYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZLRPrlzf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734395936;
	bh=cCT7yCvueY9SltdJob3Us/rABE/fV3u5HIoVCezbvm4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZLRPrlzfCzLfY/oZBMRGtmvFCtexxef32YgFBs5nnJBmYBqWAlEJkMW0+ICU/6LxJ
	 PbAWZfEPLa1vl6cqa/IsHtyH0jpUDm7OzpZBrXMIqHAhPWnBh7w6OwtyfQhouxnA5h
	 VB/e1NBqjBnAvsimHIAbvsSGYbSVZ72hHi9xgW8uhFkhDOoVqRgboEXfpH6Ux9sUIz
	 WXavXJZ8VALJNScVjFDobY+LVUYWRwzKyORKrj+8EWz6VISqGWPOjbZm9O30s1qJ+c
	 IexJ3e7MPSfXCdEdSWvGKCbDZX+67hOTjPg9rbCFaXGcv0HznQ0bGPfamAlyJU0YMK
	 aeCWiefQrb2ZA==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D70317E0E6E;
	Tue, 17 Dec 2024 01:38:56 +0100 (CET)
Message-ID: <b7e1c0e9-f8bc-4f93-a280-49cce1658baa@collabora.com>
Date: Tue, 17 Dec 2024 02:38:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/bridge-connector: Prioritize supported_formats
 over ycbcr_420_allowed
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
 <20241217-bridge-conn-fmt-prio-v3-1-3ecb3c8fc06f@collabora.com>
 <c36o6ro5qqfkqipltlecb3r22d5k3xiqdt46rtl2gdyha7xtmm@l2ovdfono7np>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <c36o6ro5qqfkqipltlecb3r22d5k3xiqdt46rtl2gdyha7xtmm@l2ovdfono7np>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 1:27 AM, Dmitry Baryshkov wrote:
> On Tue, Dec 17, 2024 at 12:54:07AM +0200, Cristian Ciocaltea wrote:
>> Bridges having the DRM_BRIDGE_OP_HDMI flag set in drm_bridge->ops are
>> supposed to rely on drm_bridge->supported_formats bitmask to advertise
>> the supported colorspaces, including HDMI_COLORSPACE_YUV420.  Therefore,
>> the newly introduced drm_bridge->ycbcr_420_allowed flag becomes
>> redundant in this particular context.
>>
>> Moreover, when drm_bridge_connector gets initialised, only
>> drm_bridge->ycbcr_420_allowed is considered in the process of adjusting
>> the equivalent property of the base drm_connector, which effectively
>> discards the formats advertised by the HDMI bridge.
>>
>> Handle the inconsistency by overwriting drm_bridge->ycbcr_420_allowed
>> for HDMI bridges according to drm_bridge->supported_formats, before
>> adding them to the global bridge list.
>>
>> Additionally, ensure the YUV420 related bit is removed from the bitmask
>> passed to drmm_connector_hdmi_init() when the final ycbcr_420_allowed
>> flag for the connector ends up not being set (i.e. the case of having at
>> least one non-HDMI bridge in the pipeline that didn't enable it).
>>
>> Fixes: 3ced1c687512 ("drm/display: bridge_connector: handle ycbcr_420_allowed")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_bridge_connector.c | 8 ++++++--
>>  drivers/gpu/drm/drm_bridge.c                   | 4 ++++
>>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> I think the second patch in the series is enough, it ensures that
> connector's state is consistent, no matter if the drm_bridge_connector
> is being used or a normal drm_connector.
> 
> Nevertheless, I'd leave the final decision to DRM maintainers.

This patch has 2 parts, maybe I should have put them into separate patches
as they kind of relate to distinct problems.

The 1st part makes sure that drm_bridge->ycbcr_420_allowed is automatically
set when HDMI_COLORSPACE_YUV420 is provided in drm_bridge->supported_formats, 
to avoid the need of requiring redundant information on HDMI bridges 
initialization.  This implicitly ensures the consistency needed to further 
allow relying on ->ycbcr_420_allowed internally.

While the 1st part could be dropped (assuming redundancy & consistency is
not really something we want/need to handle), the 2nd part I think is
mandatory, i.e. we must adjust supported_formats before calling
drmm_connector_hdmi_init() to ensure the presence of HDMI_COLORSPACE_YUV420
reflects the status of the computed connector->ycbcr_420_allowed, which
might end up being different than what the HDMI bridge advertised, i.e. the
case of having an HDMI bridge in the pipeline advertising YUV420 via 
supported_formats and a non-HDMI one that didn't enable ycbcr_420_allowed.

Thanks,
Cristian

