Return-Path: <linux-kernel+bounces-371272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6099A3901
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EA21C22A04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEFA18F2D8;
	Fri, 18 Oct 2024 08:46:35 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3418892F;
	Fri, 18 Oct 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241194; cv=none; b=Q6cRpTljSY8Hjv5EpVPHlbtRavPIxxEaA6uWDIpjgztn1w/x4sUYUYw/8yvaFufLbzIcsZ2FF+NObuVYPEFcRsmeL86bfGPWyJbQ/6u47qm7slhSGsG9fKI4lQ0fahpSACojOCbfvdqQA9zebJRuwgCWHFVUSCs+cYUKjvwZOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241194; c=relaxed/simple;
	bh=fmNNoiNd8ADaJ238aw6EjZJQsBgu84WStngfBXUeGyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vC51qGP2P2wZSZUHtyCrPCBA4EVsEHvABcF/UrTKEjxzg3n6CP35HF9n6BK775iJX+NKb0+wgvvbo6AOw+o6OR2bbTGG3NFQUXEjgwV2H0rg/Yjt/aH2UUGx35QPiySJxlZ26gQGSF59XmexM7jMn3xUcAWfBbqYP3en2EwBdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAC3F21WIBJnQ+QHCA--.15588S2;
	Fri, 18 Oct 2024 16:46:14 +0800 (CST)
Received: from [10.12.173.122] (unknown [10.12.173.122])
	by gateway (Coremail) with SMTP id _____wDXmw1RIBJnOpVkAA--.16735S2;
	Fri, 18 Oct 2024 16:46:12 +0800 (CST)
Message-ID: <af4f186b-6874-4277-b5df-f384a698fc10@hust.edu.cn>
Date: Fri, 18 Oct 2024 16:46:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/submitting-patches.rst
To: Yanteng Si <si.yanteng@linux.dev>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: hust-os-kernel-patches@googlegroups.com,
 Hu Haowen <2023002089@link.tyut.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241018015452.3787741-1-dzm91@hust.edu.cn>
 <aac937f3-f147-49b8-8408-9f8f4d00735e@linux.dev>
 <dbabf6eb-a1bf-401f-9159-605bc74e182c@linux.dev>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <dbabf6eb-a1bf-401f-9159-605bc74e182c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAC3F21WIBJnQ+QHCA--.15588S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7GrW8CF1DCF43Wry5Aw1DWrg_yoWDCwc_uF
	1Yyr12kFWDJry0qFs0g3y5GrZxC3Wj9rn8Wr1DCrs5Wa4vkFWDWFWDG34fZw17KrWFqFn8
	AF92qay8JrWa9jkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbm8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfvtZUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/10/18 15:32, Yanteng Si wrote:
>
>
>
> 在 2024/10/18 15:12, Yanteng Si 写道:
>>
>>
>>
>> 在 2024/10/18 09:54, Dongliang Mu 写道:
>>> Update to commit eb5ed2fae197 ("docs: submitting-patches: Advertise 
>>> b4")
>>>
>>> scripts/checktransupdate.py reports:
>>>
>>> Documentation/translations/zh_CN/process/submitting-patches.rst
>>> commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
>>> commit 413e775efaec ("Documentation: fix links to mailing list 
>>> services")
>>> 2 commits needs resolving in total
>>>
>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
>>
> I apologize, I signed off repeatedly (in v1).
>
> Dongliang, Similar patches can be grouped into a single patch set,
> which would make the review process easier.

Thanks for the reminder. I will submit a patch set next time.

Dongliang Mu

>
> run:
> git format-patch -n <the number of patches> -v <version>  
> --cover-letter --thread=shallow
>
> Thanks,
> Yanteng


