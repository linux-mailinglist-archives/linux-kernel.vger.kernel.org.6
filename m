Return-Path: <linux-kernel+bounces-356157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E21995D3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211371C23566
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D24084D;
	Wed,  9 Oct 2024 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qR55YWAV"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6292C190
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438295; cv=none; b=WNsx4e9dxxdf5ajFJI2RffkQGoZcIN4uXWf0n6xF/Ic/79H0sXbgWGa2gzuZt7nQZ/7vQb+iviDnVMAdURQ9MPbn84Pi5dtVZdu1KNDomy+dSy0i3yMvsbGy4/2sYWD3J5gu/5katUWRnmsrEqNtvHQJrM9mFDWO0bLLPVZsrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438295; c=relaxed/simple;
	bh=J/HeQXkg4PHmr1BDyK+Cx2VVFxYLOjavfdJa7rL/tQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbsDaSsvg91QxCoE2OVeuacVrzNJysH3XLfj9wtSsnOR/7l1TFNui/23k2ITCILng30vl/EjqZqxGTZFIAgmS7atUiETgrW5rrthSvFfBAr2H5JVn6QlfoUCSwoDuSwk6NvhkKLzZApAbzMUiFM8BqEmWbJZ+uGyFY9W5BSgR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qR55YWAV; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728438291; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HJY9e/Olgddw6xVkbDexxAXrC902p+FIZ3KO5ktTx7o=;
	b=qR55YWAVMH/cigHPCUwC+4VStqIwQqYA/N8pek/CafuBjjIGLDGxGrGMJ+L7qP4B1A4h8QLBLTKKPIJBlaBUilDJ6ta/u3/ngAs91XiAJkm8O7nGiIm4W7qRe6EIRoalqfkzoMAFQLsobyKpCvJshCvaJyM3NZEAIj6SM1WkqOY=
Received: from 30.246.161.56(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WGgrhal_1728438289)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 09:44:50 +0800
Message-ID: <7a600046-6082-46c8-9eb9-9535855d9016@linux.alibaba.com>
Date: Wed, 9 Oct 2024 09:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/dwc_pcie: Fix typos in event names
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
 <20241008231824.5102-4-ilkka@os.amperecomputing.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241008231824.5102-4-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/9 07:18, Ilkka Koskinen 写道:
> Fix a few typos in event names
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index d752168733cf..6e2214a6d6d8 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -217,9 +217,9 @@ static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
>   	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_update_fc_dllp, 0x601),
>   	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ack_dllp, 0x602),
>   	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_update_fc_dllp, 0x603),
> -	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nulified_tlp, 0x604),
> -	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nulified_tlp, 0x605),
> -	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tl, 0x606),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nullified_tlp, 0x604),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nullified_tlp, 0x605),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tlp, 0x606),
>   	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_write, 0x700),
>   	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_read, 0x701),
>   	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_write, 0x702),


Look good to me. Thanks for the fixes :)

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>


Best Regards,
Shuai

