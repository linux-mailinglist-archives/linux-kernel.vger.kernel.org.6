Return-Path: <linux-kernel+bounces-543816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587BAA4DA44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A181883FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B61FECB7;
	Tue,  4 Mar 2025 10:22:34 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C51FC107
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083754; cv=none; b=DdTEEn/bqdqwiUBMEelhSP8Ifyp7gdU7wQZ3ILsJd8VqzngtPFnImEFGXK2C8uvbLsqGCVorazjIDb8zaysuUT5JCPOFQYL3c9zqlC5xRG4XVww/0I9ZMp+yIXHQt+7/YNnFni21npECDFISKQgMuxXW1Clm8+Ij0V5d4uO3drc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083754; c=relaxed/simple;
	bh=8XVMDkKt+pjNa5HzlbP3sJ9y3tOiv6aaZLaNZNFv13w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TC1raKrZH8l69s8PzyOlsO4twobBbjw4kbrTe/Gfnju4NnMizB5szZf+l+/Hw7hZCztwI0v9oXaEKx83sUyQLw2kmPDaOLWFAyRBNCuLa4BnHOp4NTqSHKtJyYaZUYOHL6YSGzpBjjYstfx4bJShv8NzIJeYvtcqHFv09+hSRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6WrP6rxjz6M4cP;
	Tue,  4 Mar 2025 18:19:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6878D1402C7;
	Tue,  4 Mar 2025 18:22:29 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 11:22:26 +0100
Date: Tue, 4 Mar 2025 18:22:22 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH 8/9] drivers/perf: hisi: Add support for HiSilicon NoC
 PMU
Message-ID: <20250304182222.00006e5a@huawei.com>
In-Reply-To: <20250218092000.41641-9-yangyicong@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
	<20250218092000.41641-9-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 17:19:59 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Adds the support for HiSilicon NoC (Network on Chip) PMU which
> will be used to monitor the events on the system bus. The PMU
> device will be named after the SCL ID (either Super CPU cluster
> or Super IO cluster) and the index ID, just similar to other
> HiSilicon Uncore PMUs. Below PMU formats are provided besides
> the event:
> 
> - ch: the transaction channel (data, request, response, etc) which
>   can be used to filter the counting.
> - tt_en: tracetag filtering enable. Just as other HiSilicon Uncore
>   PMUs the NoC PMU supports only counting the transactions with
>   tracetag.
> 
> The NoC PMU doesn't have an interrupt to indicate the overflow.
> However we have a 64 bit counter which is large enough and it's
> nearly impossible to overflow.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
A few minor comments inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/admin-guide/perf/hisi-pmu.rst  |  11 +
>  drivers/perf/hisilicon/Makefile              |   3 +-
>  drivers/perf/hisilicon/hisi_uncore_noc_pmu.c | 391 +++++++++++++++++++
>  3 files changed, 404 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
> index 48992a0b8e94..d858bd3a8802 100644
> --- a/Documentation/admin-guide/perf/hisi-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pmu.rst
> @@ -112,6 +112,17 @@ uring channel. It is 2 bits. Some important codes are as follows:
>  - 2'b00: default value, count the events which sent to the both uring and
>    uring_ext channel;
>  
> +6. ch: NoC PMU supports to filter the event counts of certain transaction
supports filtering the event counts...
> +channel with this option. The current supported channels are as follows:
> +
> +- 3'b010: Request channel
> +- 3'b100: Snoop channel
> +- 3'b110: Response channel
> +- 3'b111: Data channel
> +
> +7. tt_en: NoC PMU supports to only count the transactions with tracetag by

supports counting only transactions that have tracetag set if this option is
set.

> +this option. See the 2nd list for more information about tracetag.
> +


> +static int hisi_noc_pmu_probe(struct platform_device *pdev)
> +{
> +	struct hisi_pmu *noc_pmu;
> +	char *name;
> +	int ret;
> +
> +	noc_pmu = devm_kzalloc(&pdev->dev, sizeof(*noc_pmu), GFP_KERNEL);
Quite a bit of use of &pdev->dev, maybe worth
struct device *dev = &pdev->dev; to shorten all these lines.

> +	if (!noc_pmu)
> +		return -ENOMEM;
> +
> +	/*
> +	 * HiSilicon Uncore PMU framework needs to get common hisi_pmu device
> +	 * by device's drvdata.

from device's drvdata


