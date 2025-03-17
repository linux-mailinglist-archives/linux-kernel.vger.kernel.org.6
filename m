Return-Path: <linux-kernel+bounces-563859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C0EA649BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E023B4B17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14AE233720;
	Mon, 17 Mar 2025 10:20:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B32E3373
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206806; cv=none; b=kG2zrGT+BCbotdTcUq/UNYnCNKYJ/afVfKEKVrBRx80vDh0Wz4P2YTuOlcPA9EdkcULF2o2nWWWuNWq2a96765ASTuEYyiO9hrYBpTKqJ8ptBRS953keHZFikHP9H6M9y6tUwKudKytf17Cx9C7/DS9ld/ODlW+2WTnBJihKnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206806; c=relaxed/simple;
	bh=y7SQyiNMqR2HpYoZOrpm5CIwKXkQ2/gmiiqomrbVWOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=etcRoJxJeXxSbFvCbtTjJK+4XXl8IjMCpFJAvBhH9LYwf0aqJY579FF+q736oyeSp5yofi59QDu/M9PKXL984ywlZQYNuadaxxG9eQbK/9juBpQLqpWODbFCJ0Hu98OkGKZNTea0mlu2YsgBrcrysglR+j9pPcIkUaz4vNnaKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZGVx21Cfmz9sRy;
	Mon, 17 Mar 2025 11:06:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GY3M6MKxajRN; Mon, 17 Mar 2025 11:06:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZGVx20QyPz9sRr;
	Mon, 17 Mar 2025 11:06:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EF3CF8B765;
	Mon, 17 Mar 2025 11:06:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Jcpq8BWRW1ng; Mon, 17 Mar 2025 11:06:13 +0100 (CET)
Received: from [10.25.207.144] (unknown [10.25.207.144])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CAF918B764;
	Mon, 17 Mar 2025 11:06:13 +0100 (CET)
Message-ID: <ebc5d8c6-3c5c-4e6a-a218-9dddcdb4f8bc@csgroup.eu>
Date: Mon, 17 Mar 2025 11:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250307] Build Failure
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <70ba4e80-53c4-4583-82f3-2851e0829aa6@linux.ibm.com>
 <5ab103b4-70f0-454e-bca6-0bfc66d143f5@csgroup.eu>
 <c0a716d0-6811-4b1b-b008-d4e97900cb0e@linux.ibm.com>
 <5c671410-cedd-4854-a3e7-2060607d5c4d@csgroup.eu>
 <25e5d468-6c40-40b7-a010-8c8018b6d228@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <25e5d468-6c40-40b7-a010-8c8018b6d228@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/03/2025 à 08:27, Venkat Rao Bagalkote a écrit :
> 
> On 12/03/25 8:49 pm, Christophe Leroy wrote:
>>
>>
>> Le 12/03/2025 à 11:11, Venkat Rao Bagalkote a écrit :
>>>
>>> On 12/03/25 4:20 am, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 09/03/2025 à 13:38, Venkat Rao Bagalkote a écrit :
>>>>> Greetings!!,
>>>>>
>>>>> I see linux-next-20250307 fails to build on IBM Power9 and Power10 
>>>>> servers.
>>>>>
>>>>>
>>>>> Errors:
>>>>>
>>>>> In file included from ^[[01m^[[K<command-line>^[[m^[[K:
>>>>> ^[[01m^[[K./usr/include/cxl/features.h:11:10:^[[m^[[K 
>>>>> ^[[01;31m^[[Kfatal error: ^[[m^[[Kuuid/uuid.h: No such file or 
>>>>> directory
>>>>>     11 | #include ^[[01;31m^[[K<uuid/uuid.h>^[[m^[[K
>>>>>        |          ^[[01;31m^[[K^~~~~~~~~~~~~^[[m^[[K
>>>>
>>>> This is unreadable. Please avoid fancy colors that add escapes to 
>>>> logs. You can unset LANG environment var before building in order to 
>>>> get pastable stuff.
>>>>
>>
>> Allthought not really readable, it seems to mention that uuid/uuid.h 
>> is missing.
>>
>> Can you confirm that you have installed libuuid package in your 
>> system ? Maybe you also need some libuuid-dev packet to get headers ?
> 
> 
> Yeah uuid package is installed on my system. I am seeing this failure 
> only with build next-20250307.
> 
> Builds with before and after are compiling successfully.

Ok, so I understand from this that the problem is fixed and there is not 
further investigation required.

Thanks
Christophe

