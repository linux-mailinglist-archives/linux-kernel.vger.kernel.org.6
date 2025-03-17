Return-Path: <linux-kernel+bounces-563654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB93A6461E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96B7188F891
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BBD221558;
	Mon, 17 Mar 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VhdM3Sgy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70521ADCB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201411; cv=none; b=nRwXFiBO5NmgGb2bbdkHK1ZdP8rJ2hhNhR8k2ye2daU7eJy/5zg3uICD6Oks6sOCNOexAbMIvDKZz0mo2oN+cE+zbBPjGX6qgYcXW5q2eWlzkjzCZsag4IYMP1taLx1RUFX2rNMhVPfPREV/UvPOE2VPXz+0KKr2AXxVZoIlZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201411; c=relaxed/simple;
	bh=WUiRsmcXf/5mpOBvUvpB9sSawrbuJ+mi9kvDgMHpCz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptVmRE3RCHfScoJM541Ynmd4QzcxkPMNrf0IanMYC1NCu9mrvFNOF6SbqIHLilin/pKrp/urqa8uCRnm1RXqfVaV2b/QQ+WD2HuTiVngZ866TSLpYc1DIV1WslgTDzRBzKql8nZyIaQuRr6t/n4nnafjDFatKzwYJeT0NiZwd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VhdM3Sgy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742201407;
	bh=WUiRsmcXf/5mpOBvUvpB9sSawrbuJ+mi9kvDgMHpCz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VhdM3Sgy+M9TR4PPkjJ+jOpE7S79oBu32SNg0SksjR13gt9lNt1AeP68lupTSkOwx
	 xAdcorLe6RRO7Ip1w8/aSlFynrlfZDVLPNxGA9XpbGw7r7WYu9dN4rzXLs0RDZlPyL
	 LsrJoXr0hTqEYaGKb7NbG0gHgVi1WwLN1r//y2xNABVZcahZNd1Mm4FzGWKS/7eik5
	 KxkGLycxmXQsvXZgBCwV38qwlzeZRnCIaNYjBo5qxei99gOp8UHapemXJ3J7dBunAw
	 QKL5Wv5GFrNB15v+v4GXEYCK3p1IiL6PVii5b4sOBbAnHPn3wGJaEl7EcgdwOoZ9b8
	 1OgWfjcFzzsfA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 064F217E0848;
	Mon, 17 Mar 2025 09:50:06 +0100 (CET)
Message-ID: <0cd19f91-2726-419c-ba92-fdb8e7a38377@collabora.com>
Date: Mon, 17 Mar 2025 09:50:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drm/panfrost: Force AARCH64_4K page table format
 on MediaTek MT8192
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kernel@collabora.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sjoerd@collabora.com
References: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
 <20250314173858.212264-7-ariel.dalessandro@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250314173858.212264-7-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/03/25 18:38, Ariel D'Alessandro ha scritto:
> MediaTek MT8192 SoC has an ARM Mali-G57 MC5 GPU (Valhall-JM). Now that
> Panfrost supports AARCH64_4K page table format, let's enable it on this
> SoC.
> 
> Running glmark2-es2-drm [0] benchmark, reported the same performance
> score on both modes Mali LPAE (LEGACY) vs. AARCH64_4K, before and after
> this commit. Tested on a Mediatek (MT8395) Genio 1200 EVK board.
> 
> [0] https://github.com/glmark2/glmark2
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



