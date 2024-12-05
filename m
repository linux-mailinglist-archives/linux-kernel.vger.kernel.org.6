Return-Path: <linux-kernel+bounces-432658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA49E4E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCB616A2AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA171B372C;
	Thu,  5 Dec 2024 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nf1mCt7E"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B11B218F;
	Thu,  5 Dec 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383582; cv=none; b=cEjoyPGcdEGfVcyPXMQNqCdZXGvW8DXWRdgKdZmfqtA+umVQtFpwmblEElHuGp8mJUcHCcSnaNxbTcaB4T790Crqe4PIgBFdWWdHl195w/NeyYo+ypyKBTgUTlffo1/052Jw/d5xXxzpI/PTQ0KYQ6Qa10YwXNDsn51QuGXkqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383582; c=relaxed/simple;
	bh=0UD6WQVddyog9nb7OkbO4pkD6YTk63/QsVvGLkzydr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVDEjvzr7vpmTV0xbuA39MbIzjVNBCS1lkcvBVOVd1Gbot8U7kSYLMR6SSOv019yjb9pGs/vy+BhQgqnVLqV0CtaAZi7/G8kxid8S8uwkIx/TYy1qSpiMzhCFjKG3UnwOHvlYGiGxiO0HfdQGQG37gV3c7NjC0SqhO2EyoxPf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nf1mCt7E; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733383576; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YKl5IZgDbXNR0bbwdxa/KbJG9SnGBZUCv2B2flHQUiU=;
	b=nf1mCt7EzRl5Aic7i0+XW1sVp/9TI0xrWrkCMaS9tG8u9QHASxLjE04IjlxzZcYc0ek1cHB0k5XQJU4LrZFxGDcPF2iZIjCQpoa5Ab6bjrqoy0U05IBwrxbnBRp0h49a3fj26NVvn1FickIGy9WItkDM6iu+z+Z56UH3BMTUS4A=
Received: from 30.74.128.237(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WKsVKi8_1733383575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 15:26:16 +0800
Message-ID: <ac669a87-7517-4a37-8026-67b70e99884c@linux.alibaba.com>
Date: Thu, 5 Dec 2024 15:26:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: dwc_pcie_pmu: Fix the mnemonics and
 eventid
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241205061914.5568-1-ilkka@os.amperecomputing.com>
 <20241205061914.5568-3-ilkka@os.amperecomputing.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241205061914.5568-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/5 14:19, Ilkka Koskinen 写道:
> Fix the event id and type in the example. In addition, the recent fix,
> which addressed the mnemonics with mixed case, didn't fix the document.
> Match the names with the driver.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   Documentation/admin-guide/perf/dwc_pcie_pmu.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> index 39b8e1fdd0cd..cb376f335f40 100644
> --- a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> @@ -60,7 +60,7 @@ description of available events and configuration options in sysfs, see
>   The "format" directory describes format of the config fields of the
>   perf_event_attr structure. The "events" directory provides configuration
>   templates for all documented events.  For example,
> -"Rx_PCIe_TLP_Data_Payload" is an equivalent of "eventid=0x22,type=0x1".
> +"rx_pcie_tlp_data_payload" is an equivalent of "eventid=0x21,type=0x0".
>   
>   The "perf list" command shall list the available events from sysfs, e.g.::
>   
> @@ -79,8 +79,8 @@ Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>   
>   The average RX/TX bandwidth can be calculated using the following formula:
>   
> -    PCIe RX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
> -    PCIe TX Bandwidth = Tx_PCIe_TLP_Data_Payload / Measure_Time_Window
> +    PCIe RX Bandwidth = rx_pcie_tlp_data_payload / Measure_Time_Window
> +    PCIe TX Bandwidth = tx_pcie_tlp_data_payload / Measure_Time_Window
>   
>   Lane Event Usage
>   -------------------------------


LGTM.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.

Best Regards,
Shuai

