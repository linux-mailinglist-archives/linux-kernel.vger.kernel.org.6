Return-Path: <linux-kernel+bounces-219451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E9090D2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73D9281AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F297135A40;
	Tue, 18 Jun 2024 13:26:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE676036;
	Tue, 18 Jun 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717177; cv=none; b=lmjx5hJjMaOv1OtPUiuEzlcHhsDGmWadEJaJFEFCUsJHH811Ik32jd6vU7uzInyfiD2tfwIxCPb//H3ZdQyHVFR7M4g82QxWbE8vZg8ZzmoXzL5DTg9UH4Q5jleFR1y0WuPsGjxIxIkMshxBMlUqYVk1s6VsEq7pbm6kdvYQ0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717177; c=relaxed/simple;
	bh=ilL+aNMmlTmTWINmpxF0mYRwKVQqupyT2snELs2/YGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWH6sRMMckOjgdssfwjrzHUWu9taKPSRkWWt3h6K/Wn/wB0AIf9H6Oi/my9piLLzmIdtygtdOPKXB7sQ4XovY/W5cQxD5rven7zU8tHIOgYlDawMI/0S0tE96YOUVbz7KvOTjPTxFFlYYIpDqIL+n+qJx52JhGr0j5ewVZnzmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.225])
	by gateway (Coremail) with SMTP id _____8DxzOryinFm2esHAA--.31900S3;
	Tue, 18 Jun 2024 21:26:10 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.225])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnsfwinFmTI4nAA--.30592S3;
	Tue, 18 Jun 2024 21:26:09 +0800 (CST)
Message-ID: <1d1b1633-63e3-428a-b572-fe4ef294f7d1@loongson.cn>
Date: Tue, 18 Jun 2024 21:26:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 RESEND 1/1] zh_CN/admin-guide: Add
 zh_CN/admin-guide/numastat.rst translation document
To: Tao Zou <wodemia@foxmail.com>
Cc: alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, wodemia@linux.alibaba.com
References: <d9ee8cc2-8fd9-4a99-9673-b3a56187df95@loongson.cn>
 <tencent_262FCAE8F01C8D0582A45600851988585806@qq.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <tencent_262FCAE8F01C8D0582A45600851988585806@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnsfwinFmTI4nAA--.30592S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXry8JF17tw1UGrWfuw4rJFc_yoW5Cw1xpa
	ykKFySg3Z7Jry5Cw1xKF12qF17Kr4Sgw4DJFySqw18t3s8Arn3tr43trZ09F93WrW0yay8
	XayFgrWUur4Yy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8CksDUUUUU==


在 2024/6/18 16:44, Tao Zou 写道:
> Hi, Yanteng Si. Thanks for your suggestion.
>
> On Tue, 18 Jun 2024 12:01:33 +0800 Yanteng Si wrote:
>> 在 2024/6/18 10:47, wodemia@foxmail.com 写道:
>>> From: Tao Zou <wodemia@linux.alibaba.com>
>>>
>>> Add translation zh_CN/admin-guide/numastat.rst and link it to
>>> zh_CN/admin-guide/index.rst while clean its todo entry.
>>>
>>> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
>>> ---
>>>
>>> I apologize, the previous PATCH had an incorrect email address for linux-doc when it was sent, so I need to resend it.
>>>    
>>>    .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>>>    .../zh_CN/admin-guide/numastat.rst            | 50 +++++++++++++++++++
>>>    2 files changed, 51 insertions(+), 1 deletion(-)
>>>    create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst
>>>
>>> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
>>> index ac2960da33e6..0db80ab830a0 100644
>>> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
>>> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
>>> @@ -68,6 +68,7 @@ Todolist:
>>>       cpu-load
>>>       cputopology
>>>       lockup-watchdogs
>>> +   numastat
>>>       unicode
>>>       sysrq
>>>       mm/index
>>> @@ -109,7 +110,6 @@ Todolist:
>>>    *   module-signing
>>>    *   mono
>>>    *   namespaces/index
>>> -*   numastat
>>>    *   parport
>>>    *   perf-security
>>>    *   pm/index
>>> diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rst b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>>> new file mode 100644
>>> index 000000000000..4f7fee557cb5
>>> --- /dev/null
>>> +++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>>> @@ -0,0 +1,50 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +.. include:: ../disclaimer-zh_CN.rst
>>> +
>>> +:Original: Documentation/admin-guide/numastat.rst
>>> +:Translator: Tao Zou <wodemia@linux.alibaba.com>
>>> +

>>> +.. _cn_numastat:
>> Drop it, because it introduces a warning.
> I'm not quite sure which lines should be dropped, as you've mentioned several. Could you give me more details of the warning?

Sorry, Drop  "+.. _cn_numastat:"


This label is useless, if you read the newly translated Chinese documents,

you will find that all do not have this label.


In fact, these labels should be removed from Chinese documents.

Why is that? Because there is a duplicate tag in the original

document, this will introduce some warning. Therefore, if

there is a similar label in the original document, we should

not bring it to the Chinese document.


I'm not sure if _cn_xxxx will trigger a warning, it's been a while

since I've seen a warning like this. But since it's useless,

let's Drop it.


Thanks,

Yanteng


>>> +
>>> +
>>> +===============================
>>> +Numa策略命中/未命中统计
>>> +===============================
>>   Drop unnecessary "=".
>>
>> one English char,  one "="
>>
>> one Chinese char, two "="
> Get it. I will fix it in PATCH v2.


