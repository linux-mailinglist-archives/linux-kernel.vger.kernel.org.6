Return-Path: <linux-kernel+bounces-281774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572894DB29
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D666B1F21EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FE414A600;
	Sat, 10 Aug 2024 06:59:31 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455474779F;
	Sat, 10 Aug 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723273171; cv=none; b=NhG5DDfSfNl/8xLPUgYaJk6HLMOqPGTgLD0B24MfhloEan6V+PxyEBdmmru7uzPAefVTjeS3S6YpNt5XICLsgGjQL6NjbJpk2D8VcqudKvgFoK0Qvt26r4JiLh+Xx74zYBZrEi/LM6sj38pVpyPgqXwRQDoneMiJyHqlcya4hFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723273171; c=relaxed/simple;
	bh=cIqDN/pSY+8JChTZBiL1uAX4CFKJE+LpR8rYOQwaJp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckf2NVO2ZRkG76mtnYpQhSa0ke8IfzAfob4tVe8ErrBxa+4XGs6HQPuBfj4hME3ciROXvttbE3UDkaAp0EDGAV4a/ps1iRsBiBN4VJigoWRXijx+CE5vks8GJPmNtybeACNVHjF7MGfMfr83GQ0j8SnBIj4JH9D21khYNVMXNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrABHTc2bD7dmpE10AA--.38994S2;
	Sat, 10 Aug 2024 14:58:35 +0800 (CST)
Received: from [192.168.1.111] (unknown [10.12.177.116])
	by gateway (Coremail) with SMTP id _____wDn77+ZD7dmlpoEAA--.7043S2;
	Sat, 10 Aug 2024 14:58:34 +0800 (CST)
Message-ID: <aeebfd95-200c-4856-9067-6cf49931d840@hust.edu.cn>
Date: Sat, 10 Aug 2024 14:58:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] docs/zh_CN: Add dev-tools/kcsan Chinese translation
To: YanTeng Si <si.yanteng@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240807162720.46588-1-tttturtleruss@hust.edu.cn>
 <d6eec1da-0e79-432f-a5cf-7dc8c59f28c1@hust.edu.cn>
 <87r0b0th7l.fsf@trenco.lwn.net>
 <c4ffaae1-59a0-4837-a965-441af4851d2a@hust.edu.cn>
 <25b4c3e0-784d-41ea-8ff3-8cb175983676@linux.dev>
 <2e27c607-713f-48f2-9a2e-41f7c61f7e73@linux.dev>
Content-Language: en-US
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
In-Reply-To: <2e27c607-713f-48f2-9a2e-41f7c61f7e73@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrABHTc2bD7dmpE10AA--.38994S2
Authentication-Results: app2; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxuFW3tF1rKry3Xr15twb_yoWDCFg_Cw
	1ay3Z2kr4DAr409Fn7Gw45Jw4DWa98Wa13Gw1rJa1rJwnxZF4UCr1DWwn3Xwn3Aa10krs0
	qF1UuF1Utry7WjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbmxYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUSznQDUUUU
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQsFAma237IJyAAAsx


On 8/9/24 10:57 AM, YanTeng Si wrote:
>
> 在 2024/8/9 18:44, YanTeng Si 写道:
>> Hi Haoyang,
>>
>> 在 2024/8/8 0:48, Haoyang Liu 写道:
>>>
>>> 在 2024/8/8 0:45, Jonathan Corbet 写道:
>>>> Haoyang Liu <tttturtleruss@hust.edu.cn> writes:
>>>>
>>>>> This is a mistake but I missed it before sending this patch.
>>>>>
>>>>> What should I do to revert or correct this patch?
>>>>>
>>>>> Thanks for your help and patience.
>>>> Send a v6 with the correction made - but wait a while for other 
>>>> reviews
>>>> first.
>>>
>>> OK.
>>>
>> The doc is good enough for me, so you can send a v6 after fix the typo.
>>
>>
>> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>
> I am Sorry! It seems that I've permanently lost access to 
> siyanteng@loongson.cn account,
>
> So you need use  --suppress-cc=sob when you send-email and pick my 
> Reviewed-by tag.

Hi Yanteng,


OK, I will send a v6 soon.


Thanks,

Haoyang

>
>
> Thanks,
>
> Yanteng
>
>>
>>
>> Thanks,
>>
>> Yanteng
>>
>>>
>>> Thank you,
>>>
>>> Haoyang
>>>
>>>>
>>>> Thanks,
>>>>
>>>> jon
>>>
>>>
>>


