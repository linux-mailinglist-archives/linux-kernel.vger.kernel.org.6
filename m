Return-Path: <linux-kernel+bounces-448317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855409F3E70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F69F188F352
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5748C1D95BE;
	Mon, 16 Dec 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZszwILMo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEB42A9B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392879; cv=none; b=G49qpsadM9bQBLqbIXjE04qPB+h/NwyNH6yamNzwf5MuX9o98Wk6bMobEgS7Vdltak6IAsHvk/YbbZJEGVmf3hZeyLyWnlhLM/VeQQF+k3/LCl2oOKQvyMBmm/0FVwbnxI6iFTa6Om5gEKzuF9OTgbWVSHN9Q2YR4b4WBam8JjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392879; c=relaxed/simple;
	bh=ZF+GHp4mKiw2778Txr5TLw8vV8Wy5MyIoekOj49ijMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OA4ULcAisu2M2joToLLTvGghdKumnTxX0VZcot9oAF6k8MMT+0Yro2Af4h8QGU0g5BDjc5C9yNtoPCdVb4HuRu876rqswHXYOPPwkosR8a45da37KkJBja1zfH5aVng5CUhsV71PhdjwQ8Mr9FhIWx8XhDPXFpCChnN/DmwD44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZszwILMo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734392875;
	bh=ZF+GHp4mKiw2778Txr5TLw8vV8Wy5MyIoekOj49ijMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZszwILMoCfDGbbRcFEZQGd/vMa3yI4C+Sxucd2DT8xWnoALuZGYRcSYKyi0TxrA4B
	 XyJT5EVaM7XOwJjkOGQ/Wl2uTTvc/LCoG6mdtEBEaYbcxKEceHNqi+vAdhTT05/Qbe
	 nxl1Wq17YK4kyD2GGzqUIesnlp2TjG6PL2CS4e8of56cZuFekTJcCz08FbJEyBt/nv
	 /a10kIrHGVBCVo+6wjmWX5XkvAuV3yrBMJD7lyoM6WJYtMbuof17/C2HSYUhfYPuRV
	 F31u+Vdm1ZtHsC1VmYe7SCAjkM1vVOVFN7z86OXqas/ROh86EvJj8D56WjUZr1t52b
	 OnnXjhkoLdydg==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 29DCB17E0DD7;
	Tue, 17 Dec 2024 00:47:55 +0100 (CET)
Message-ID: <d983544b-fbfb-41ed-8af0-31b92e2f904b@collabora.com>
Date: Tue, 17 Dec 2024 01:47:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge-connector: Prioritize supported_formats
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
References: <20241206-bridge-conn-fmt-prio-v2-1-85c817529b88@collabora.com>
 <uw7uqw6zsmoe2cyxe3mqm3ok43afut47jms37nny6ecl44b5xe@byagwnayplse>
 <d1fe66a7-c495-429d-9908-6f4076a994da@collabora.com>
 <dn625hkcujqlre74wu3hezlcbkxza5urydgcl3kvs3exbr4tl7@rpznp2zefpoe>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <dn625hkcujqlre74wu3hezlcbkxza5urydgcl3kvs3exbr4tl7@rpznp2zefpoe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 1:32 AM, Dmitry Baryshkov wrote:
> On Tue, Dec 17, 2024 at 01:17:48AM +0200, Cristian Ciocaltea wrote:
>> Hi Dmitry,
>>
>> On 12/10/24 3:12 AM, Dmitry Baryshkov wrote:
>>> On Fri, Dec 06, 2024 at 10:00:46PM +0200, Cristian Ciocaltea wrote:
>>>> Bridges having the DRM_BRIDGE_OP_HDMI flag set in drm_bridge->ops are
>>>> supposed to rely on drm_bridge->supported_formats bitmask to advertise
>>>> the supported colorspaces, including HDMI_COLORSPACE_YUV420.  Therefore,
>>>> the newly introduced drm_bridge->ycbcr_420_allowed flag becomes
>>>> redundant in this particular context.
>>>>
>>>> Moreover, when drm_bridge_connector gets initialised, only
>>>> drm_bridge->ycbcr_420_allowed is considered in the process of adjusting
>>>> the equivalent property of the base drm_connector, which effectively
>>>> discards the formats advertised by the HDMI bridge.
>>>
>>> I think this should be handled in a different way: during HDMI connector
>>> init verify that HDMI_COLORSPACE_YUV420 matches the
>>> drm_connector->ycbcr_420_allowed value and rejects incompatible
>>> connectors.
>>
>> I added a 2nd patch in v3 [1] to perform this verification on HDMI
>> connector init, but I think we still need a proper handling of the
>> inconsistency at bridge[-connector] level. I simplified a bit the initial
>> approach, hopefully that would bring us closer to an acceptable solution.
> 
> I'm sorry, I first commented on the new patchseries. I think that the
> second patch is enough.

No worries, thanks for your quick review!  Let's move the discussion on
the new series!

