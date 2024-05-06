Return-Path: <linux-kernel+bounces-169966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD428BCFFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA79288852
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E7013E051;
	Mon,  6 May 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qZNk2uVI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8F81211;
	Mon,  6 May 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005110; cv=none; b=cj5nSucAr5PYkEPjO6py4POy8sWqP1ZX3x7JgtzIQwrh66DdPF2+/3oU0qzRP2vcW2njFatmxMalPnEqjJKA1RWgfhTmOZV1CgDPIcF3O0S3mXWL0Rs5Viw7apQQcNAuLdUK6RqE4KVxXn7dsd1tiEOntsXJaju/eqzoX4WSP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005110; c=relaxed/simple;
	bh=Vi05QVSG3iatwDAILN86QUEWJ3fE0RrPn+kvsUCWGws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCE+H5cWpb/BS1KCngd5EcN28pLLT4azO39bmMf4AMmcJpHhKSQAsryHv5OsLPeXzP/D1MAhibTtS9Fs8OJVPGkujh9ClK0HN+8jAINCwifE3bwXKBQhWIkaQZa8oGDlPIptHtkOIQ0nrqIkycadlQWa/dj9957xzOIykv+pDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qZNk2uVI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715005106;
	bh=Vi05QVSG3iatwDAILN86QUEWJ3fE0RrPn+kvsUCWGws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qZNk2uVI+pZGR3kmAAkImZwSLKE9T+TahIUXH14Y7DA0Pnhl54iALE4oXsJK4KjMq
	 l3djJ5Ie/y8OAuQJelPxMxPTHk/toXDpEj+cBGquJK5jnoHgZg5RTsXXrsN8/rXtmA
	 0FTxMdNRP/UOBcTJ2JRvdnjmqjOIM9FXNe35X/pyLiOiQi3u98e+N5EiyRLdbb4qzo
	 lvVgqpKVoTWeQ39JSe9EJUrwwbL7iP3bIzwK3o2nZNR+xPMAXap5I7bNRijl+zO/e+
	 ICB9MvXQkAU51lwau8PqYmHqQMG+Le3wdbXBgrYcFS14L6RxnoinEbMJ2PeTQb+zs0
	 zNGjrTFn187Kw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4BD99378020D;
	Mon,  6 May 2024 14:18:25 +0000 (UTC)
Message-ID: <2e3e49ff-8ace-498b-b2d0-54500e6f1e70@collabora.com>
Date: Mon, 6 May 2024 16:18:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/mediatek: Add support for OF graphs
To: Michael Walle <mwalle@kernel.org>,
 Alexandre Mergnat <amergnat@baylibre.com>, chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
 <1fc23530-89ba-4e36-9e9a-a1289f56a9bc@baylibre.com>
 <608fdbde-ad06-45ec-9771-18aa9f002f2d@collabora.com>
 <D12H4GDJJEUF.1Y91H9RMUIX20@kernel.org>
 <50be68dc-b86a-4334-9f83-43c6fda2c271@collabora.com>
 <1b8fa907-b48f-4ebe-bc17-3de1d7c0d062@collabora.com>
 <D12LA0QKEFRQ.68TZEVQZ7FJB@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <D12LA0QKEFRQ.68TZEVQZ7FJB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/05/24 15:17, Michael Walle ha scritto:
> Hi Angelo,
> 
> On Mon May 6, 2024 at 1:22 PM CEST, AngeloGioacchino Del Regno wrote:
>>> The problem with this is that you need DDP_COMPONENT_DRM_OVL_ADAPTOR... which is
>>> a software thing and not HW, so that can't be described in devicetree.
>>>
>>> The only thing this series won't deal with is exactly that.
>>
>> Sorry, no, I got confused.
>>
>> The series *does* already deal with that, as the pipeline is built before the check
>> for OVL_ADAPTOR components, so that will get probed.
> 
> Are you sure? Because who is actually adding the OVL_ADAPTOR to the
> path? It looks like your patch will walk the graph and add all the
> components according to their compatible string. And since the
> OVL_ADAPTOR is virtual and doesn't have a node..
> 

I shouldn't look at code while having a flu.

	if (mtk_drm_find_mmsys_comp(private, DDP_COMPONENT_DRM_OVL_ADAPTOR)) {

..but yes nothing adds the mmsys_comp for OVL_ADAPTOR.

Needs to be addressed, will do that asap.

