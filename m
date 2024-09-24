Return-Path: <linux-kernel+bounces-337388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610C98496D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1928B23895
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5041A4F39;
	Tue, 24 Sep 2024 16:18:17 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6B1B85D6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194696; cv=none; b=pFZglCuAz5MFVOGF6BCyyRuMBxM/BT2sqkscgLiE4wKdGuo8cMrwdjVtaFn5kb3/ncwjXqTnJ8k3FmIx68uz/YXiLFOXDLlUrFk3A/VFe1+8VgwXqH1iqHT2m6yb4iHM5L3NHAa/bAODA4Ag1ylPIS+nLh3ky8SjuRH7vipB5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194696; c=relaxed/simple;
	bh=m2Xvnx9HDVZ9Becxi+SF7OPgrq0Oy5XO9ZCBhC50Mzs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ml5gDo8GYjUbqAzktxjZEi23DhRW5/bonyq1PPPMl7ul/mCsLP/avMVgxD/4KoI0B3DG0ys8otKYRq46ivzDs6gs7ID5ulzaTROKSj6T6hzJ+3gTL610ix1Vy/2RW14yWkCZBDFLTyDOn5wuav+d4iY69hdHb4r6Bsr4NI/sLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XClKv3S9fz6DB95;
	Wed, 25 Sep 2024 00:14:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 380E01400D4;
	Wed, 25 Sep 2024 00:18:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 18:18:07 +0200
Date: Tue, 24 Sep 2024 17:18:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v8 1/6] perf/marvell: Refactor to extract platform data
 - no functional change
Message-ID: <20240924171806.0000525c@Huawei.com>
In-Reply-To: <20240919074717.3276854-2-gthiagarajan@marvell.com>
References: <20240919074717.3276854-1-gthiagarajan@marvell.com>
	<20240919074717.3276854-2-gthiagarajan@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Sep 2024 13:17:12 +0530
Gowthami Thiagarajan <gthiagarajan@marvell.com> wrote:

> This commit introduces a refactor to the Marvell DDR pmu driver,
> specifically targeting the extraction of platform data
> (referred to as "pdata") from the existing driver. The purpose of
> this refactor is to prepare for the upcoming support of the next
> version of the Performance Monitoring Unit (PMU) in this
> driver.
> 
> No functional changes are introduced in this refactor. Its sole
> purpose is to improve code organization and pave the way for
> future enhancements to the driver.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
A few drive by comments as I was curious.

Jonathan

> ---
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 127 +++++++++++++++++++--------
>  1 file changed, 92 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
> index 94f1ebcd2a27..e33d383aa6d2 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
> +/*
> + * Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
>   *
> - * Copyright (C) 2021 Marvell.
> + * Copyright (C) 2024 Marvell.

Maybe 2021-2024 is appropriate?


>   */
>  
>  #include <linux/init.h>
> @@ -14,24 +15,24 @@
>  #include <linux/platform_device.h>
>  
>  /* Performance Counters Operating Mode Control Registers */
> -#define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
> -#define OP_MODE_CTRL_VAL_MANNUAL	0x1
> +#define CN10K_DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
> +#define OP_MODE_CTRL_VAL_MANUAL	0x1

Typo fix probably belongs in a separate patch.


>  /* 8 Generic event counter + 2 fixed event counters */
>  #define DDRC_PERF_NUM_GEN_COUNTERS	8
> @@ -42,17 +43,19 @@
>  					 DDRC_PERF_NUM_FIX_COUNTERS)
>  
>  /* Generic event counter registers */
> -#define DDRC_PERF_CFG(n)		(DDRC_PERF_CFG_BASE + 8 * (n))
> +#define DDRC_PERF_CFG(base, n)		((base) + 8 * (n))
>  #define EVENT_ENABLE			BIT_ULL(63)
>  
>  /* Two dedicated event counters for DDR reads and writes */
>  #define EVENT_DDR_READS			101
>  #define EVENT_DDR_WRITES		100
>  
> +#define DDRC_PERF_REG(base, n)		((base) + 8 * (n))
>  /*
>   * programmable events IDs in programmable event counters.
>   * DO NOT change these event-id numbers, they are used to
>   * program event bitmap in h/w.
> + *

Stray change. Drop this additional line.

>   */
>  #define EVENT_OP_IS_ZQLATCH			55
>  #define EVENT_OP_IS_ZQSTART			54
> @@ -63,8 +66,8 @@
>  #define EVENT_VISIBLE_WIN_LIMIT_REACHED_RD	49
>  #define EVENT_BSM_STARVATION			48
>  #define EVENT_BSM_ALLOC				47
> -#define EVENT_LPR_REQ_WITH_NOCREDIT		46
> -#define EVENT_HPR_REQ_WITH_NOCREDIT		45
> +#define EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED	46
> +#define EVENT_DFI_OR_HPR_REQ_NOCRED		45
Is this reflecting a 'fix' of the naming, or the broadening
of this event for a different IP?
If it is a 'fix' then do it first, if it is an either or
kind of thing then maybe additional define for the other use is
appropriate?

Pulling it out to a patch where you can explain the change
is probably a good idea rather than burying it in here.


>  
> -/* Fixed event counter value register */
> -#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
> -#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
>  #define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
>  #define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
>  
> +/* Fixed event counter value register */
> +#define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
> +#define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
> +
>  struct cn10k_ddr_pmu {
>  	struct pmu pmu;
>  	void __iomem *base;
> +	const struct ddr_pmu_platform_data *p_data;
>  	unsigned int cpu;
>  	struct	device *dev;
>  	int active_events;
> @@ -134,6 +138,22 @@ struct cn10k_ddr_pmu {
>  
>  #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
>  
> +struct ddr_pmu_platform_data {
> +	u64 counter_overflow_val;
> +	u64 counter_max_val;
> +	u64 ddrc_perf_cnt_base;

As this is in a structure that tells you it's about ddrc pmu
can you drop the ddrc_perf_ prefix?

> +	u64 ddrc_perf_cfg_base;
> +	u64 ddrc_perf_cnt_op_mode_ctrl;
> +	u64 ddrc_perf_cnt_start_op_ctrl;
> +	u64 ddrc_perf_cnt_end_op_ctrl;
> +	u64 ddrc_perf_cnt_end_status;
> +	u64 ddrc_perf_cnt_freerun_en;
> +	u64 ddrc_perf_cnt_freerun_ctrl;
> +	u64 ddrc_perf_cnt_freerun_clr;
> +	u64 ddrc_perf_cnt_value_wr_op;
> +	u64 ddrc_perf_cnt_value_rd_op;
> +};


