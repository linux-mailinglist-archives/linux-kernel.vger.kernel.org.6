Return-Path: <linux-kernel+bounces-254679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFB793364C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6273F1F23DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8273D304;
	Wed, 17 Jul 2024 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SYMEn0VT"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F357125DE;
	Wed, 17 Jul 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193135; cv=none; b=lmzB8W+G/ZKZ7J0ufiDQafZ2rzg/wSlpLR/IDiL7vpdZYfy7YCYcGDUkxoqNMm1pb6jejyp7+K9ZzBE4WrEpMmxq7IjJrbEUbf+pQNhJ0DKl0+WbR4FG+apnvyV3gkrolzQMws+/Ci54negqka1Uwlu46/OMrwIecCuDZZeGjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193135; c=relaxed/simple;
	bh=H36BJoSSlRDF1Z+nVvb/Uc70itDMo3PGoNayxqtEKAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMOJ/L0BQAqQOewkVTw3MoRvUzZdxyu5xHgTMb5AJN1Uij+uerI4+srZS2aPnYiv5HDeJ2rThuDmBoUoPhMW7olQRTGae8yE/QqZsBrlKDcItzlUAweKcFstiBbTahNmVLgCOyYKZRRGN0KhzNe8bXAmsly7odgtOgb3Jzag5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SYMEn0VT; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id TwxMsrsBhJ7CGTwxMsIU7w; Wed, 17 Jul 2024 07:12:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721193124;
	bh=sa2nadHmhXuLtY7ot8ndiHN0OIbRKX9pb16VLbEu1i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SYMEn0VTwbEU4NR9+q4PpIKnHPyG0VclAA9dE9BxrjCHFYm6vy7uxjGABb4UJKu+f
	 2OMrEnBXZDF24dnBHwbgpZ/HtfmXxgFotjw5OocOtTNP51Dhp5C4R41D0/4tk2/KzJ
	 iqXfwgeDOTC6rH1Htoh+nmhwqEyAaNwBS0SQPQXOk/44hefbEFimwWEOSt0KxWCPY9
	 VR5oPQs0pXtQ5X0QZ33qWvAaKC4JulzZYIZ7IAfD0oDjbXNwUTfhnzY7RGCA4Cz0Kk
	 2PI34OFBuYnMeXtvovf6dd00GGdmRckTtAPF7XjgRxvhItJRjm5kgMwmaGa/MnxweB
	 8b2jX2AGrXamg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 17 Jul 2024 07:12:04 +0200
X-ME-IP: 90.11.132.44
Message-ID: <4197ad98-a7f7-487d-a303-d682677e0b80@wanadoo.fr>
Date: Wed, 17 Jul 2024 07:12:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Use seq_putc() in two functions
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 kernel-janitors@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Markus Elfring <Markus.Elfring@web.de>
References: <d4be0dc8-f6db-4bf1-bb6d-ccff161dfde9@web.de>
 <cb908d7f-db6a-4b04-8867-bf36fb2dd45f@intel.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <cb908d7f-db6a-4b04-8867-bf36fb2dd45f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/07/2024 à 23:43, Reinette Chatre a écrit :
> Hi Markus,
> 
> On 7/13/24 2:00 AM, Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sat, 13 Jul 2024 10:43:14 +0200
>>
>> Single characters should be put into a sequence.
>> Thus use the corresponding function “seq_putc”.
>>

...

> Could you please highlight the benefit of this change? Looking at 
> seq_puts() implementation, thanks
> to [1], it seems to me these seq_puts() calls will result in seq_putc() 
> anyway?

Hi,

in this case, there is no benefit and the generated code should be 
exactly the same.

CJ

> 
> Reinette
> 
> [1] 
> https://lore.kernel.org/all/a8589bffe4830dafcb9111e22acf06603fea7132.1713781332.git.christophe.jaillet@wanadoo.fr/
> 
> 


