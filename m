Return-Path: <linux-kernel+bounces-212625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B32906409
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0F1B22A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15A6136E0F;
	Thu, 13 Jun 2024 06:28:54 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D286425632;
	Thu, 13 Jun 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260134; cv=none; b=L9lQDB1TtDjBRNSABIAylAbihFMNZurF+XKaTvmpRtLRQk1jA8ejkKTHbY+v8qATLp//W8p4Iky2zEnaaLTIcQOj4zn5RmqKwNyHaQvxhQ8/5o7LURFgWG9zbNyYjCOXpSYuWH6hr4LYG69Qg9sjqC2jU3qGHRC2Orsb3FlXWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260134; c=relaxed/simple;
	bh=sElRb+gr2z38VzPOs6tSW0eRkwueqHTVt4PboxtTrbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4QJG/5GIz+8thDCGvY7sdFIMJroh6KQkRbgV9Y5znTuFtll/El2uirRQpV/wt9taHJLk1kP5YFJwstkbLwu5qMKbHtI4sB2AZ7ca5XU8ucrwBUYOlX8yvFZ8Bp4DLHt/5x+BKOhAMKRyawlUTOZWOZC/rVIbMllf/g84q2mgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAAHD4NckWpm8sXMBw--.61145S2;
	Thu, 13 Jun 2024 14:27:40 +0800 (CST)
Received: from [10.12.169.238] (unknown [10.12.169.238])
	by gateway (Coremail) with SMTP id _____wBnoU5akWpmKZgeAA--.32816S2;
	Thu, 13 Jun 2024 14:27:39 +0800 (CST)
Message-ID: <c6da52be-087a-4f28-8a8c-d61196922cb7@hust.edu.cn>
Date: Thu, 13 Jun 2024 14:27:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: add process/researcher-guidelines Chinese
 translation
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612021845.12036-1-dzm91@hust.edu.cn>
 <87tthxoo3u.fsf@trenco.lwn.net>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87tthxoo3u.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrAAHD4NckWpm8sXMBw--.61145S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxAr47WryUuFWxWr4fWryfWFg_yoW5GrWfpF
	y8KF93Ka1xJw1UC3yxur1jgF1fJ3Z7Ca9xtw12qw1Sqrn0yrn2qr9xtrZ8Kas3WrW8Za4U
	Xr4YgrWUur17Z3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm0b7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVWxJVW8Jr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcV
	Cjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07j6VbkUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/6/13 05:19, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> Finish the translation of researcher-guidelines and add it to the
>> index file.
>>
>> Update to commit 27103dddc2da ("Documentation: update mailing list
>> addresses")
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>> v1->v2: Revise description suggested by Alex Shi
>>          Add a commit id to keep track of the translation status
>>          Add a new line at the end of researcher-guidelines.rst
>>   .../translations/zh_CN/process/index.rst      |   2 +-
>>   .../zh_CN/process/researcher-guidelines.rst   | 129 ++++++++++++++++++
>>   2 files changed, 130 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/translations/zh_CN/process/researcher-guidelines.rst
>>
>> diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
>> index 5c6c8ccdd50d..5a5cd7c01c62 100644
>> --- a/Documentation/translations/zh_CN/process/index.rst
>> +++ b/Documentation/translations/zh_CN/process/index.rst
>> @@ -64,6 +64,7 @@ TODOLIST:
>>      management-style
>>      stable-kernel-rules
>>      submit-checklist
>> +   researcher-guidelines
>>   
>>   TODOLIST:
>>   
>> @@ -71,7 +72,6 @@ TODOLIST:
>>   * kernel-docs
>>   * deprecated
>>   * maintainers
>> -* researcher-guidelines
>>   * contribution-maturity-model
>>   
>>   
>> diff --git a/Documentation/translations/zh_CN/process/researcher-guidelines.rst b/Documentation/translations/zh_CN/process/researcher-guidelines.rst
>> new file mode 100644
>> index 000000000000..66e4840f208a
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/process/researcher-guidelines.rst
>> @@ -0,0 +1,129 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +.. _cn_submittingpatches:
> This label here ^^^ adds a new warning to the docs build:
>
>> Documentation/translations/zh_CN/process/researcher-guidelines.rst:7: WARNING: duplicate label cn_submittingpatches, other instance in Documentation/translations/zh_CN/process/submitting-patches.rst
> This is a fairly obvious error, and one you should have seen when you
> did your own docs build.  Please be a bit more careful.


Sorry about this. I did build documents(make htmldocs) in my local 
environment. It seems that this warning slipped out of my eyes :(

I will be more careful about kernel commits in the future. Will send a 
v3 patch today or tomorrow.

Dongliang Mu


>
> jon


