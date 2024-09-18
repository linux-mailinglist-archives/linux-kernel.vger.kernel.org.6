Return-Path: <linux-kernel+bounces-332509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2D297BA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0341F22FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665D17AE0C;
	Wed, 18 Sep 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g7h4R+JP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B6178378
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654524; cv=none; b=sMe42qiNF+c6yckKT0RN++UypHRu5TWE86yITyG0WkP3xPIm3bBPtbKEY86kU/v7RAT4dml1MD2qUyMfvbOO+nZtENauqLvHwoNdT8qmMD4WuK38njFPZ+kVzDjjvrhKARGsdxSgLU5CPsmLoVcZgI6R55xu4gWBEWSbf2qTw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654524; c=relaxed/simple;
	bh=ngZrcRDlM5CWBR80rje1RK9nTLokmmBXmMbbHkuM5P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CawuhAj77GuBogwecpYI0hq0VJxgO59rI/5HLU4gmn0Bpwn/JfckNj2GnLKeKcfugVqihtjNB9bz29KksmRsjbHtmKAVbdSmfFqoxo//Tut+InU/g53W1WB0vx9KBozwcN1liEm9ZE70RKRJTHEhJKgiUfGH5V0Qk/d2tcW6LBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g7h4R+JP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726654521;
	bh=ngZrcRDlM5CWBR80rje1RK9nTLokmmBXmMbbHkuM5P0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g7h4R+JPJFvG4wo1gZY7K4fOAOoEr3AxH6k0hlsP107hvZuoX1yw40g28rTlRMLAN
	 WrMwDCBsKpC6YBCS6pdHcSDj2039i+wY8tlhox3wumHROkpM2QIFLnJA6F3ubh6ofZ
	 AOX/MIr13YAAHxA0O/LKMCr1HDR3K5wHnVuQcgVWe3exr60QqdcGuTl55e+I9wwg1I
	 VK0e25qb0YzPKbNRZRxXsMKSx/IP2D1pvgCH3l8vW9AaTOIMT0Qdvo77Hkyu0kpY6M
	 fwx9hxH0scgNWr+4weo+1aFK8+DLQ1sk+cdUpeFmy6wPeTKNvZ/90DvMDr31VZXm5y
	 HyJgXpMIkZqpw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B497917E10AE;
	Wed, 18 Sep 2024 12:15:20 +0200 (CEST)
Message-ID: <92a8d48f-e109-461b-bb6a-29da98a444ad@collabora.com>
Date: Wed, 18 Sep 2024 12:15:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/mediatek: ovl: Add fmt_convert function pointer to
 driver data
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Singo Chang
 <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240917164434.17794-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240917164434.17794-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/24 18:44, Jason-JH.Lin ha scritto:
> OVL_CON_CLRFMT_MAN is a configuration for extending color format
> settings of DISP_REG_OVL_CON(n).
> It will change some of the original color format settings.
> 
> Take the settings of (3 << 12) for example.
> - If OVL_CON_CLRFMT_MAN = 0 means OVL_CON_CLRFMT_RGBA8888.
> - If OVL_CON_CLRFMT_MAN = 1 means OVL_CON_CLRFMT_PARGB8888.
> 
> Since OVL_CON_CLRFMT_MAN is not supported on previous SoCs,
> It breaks the OVL color format setting of MT8173.
> 
> Therefore, the fmt_convert function pointer is added to the driver data
> and mtk_ovl_fmt_convert_with_blend is implemented for MT8192 and MT8195
> that support OVL_CON_CLRFMT_MAN, and mtk_ovl_fmt_convert is implemented
> for other SoCs that do not support it to solve the degradation problem.
> 
> Fixes: a3f7f7ef4bfe ("drm/mediatek: Support "Pre-multiplied" blending in OVL")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Awesome.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



