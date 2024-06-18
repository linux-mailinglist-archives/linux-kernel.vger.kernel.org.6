Return-Path: <linux-kernel+bounces-218621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424FC90C2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2BE1C21EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBE473462;
	Tue, 18 Jun 2024 04:01:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E212595;
	Tue, 18 Jun 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683302; cv=none; b=a+SY7PV2lGNEO3kv66Zlblm3gY5TEXJNJk+n7bI/cmJVHMZJGtL5b4b3XCdFIhaaHJiU6ncYW/1jSWY7xhA0GBr/M+iSJWKR+SbS+wb5/9YUDT9x5GBuscl/PTW6IZRkbmMWSOcaIOKGMuPc4FY0NnoIdgxSEBp74HMR+726x2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683302; c=relaxed/simple;
	bh=HMZmwcszMz4muO8iBnwOnpOFsZw8nvTmN8F2CzLzj0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKNjM7TVgvNYOiyMY+Nd431I1xscKN1vNLdyhykQGdzTGpVnGg0AmrCidHJaMr+ogxN45K1b8zgsmxKH3wKZRn2+uqZV+UxHiWK17oZIOzmkxQFSORn45qcTHMfYcN4IdCFaU9dxAePk+OWvthbqP3QpSKq3JD/6uNynzt0eors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.225])
	by gateway (Coremail) with SMTP id _____8Dx2OmgBnFm0s0HAA--.18699S3;
	Tue, 18 Jun 2024 12:01:36 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.225])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxRcWdBnFmQM8mAA--.16960S3;
	Tue, 18 Jun 2024 12:01:33 +0800 (CST)
Message-ID: <d9ee8cc2-8fd9-4a99-9673-b3a56187df95@loongson.cn>
Date: Tue, 18 Jun 2024 12:01:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 RESEND 1/1] zh_CN/admin-guide: Add
 zh_CN/admin-guide/numastat.rst translation document
To: wodemia@foxmail.com, alexs@kernel.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Zou <wodemia@linux.alibaba.com>
References: <tencent_227A20B261EF28E4C37834F2089D5AD91408@qq.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <tencent_227A20B261EF28E4C37834F2089D5AD91408@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxRcWdBnFmQM8mAA--.16960S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZryrGFykJFyDAFWkKw1DXFc_yoW8uF17pF
	1kKrySg3WxJry5Cw1xGF17WF18Gr1xuw4DGa4Sqw18twn8Ar4ktrsxtrWUKFn3GrWFyay8
	AFWFgrWUurWjy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=

Hi Tao,

在 2024/6/18 10:47, wodemia@foxmail.com 写道:
> From: Tao Zou <wodemia@linux.alibaba.com>
>
> Add translation zh_CN/admin-guide/numastat.rst and link it to
> zh_CN/admin-guide/index.rst while clean its todo entry.
>
> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
> ---
>
> I apologize, the previous PATCH had an incorrect email address for linux-doc when it was sent, so I need to resend it.
>   
>   .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>   .../zh_CN/admin-guide/numastat.rst            | 50 +++++++++++++++++++
>   2 files changed, 51 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst
>
> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
> index ac2960da33e6..0db80ab830a0 100644
> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
> @@ -68,6 +68,7 @@ Todolist:
>      cpu-load
>      cputopology
>      lockup-watchdogs
> +   numastat
>      unicode
>      sysrq
>      mm/index
> @@ -109,7 +110,6 @@ Todolist:
>   *   module-signing
>   *   mono
>   *   namespaces/index
> -*   numastat
>   *   parport
>   *   perf-security
>   *   pm/index
> diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rst b/Documentation/translations/zh_CN/admin-guide/numastat.rst
> new file mode 100644
> index 000000000000..4f7fee557cb5
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/admin-guide/numastat.rst
> +:Translator: Tao Zou <wodemia@linux.alibaba.com>
> +
> +.. _cn_numastat:
Drop it, because it introduces a warning.
> +
> +
> +===============================
> +Numa策略命中/未命中统计
> +===============================
  Drop unnecessary "=".

one English char,  one "="

one Chinese char, two "="


Thanks,

Yanteng


