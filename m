Return-Path: <linux-kernel+bounces-340140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C723986EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711E51C24A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF127192B65;
	Thu, 26 Sep 2024 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X653y6rv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B51C6A3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339861; cv=none; b=ho1tHxcc9ZYJd11hA9HOpz+robZTUMQfxAaJlDZ6qiDXq7z1GMgX5KQk24Aabx6z0EOGSLFfqVub5RVQ/+0+gu8+2QwYxdG7efLKM2iLN8A47DLFeAa+mHmxQGAKky0OMN2hEQzmiojGScZFRR8i0pZ130eY9VQMtRqZaAP+UdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339861; c=relaxed/simple;
	bh=1P1r8VZxe/zn+c9DOqxIXnq8EBkiT30JweUnMt9tvdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/xn4WcrNBd2sNLSDf5KZXM9pZsroRkZ5ds8aV3doC5yIa1Uv2A5b+uMFOomgSxVVRQUwrceXJrYMpGrA8vnT1zK+VaoU05wtJGPYhCEVDOBtNsCDLt6yW/vDVfTWTel8tvFnYK47hSiPaQcqpOg/sTV67Befg+sRhnJy/YEBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X653y6rv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727339857;
	bh=1P1r8VZxe/zn+c9DOqxIXnq8EBkiT30JweUnMt9tvdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X653y6rvkSthS/5duP//v09NQJeY6fLxTzrkLJ54ExRu5LUNgWu5ZPg/d4R8/qHeO
	 tJuDXJ1zd7uu5w5/eJYxUuKwy6UKXq4aIX6fq+XYNzmIKp9gsYkBt6+rdot0aPJp6a
	 P1tV1F3hhwtDbmLzhlM6IXAXsnJMRyv57FGd+mEReCQAMh0wP99v4vGqwgaWOvvuDV
	 VT+/Kcpry07mr03LjUNEs0ejNdzh5/T1eydsQHRaDSW2aEobN+Rl/ertu/KfLU+BjU
	 8+lT/hf65O1R6YgETw/C+AyFi9B7l5SapIU59nOBxV9b12+Q6jAEXk0V5957cApCXG
	 jSlmt2t00irmA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B20217E0FC2;
	Thu, 26 Sep 2024 10:37:37 +0200 (CEST)
Message-ID: <64b96ec0-1264-4a3c-a26d-f8a0c3375d79@collabora.com>
Date: Thu, 26 Sep 2024 10:37:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Singo Chang
 <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240925101927.17042-1-jason-jh.lin@mediatek.com>
 <20240925101927.17042-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925101927.17042-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 12:19, Jason-JH.Lin ha scritto:
> Since some SoCs support premultiplied pixel formats but some do not,
> the blend_modes parameter is added to mtk_plane_init(), which is
> obtained from the mtk_ddp_comp_get_blend_modes function implemented
> in different OVL components.
> 
> The OVL component can use driver data to set the blend mode
> capabilities for different SoCs.
> 
> Fixes: 4225d5d5e779 ("drm/mediatek: Support alpha blending in display driver")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Just perfect.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


