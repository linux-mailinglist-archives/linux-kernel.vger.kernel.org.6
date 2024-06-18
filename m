Return-Path: <linux-kernel+bounces-218525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445790C18C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29801F21CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B617565;
	Tue, 18 Jun 2024 01:42:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1310A16
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674976; cv=none; b=kbp50yDXJn18Yo8M6nPV/mjSUWx/spPp5HBh4HtRSL9iChMrmGbXiG2xhK1iP7lDZLdDKNcTkwAHFYvgoQHLUvx9TuudT/myjW0eTYet26SGG0Hq73RKqIP6IVXNuw+1/bMJ7YPCX1X/9AGyQDE7YUVW598+8j6inOyfhySJSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674976; c=relaxed/simple;
	bh=173Gr/hLGVCXy+QuV8QJFgFRfyAVlEZrwGfrZLVwD7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2ZFzS4p99diRHPTaE59D2KYAVqAGCfR2HOYpc161ayuCMobVpq6HgnPguG/VWG35hrBtclP3QEDnD5e96GOqdptRHp4g8WGeg55y7kFZMYeY1wG7taelw45+a4tZm/ksWfF3JyRzOx3Mrce7HXifwYlVGZ2oXa752VjacQzhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.225])
	by gateway (Coremail) with SMTP id _____8CxcPAV5nBmXMcHAA--.31329S3;
	Tue, 18 Jun 2024 09:42:45 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.225])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBMUU5nBmi6kmAA--.17672S3;
	Tue, 18 Jun 2024 09:42:44 +0800 (CST)
Message-ID: <6769145a-f4dc-40a0-8215-23e9925b9711@loongson.cn>
Date: Tue, 18 Jun 2024 09:42:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst
 translation document
To: wodemia@foxmail.com, alexs@kernel.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.or, linux-kernel@vger.kernel.org,
 Tao Zou <wodemia@linux.alibaba.com>
References: <tencent_F6283AC33634D608765A49147F203961E308@qq.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <tencent_F6283AC33634D608765A49147F203961E308@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxBMUU5nBmi6kmAA--.17672S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JrW7CF4xWr48Jry7Kr15GFX_yoW3Wrc_Cw
	s7XFZayr48J3WIkFy7Ca1YyryxGw45K3909asYqw4DX3y7Gws8J34qg3Z5X345Wrs0krW3
	Wws5Wr1xurnrWosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbV8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZF
	pf9x07j5xhLUUUUU=

Hi Tao,


Good job!

在 2024/6/17 17:03, wodemia@foxmail.com 写道:
> From: Tao Zou <wodemia@linux.alibaba.com>
>
> Add translation zh_CN/admin-guide/numastat.rst and link it to
> zh_CN/admin-guide/index.rst while clean its todo entry.
>
> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
> ---
>   .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>   .../zh_CN/admin-guide/numastat.rst            | 50 +++++++++++++++++++
>   2 files changed, 51 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst

Unfortunately, I don't see your email in linux-doc list, so I can't 
comment on it for now.


You can try resending it as plain text and using git send-email.


Thanks,

Yanteng


