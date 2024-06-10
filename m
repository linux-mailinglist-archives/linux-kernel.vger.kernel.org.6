Return-Path: <linux-kernel+bounces-207572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A5901906
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 02:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF9D1C21130
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA51869;
	Mon, 10 Jun 2024 00:38:16 +0000 (UTC)
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987917C2;
	Mon, 10 Jun 2024 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717979896; cv=none; b=T2erOU74uQBvPONne1ancbN2x5tDjlIUzpUJ4uhxUq4fJ03K3LneNuKoYCQPdMUQbkWvFYH2G2e4ewgtZ5T+HoeXA1JywFfem5icH4n5Jj5wAKPBHnXThcz8h2wGt6OIiym+43TsLTtzM17GhTjmkkWDPpz/72a5PgsTrP9/qo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717979896; c=relaxed/simple;
	bh=twC7u+cnCs40QAYIo4dxWxJGIYDno4mxjFJPtF2cimw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wjn72MmnLM8ikCcPvdkUaGcHITHsbMEWzDF3Xo6Hbaq6bjsFUWdYU5aQHCS3KP8oBclLUjHSPxCoJQQmqgUDSKwbP8sAPCNx52FVKkUMlMdezU1llExTUn+jJCOai/i/bRa2+8oXb3TeVDn6OARGU82m56Mm8EXptizTfRCKjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrABXr8fVSmZmUbBpAQ--.63384S2;
	Mon, 10 Jun 2024 08:37:41 +0800 (CST)
Received: from [192.168.1.10] (unknown [117.152.240.122])
	by gateway (Coremail) with SMTP id _____wCH9C3RSmZmlMr6AA--.45419S2;
	Mon, 10 Jun 2024 08:37:39 +0800 (CST)
Message-ID: <c477a8d2-c71e-43f9-a796-4ddc4abe85de@hust.edu.cn>
Date: Mon, 10 Jun 2024 08:37:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: update the translation of security-bugs
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240607025842.24321-1-dzm91@hust.edu.cn>
 <fdbbe5d0-65ea-49ef-9a4c-26fe7a691c64@linux.dev>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <fdbbe5d0-65ea-49ef-9a4c-26fe7a691c64@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrABXr8fVSmZmUbBpAQ--.63384S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1fJFykKFy3Kr4xCF1DGFg_yoW8Kr4fpa
	4kKFyxK3ZxAF15GrWxGr12gF1IyFWxG398GFs0qw18tFn5ArsYqrsIq3s0gFZ5XrWrJay8
	Xr4rKrW5uryYyrDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUAV
	WUtwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82
	IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnb4S5UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/6/9 16:20, Zenghui Yu wrote:
>
> On 2024/6/7 10:58, Dongliang Mu wrote:
>> Update to commit 5928d411557e ("Documentation: Document the Linux Kernel
>> CVE process")
>>
>> commit 0217f3944aeb ("Documentation: security-bugs.rst: linux-distros
>> relaxed their rules")
>> commit 3c1897ae4b6b ("Documentation: security-bugs.rst: clarify CVE
>> handling")
>> commit 4fee0915e649 ("Documentation: security-bugs.rst: update
>> preferences when dealing with the linux-distros group")
>> commit 44ac5abac86b ("Documentation/security-bugs: move from 
>> admin-guide/
>> to process/")
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>  .../translations/zh_CN/admin-guide/index.rst  |  1 -
>>  .../translations/zh_CN/process/index.rst      |  3 +-
>>  .../zh_CN/process/security-bugs.rst           | 84 +++++++++++++++++++
>>  3 files changed, 86 insertions(+), 2 deletions(-)
>>  create mode 100644 
>> Documentation/translations/zh_CN/process/security-bugs.rst
>>
>> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst 
>> b/Documentation/translations/zh_CN/admin-guide/index.rst
>> index ac2960da33e6..773c53956000 100644
>> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
>> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
>> @@ -37,7 +37,6 @@ Todolist:
>>
>>     reporting-issues
>>     reporting-regressions
>> -   security-bugs
>
> It's be good to remove the old zh_CN/admin-guide/security-bugs.rst file


Yeah, thanks. I've sent a v2 patch.


> as well and update all references to it:
>
> % git grep "admin-guide/security-bugs.rst" 
> Documentation/translations/zh_CN/
> Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:Documentation/translations/zh_CN/admin-guide/security-bugs.rst 
> ，
> Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:更多信息请参见 
> Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
> Documentation/translations/zh_CN/process/submitting-patches.rst:参见 
> Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
>
> Thanks,
> Zenghui


