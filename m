Return-Path: <linux-kernel+bounces-216645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ED290A294
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E651F21BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FCA17B40F;
	Mon, 17 Jun 2024 02:44:22 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D69176ABF;
	Mon, 17 Jun 2024 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592261; cv=none; b=GcewwjP4M2ABIG4vwldHvts3X5YJUMyMOPRAArx1NTaB28ALW7Z56Bx3rkRB7ihKbc2rFatWpjYG6H6LfOR0dNk70dGZBYO536EHotNPrjO9n5U1Tx98GDtBcr4gsI4eYKVFZuEOF+Y4++kT8ZQvk9UZIe6kVrA37L9bpGeAgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592261; c=relaxed/simple;
	bh=xjkUR6MKG+zNwxf1eNXwNNovNlcpwqV0wmrt5AuuGvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PErFA9+I3bjklMh3xdirWy57a7MRlMDwEgOM3MQqfBpLC9IVaPpzfXG65fDQTlmDNNTiPkFnl7ip91f/4z4tekKQL2PIQOEM3KNF7CK6mbRidoSKKx9nYnbsSJBZbfG2HKU5VSzh9/tcbHOuiKeMjYwDwBDErTW1hSFs18MtxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAA3PCvjom9mr5ECCA--.64462S2;
	Mon, 17 Jun 2024 10:43:47 +0800 (CST)
Received: from [172.19.192.113] (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wCngUbfom9mVtA2AA--.8204S2;
	Mon, 17 Jun 2024 10:43:46 +0800 (CST)
Message-ID: <e9c5fc69-5070-466f-af26-b72565394b46@hust.edu.cn>
Date: Mon, 17 Jun 2024 10:43:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] scripts: fix most issues reported by pylint
To: Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Cheng Ziqiu <chengziqiu@hust.edu.cn>, Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20240615035323.909650-1-dzm91@hust.edu.cn>
 <87ikyakn6l.fsf@trenco.lwn.net>
 <4df7cbfd-5a14-43a4-973b-23fd4f5d78fb@hust.edu.cn>
 <3ae5e014-108e-484e-bbdf-689ab67a85e2@loongson.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <3ae5e014-108e-484e-bbdf-689ab67a85e2@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAA3PCvjom9mr5ECCA--.64462S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4kKF4Utry8Zw18Cr45KFg_yoW8Xr1kpF
	W3CanayF45Jr13Aw4Iyw1rJr1Ykas3trWDWr13Jw18urnIvFnagr47KF4ruryDXryfuw12
	yw4aqasa9F98AFJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmYb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUVoGHUUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/6/17 10:29, Yanteng Si wrote:
> Hi,Dongliang
>
> 在 2024/6/17 09:05, Dongliang Mu 写道:
>>
>> On 2024/6/16 03:42, Jonathan Corbet wrote:
>>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>>
>>>> Pylint reports many coding style issues of scripts/checktransupdate.py
>>>>
>>>> This patch fixes most issues with the following contents:
>>>> - add or revise comments for all functions
>>>> - use format string suggested by python
>>>>
>>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>>> ---
>>>>   scripts/checktransupdate.py | 55 
>>>> ++++++++++++++++---------------------
>>>>   1 file changed, 24 insertions(+), 31 deletions(-)
>>> How does this differ from v1?  Please always give that information so
>>> reviewers know what's going on.
>>
>> Hi Jon,
>>
>> Patch 1/2 in v2 patch has no difference with Patch 1/2 in v1. Randy 
>> put up some change requests about
>>
>> the help documentation, and it is written in the Patch 2/2 in v2.
>>
>> I am not sure how to show this information in Patch 1/2. How about 
>> "v1->v2: no changes"?
>>
>>
> Let's make a cover letter, just like:
>
> <https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/> 
>
>
>
> you can run:
>
>
> $: git format-patch xxxxx   --cover-letter
>
I see. I will follow this rule when sending a patchset in the future.

Thanks for your helpful message.

>
> BTW,
>
> It seem that you forget to cc  linux-doc@vger.kernel.org.
>
>
> Thanks,
>
> Yanteng


