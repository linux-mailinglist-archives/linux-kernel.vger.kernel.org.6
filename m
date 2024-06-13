Return-Path: <linux-kernel+bounces-212605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21139063E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155E2B25079
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAB913792E;
	Thu, 13 Jun 2024 06:14:50 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18489137914;
	Thu, 13 Jun 2024 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259290; cv=none; b=OreXJALMytFKxhQuRYjaykCT1I1Zq59nsQnIMY8ICutCFqUUUGhokrDlz2qUJho+O/5D+Y59/IgNUTgBvHwoYztr+OvfLuds/cHBe2vlXApNb1Sy9TiOK46hPWIN8HUOO6g6x1VKsRelVTLUlgzeO3JPwZfESEPZw7EWshOzfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259290; c=relaxed/simple;
	bh=/NPEZDTSboUNyHHYCssTCB8+lPpXpoNQ9QHlCkgKOnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSWq1pyahym2sHJjnTL3O9W8f6AO7QnM/pGoe7DsmPM4ge2b9a8/FO03oBOEGclrCLLydfYSuRB8xkYYHca31WK4Ke79WtxeKgt9nzwaMCXvCBjM0NtF0lc/jqHBN33UL8nu9whRd3Nc3Ed3EAaCJbqPK9ijAavq2iCwXUGL+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrACXmShLjmpmoqTMBw--.62950S2;
	Thu, 13 Jun 2024 14:14:35 +0800 (CST)
Received: from [10.12.169.238] (unknown [10.12.169.238])
	by gateway (Coremail) with SMTP id _____wAnYk9KjmpmQIceAA--.32707S2;
	Thu, 13 Jun 2024 14:14:34 +0800 (CST)
Message-ID: <25a6d1e3-5965-4a51-ab9a-4489c519e10b@hust.edu.cn>
Date: Thu, 13 Jun 2024 14:14:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Update dev-tools/index.rst
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Haoyang Liu <tttturtleruss@hust.edu.cn>,
 Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612161835.18931-1-dzm91@hust.edu.cn>
 <871q51q2zq.fsf@trenco.lwn.net>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <871q51q2zq.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrACXmShLjmpmoqTMBw--.62950S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kXrWUZw47CrWUXr47Arb_yoW8XF1xpF
	409FySka4rXry3C342gF1jgFy8KF1xWw4DGF1qq3ZYqrn8XFs7tFsxtr9I9FyfXrWfAayr
	AF4IgFy5W34jka7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26F4j6r4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82
	IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_uctUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/6/13 05:12, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> Update to commit 8c88bc5b489e ("docs: dev-tools: Add UAPI checker
>> documentation")
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>   Documentation/translations/zh_CN/dev-tools/index.rst | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
>> index fa900f5beb68..c540e4a7d5db 100644
>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>> @@ -20,18 +20,22 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>   
>>      testing-overview
>>      sparse
>> +   kcov
>>      gcov
>>      kasan
>> -   kcov
>>      ubsan
>>      kmemleak
>>      gdb-kernel-debugging
>>   
>>   Todolist:
>>   
>> + - checkpatch
>>    - coccinelle
>> + - kmsan
>>    - kcsan
>>    - kfence
>>    - kgdb
>>    - kselftest
>>    - kunit/index
>> + - ktap
>> + - checkuapi
> So I have to say that the changelog here is not particularly helpful.
> You have *not* updated the translation to that commit, so it doesn't
> seem like you should say that you did.  "Add several newish documents to
> the todo list" is appropriate for something like this.


Yes, I should use another commit message to describe what I am doing.


> I've applied the patch, but with the changed commit message.


Thanks very much.


>
> Thanks,
>
> jon


