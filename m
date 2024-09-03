Return-Path: <linux-kernel+bounces-313488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EEB96A606
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0E81C2145A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80131917E8;
	Tue,  3 Sep 2024 17:58:18 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1388819005F;
	Tue,  3 Sep 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386298; cv=none; b=i0/1hOwFJapwBLQRNSBO/N1VmOcEWsp+6ic+AG1zTTZOCmrkXdBLQ20TiM2PPi23bhIE9JS2IKzb1fk+1YOaOzqUvP8SUYrzRVJXdEW9TqmzfxRCZNxHITJ7mgr/BzOCUpODmNNlV5cnTznr0wLJmo+Gn2k7fsPIVSk1p/Qd9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386298; c=relaxed/simple;
	bh=uATjZ/YF6nzeNKi1F2SZH37jXsIQydZyrH2XaUeCEdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QILVSExEGhigbd/0LjNB1eI4er1RSz63gn22fmIYC7iq1pPZmZ+qUfY1y4juAVfygJXRdtS1dKuyj9BcBBTDMpMQ42ni2oecXQTnCo3wsErTSENC1+WCOXeBTQEfztu1vrwrNwUp2xZrTiOW9puDaYZNEncIw2gL2mFmNyE7nnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrACXn7f4TddmHm+pAA--.54713S2;
	Wed, 04 Sep 2024 01:57:12 +0800 (CST)
Received: from [198.18.0.1] (unknown [10.12.177.116])
	by gateway (Coremail) with SMTP id _____wB3b772Tddm33b7AA--.43248S2;
	Wed, 04 Sep 2024 01:57:11 +0800 (CST)
Message-ID: <bd647428-f74d-4f89-acd2-0a96c7f0478a@hust.edu.cn>
Date: Wed, 4 Sep 2024 01:57:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update dev-tools/kcsan.rst url about KTSAN
To: Marco Elver <elver@google.com>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>,
 hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725174632.23803-1-tttturtleruss@hust.edu.cn>
 <a6285062-4e36-431e-b902-48f4bee620e0@hust.edu.cn>
 <CANpmjNOiMFUM8KxV8Gj_LTSbC_qLYSh+34Ma8gC1LFCgjtPRsA@mail.gmail.com>
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
In-Reply-To: <CANpmjNOiMFUM8KxV8Gj_LTSbC_qLYSh+34Ma8gC1LFCgjtPRsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrACXn7f4TddmHm+pAA--.54713S2
Authentication-Results: app2; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kGFWrWFWfAry3uF45Jrb_yoW8uF4kpa
	yfuFyIkw4vqr17K3yIgw40yFW8tF93Xr1UJ3W8J3WFqrsIvFn3trW29w4Fga4UZrZ5CFW2
	vF4j9a4Fv3WDAaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmFb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI
	0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAq
	x4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r4UJVWxJr1lYx0E74AGY7
	Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw2
	8IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0KNt3UUUUU==
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQkJAmbWg7dAjQADsJ


在 2024/7/26 16:38, Marco Elver 写道:
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
> that you ask that maintainer to take both patches, this and the
> Chinese translation patch. (Otherwise, I will queue this patch to be
> remembered but it'll be a while until it reaches mainline.)

Hi, Marco.


The patch "docs/zh_CN: Add dev-tools/kcsan Chinese translation" has been 
applied, but they didn't take this one. How about you take it into your 
tree?


Thanks,

Haoyang


