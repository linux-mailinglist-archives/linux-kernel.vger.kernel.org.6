Return-Path: <linux-kernel+bounces-557863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF1EA5DEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACAF3B60BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27EC24DFEF;
	Wed, 12 Mar 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="MjBhGQ5k"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1F24A062
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789274; cv=pass; b=pq7tnX0liTGL5fgwczMHtBHWY6b9/k+e1AD6FSYsTGiMOTtMyK19I7N4Qycm59icBKlUnoadhyEWCEd5DHQBcjjStxGMTM+g7ACuTtmxK1ya2q46WX+DTKP8KdCsyxwWnJ834Wdd7seSTjZxzYiBAP7nRPCMXrlM9a4C2yDQbVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789274; c=relaxed/simple;
	bh=T5Fz/Xkym3pHKl4anH2NhMdxtWQlvoOIc+/QXp3OtE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kV87l0BoJ0FmhKHHFG2i6YAfgmFAxfVdt8K/qGc2BIoYiL2fwko1sFqVYXhHQ7ujhBkGzJNcaB9JhiAvXKTsVEXddF1RqmJvwZaN7JveoVV6k+HN/BMmUaJRd37bjwPayPVL6ApcIu0HJT++icXaH+cnVVf/kL9FRR9xO1+GY/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=MjBhGQ5k; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741789241; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AmmAx8zhvqOgEriWIg3TJZ/eYdtxX9PCy6ZmTadMSJYjAgixhbollceHi3mKg/7oFug+mG5roQOaMYB8wrrbSk0AIxiBMJXtT/n/I4WophxszsLyJRcN+5Nxc1SdHCoWGPscyDdidlzwkDvvYit0rg3eFjmE5Jmpbam2egWw6ak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741789241; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Lr9QZU/bvI8GMhShiHoF7m3aAfwgiT4ZYtZzTBsdWHI=; 
	b=Zx9kKVijTQMLRQ0p47XY3emFrNcG1mhTRjh182Mbx2zGh/H1t/bgiLT2VxW6+AJhGAr6Yh4Jg2KLhTvUg1+khHxEpxLMp6qleYDA9h8lqHxcyCROMtfMKVZ9gdCkPTHiOmBtkGfM6gPul/JOHdnlBknfKcvZ9kID+9C4TwNSRn0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741789241;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Lr9QZU/bvI8GMhShiHoF7m3aAfwgiT4ZYtZzTBsdWHI=;
	b=MjBhGQ5krNUbylNTnTWgJZHxsI2lu5fkeWB8gFoRzDJVpbEUIp2vA/cMZ+49UzH4
	XwZjhlBKSwu0GIqUzZwRUUZYPiIRmIGvLmzYLlwHwW3wqiK6LyS+bZfI0oOhtNroeH0
	+FcgML0nUt4txxMwwMMg/vl0wZ2PCzL+7u+UU/3c=
Received: by mx.zohomail.com with SMTPS id 1741789239857600.4648741596387;
	Wed, 12 Mar 2025 07:20:39 -0700 (PDT)
Message-ID: <d2ec6fe3-db78-4e8b-ac81-fd4c631a599b@collabora.com>
Date: Wed, 12 Mar 2025 11:20:33 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] drm/panfrost: Add support for AARCH64_4K page
 table format
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kernel@collabora.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sjoerd@collabora.com
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
 <20250310195921.157511-5-ariel.dalessandro@collabora.com>
 <760e3112-0433-41ab-ab39-faaf0463fbe8@collabora.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <760e3112-0433-41ab-ab39-faaf0463fbe8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Angelo,

On 3/11/25 6:10 AM, AngeloGioacchino Del Regno wrote:
> Il 10/03/25 20:59, Ariel D'Alessandro ha scritto:
>> Currently, Panfrost only supports MMU configuration in "LEGACY" (as
>> Bifrost calls it) mode, a (modified) version of LPAE "Large Physical
>> Address Extension", which in Linux we've called "mali_lpae".
>>
>> This commit adds support for conditionally enabling AARCH64_4K page
>> table format. To achieve that, a "GPU optional configurations" field was
>> added to `struct panfrost_features` with the related flag.

[snip]

>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/ 
>> drm/panfrost/panfrost_mmu.c
>> index 31df3a96f89bd..4a9b8de2ff987 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c

[snip]

