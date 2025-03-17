Return-Path: <linux-kernel+bounces-563653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D714A64614
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D770188F5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7860B21D3F2;
	Mon, 17 Mar 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DHO7A4Tz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284738B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201395; cv=none; b=m8EAtLbRK+rL9iZClrOibF9QR9EhPVr6OF4s9BVl6PwlRt7XoDjrsCzQ2J+2PqGs273PiyOVV1+KrA9Rmn/PbxYm1e2B/dYfYfWFLv7FUmVYazr+F11vM8BYiSkIUe2buv3HyQEiR0dD3zCQ+485UADmoDzVcreDvrtSc/lK11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201395; c=relaxed/simple;
	bh=1rfFLt1FGwRgYWw/LMCOw039hfCefer9lrU++Y7m7yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZIp7gO/tS8x5giYpdqS8btxAGgk1Nb10UDFpLT/q0m4GgPSkEwWe1XXNckCSs4jL8TxNy0LKPO1bNFeboGJJxAzIJyCvpjV7C6Vkw/W1IqpYl7dT+VKo0lLVdGeqs7roNJ4oWWtXIawwszbIy6HrLfBtoU+HcndZcfmVYFiq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DHO7A4Tz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742201391;
	bh=1rfFLt1FGwRgYWw/LMCOw039hfCefer9lrU++Y7m7yQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DHO7A4TzNIY+kl7FjgK92H8XgzGX5OK+PG92cDnJsYXUKg79N/I2KtlUzLpcFN3OZ
	 xGVtDl5g8o9InTjieFWFOHsp9jKiL99tZEHE2yImw1eLFOAIOKU/n/zw/EuFiI4ZNg
	 bf0cs3Je4lPc2GVdirmD8RKUaKyYderkv0lZD/ac38d5gAq8qbj27yBgip9Uf6ii0o
	 2nrCkJwtql8o376/PNVzvuQtOqlpKMH/cUkU+VdwxtAi2llJjMLE2S3awcaLMuaSJp
	 /vcHRnd96R3bOYqenrWofpH4LGBQ3OQorx/9t5m4wGC9YUq0EKwKklQQtQy0TL0lNm
	 aTBbzanb/LRiA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3565D17E0848;
	Mon, 17 Mar 2025 09:49:50 +0100 (CET)
Message-ID: <e217363f-5492-486e-8063-8e3eed047b00@collabora.com>
Date: Mon, 17 Mar 2025 09:49:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] drm/panfrost: Add support for AARCH64_4K page
 table format
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kernel@collabora.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sjoerd@collabora.com
References: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
 <20250314173858.212264-5-ariel.dalessandro@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250314173858.212264-5-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/03/25 18:38, Ariel D'Alessandro ha scritto:
> Currently, Panfrost only supports MMU configuration in "LEGACY" (as
> Bifrost calls it) mode, a (modified) version of LPAE "Large Physical
> Address Extension", which in Linux we've called "mali_lpae".
> 
> This commit adds support for conditionally enabling AARCH64_4K page
> table format. To achieve that, a "GPU optional quirks" field was added
> to `struct panfrost_features` with the related flag.
> 
> Note that, in order to enable AARCH64_4K mode, the GPU variant must have
> the HW_FEATURE_AARCH64_MMU feature flag present.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

I would've preferred the LEGACY format to be a quirk, instead of AARCH64, but
okay.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



