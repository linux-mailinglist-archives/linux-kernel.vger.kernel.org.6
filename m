Return-Path: <linux-kernel+bounces-263010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5093CFC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42A21C2231F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993A13D255;
	Fri, 26 Jul 2024 08:45:17 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E92E64B;
	Fri, 26 Jul 2024 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983517; cv=none; b=sCzK+o0+dbrSfJeILzcyWLJBZr/h5ovzIoA9CjlPXoa5IIvFh5I5St0sZqmrQIds4Muc5mqw9SgKSpB9VwgH1oHzms0Fuj9hjtqxB1xwD0PPEO2DwqaKcq2SwTn3E+7eQnG9Waml5T8XbITi+xHCOpPcrXIAwKidiXmeShXmcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983517; c=relaxed/simple;
	bh=u9BrJxc04mZK3G3ncToJZjpU9o3nT694f4gHbI3vLps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUH89kl1RdJBhNg+jvsn7L4OpiI7BJuEv6Mag9tXwiFP/1Kq/vOFmqmaPZOvK0L3GXkAQu1qLblXy+xYAImS1lhfBiTmmTrAqIv7TdWjGhxczmDflF5VnVa7mfPHtN4dlc+Me78tvLM3gNvY+HnaYZ7EB+6UUnWN6hTklYMTlj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrACX92wAYqNmsjUCAg--.25306S2;
	Fri, 26 Jul 2024 16:44:48 +0800 (CST)
Received: from [10.12.164.29] (unknown [10.12.164.29])
	by gateway (Coremail) with SMTP id _____wDn0Nb9YaNmiJMFAA--.5993S2;
	Fri, 26 Jul 2024 16:44:47 +0800 (CST)
Message-ID: <221f644f-c085-4873-93e2-4918375b1747@hust.edu.cn>
Date: Fri, 26 Jul 2024 16:44:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update dev-tools/kcsan.rst url about KTSAN
To: Marco Elver <elver@google.com>
Cc: Haoyang Liu <tttturtleruss@hust.edu.cn>,
 Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>,
 hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725174632.23803-1-tttturtleruss@hust.edu.cn>
 <a6285062-4e36-431e-b902-48f4bee620e0@hust.edu.cn>
 <CANpmjNOiMFUM8KxV8Gj_LTSbC_qLYSh+34Ma8gC1LFCgjtPRsA@mail.gmail.com>
Content-Language: en-US
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <CANpmjNOiMFUM8KxV8Gj_LTSbC_qLYSh+34Ma8gC1LFCgjtPRsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrACX92wAYqNmsjUCAg--.25306S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kGFWrWFWfAry3uF45Jrb_yoW8Zw1xpa
	yfuFyIkr4ktr17K3yIgw10yFW0yFZxtr1Ut3WUG3WFvrsIvFnaqrW29w4FgFyUZrWrCFW2
	vF1jva4Fv3W5AaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXV
	WUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82
	IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0EksPUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 7/26/24 16:38, Marco Elver wrote:
> On Fri, 26 Jul 2024 at 03:36, Dongliang Mu <dzm91@hust.edu.cn> wrote:
>>
>> On 2024/7/26 01:46, Haoyang Liu wrote:
>>> The KTSAN doc has moved to
>>> https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md.
>>> Update the url in kcsan.rst accordingly.
>>>
>>> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
>> Although the old link is still accessible, I agree to use the newer one.
>>
>> If this patch is merged, you need to change your Chinese version to
>> catch up.
>>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>>
>>> ---
>>>    Documentation/dev-tools/kcsan.rst | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
>>> index 02143f060b22..d81c42d1063e 100644
>>> --- a/Documentation/dev-tools/kcsan.rst
>>> +++ b/Documentation/dev-tools/kcsan.rst
>>> @@ -361,7 +361,8 @@ Alternatives Considered
>>>    -----------------------
>>>
>>>    An alternative data race detection approach for the kernel can be found in the
>>> -`Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/wiki>`_.
>>> +`Kernel Thread Sanitizer (KTSAN)
>>> +<https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md>`_.
>>>    KTSAN is a happens-before data race detector, which explicitly establishes the
>>>    happens-before order between memory operations, which can then be used to
>>>    determine data races as defined in `Data Races`_.
> Acked-by: Marco Elver <elver@google.com>
>
> Do you have a tree to take your other patch ("docs/zh_CN: Add
> dev-tools/kcsan Chinese translation") through? If so, I would suggest

Thanks Marco.

That patch will be merged to lwn tree maintained by Jon if all issues 
are resolved.

> that you ask that maintainer to take both patches, this and the
> Chinese translation patch. (Otherwise, I will queue this patch to be
> remembered but it'll be a while until it reaches mainline.)


