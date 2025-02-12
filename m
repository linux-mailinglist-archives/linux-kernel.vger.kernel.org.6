Return-Path: <linux-kernel+bounces-510465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE0A31D41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C567B18872DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0761E5707;
	Wed, 12 Feb 2025 04:09:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E21DF751
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739333340; cv=none; b=SX5r0IxRF44cICfMbZ0EUUQSrd5qw6ywnQUQLeaqilOWn/54j2hVjN+xYTmt7lrq/29HUU8JZSyt3Qm3YvmElLzJjuxYOB+sDpvHxYt6U7Kf8ClV5+bg1PhZ+rf7Bwl1svaDec6yy3I62R9BT1SGBjXPXTuQj1xJU7pvbnEzFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739333340; c=relaxed/simple;
	bh=ubLQslBYGLfJx/VC49hgVO2y8uIfkqmRmJt2hbbLVPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LQOZX1voZDF7RzhgxzJd5QUIFPgGcpev60L5yZwizzTPrqRopGbCs9m1sZksen+VrLr0c0+IgZDgOycfnt0ve7LIAfGf8Os7Ii+Td0ZZN5BKJM1WWMEXx+MBPD/xF43uVPg/P/O3FVl7rdCtkZ+442uyp/T7ZhiZbvFjb/e2lCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yt4X774BQzpTR1;
	Wed, 12 Feb 2025 12:07:19 +0800 (CST)
Received: from dggpemf100016.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id D693F14022E;
	Wed, 12 Feb 2025 12:08:54 +0800 (CST)
Received: from [10.67.120.139] (10.67.120.139) by
 dggpemf100016.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 12:08:54 +0800
Message-ID: <21a3726f-63d0-4c33-84a2-9e11b99f9e9c@huawei.com>
Date: Wed, 12 Feb 2025 12:08:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] soc cache: Add support for HiSilicon L3 cache
To: <xuwei5@hisilicon.com>, <yangyicong@hisilicon.com>,
	<Jonathan.Cameron@huawei.com>, <wangjie125@huawei.com>,
	<wanghuiqiang@huawei.com>, <christophe.jaillet@wanadoo.fr>
CC: <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250122065803.3363926-1-wangyushan12@huawei.com>
Content-Language: en-US
From: wangyushan <wangyushan12@huawei.com>
In-Reply-To: <20250122065803.3363926-1-wangyushan12@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100016.china.huawei.com (7.185.36.236)

Gentle ping on this patch.

On 2025/1/22 14:58, Yushan Wang wrote:
> This series adds support for HiSilicon SoC cache lockdown and cache
> maintenance operations.
>
> Cache lockdown feature prevents cache entries from being evicted from L3
> cache for better performance.  It can be enabled by calling mmap
> function to the file (`/dev/hisi_soc_cache_mgmt`).  This feature is
> implemented in the driver hisi_soc_l3c.
>
> L3 cache and L3 cache PMU share the same memory resource, which makes
> one fails to probe while another is on board.  Since both devices
> rely on distinct information exported by ACPI, their probing functions
> should be unrelated.  Workaround the resource conflict check by
> replacing devm_ioremap_resource() to devm_ioremap() instead.
>
> Changes in v2:
>    - Save unnecessary iterations when performing cache lock. (Christophe)
>    - Other minor style changes. (Christophe)
>    - Link to v1: https://lore.kernel.org/all/20250107132907.3521574-1-wangyushan12@huawei.com
>
> Jie Wang (1):
>    soc cache: Add framework driver for HiSilicon SoC cache
>
> Yushan Wang (1):
>    soc cache: L3 cache lockdown support for HiSilicon SoC
>
>   drivers/soc/hisilicon/Kconfig                 |  22 +
>   drivers/soc/hisilicon/Makefile                |   2 +
>   .../soc/hisilicon/hisi_soc_cache_framework.c  | 534 ++++++++++++++++++
>   .../soc/hisilicon/hisi_soc_cache_framework.h  |  77 +++
>   drivers/soc/hisilicon/hisi_soc_l3c.c          | 527 +++++++++++++++++
>   5 files changed, 1162 insertions(+)
>   create mode 100644 drivers/soc/hisilicon/hisi_soc_cache_framework.c
>   create mode 100644 drivers/soc/hisilicon/hisi_soc_cache_framework.h
>   create mode 100644 drivers/soc/hisilicon/hisi_soc_l3c.c
>