>> +static void panfrost_mmu_cfg_init(struct panfrost_mmu *mmu,
>> +                  enum io_pgtable_fmt fmt)
>> +{
>> +    struct panfrost_device *pfdev = mmu->pfdev;
>> +
>> +    switch (fmt) {
>> +    case ARM_64_LPAE_S1:
>> +        mmu_cfg_init_aarch64_4k(mmu);
>> +        break;
>> +    case ARM_MALI_LPAE:
>> +        mmu_cfg_init_mali_lpae(mmu);
>> +        break;
>> +    default:
> 
> If you add a
>          /* That should never happen */
> 
> ...it's clear-er why this function doesn't fail (but still raises some 
> eyebrows,
> because if the `default` case is not reachable, why does it even have a 
> print?).

Makes sense. In that case, makes sense to just simplify it as:

         default:
                 /* This should never happen */
                 WARN_ON(1);
                 break;

>> +        dev_WARN_ONCE(pfdev->dev, 1, "Unhandled page table format\n");
>> +        break;
>> +    }
>> +}
>> +
>>   static void
>>   _panfrost_mmu_as_control_write(struct panfrost_device *pfdev, u32 
>> as_nr,
>> -                   u64 transtab, u64 memattr)
>> +                   u64 transtab, u64 memattr, u64 transcfg)
>>   {
>>       mmu_hw_do_operation_locked(pfdev, as_nr, 0, ~0ULL, 
>> AS_COMMAND_FLUSH_MEM);
>> @@ -133,25 +223,28 @@ _panfrost_mmu_as_control_write(struct 
>> panfrost_device *pfdev, u32 as_nr,
>>       mmu_write(pfdev, AS_MEMATTR_LO(as_nr), lower_32_bits(memattr));
>>       mmu_write(pfdev, AS_MEMATTR_HI(as_nr), upper_32_bits(memattr));
>> +    mmu_write(pfdev, AS_TRANSCFG_LO(as_nr), lower_32_bits(transcfg));
>> +    mmu_write(pfdev, AS_TRANSCFG_HI(as_nr), upper_32_bits(transcfg));
>> +
>>       write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
>> +
>> +    dev_dbg(pfdev->dev, "mmu_as_control: as=%d, transtab=0x%016llx, 
>> memattr=0x%016llx, transcfg=0x%016llx",
>> +        as_nr, transtab, memattr, transcfg);
>>   }
>>   static void panfrost_mmu_enable(struct panfrost_device *pfdev, 
>> struct panfrost_mmu *mmu)
>>   {
>> -    int as_nr = mmu->as;
>> -    struct io_pgtable_cfg *cfg = &mmu->pgtbl_cfg;
>> -    u64 transtab = cfg->arm_mali_lpae_cfg.transtab;
>> -    u64 memattr = cfg->arm_mali_lpae_cfg.memattr;
>> -
>>       /* Need to revisit mem attrs.
>>        * NC is the default, Mali driver is inner WT.
>>        */
>> -    _panfrost_mmu_as_control_write(pfdev, as_nr, transtab, memattr);
>> +    _panfrost_mmu_as_control_write(pfdev, mmu->as, mmu->cfg.transtab,
>> +                       mmu->cfg.memattr, mmu->cfg.transcfg);
>>   }
>>   static void panfrost_mmu_disable(struct panfrost_device *pfdev, u32 
>> as_nr)
>>   {
>> -    _panfrost_mmu_as_control_write(pfdev, as_nr, 0, 0);
>> +    _panfrost_mmu_as_control_write(pfdev, as_nr, 0, 0,
>> +                       AS_TRANSCFG_ADRMODE_UNMAPPED);
>>   }
>>   u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct 
>> panfrost_mmu *mmu)
>> @@ -616,6 +709,7 @@ struct panfrost_mmu 
>> *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>>   {
>>       u32 va_bits = GPU_MMU_FEATURES_VA_BITS(pfdev- 
>> >features.mmu_features);
>>       u32 pa_bits = GPU_MMU_FEATURES_PA_BITS(pfdev- 
>> >features.mmu_features);
>> +    enum io_pgtable_fmt fmt = ARM_MALI_LPAE;
> 
> Double initialization! :-)

Will fix in v2.

>>       struct panfrost_mmu *mmu;
>>       mmu = kzalloc(sizeof(*mmu), GFP_KERNEL);
>> @@ -641,16 +735,28 @@ struct panfrost_mmu 
>> *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>>           .iommu_dev    = pfdev->dev,
>>       };
>> -    mmu->pgtbl_ops = alloc_io_pgtable_ops(ARM_MALI_LPAE, &mmu- 
>> >pgtbl_cfg,
>> -                          mmu);
>> -    if (!mmu->pgtbl_ops) {
>> -        kfree(mmu);
>> -        return ERR_PTR(-EINVAL);
>> +    if (pfdev->comp->gpu_configs & BIT(GPU_CONFIG_AARCH64_4K)) {
> 
> Why aren't you performing this check before kzalloc?
> 
> If you do so, you will be able to avoid having a goto, because this 
> check will
> simply return an error (struct not allocated yet, nothing to kfree).
> This also means that you won't have to modify anything about the error 
> handling
> of the alloc_io_pgtable_ops below....

Yup, definitely agreed. Thanks!

>> +        if (!panfrost_has_hw_feature(pfdev, HW_FEATURE_AARCH64_MMU)) {
>> +            dev_err_once(pfdev->dev,
>> +                     "AARCH64_4K page table not supported\n");
>> +            goto err_free_mmu;
>> +        }
>> +        fmt = ARM_64_LPAE_S1;
>>       }
> 
> } else {
>      fmt = ARM_MALI_LPAE;
> }

Ack. Will fix in v2.

