Return-Path: <linux-kernel+bounces-369069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4C09A1895
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDB61C225F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D584A35;
	Thu, 17 Oct 2024 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AKTPquif"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABD335BA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131884; cv=none; b=nYOND4AGG/yf8ptJoXt1qaFEsQTQ27u+ckfTUy8qvzJBGpxWSrEmtivq6m3KA8r26H0PeJ1/u/zkWi00F4CfhSmhvVx0oKgdgRm8LsQOpsxVMV1cRVxROoUihHYxIKNt5UvP61ZDxYzjEMIydC+MWNYa6tzR30kU+F6skn4wlAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131884; c=relaxed/simple;
	bh=Do5vG6pniFKL9CgKnRhAzSlGZriNR+Jkfe7eB92gs+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+VRk6F22Cpz8vtMmh6BjAauMPFUaLTvPYAGEjqpMK8Hp6JsFWSYsC17iNJTIkebqwnnwVsihwQnapzaTU/3bS5L+fCa3WwK5Bqet84KVUJauftN998kbXuGPF/SDRKrQ92rNZ0EAG3RVxIH0PY/I7UgGQasy/k5ENZxRv0aK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AKTPquif; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <660201ce-9109-4da7-8921-7a781b4b8ec4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729131878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5km65xJISQkG7Yb2tyjZxOp2bjZuxl/DZnU3wHuWT8=;
	b=AKTPquifZWldMTgRfE9DAvvqxSXSCvlKp/WzoWln6THOwqsEWHnH6/RWn02QcBvujUs07X
	ndMt01Iwj0uv5E/VwLSc0JwZ7ymKxRg2GLc4yFwqO5FnfF/v4iKs2G1L4i9g4XeZX8fMez
	s/BGFaXSP7DTHat2bPpWQDQ7Q98wvh4=
Date: Thu, 17 Oct 2024 10:24:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 4/4] docs/zh_CN: Add a entry in Chinese glossary
To: Pengyu Zhang <zpenya1314@gmail.com>, alexs@kernel.org,
 siyanteng@loongson.cn, corbet@lwn.net, seakeel@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yaxin_wang_uestc@163.com, zenghui.yu@linux.dev
References: <20241016141801.25487-1-zpenya1314@gmail.com>
 <20241016141801.25487-5-zpenya1314@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20241016141801.25487-5-zpenya1314@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/10/16 22:18, Pengyu Zhang 写道:
> To avoid confusion with the term "entry," the glossary stipulates
> that in contexts related to page tables, "page table entry" will be
> translated as "页表项," while "entry" will be translated as "表项."
>
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng
> ---
>   Documentation/translations/zh_CN/glossary.rst | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/translations/zh_CN/glossary.rst b/Documentation/translations/zh_CN/glossary.rst
> index 24f094df97cd..5975b0426f3d 100644
> --- a/Documentation/translations/zh_CN/glossary.rst
> +++ b/Documentation/translations/zh_CN/glossary.rst
> @@ -34,3 +34,4 @@
>   * semaphores: 信号量。
>   * spinlock: 自旋锁。
>   * watermark: 水位，一般指页表的消耗水平。
> +* PTE: 页表项。（Page Table Entry）


