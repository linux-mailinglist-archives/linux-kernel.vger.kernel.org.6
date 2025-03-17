Return-Path: <linux-kernel+bounces-564357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E3A653A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560FE166685
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10323F401;
	Mon, 17 Mar 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="CiAXpq8N"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1D2940D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221897; cv=pass; b=IqzrMzgiSXrdxyM634gdun205v7GLMl070my3o1oHuX0h2Gh//bVn+lTZdqf3nn2q9/yt+fXdoseKOfMwRX1OIZf0LBwkbInEULPXFR6o9yYeINumF+Y4AcmvCh3POmUc35mxcVmTaj4bJ90BcV5KXt61B/jaEl4uKSLg5fo9Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221897; c=relaxed/simple;
	bh=+cKkWnVr1coakUMf/WK6R0x3EVXrLJlx4VnLHV8Mp/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbXdTQ/oz7J5+HpzLXIr4j0TD3FGKVkRu8vNp9WNtQNDrZjemKXKbYUe58yYM/QkbdcA/XGrL5amJ6/+qfo8Crd+iNM/WPD7SC7HHJiE0Z275GZGdyisxfzcdRJHKHJUshpTBuyuft2ICtmvlHwOqOZXRRwoM9KtllA6xmtLgQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=CiAXpq8N; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742221868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BJpEgdkNOnSiwPrSUBLBl5lYM+9hFEOctSz9K9PKKQtT5xnLZulbT4jKlx5w5CyrA7bRjPfUchYlYQNkDIwJ3I8ppedq7Dv1VUg5TyTlG2+HY/vwjLnveGsb3+E7+EoKkbk06OmOsrqbOGSgrmMMWNGes0MRf19ZxaeGjSmMx2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742221868; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=juhBGFrnJEtXmwmWUkOgurD4ow1+cM0JUbcI3gD4F48=; 
	b=ecgMK9cayVciXKLAu5E0ZSdMZjVvZf7lm927GcnIz1VU3UBjjcCpsJr6CrO7K2f9wtg5uRocgz3DxeRYM18tgoBdiZTywAnL0hqyXDt7roYcgzXKcBYO7FVAEnXnxnPBUWt3hueS0tglURSEXOwtsGM2mod3r3cMkKSr9mVwDrU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742221868;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=juhBGFrnJEtXmwmWUkOgurD4ow1+cM0JUbcI3gD4F48=;
	b=CiAXpq8Nrl/AHbcs52PL//215ZsdMXGiJpd1bLL0pvgHIbsjUTw4dPW6Xg9FdhHh
	VyKaKpzY/kQP6q94ru+oCbZfFGzK9UMFu98OW0CsHa8T49RsZCBg6kxjO7W9/aGUXG1
	zrh0Fz3mtauDQ+mUb70hAcN9IV4RZYToVMNZEumQ=
Received: by mx.zohomail.com with SMTPS id 1742221866050461.80081265142326;
	Mon, 17 Mar 2025 07:31:06 -0700 (PDT)
Message-ID: <992360e3-632c-4a0e-bb84-a72be7d7cd37@collabora.com>
Date: Mon, 17 Mar 2025 11:30:59 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] drm/panfrost: Add support for AARCH64_4K page
 table format
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com,
 angelogioacchino.delregno@collabora.com
References: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
 <20250317124044.16257-5-ariel.dalessandro@collabora.com>
 <20250317144436.2bcc17ed@collabora.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20250317144436.2bcc17ed@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Boris,

On 3/17/25 10:44 AM, Boris Brezillon wrote:
> On Mon, 17 Mar 2025 09:40:42 -0300
> Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:
> 
>> +static int panfrost_mmu_cfg_init(struct panfrost_mmu *mmu,
>> +				  enum io_pgtable_fmt fmt)
>> +{
>> +	struct panfrost_device *pfdev = mmu->pfdev;
>> +
>> +	switch (fmt) {
>> +	case ARM_64_LPAE_S1:
>> +		return mmu_cfg_init_aarch64_4k(mmu);
>> +	case ARM_MALI_LPAE:
>> +		return mmu_cfg_init_mali_lpae(mmu);
>> +	default:
>> +		/* This should never happen */
>> +		return drm_WARN_ON(pfdev->ddev, -EINVAL);
> 
> This won't return -EINVAL, but !!(-EINVAL), AKA true. We should do
> 
> 	default:
> 		drm_WARN(ptdev->ddev, "Invalid pgtable format");
> 		return -EINVAL;
> 
> instead.

Ah, good catch. I missed that from the WARN_ON definition:

         int __ret_warn_on = !!(condition);

Thanks, will fix in v4.

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


