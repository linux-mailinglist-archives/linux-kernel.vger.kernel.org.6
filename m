Return-Path: <linux-kernel+bounces-356637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6799646D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0158FB245D9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CF2189B8D;
	Wed,  9 Oct 2024 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CvZkDg+3"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A931188901
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464852; cv=none; b=APkV69RQv5ZWw2Z1tBBQPR6bfYp0wBySVZiFrtOKJMFYJ+PxuUqBwGW0oGttrgLDBIpbC5uP6TSXHh11t5EPaAuXGsS1AxHExlylANhTiVw03sVroBOZ+ykqd3XYsudHrbrIBURnf4NJhX6ErooCjp2OuojT+isc6Zl9eIGlEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464852; c=relaxed/simple;
	bh=+r78qbbCNfOf6aK/mEzWVJPQ00O9JIQKGxGWCaxnogk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3QVBBbeQ4J6EiAlRFbw6yTu9bTNZknmyD7o2orZLBKrahCgao647K2KKfOFAv8j2HbG1AvKZancC8BpOqOS6W65Nef6gjCuPpEZF4X5f3NRIDdeIPAV+SRP5+JCGlGOOGaDDdzAOg+kD1Ntyoe+u2P+fSXfKDdebpwOFlZLKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CvZkDg+3; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728464847; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=czggiP137u8Kb+mEj3Ao6pjcVK0zEcYbz9Ra7LzBH+c=;
	b=CvZkDg+3aVGIRyx9uh9unGgSDYp8DmMxsO1uAdoIwqlIULqblxfyqpDz7UOwAOK71nXYjiXpwCkR9boYByu89TYiyt5FuOn6QwrdmiE2iWJa55+pJLojXrFWIVd/kBrTQ0ijRLTLbVKSSSS9j0RWfLABwD80EDA2qgiVD1kXodM=
Received: from 30.221.147.213(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WGiASfg_1728464845)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 17:07:26 +0800
Message-ID: <fec25fa8-860f-4aa6-b074-a2404625d0c3@linux.alibaba.com>
Date: Wed, 9 Oct 2024 17:07:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/dwc_pcie: Fix typos in event names
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
 <20241008231824.5102-4-ilkka@os.amperecomputing.com>
From: Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <20241008231824.5102-4-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

You are right.

Reviewed-by: Jing Zhang <renyu.zj@linux.alibaba.com>

在 2024/10/9 上午7:18, Ilkka Koskinen 写道:
> Fix a few typos in event names
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/perf/dwc_pcie_pmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index d752168733cf..6e2214a6d6d8 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -217,9 +217,9 @@ static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
>  	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_update_fc_dllp, 0x601),
>  	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ack_dllp, 0x602),
>  	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_update_fc_dllp, 0x603),
> -	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nulified_tlp, 0x604),
> -	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nulified_tlp, 0x605),
> -	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tl, 0x606),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nullified_tlp, 0x604),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nullified_tlp, 0x605),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tlp, 0x606),
>  	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_write, 0x700),
>  	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_read, 0x701),
>  	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_write, 0x702),

