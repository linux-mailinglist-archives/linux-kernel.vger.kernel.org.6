Return-Path: <linux-kernel+bounces-558231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F31A5E31E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC57177CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79A72512D0;
	Wed, 12 Mar 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="PcsztnZt"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760F1DED52
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801781; cv=pass; b=RiOnDatMS8Y5j3UQ76gdjoMLQoROHYv2iplciAeAE/8hi4E3FjXIqUAnueg2MKCR+/hLbAqAxEqbzcjZQOgoDRw+2qQaWf0Vp9mEF98vRHwI7SfpAMUbjCNIoLfK57XRTwYap7i0Sci+wxnnHEaYPwx8J/XnrUCZinPqEZRhDEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801781; c=relaxed/simple;
	bh=zDv0/KZmv1LdExGbKvPtGWRSkGpMX6h+Y85UZhzt1K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYxQXr5ui6zefP6CMA2zEsVIEcy+QHK4hKP30U2R13yut/syR70K+gKYPlMNfA53EMd27AXBLr4yN7ZPVKLBRS75EOC4OqQoeViitsWRQFGM99gSxKYiCpUEHqu1vrBVxE2KyqXKpFhQHLHFsOG3wwp0+5NDXIbXssVN2wD577A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=PcsztnZt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741801753; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SAfl3N8rsewqYQDnkeV+PD2E0zfVHAAv5MietZH3WR2v2Y4QRPOYPD1rDyyxAoshpdUIPXsC5nF5jdsKmDot4M/Nl6bhbYBGjs3f6YFN9xh1e+h0P2AsYgC4AdhHiKpARRcRibWqpzz0E6gu8zDVVIVWUaoAoP5ONaXNWFk5XyA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741801753; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3f7x136P0U6iN8JQ3Mpr6oOy7NFn9xkBlwLZt3BmvGw=; 
	b=JB5ctn7tlkBwWu0sHQ/s/JN7bvVvP9EXQSfrTN1xbxEhGBbu8u+C5xbZkVLWcLxQbjwUdZhGxYX7falDJKU5MP0o7UlLSaV+AFC1DfbEow8KB187SwSRiER+FzS/r0+wfssLfCTgNDrb2TjULjHYY1QF2W+Z1Jew9Z7Dpm7Ve9A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741801753;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3f7x136P0U6iN8JQ3Mpr6oOy7NFn9xkBlwLZt3BmvGw=;
	b=PcsztnZtOkz2ga7BERVEd9BX8jpKBSNjDMbEUtYwSKCPm7vk6cmCRZOv0MjPZLQo
	dXjByBMvE1o4lyxCtUcfbqyZSFbsseTCXh1W6wxiWHjdhjeDhc9xSQHRLFNOPCYVfHF
	BEK9mAWLiOCAuGLZILtpIaTFdDNHRH/s0JwHXrq0=
Received: by mx.zohomail.com with SMTPS id 174180175060146.026318885376554;
	Wed, 12 Mar 2025 10:49:10 -0700 (PDT)
Message-ID: <6bc2abd2-4d1d-4b94-b2f3-6d3638f3e8ba@collabora.com>
Date: Wed, 12 Mar 2025 14:49:03 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] drm/panfrost: Add support for AARCH64_4K page
 table format
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
 <20250310195921.157511-5-ariel.dalessandro@collabora.com>
 <20250311090545.3b941567@collabora.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20250311090545.3b941567@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Boris,

On 3/11/25 5:05 AM, Boris Brezillon wrote:
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

Will follow on this thread after latest responses.

>>   };
>>   
>>   struct panfrost_device {
>> @@ -162,6 +173,11 @@ struct panfrost_mmu {
>>   	int as;
>>   	atomic_t as_count;
>>   	struct list_head list;
>> +	struct {
>> +		u64 transtab;
>> +		u64 memattr;
>> +		u64 transcfg;
>> +	} cfg;
>>   };
>>   
>>   struct panfrost_engine_usage {
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> index 31df3a96f89bd..4a9b8de2ff987 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -26,6 +26,48 @@

[snip]

>> +static void mmu_cfg_init_aarch64_4k(struct panfrost_mmu *mmu)
>> +{
>> +	struct io_pgtable_cfg *pgtbl_cfg = &mmu->pgtbl_cfg;
>> +
>> +	mmu->cfg.transtab = pgtbl_cfg->arm_lpae_s1_cfg.ttbr &
>> +				AS_TRANSTAB_AARCH64_4K_ADDR_MASK;
> 
> Silently masking the low 4bits is not the solution, it's just papering
> over a real issue. If pgtbl_cfg->arm_lpae_s1_cfg.ttbr is not aligned on
> 16 bytes (PAGE_SIZE even) we have a problem, so I would drm_WARN_ON()
> here, and return an error so we can fail the probe.

Good point. I'll add something like this in v2:

         if (drm_WARN_ON(pfdev->ddev, pgtbl_cfg->arm_lpae_s1_cfg.ttbr &
                                      ~AS_TRANSTAB_AARCH64_4K_ADDR_MASK))
                 return -EINVAL;

>> +
>> +	mmu->cfg.memattr = mair_to_memattr(pgtbl_cfg->arm_lpae_s1_cfg.mair,
>> +					   pgtbl_cfg->coherent_walk);
>> +
>> +	mmu->cfg.transcfg = AS_TRANSCFG_PTW_MEMATTR_WB |
>> +			    AS_TRANSCFG_PTW_RA |
>> +			    AS_TRANSCFG_ADRMODE_AARCH64_4K |
>> +			    AS_TRANSCFG_INA_BITS(55 - pgtbl_cfg->ias);
>> +	if (pgtbl_cfg->coherent_walk)
>> +		mmu->cfg.transcfg |= AS_TRANSCFG_PTW_SH_OS;
>> +}

[snip]

>> @@ -616,6 +709,7 @@ struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>>   {
>>   	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(pfdev->features.mmu_features);
>>   	u32 pa_bits = GPU_MMU_FEATURES_PA_BITS(pfdev->features.mmu_features);
>> +	enum io_pgtable_fmt fmt = ARM_MALI_LPAE;
>>   	struct panfrost_mmu *mmu;
>>   
>>   	mmu = kzalloc(sizeof(*mmu), GFP_KERNEL);
>> @@ -641,16 +735,28 @@ struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>>   		.iommu_dev	= pfdev->dev,
>>   	};
>>   
>> -	mmu->pgtbl_ops = alloc_io_pgtable_ops(ARM_MALI_LPAE, &mmu->pgtbl_cfg,
>> -					      mmu);
>> -	if (!mmu->pgtbl_ops) {
>> -		kfree(mmu);
>> -		return ERR_PTR(-EINVAL);
>> +	if (pfdev->comp->gpu_configs & BIT(GPU_CONFIG_AARCH64_4K)) {
>> +		if (!panfrost_has_hw_feature(pfdev, HW_FEATURE_AARCH64_MMU)) {
>> +			dev_err_once(pfdev->dev,
>> +				     "AARCH64_4K page table not supported\n");
>> +			goto err_free_mmu;
>> +		}
>> +		fmt = ARM_64_LPAE_S1;
>>   	}
> 
> How about moving this check before allocating the mmu object, so you
> don't have to free it if it fails?

Yes, will fix in v2.

Thanks!

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


