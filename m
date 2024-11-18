Return-Path: <linux-kernel+bounces-412800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20589D0F22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C691F2221E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009DA194C83;
	Mon, 18 Nov 2024 11:02:57 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A06192B66
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927776; cv=none; b=Mp9u2oaz65GtN93HaaOVGMvlgwUVgk1SdNhK7C+tvEBri0FrGi9SIMXj4F+DtK4yxKEN0Y1ME9eHy5qAGcNp/6cSV9ZOiCvyRpQnNwMoYxEyEyOkfGrKbZm3VJhImnYtVwoRFWtgtrPvtQRjDJ6B7mvWOe1GP7OUH6heNYuwZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927776; c=relaxed/simple;
	bh=e46rW2O9e/lSsh+lAjIeCA8ild7IshiOodNkyj6NRX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG/EgvGMeEHwi1Y/IS964SjAkm2Qa01wBk2Olm4bFj5c4JaLIDe/nQy0/1pN9P2QlkSN+MCSTYt0jGOm+vYhb+Wea7FUpwiAh4+L6tNNKyRIZnm8/W1r+1AP3w65zMWGNQumuv5RxtWOjaQw+Ctx+XXfCNbbBpsP4eGKxnkQWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XsPqB6Lr7z9sSZ;
	Mon, 18 Nov 2024 12:02:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sd1BtRiIvj43; Mon, 18 Nov 2024 12:02:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XsPqB5XPxz9rvV;
	Mon, 18 Nov 2024 12:02:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A9BEA8B767;
	Mon, 18 Nov 2024 12:02:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4Amllp3f1lFq; Mon, 18 Nov 2024 12:02:46 +0100 (CET)
Received: from [192.168.232.23] (PO27094.IDSI0.si.c-s.fr [192.168.232.23])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 58B098B763;
	Mon, 18 Nov 2024 12:02:46 +0100 (CET)
Message-ID: <124ab5ab-3bfd-4ad7-a75d-981da9c03423@csgroup.eu>
Date: Mon, 18 Nov 2024 12:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241115133802.3919003-1-andriy.shevchenko@linux.intel.com>
 <5b44abcc-f629-4250-9edf-7f173b78172c@csgroup.eu>
 <ZzsG9EjzV82Crl2W@smile.fi.intel.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZzsG9EjzV82Crl2W@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/11/2024 à 10:20, Andy Shevchenko a écrit :
> On Sat, Nov 16, 2024 at 11:44:35AM +0100, Christophe Leroy wrote:
>> Le 15/11/2024 à 14:38, Andy Shevchenko a écrit :
>>> Remove legacy-of-mm-gpiochip.h header file, replace of_* functions
>>> and structs with appropriate alternatives.
>>
>> Looks like you don't really have an alternative to
>> of_mm_gpiochip_add_data(), you are replacing one single line by 11 new ones,
>> and that is done twice (once for cpm1_gpiochip_add16(), once for
>> cpm1_gpiochip_add32()).
> 
> True, but that's the issue that we have of_specific API. If someone propose
> the common API for the agnostic approach,  it would be nice, but I am not
> the one. And TBH I do not see the advantage of it right now as almost every
> GPIO driver is using its own labeling schema (*). Note, that this patch also
> fixes a memory leak as a side effect.

Can you explain that in the commit message instead of saying you use 
appropriate alternatives that do not exist ?

Don't hesitate to mention the memory leak it in the commit message as well.

> 
> *) the legacy API is mostly used by PPC code, do you want that of_mm_* thingy
> to be moved to PPC specific code instead of killing it? Would be done this
> way as well.

No no, your change is ok for me, just need an accurate commit message.

> 
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>    arch/powerpc/platforms/8xx/cpm1.c | 119 +++++++++++++++---------------
>>
>> Does not build:
> 
> Crap, I most likely built something else and not these files...
> I have carefully build-test this for v2.

Just use mpc885_ads_defconfig

> 
> Note to myself: Never ever send the patches on Friday evenings! :-)
> 

Christophe

