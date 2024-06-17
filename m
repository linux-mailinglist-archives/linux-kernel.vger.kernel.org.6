Return-Path: <linux-kernel+bounces-216635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1090A271
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4919E1C20D58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FD17836A;
	Mon, 17 Jun 2024 02:29:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154123A9;
	Mon, 17 Jun 2024 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591353; cv=none; b=HuiX08UmVjTvSsG9ydZo1GmsfrSuXO+WwriGnCH31QQbEHbjqay7d3z1oG52uIeF0uV44HDGsOHjKyiNkeIoDbWP2x5AtEGs6o4J2lTv8a1wdBVLjaHYtBvA/zAri5WbLm1CosqPsYvXPf4X+wez5u5MUmia3D3RikEWnjyaYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591353; c=relaxed/simple;
	bh=m4fw77Bj1oYoTCNGPtzdaz997Yb3pcMlVHVmHljxOls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWWnxrXW0GP8wVNq6ul3LCXd/u6AAHlt1Ennw1Wog80an69ISMPTE/CG9BYXKLUKu+D9OILnJf2Xu6DB5W4RoF97MIJAW80VQxN30eXHoTWNNaeYrwaaftnd1QopdU1wbrNqR40RPP5E1cu366zKLxue/xj1T2PCmGpJBe5pvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.225])
	by gateway (Coremail) with SMTP id _____8DxFPBzn29m+3IHAA--.29937S3;
	Mon, 17 Jun 2024 10:29:07 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.225])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axjsdwn29mxcYkAA--.23233S3;
	Mon, 17 Jun 2024 10:29:05 +0800 (CST)
Message-ID: <3ae5e014-108e-484e-bbdf-689ab67a85e2@loongson.cn>
Date: Mon, 17 Jun 2024 10:29:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] scripts: fix most issues reported by pylint
To: Dongliang Mu <dzm91@hust.edu.cn>, Jonathan Corbet <corbet@lwn.net>,
 Cheng Ziqiu <chengziqiu@hust.edu.cn>, Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20240615035323.909650-1-dzm91@hust.edu.cn>
 <87ikyakn6l.fsf@trenco.lwn.net>
 <4df7cbfd-5a14-43a4-973b-23fd4f5d78fb@hust.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <4df7cbfd-5a14-43a4-973b-23fd4f5d78fb@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Axjsdwn29mxcYkAA--.23233S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWruF45CF1UtF1rAw13uFW5XFc_yoW8JF4UpF
	WakanakF45JrnxCa1xtw4fXr1YkF97tryDWr47tw1kuFnIyr1vgw4agF4ru34DJryfu3WU
	tr1aqasY9r95AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

Hi,Dongliang

在 2024/6/17 09:05, Dongliang Mu 写道:
>
> On 2024/6/16 03:42, Jonathan Corbet wrote:
>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>
>>> Pylint reports many coding style issues of scripts/checktransupdate.py
>>>
>>> This patch fixes most issues with the following contents:
>>> - add or revise comments for all functions
>>> - use format string suggested by python
>>>
>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> ---
>>>   scripts/checktransupdate.py | 55 
>>> ++++++++++++++++---------------------
>>>   1 file changed, 24 insertions(+), 31 deletions(-)
>> How does this differ from v1?  Please always give that information so
>> reviewers know what's going on.
>
> Hi Jon,
>
> Patch 1/2 in v2 patch has no difference with Patch 1/2 in v1. Randy 
> put up some change requests about
>
> the help documentation, and it is written in the Patch 2/2 in v2.
>
> I am not sure how to show this information in Patch 1/2. How about 
> "v1->v2: no changes"?
>
>
Let's make a cover letter, just like:

<https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/>


you can run:


$: git format-patch xxxxx   --cover-letter


BTW,

It seem that you forget to cc  linux-doc@vger.kernel.org.


Thanks,

Yanteng


