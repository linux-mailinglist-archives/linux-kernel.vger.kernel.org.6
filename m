Return-Path: <linux-kernel+bounces-555720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB8A5BBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F9D18869D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8477225A50;
	Tue, 11 Mar 2025 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M/re1CNF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDCC222587
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684489; cv=none; b=lCTYFrEjwza5b8eMuQY+fcu94v3uF8vItKSF9DrR8GXi6lsVujraivdrA8kh7rHaGBuEM8ifCNqTL+HSUB8jg2lpnTY06dR7MSIYXi790JOPLUSN/hmkByBmzYagFTyWP+8WlVpdVSuXgMsN+DColGVWdDdOxHqv2KS2c9rwe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684489; c=relaxed/simple;
	bh=krh3Xo5+e4+66cDwA1x9mFLk+qlGz6xj0D6Py+bTdGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDrovIl8UaSCAaTUUqieZI3L7hD6OagKgDp/mG/zxlBrnoJUBjmy1LvCuvPy7RlZT9jIO1g6/qnzZUbY6mHl/sAENAQ7f9XcV9G/cvR61s/zgMXX/+qCh1hBpKDE9Vb/DIDDDBARVmKN44KCjiE1wiuQSRSf2mU3qylyL8nLEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M/re1CNF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741684485;
	bh=krh3Xo5+e4+66cDwA1x9mFLk+qlGz6xj0D6Py+bTdGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M/re1CNFx5F+jw5e7H70TQm+ufe0OmJINW10yJMxMNdQd6dei7Wi3SIjNXfFULUHE
	 NmrQ/FsZDckcUX5QOMTs7NrkQpqnj9eMvf+7EReGAe23ywcw0imqF4Yyfu6+6r397I
	 vAPDO15efrbNI5y9CeSzoTOH6uJ0X6lEOHZXs4QyP/6o0AnfbOfGrz8OozhjbJAEHg
	 zyqPmX8vPPf0JIWiUejsZ6MCR1MjJkn75+AB9ziSX/VXe822CHdSJcVvoU/e6LzCHm
	 tdsBSLjxPLHv5RsbL/RIMNBzaHIyAAJDZpvmWpic1fH4ECcYZY5nHB4eViVua5/5zg
	 RSzx2HorV+WuQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ABF4017E0B25;
	Tue, 11 Mar 2025 10:14:44 +0100 (CET)
Message-ID: <16f6a6e2-4dce-4af9-bc0a-61c4d6213f02@collabora.com>
Date: Tue, 11 Mar 2025 10:14:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] drm/panfrost: Add support for AARCH64_4K page
 table format
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
 <20250310195921.157511-5-ariel.dalessandro@collabora.com>
 <20250311090545.3b941567@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250311090545.3b941567@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/03/25 09:05, Boris Brezillon ha scritto:
> On Mon, 10 Mar 2025 16:59:19 -0300
> Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:
> 
>> Currently, Panfrost only supports MMU configuration in "LEGACY" (as
>> Bifrost calls it) mode, a (modified) version of LPAE "Large Physical
>> Address Extension", which in Linux we've called "mali_lpae".
>>
>> This commit adds support for conditionally enabling AARCH64_4K page
>> table format. To achieve that, a "GPU optional configurations" field was
>> added to `struct panfrost_features` with the related flag.
>>
>> Note that, in order to enable AARCH64_4K mode, the GPU variant must have
>> the HW_FEATURE_AARCH64_MMU feature flag present.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_device.h |  16 +++
>>   drivers/gpu/drm/panfrost/panfrost_mmu.c    | 132 +++++++++++++++++++--
>>   drivers/gpu/drm/panfrost/panfrost_regs.h   |  34 ++++++
>>   3 files changed, 169 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
>> index cffcb0ac7c111..0385702aa43c7 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
>> @@ -42,6 +42,14 @@ enum panfrost_gpu_pm {
>>   	GPU_PM_VREG_OFF,
>>   };
>>   
>> +/**
>> + * enum panfrost_gpu_config - GPU optional configurations
>> + * @GPU_CONFIG_AARCH64_4K: Use AARCH64_4K page table format
>> + */
>> +enum panfrost_gpu_config {
>> +	GPU_CONFIG_AARCH64_4K,
>> +};
>> +
>>   struct panfrost_features {
>>   	u16 id;
>>   	u16 revision;
>> @@ -95,6 +103,9 @@ struct panfrost_compatible {
>>   
>>   	/* Allowed PM features */
>>   	u8 pm_features;
>> +
>> +	/* GPU features */
>> +	u8 gpu_configs;
> 
> I would probably name this gpu_quirks, with the GPU_CONFIG_AARCH64_4K
> flag renamed GPU_QUIRK_FORCE_AARCH64_PAGE_TABLE.
> 

Boris, at this point the quirk should be LPAE, not AARCH64_4K, because the
former is legacy...

I think that Ariel is right in this, as in, that's a capability of the GPU
MMU, so if anything I would rather rename it to gpu_capabilities, but then
that'd be confusing for other stuff - which means that gpu_configs is most
probably the least confusing and/or most appropriate name for this.

Of course, just IMO.

Cheers,
Angelo

>>   };
>>   


