Return-Path: <linux-kernel+bounces-432652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556589E4E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3397B1882329
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389FB1B0F25;
	Thu,  5 Dec 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TC5tmE0N"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB51A8F72;
	Thu,  5 Dec 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383452; cv=none; b=MkNMCe+MTR8qwsBcgkOYCB/o6QzP6vz3wNXWXjHj2PMn7qfwlAgIAyeZI42qJQJeaCSWDG+D2B3LiHbyCTwCABTpdalBTvbxKSJYi2oTHyd8qmIsXDaoH3gJ0cyc95USv4U7N1HdvcSMKWnIk1+FXOHkDRQjE6Snvd6EyC8R38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383452; c=relaxed/simple;
	bh=4NQfzxD9h7TufHa3t3WHK8FJ3Fs/k5ih3pE2sDxVI14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9VYQhBJf84uNexc1dToctQLRUigliuN1FkQUSHDWaRNA+1v7a+XL2PEveEd4Zpi/lojh5DbrG2/EcKYHfR5ejYXRaivry/UhHPN6C8lMeS7mQt+eZ1Krxg27QdjxYbhZtEGxFyHzajKO5lCbCIb5eFeQq5xzGYAAIWQh63BgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TC5tmE0N; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733383447; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=95J/4I16ZOfi0aNqPQOHwFzFZR3fi4JmEZHj/JIo1Ys=;
	b=TC5tmE0NefvGJxKGkvXiv/YJhmVSdIVrq4ome5KNXtCa6Nsb8jZIItAoY2LCnrRu23Kw4hx9FoRV/twTx6oSWmULuEyLDly+4S9RfKQObRRvEKYTGWdyIrgAqMQ2ry30f3yCAmTCFD5ReMQXsk2QzS/inybRcGREmpCP5EbOXbE=
Received: from 30.74.128.237(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WKsWPiz_1733383445 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 15:24:06 +0800
Message-ID: <412549fa-ca7a-42a1-9fad-85d3dcd14b79@linux.alibaba.com>
Date: Thu, 5 Dec 2024 15:24:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf/dwc_pcie: Fix the swapped event numbers as well
 as the documentation
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241205061914.5568-1-ilkka@os.amperecomputing.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241205061914.5568-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/5 14:19, Ilkka Koskinen 写道:
> According to the versions of Designware Cores PCI Express Controller Databook
> I found, the eventid for "L1 aux" is 0x08 and "TX L0s and RX L0S" is 0x09.
> 
> Shuai and Jing, could you verify that your document matches ours and the events
> are indeed swapped in the driver at the moment?

Yep, it is a typo.

> 
> Cheers, Ilkka

Thanks for the fixes :)

Best Regards,
Shuai

> 
> 
> 
> Ilkka Koskinen (2):
>    perf/dwc_pcie: Fix the event numbers
>    Documentation: dwc_pcie_pmu: Fix the mnemonics and eventid
> 
>   Documentation/admin-guide/perf/dwc_pcie_pmu.rst | 6 +++---
>   drivers/perf/dwc_pcie_pmu.c                     | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 


