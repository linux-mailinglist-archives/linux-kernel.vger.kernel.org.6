Return-Path: <linux-kernel+bounces-444325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A179F04CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85292838CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BDC18C031;
	Fri, 13 Dec 2024 06:28:50 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4C13DDAA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071330; cv=none; b=ZZ0t19ZKtIO3gMsDVkSDubMrmg1/ifYJUo67po3HbTAIEeOUxCSBM/eIiByyN+D0YLrYWUv/lIq6m7iMoW7MvfyuBfhHcrd6nA8O2pDWADACSGfOT3jaQYf8ShITkg05kPn+RyTZAgtxf6bfJHisxnKMvfFsLafQ7FG0WJNSngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071330; c=relaxed/simple;
	bh=sc1FPR5UyRoyEjvi4OMO42Bl1JzCpS7bDJ2y/kDuqfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9Y7Mgrp3rQPUzTJ5m6izFU6SRQyQjIcnThq2cCkIssp+GTU19s6zhsbt6fxbf7lSERuWOtKUwFT169PaUi6kik7dDAqbD20RoMhydiLfL4kEqXF0GjaWZzl0d13C7HOt06YMjAUAF3Fdyy/CNZWJVvB3RIlVC29EmXzIgYKxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y8fYV4W1mz9stv;
	Fri, 13 Dec 2024 07:28:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nRIFyjzOzWwM; Fri, 13 Dec 2024 07:28:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y8fYV3lykz9sts;
	Fri, 13 Dec 2024 07:28:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 719C78B773;
	Fri, 13 Dec 2024 07:28:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id I9yCcYxlM4Xk; Fri, 13 Dec 2024 07:28:46 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF70C8B763;
	Fri, 13 Dec 2024 07:28:45 +0100 (CET)
Message-ID: <991aee8b-fb10-4152-89fb-6ac542ee87c1@csgroup.eu>
Date: Fri, 13 Dec 2024 07:28:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
 <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
 <Z1sOTf6UZbruptnl@smile.fi.intel.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z1sOTf6UZbruptnl@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/12/2024 à 17:24, Andy Shevchenko a écrit :
> On Mon, Nov 18, 2024 at 03:10:09PM +0100, Christophe Leroy wrote:
>> Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
>>> Remove legacy-of-mm-gpiochip.h header file. The above mentioned
>>> file provides an OF API that's deprecated. There is no agnostic
>>> alternatives to it and we have to open code the logic which was
>>> hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
>>> drivers are using their own labeling schemas and resource retrieval
>>> that only a few may gain of the code deduplication, so whenever
>>> alternative is appear we can move drivers again to use that one.
>>>
>>> As a side effect this change fixes a potential memory leak on
>>> an error path, if of_mm_gpiochip_add_data() fails.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Thanks, what's next?
> 

Next step is that Michael or Madhavan apply it I guess ?

Christophe

