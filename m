Return-Path: <linux-kernel+bounces-419016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F859D6894
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED19B219A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279918756A;
	Sat, 23 Nov 2024 10:19:40 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D818595F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732357179; cv=none; b=XRaTcxxo+ACKEvoN2duqdpXmIYwMaZcDYfYKVYFSx5xXttzdd2cSC0fCuuDnimVIC0tCACtgEY43fk/daVdALI/V5kIiFV392oxl+8BrfM1MLBMdyb+80TNUa1gJ24pc+ic1Vgw9HMA8beu8ckBsi3UXhxbQcnbTylExBxJJN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732357179; c=relaxed/simple;
	bh=lgZ1ifmInpNdZWm6P4wHsMzuZXf5CTcwlaWUNH8y11o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mq32DRl/fxFnZhfNAyBUPmdfO/AyW2kBv77DtvzxifzIDhN8Vq/ldqNfMOdiV7W82/vX8cQVTDWNSI1CpAsQsSEohpTlbtThlROzGSjc1KYOwVZIE2muzKXrBzkBTRt/WRGCJJfPjd8KSHRJoxK7CoSTNRq/SDY6eH24WxIOB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XwScx5KxVz9sPd;
	Sat, 23 Nov 2024 11:19:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IMnpy2PKmDHd; Sat, 23 Nov 2024 11:19:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XwScx49Y8z9rvV;
	Sat, 23 Nov 2024 11:19:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7416C8B765;
	Sat, 23 Nov 2024 11:19:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id F0Hvjc_3hwkh; Sat, 23 Nov 2024 11:19:29 +0100 (CET)
Received: from [192.168.232.139] (unknown [192.168.232.139])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 15C368B764;
	Sat, 23 Nov 2024 11:19:29 +0100 (CET)
Message-ID: <d9e232bb-5069-4526-b781-f4e316bda95d@csgroup.eu>
Date: Sat, 23 Nov 2024 11:19:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Transliterate author name and remove FIXME
To: Michael Ellerman <mpe@ellerman.id.au>,
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241110162139.5179-2-thorsten.blum@linux.dev>
 <87v7wuy3p5.fsf@mpe.ellerman.id.au>
 <55B1EE24-BEC9-4A8D-84B0-ED32FCC070A5@linux.dev>
 <87v7weodqn.fsf@mpe.ellerman.id.au>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87v7weodqn.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/11/2024 à 04:01, Michael Ellerman a écrit :
> Thorsten Blum <thorsten.blum@linux.dev> writes:
>> On 11. Nov 2024, at 02:11, Michael Ellerman wrote:
>>> Thorsten Blum <thorsten.blum@linux.dev> writes:
>>>> The name is Mimi Phuong-Thao Vo.
>>>
>>> Is that the correct spelling?
>>>
>>> The github commit below suggests it's Mimi Phûông-Thåo Võ.
>>>
>>> And presumably the author preferred that spelling, otherwise they would
>>> have just written it in ASCII in the first place.
>>>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fbminor%2Fbinutils-gdb%2Fcommit%2F6603bf38d74409906b3814f6a26c0483a5d32e41&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Ce09e131ad44342b0be9a08dd0b6b1c9b%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638679276875561424%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=5F8j2IkQc6sy8tnoBoNVlbxA2YyxptCfh92Gx9mi460%3D&reserved=0
>>
>> Hi Michael,
>>
>> Are you suggesting to keep "Mimi Ph\373\364ng-Th\345o V\365" and a FIXME
>> instead of changing it to "Mimi Phuong-Thao Vo" which is how she spells
>> her name on her LinkedIn profile and other websites?
> 
> No I'm not suggesting to leave it as-is.
> 
> But I also suspect they spell it that way on LinkedIn etc. because it's
> the path of least resistance, not because it's the correct spelling.
> 
> I was hoping someone who's more familiar with Vietnamese (I believe)
> spelling would chime in and tell us which is correct.
> 
>> I doubt anyone prefers their name to be spelled with octal escape
>> characters.
>   
> Sure, but it wouldn't have been octal escapes in the original character
> encoding, it would have appeared, I believe, as Mimi Phûông-Thåo Võ.
> 

Isn't our file just a copy of the one from binutils ? Shouldn't we 
adjust it based on commit 
https://github.com/bminor/binutils-gdb/commit/2ce18a16268a ?

Christophe

