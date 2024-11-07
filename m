Return-Path: <linux-kernel+bounces-399781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E55F9C0422
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52588282591
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272120ADCE;
	Thu,  7 Nov 2024 11:33:23 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BB1EF08E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979203; cv=none; b=hQIFYqc15/InFDzcv+Zkixg6Z5Fwyn8ydPRm2o+6yoeCW0929EUGUV3CYqpyOip97XYbRSmMAT4heatGTXhFm+N7wc3RlUWCKqsR9myN6ta0un+yvRk8xKfOrVTqNPBQ1EUakqAJH67KOWiEC3fPQArCHugStBvn0uhF+WLQGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979203; c=relaxed/simple;
	bh=CL32niuIDYKkeEG7Qq+Dp3Oe6Gouzte0zdDYjFnhyiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3Ur8t/Ncir5dKTqY1sLqGOVocS6ktssWJiDPvXXNWMW+aGjpi92S9oBL21B7mxRl6RxgqcG/lqhJjOrKVD8l4nw1CJAOpnBRf09Y2HiBl50QhfnV8VnCjcuFJ00ZRPEYs1C1QSLwp7A8qIt5Xa6dskACi052IrteEilwQGGvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xkg1Q1hLcz9sSL;
	Thu,  7 Nov 2024 12:33:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5xrcSFGIfoJs; Thu,  7 Nov 2024 12:33:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xkg1Q0p7cz9sSK;
	Thu,  7 Nov 2024 12:33:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C3108B77B;
	Thu,  7 Nov 2024 12:33:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OMnLZ6-ruVde; Thu,  7 Nov 2024 12:33:13 +0100 (CET)
Received: from [192.168.232.148] (unknown [192.168.232.148])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F2208B77A;
	Thu,  7 Nov 2024 12:33:13 +0100 (CET)
Message-ID: <ed3a5d53-af06-498f-a8fe-0fe1e3a293bc@csgroup.eu>
Date: Thu, 7 Nov 2024 12:33:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] powerpc/machdep: Remove duplicated include in svm.c
To: Michael Ellerman <mpe@ellerman.id.au>,
 Yang Li <yang.lee@linux.alibaba.com>, npiggin@gmail.com, naveen@kernel.org,
 maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20241107010259.46308-1-yang.lee@linux.alibaba.com>
 <87msibcmeb.fsf@mpe.ellerman.id.au>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87msibcmeb.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/11/2024 à 12:29, Michael Ellerman a écrit :
> Yang Li <yang.lee@linux.alibaba.com> writes:
>> The header files linux/mem_encrypt.h is included twice in svm.c,
>> so one inclusion of each can be removed.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11750
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>   arch/powerpc/platforms/pseries/svm.c | 1 -
>>   1 file changed, 1 deletion(-)
> 
> The two includes only appear in linux-next, and they both come from
> different trees. They are required in each tree to avoid breaking the
> build.
> 
> So no one can merge this patch until the two trees are merged into mainline.

But can't those two trees coordinate the patches so that the include 
goes at the same place avoiding duplication at merge ?

Christophe

