Return-Path: <linux-kernel+bounces-445325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD769F14A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317C116ABDC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF81E32A3;
	Fri, 13 Dec 2024 18:01:47 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CE186E52
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112906; cv=none; b=ektWJRkNxg2cfN6W+gLQF0Dz4RL/RSHQmsRmyjmsh4KYGyClW7dd2vWLfAXRdjbW2HlzbYSNORoU1Sf3DppTYDkZSmaL93/ef476dTC83+fj/bWwnrxIiye6aX9x5IvukQyiJAlt4PyoIuY/c+RvZogK0mXs6P/zyZlKOjtnmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112906; c=relaxed/simple;
	bh=0+F0DJPkKhYVV1hxT8kRLvmvYRjkZiU2L79/WwpxMPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llKr/WCbc1cqQk0K/+rkfs1LnB/pJENbqrhQ70uyq8M7PKgP/sR7TyNCkcBRgERia5SRGjuvxf1BjSlYTqizuQBoZYl+j1hB+DyGO5ZECCbEIKgX1FVNc2G6ncjd0f25fzXrdPxXMGsRS/JdrZGg+8QSZt2LwnRt3zxbsSZhsxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y8xx30j08z9stM;
	Fri, 13 Dec 2024 19:01:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSSsHbs8N1EE; Fri, 13 Dec 2024 19:01:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y8xx26twzz9sSN;
	Fri, 13 Dec 2024 19:01:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DB8938B773;
	Fri, 13 Dec 2024 19:01:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id XbgtfbMthvBF; Fri, 13 Dec 2024 19:01:42 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EA9D8B763;
	Fri, 13 Dec 2024 19:01:42 +0100 (CET)
Message-ID: <95951cd6-f98f-4793-a35c-22f4e8d743af@csgroup.eu>
Date: Fri, 13 Dec 2024 19:01:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
 <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
 <Z1sOTf6UZbruptnl@smile.fi.intel.com>
 <991aee8b-fb10-4152-89fb-6ac542ee87c1@csgroup.eu>
 <Z1xp1xwLXAvkKgwD@smile.fi.intel.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z1xp1xwLXAvkKgwD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/12/2024 à 18:07, Andy Shevchenko a écrit :
> On Fri, Dec 13, 2024 at 07:28:45AM +0100, Christophe Leroy wrote:
>> Le 12/12/2024 à 17:24, Andy Shevchenko a écrit :
>>> On Mon, Nov 18, 2024 at 03:10:09PM +0100, Christophe Leroy wrote:
>>>> Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
>>>>> Remove legacy-of-mm-gpiochip.h header file. The above mentioned
>>>>> file provides an OF API that's deprecated. There is no agnostic
>>>>> alternatives to it and we have to open code the logic which was
>>>>> hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
>>>>> drivers are using their own labeling schemas and resource retrieval
>>>>> that only a few may gain of the code deduplication, so whenever
>>>>> alternative is appear we can move drivers again to use that one.
>>>>>
>>>>> As a side effect this change fixes a potential memory leak on
>>>>> an error path, if of_mm_gpiochip_add_data() fails.
>>>>>
>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>
>>>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>
>>> Thanks, what's next?
>>
>> Next step is that Michael or Madhavan apply it I guess ?
> 
> Folks, do you have any comments? Can you apply this and we move forward towards
> removing the legacy API from the kernel?
> 

If you have some work which depends on this patch, you can also take it 
together with that work through another tree. Just let us know.

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