> 
>> +    mmu->pgtbl_ops = alloc_io_pgtable_ops(fmt, &mmu->pgtbl_cfg, mmu);
>> +    if (!mmu->pgtbl_ops)
>> +        goto err_free_mmu;
>> +
>> +    panfrost_mmu_cfg_init(mmu, fmt);
>> +
>>       kref_init(&mmu->refcount);
>>       return mmu;
>> +
>> +err_free_mmu:
>> +    kfree(mmu);
>> +    return ERR_PTR(-EINVAL);
>>   }
>>   static const char *access_type_name(struct panfrost_device *pfdev,
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/ 
>> drm/panfrost/panfrost_regs.h
>> index b5f279a19a084..2b8f1617b8369 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
>> @@ -301,6 +301,17 @@
>>   #define AS_TRANSTAB_HI(as)        (MMU_AS(as) + 0x04) /* (RW) 
>> Translation Table Base Address for address space n, high word */
>>   #define AS_MEMATTR_LO(as)        (MMU_AS(as) + 0x08) /* (RW) Memory 
>> attributes for address space n, low word. */
>>   #define AS_MEMATTR_HI(as)        (MMU_AS(as) + 0x0C) /* (RW) Memory 
>> attributes for address space n, high word. */
>> +#define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL        (2 << 2)
>> +#define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)    ((3 << 2) | \
>> +                             ((w) ? BIT(0) : 0) | \
>> +                             ((r) ? BIT(1) : 0))
>> +#define   AS_MEMATTR_AARCH64_SH_MIDGARD_INNER        (0 << 4)
>> +#define   AS_MEMATTR_AARCH64_SH_CPU_INNER        (1 << 4)
>> +#define   AS_MEMATTR_AARCH64_SH_CPU_INNER_SHADER_COH    (2 << 4)
>> +#define   AS_MEMATTR_AARCH64_SHARED            (0 << 6)
>> +#define   AS_MEMATTR_AARCH64_INNER_OUTER_NC        (1 << 6)
>> +#define   AS_MEMATTR_AARCH64_INNER_OUTER_WB        (2 << 6)
>> +#define   AS_MEMATTR_AARCH64_FAULT            (3 << 6)
>>   #define AS_LOCKADDR_LO(as)        (MMU_AS(as) + 0x10) /* (RW) Lock 
>> region address for address space n, low word */
>>   #define AS_LOCKADDR_HI(as)        (MMU_AS(as) + 0x14) /* (RW) Lock 
>> region address for address space n, high word */
>>   #define AS_COMMAND(as)            (MMU_AS(as) + 0x18) /* (WO) MMU 
>> command register for address space n */
>> @@ -311,6 +322,24 @@
>>   /* Additional Bifrost AS registers */
>>   #define AS_TRANSCFG_LO(as)        (MMU_AS(as) + 0x30) /* (RW) 
>> Translation table configuration for address space n, low word */
>>   #define AS_TRANSCFG_HI(as)        (MMU_AS(as) + 0x34) /* (RW) 
>> Translation table configuration for address space n, high word */
>> +#define   AS_TRANSCFG_ADRMODE_LEGACY            (0 << 0)
>> +#define   AS_TRANSCFG_ADRMODE_UNMAPPED            (1 << 0)
>> +#define   AS_TRANSCFG_ADRMODE_IDENTITY            (2 << 0)
>> +#define   AS_TRANSCFG_ADRMODE_AARCH64_4K        (6 << 0)
>> +#define   AS_TRANSCFG_ADRMODE_AARCH64_64K        (8 << 0)
> 
> "Anything" shifted in any direction by 0 is equal to the same 
> "anything" :-)
> 
> Those are just 0,1,2,6,8

Well, I agree... However, I'm copying this from panthor as-is. As these 
are similar drivers, I just kept all the macro definitions.

> 
>> +#define   AS_TRANSCFG_INA_BITS(x)            ((x) << 6)
>> +#define   AS_TRANSCFG_OUTA_BITS(x)            ((x) << 14)
>> +#define   AS_TRANSCFG_SL_CONCAT                BIT(22)
>> +#define   AS_TRANSCFG_PTW_MEMATTR_NC            (1 << 24)
> 
> BIT(24)
> 
>> +#define   AS_TRANSCFG_PTW_MEMATTR_WB            (2 << 24)
> 
> BIT(25)
> 
>> +#define   AS_TRANSCFG_PTW_SH_NS                (0 << 28)
> 
> 0
> 
>> +#define   AS_TRANSCFG_PTW_SH_OS                (2 << 28)
> 
> BIT(29)
> 
>> +#define   AS_TRANSCFG_PTW_SH_IS                (3 << 28)
> 
> GENMASK(29, 28) or BIT(28) | BIT(29)
> 
> (btw, rinse and repeat for the memattrs)

I think the criteria used in panfrost/panthor for these definitions is:
* if the register field is 1 bit, use BIT()
* if the register field is >1 bit, use the value (as defined in the 
datasheet) an shift it.
* and -be super explicit- do this even if the value is 0.

I don't really have a strong opinion, but I'd attach to the 
subsystem/driver criteria used as much as possible :)

Thanks!

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


