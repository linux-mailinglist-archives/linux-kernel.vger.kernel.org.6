Return-Path: <linux-kernel+bounces-572715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E1A6CDB1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D33B3B84DE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F071F9F73;
	Sun, 23 Mar 2025 02:30:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7302E3380
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742697025; cv=none; b=M9kpymeMpFexWx1Slykps7+djuxfhGDL1498R05dDdnCUr/UvEAbUkBHuAxph63Xb6Df9UHo/fc1v7zW+ITgegd26ByiCT6hvwrieXGk5OSMMRbLXe0tWW2PaTEjrqnulE2wAhRwY6GBnVsqcZHGqkDA66xpS4/8m8d+3QQJ4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742697025; c=relaxed/simple;
	bh=fNzT7JKdgX7Xeq8q0y71qemuhCzNxeIGs371Zh/Yvns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a72JGW2s14sYolrn1hutCEk2ZMO1BqYGNUxjhE7bcb5o+DPGf+Mj9nw9YrKOb0zr3nmIDjhaJYkBVAAoBdMaSNQO3Zdee8RadSQSrvtiaCczuJtL2Ptl6l0ZV/Ft3bM4DsITztvZxVk2Ce2iulb/ABVuPHUV5sHcSlNgT4yB48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZL0Qp2sy0z1g2Cb;
	Sun, 23 Mar 2025 10:25:38 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6120D1A0188;
	Sun, 23 Mar 2025 10:30:13 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 23 Mar 2025 10:30:12 +0800
Message-ID: <8370ea3f-38c5-4dd2-82fd-e89d53d88b8a@huawei.com>
Date: Sun, 23 Mar 2025 10:30:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] drm/xe: Fix unmet direct dependencies warning
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20250322095521.4153684-1-yuehaibing@huawei.com>
 <2p7zbqflqj4khxmwofotnn5no5vo54yq5wq7z3j6etntkg3b4v@wym3efsfrx4o>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <2p7zbqflqj4khxmwofotnn5no5vo54yq5wq7z3j6etntkg3b4v@wym3efsfrx4o>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/3/22 20:51, Lucas De Marchi wrote:
> On Sat, Mar 22, 2025 at 05:55:21PM +0800, Yue Haibing wrote:
>> WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
>>  Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
>>  Selected by [m]:
>>  - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=m] && DRM_XE [=m] && DRM_XE [=m]=m [=m] && HAS_IOPORT [=y]
>>
>> FB_IOMEM_HELPERS depends on FB_CORE, Select it before FB_IOMEM_HELPERS.
>>
>> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>> drivers/gpu/drm/xe/Kconfig | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
>> index 7d7995196702..fcf324f37d2d 100644
>> --- a/drivers/gpu/drm/xe/Kconfig
>> +++ b/drivers/gpu/drm/xe/Kconfig
>> @@ -53,6 +53,7 @@ config DRM_XE
>> config DRM_XE_DISPLAY
>>     bool "Enable display support"
>>     depends on DRM_XE && DRM_XE=m && HAS_IOPORT
>> +    select FB_CORE
> 
> other places in drm, including i915 where this is coming from, use:
> 
>     select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
> 
> ... and don't explicitly select FB_CORE. I think that is sufficient
> following the chain of selects which ends up with DRM_CLIENT_LIB
> selecting FB_CORE when DRM_FBDEV_EMULATION is set. Does that fixes it
> for you?

Thanks, it works for this, will send v2 soon.
> 
> Lucas De Marchi
> 

