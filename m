Return-Path: <linux-kernel+bounces-558055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D994A5E106
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F140B3B3199
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC04254B02;
	Wed, 12 Mar 2025 15:50:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358A247DE1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794606; cv=none; b=fz4OoZRMQsWWEgnIg83gvvU5hS1l98bCYeHyn9T/DNhDJmkTc8QpndyqJoDSPm35mksKnhjGhIeQoFShDIWQIXWJ9XYjHgUv6RMCwFfSb7XVJ1tPjsgqhMHuzXadXOGJ1KeHb28Izo2R5UaL4iAdO0W77iXIzrvtMpsoiGXQno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794606; c=relaxed/simple;
	bh=JJvAd0hsfb1YNkSh5CNsBuR69c8ye+2lpWPnarfnN6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N9leZgju52qCnPUrhbwWmQxRP2k9N6LaJlk6LqVhlzgsm9ioJQm8Gqm6maILDQp4HvKKdaA2X2oP9LbfZwtALrCFzic87ZMCa4ULmQUlQBZVCbumUt0SuhpVcZJwJOqnCysC4PwSJuli0mC3l0+jF4ytRccci7lCPa2/zPhEpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZCZ7F38Gqz9sVt;
	Wed, 12 Mar 2025 16:19:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SOQ0iH8D4HeJ; Wed, 12 Mar 2025 16:19:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZCZ7F2LC3z9sVs;
	Wed, 12 Mar 2025 16:19:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A4828B768;
	Wed, 12 Mar 2025 16:19:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id NSc88byWdIAx; Wed, 12 Mar 2025 16:19:53 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DD1198B763;
	Wed, 12 Mar 2025 16:19:52 +0100 (CET)
Message-ID: <5c671410-cedd-4854-a3e7-2060607d5c4d@csgroup.eu>
Date: Wed, 12 Mar 2025 16:19:52 +0100
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <c0a716d0-6811-4b1b-b008-d4e97900cb0e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/03/2025 à 11:11, Venkat Rao Bagalkote a écrit :
> 
> On 12/03/25 4:20 am, Christophe Leroy wrote:
>>
>>
>> Le 09/03/2025 à 13:38, Venkat Rao Bagalkote a écrit :
>>> Greetings!!,
>>>
>>> I see linux-next-20250307 fails to build on IBM Power9 and Power10 
>>> servers.
>>>
>>>
>>> Errors:
>>>
>>> In file included from ^[[01m^[[K<command-line>^[[m^[[K:
>>> ^[[01m^[[K./usr/include/cxl/features.h:11:10:^[[m^[[K 
>>> ^[[01;31m^[[Kfatal error: ^[[m^[[Kuuid/uuid.h: No such file or directory
>>>     11 | #include ^[[01;31m^[[K<uuid/uuid.h>^[[m^[[K
>>>        |          ^[[01;31m^[[K^~~~~~~~~~~~~^[[m^[[K
>>
>> This is unreadable. Please avoid fancy colors that add escapes to 
>> logs. You can unset LANG environment var before building in order to 
>> get pastable stuff.
>>

Allthought not really readable, it seems to mention that uuid/uuid.h is 
missing.

Can you confirm that you have installed libuuid package in your system ? 
Maybe you also need some libuuid-dev packet to get headers ?

Christophe

