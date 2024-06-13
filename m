Return-Path: <linux-kernel+bounces-212591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D4C9063BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193CA284E31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888061369A0;
	Thu, 13 Jun 2024 06:06:51 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F75136E2A;
	Thu, 13 Jun 2024 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258811; cv=none; b=SZJjVOQqtphWlCqee2yfuX8+LpwWhyDiS3DWRf5oozUgvWamjjkTw4fpCvwgRa+ICsjkbtubU+ugcNlgXRKaAVkSnSIHkjlszNT5QYnKTjVI6CClKTpqaFtnRo7hFabeM7MRcqn6PI172HqA+X8iDorMsz5uCZ00U1l9BRScxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258811; c=relaxed/simple;
	bh=tQuruoBPJkmyTST/kNkyaOSE113hO9dTS2VsCm0j+SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO/KJGwtrR+zbS78rgNC979Z6skQouEzzQFmaq08y5+D9DxH3w7EyZMKGflY9HMSR/SMRyRHVYjq45tsIBRVp/GfB7EqBqQbPpLm4EzATe0amdqU28M2zLSZYb/djvcPPdHzG5LloxPSnBrx34nwqkdkGP8fDVng5cdOn0LbUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAAHX8dZjGpmPkNxAQ--.8099S2;
	Thu, 13 Jun 2024 14:06:17 +0800 (CST)
Received: from [10.12.169.238] (unknown [10.12.169.238])
	by gateway (Coremail) with SMTP id _____wDHokRWjGpm+X0eAA--.577S2;
	Thu, 13 Jun 2024 14:06:16 +0800 (CST)
Message-ID: <43d7cf37-8f7f-4004-a5d1-15fcc9189016@hust.edu.cn>
Date: Thu, 13 Jun 2024 14:06:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts: add scripts/checktransupdate.py
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 Cheng Ziqiu <chengziqiu@hust.edu.cn>, linux-kernel@vger.kernel.org
References: <20240611131723.53515-1-dzm91@hust.edu.cn>
 <87plslonqu.fsf@trenco.lwn.net>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87plslonqu.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HwEQrAAHX8dZjGpmPkNxAQ--.8099S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Gw4xXrW8GrW5JFyUuF1rZwb_yoW8JF15pa
	4j9F1aywn8Kr1xCF4fKw1vqFWrJF1IyFWFqry2qr1rXrn8tr1xGF4avw45ur1UurW8Jw1Y
	yFyjkFZrK3W5CFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQFb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVWxJVW8Jr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6FALUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/6/13 05:27, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> The checktransupdate.py script helps track the translation status of
>> the documentation in different locales, e.g., zh_CN and verify if
>> these documenation is up-to-date. More specially, it uses `git log`
>> commit to find the latest english commit from the translation commit
>> (order by author date) and the latest english commits from HEAD. If
>> differences occur, report the file and commits that need to be updated.
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
>> ---
>> v1->v2: revise the output format of git commits
>>          add some description and usage of this script
>>   scripts/checktransupdate.py | 203 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 203 insertions(+)
>>   create mode 100755 scripts/checktransupdate.py
> I have applied this, it seems like a useful tool.
Thanks, jon.
> I do wish the code looked like something a bit closer to the kernel
> coding style, but so it goes.

Linux kernel does have coding style for C language. Any reference to 
python coding style?

I can refer to these materials to revise this script.

Dongliang Mu

>
> Thanks,
>
> jon


