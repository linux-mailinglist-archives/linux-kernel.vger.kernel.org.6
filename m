Return-Path: <linux-kernel+bounces-334010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB497D15B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF3B1F253C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF340858;
	Fri, 20 Sep 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ahcRBpmr"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99A23D2
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815322; cv=none; b=svFvC/X8VgyBp8IfucXDle/fJ7GK5CUu5f0WONe0zlWzoEuB2/2UK/E59uopamuylsmHfTC2rdcOdDPYuahOsqqJj4ytnl4cij7Xfa05RWM8oxckAnAI28Ozy1K6XMxDUgl77paogZNs0sULxYj8GRnu/FbEM/28CnD89bmbe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815322; c=relaxed/simple;
	bh=DSmdI2BiEwgu4HiCEgQ/nhsjg4cXSnIwf5Jn7iPoixI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jBvvxd4w6cMNH0dEjliCNZ6+I9/6bAN2f4SX/hDhajck/CXLjvatMT9t2T2AqPKq+/uySNMNXp1JNasiJZ9Kxvq3yM7hUOw9QtI33s1GSZH1FgM+FYi0iXuYF2j1zXeS8MS7/wrbULRSDv8EGen3nhHAFwlXTXUxNs/4ip/OSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ahcRBpmr; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726815318; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ExOMP5aGRZkCEGQtQBxo4/a0kohzwmKg50xpQ6agkR8=;
	b=ahcRBpmrwG/SRnyFTHlocLYNhXxqM/bJlfEtBE+o7Y9YchfU2kZcJXkWC8fuZ4b6v09ySrF7CwMWcfQg+fp+SKnByICDVMgfg6vEI8otWycvDglta6cVWH+zc46vXSXQpybhj9+OmZy1ufrkRDPI7oovBthNcUB7kTdYt14lshw=
Received: from 30.246.161.141(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WFKCr8X_1726815316)
          by smtp.aliyun-inc.com;
          Fri, 20 Sep 2024 14:55:17 +0800
Message-ID: <40e700b2-8cdf-417d-997c-de7df7f8b950@linux.alibaba.com>
Date: Fri, 20 Sep 2024 14:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers perf: remove unused field pmu_node
To: Yunhui Cui <cuiyunhui@bytedance.com>, punit.agrawal@bytedance.com,
 renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240919034601.2453-1-cuiyunhui@bytedance.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240919034601.2453-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/19 11:46, Yunhui Cui 写道:
> The driver does not use the pmu_node field, so remove it.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

LGTM. Thanks.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Best Regards,
Shuai

> ---
>   drivers/perf/dwc_pcie_pmu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 4ca50f9b6dfe..59526a48499f 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -82,7 +82,6 @@ struct dwc_pcie_pmu {
>   	u16			ras_des_offset;
>   	u32			nr_lanes;
>   
> -	struct list_head	pmu_node;
>   	struct hlist_node	cpuhp_node;
>   	struct perf_event	*event[DWC_PCIE_EVENT_TYPE_MAX];
>   	int			on_cpu;


