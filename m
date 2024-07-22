Return-Path: <linux-kernel+bounces-259258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF893932B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C22E283A98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231116EC16;
	Mon, 22 Jul 2024 17:20:08 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B6176AC6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668807; cv=none; b=ltu99pGlXsPClKGu3S8wfNaTTCSk2EfKEwFxb6BmSpIQROVgZSHsjyItVoSwsB4StfxWMkou8lSa89nel6W08ZdWs7pBKUCXHtyQY/2nXq2ATFimfd2k9ogYvN6tUHJf2c5U+ovYVhrYrYx38/VN9C24sIjFAWDaT9C2dWAiXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668807; c=relaxed/simple;
	bh=aqsqn7WLZDkVLdjraWcmZd3efcEBRvpWewI5KI3Q4cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQKYr0XkUtKLFWb9X9wZ8QOl0mZ7nRNVKKv0USkPPQnaggj3w6pqYz7RpYhA7DVfDiu0rcGU6DB5cnig+MQRJVTj3QMPmaqJ4fjjP3MkEXtDxOF96PuhICIeZnkz7Qg4qiWvNLa1FHFX60nBWuD6oxUoPM3VsUGTwkYQGLqJCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WSRhZ3b8Vz9sSt;
	Mon, 22 Jul 2024 19:14:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XdQgWNNfizAM; Mon, 22 Jul 2024 19:14:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WSRhZ1w7tz9sSs;
	Mon, 22 Jul 2024 19:14:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EE2188B773;
	Mon, 22 Jul 2024 19:14:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id XOyPcpf4z-1J; Mon, 22 Jul 2024 19:14:05 +0200 (CEST)
Received: from [192.168.233.78] (unknown [192.168.233.78])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FBF68B76D;
	Mon, 22 Jul 2024 19:14:05 +0200 (CEST)
Message-ID: <3b4feef7-35c3-4afd-aa08-73871b404835@csgroup.eu>
Date: Mon, 22 Jul 2024 19:14:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc/fsl/qbman: remove unused struct 'cgr_comp'
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Sean Anderson <sean.anderson@linux.dev>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: camelia.groza@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240528231123.136664-1-linux@treblig.org>
 <336239e6-4369-44ea-a60c-d300cf6e6f81@linux.dev> <Zp2QtPET9649y9pA@gallifrey>
 <878qxtx527.fsf@mail.lhotse>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <878qxtx527.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/07/2024 à 09:24, Michael Ellerman a écrit :
> "Dr. David Alan Gilbert" <linux@treblig.org> writes:
>> * Sean Anderson (sean.anderson@linux.dev) wrote:
>>> On 5/28/24 19:11, linux@treblig.org wrote:
>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>
>>>> 'cgr_comp' has been unused since
>>>> commit 96f413f47677 ("soc/fsl/qbman: fix issue in
>>>> qman_delete_cgr_safe()").
>>>>
>>>> Remove it.
>>>>
>>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>>> ---
>>>>   drivers/soc/fsl/qbman/qman.c | 5 -----
>>>>   1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
>>>> index 7e9074519ad2..4dc8aba33d9b 100644
>>>> --- a/drivers/soc/fsl/qbman/qman.c
>>>> +++ b/drivers/soc/fsl/qbman/qman.c
>>>> @@ -2546,11 +2546,6 @@ int qman_delete_cgr(struct qman_cgr *cgr)
>>>>   }
>>>>   EXPORT_SYMBOL(qman_delete_cgr);
>>>>   
>>>> -struct cgr_comp {
>>>> -	struct qman_cgr *cgr;
>>>> -	struct completion completion;
>>>> -};
>>>> -
>>>>   static void qman_delete_cgr_smp_call(void *p)
>>>>   {
>>>>   	qman_delete_cgr((struct qman_cgr *)p);
>>>
>>> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
>>
>> Hi Sean,
>>    Do you know who will pick this one up?
>>    I got a notification a while ago from a patchwork at
>>    linuxppc-dev marked 'Handled elsewhere' - but I'm not
>> sure where.
> 
> drivers/soc/fsl was orphaned, but Christophe has recently volunteered to
> look after it.
> 
> This patch looks trivial so I can just pick it up if you like Christophe?
> 

Sure Michael, you can pick it up.

Thanks
Christophe

