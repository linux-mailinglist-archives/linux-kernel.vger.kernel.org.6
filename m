Return-Path: <linux-kernel+bounces-169857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365548BCEA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A901C21D13
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C7768E1;
	Mon,  6 May 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O9YxQ8dC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A036EB53;
	Mon,  6 May 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000318; cv=none; b=d7mBUL78qynu5sQQwBFreA9nFijxiFgiIlPd6o7QV30WrNvGtVxb2kkHM3pipuQtSm1v32LnjNZWYcg/R5LqpJtQ/oziytXhBhfZMcGlXsEwf5e0RW2SfXxWIQHa7599+uPzlGTx14ym4D0ZELFGZjkYZIRYRTwapoX6HypzXHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000318; c=relaxed/simple;
	bh=tLmidEw0xvorttT3kpSnB/51l0/SZujW7+7sWnN3BTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cg+cLSmRjo+VFFxTeNdh4sl4ws6enBRkBpaZQ6wSYbCw+nhxmvfcSIE66mU1MHcC54V8QLxy7eB5icM5SXe6PR8FIWUwEMtZWTPZZt0Jx9QUKooHbqMMTtwd/tMLfvHfqpTOxP3VVQg55oan6cXYn/PEHnlD0AUFu3JzJQU8f78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O9YxQ8dC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715000315;
	bh=tLmidEw0xvorttT3kpSnB/51l0/SZujW7+7sWnN3BTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O9YxQ8dCW1tqgLW5rA+0n2ArPG6QQFelD3GGiGn1iE3MvfASacacXhC4m6/6738Ti
	 k/V/Ma+/rUbWei5h8Gs7kAAtv5k4CiXrV87IfdqqBH9pFD/I4e9fnTRgANZgxgA2Er
	 YuKt83JuNXixC1NSoRiH2W/I3t3Q3F+oni1Sbj1Xj7L/PJD2WzQ5Vb65aCu5LqEH/R
	 8QJmt3NtrgfLnLC1HR7QZuZWQSLB12fbi79eEanIy9j4bCVumzWB5ek4gl+mDAc7pJ
	 NRa00YWGRzZUciGJQYW20VIAEebikMKu8YzZYlX4GMx7jHPMa+s0JxRr0qjzFI3a0L
	 e9gMJgpPOcHXw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8896437813E3;
	Mon,  6 May 2024 12:58:33 +0000 (UTC)
Message-ID: <01b2e468-e721-4bc5-9149-4e2292eafd42@collabora.com>
Date: Mon, 6 May 2024 14:58:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/mediatek: Implement OF graphs support for
 display paths
To: Michael Walle <mwalle@kernel.org>, chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
 <20240409120211.321153-4-angelogioacchino.delregno@collabora.com>
 <D12G1NPU2H06.3LBLR19XYUAA6@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <D12G1NPU2H06.3LBLR19XYUAA6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/05/24 11:11, Michael Walle ha scritto:
> Hi Angelo,
> 
> On Tue Apr 9, 2024 at 2:02 PM CEST, AngeloGioacchino Del Regno wrote:
>> +static int mtk_drm_of_get_ddp_ep_cid(struct device_node *node,
>> +				     int output_port, enum mtk_drm_crtc_path crtc_path,
> 
> Not sure what's your base branch is, but "enum mtk_drm_crtc_path"
> was renamed to "enum mtk_crtc_path" in commit 9e149879038f5
> ('drm/mediatek: Rename "mtk_drm_crtc" to "mtk_crtc"').
> 
>> +/**
>> + * mtk_drm_of_ddp_path_build_one - Build a Display HW Pipeline for a CRTC Path
>> + * @dev:          The mediatek-drm device
>> + * @cpath:        CRTC Path relative to a VDO or MMSYS
>> + * @out_path:     Pointer to an array that will contain the new pipeline
>> + * @out_path_len: Number of entries in the pipeline array
>> + *
>> + * MediaTek SoCs can use different DDP hardware pipelines (or paths) depending
>> + * on the board-specific desired display configuration; this function walks
>> + * through all of the output endpoints starting from a VDO or MMSYS hardware
>> + * instance and builds the right pipeline as specified in device trees.
>> + *
>> + * Return:
>> + * * %0       - Display HW Pipeline successfully built and validated
>> + * * %-ENOENT - Display pipeline was not specified in device tree
>> + * * %-EINVAL - Display pipeline built but validation failed
>> + * * %-ENOMEM - Failure to allocate pipeline array to pass to the caller
>> + */
>> +static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_drm_crtc_path cpath,
> 
> likewise
> 
>> +					 const unsigned int **out_path,
>> +					 unsigned int *out_path_len)
> 
> -michael

Yeah, thanks for noticing that, I'll send a new version soon.

Cheers

