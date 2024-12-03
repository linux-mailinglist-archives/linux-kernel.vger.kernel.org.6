Return-Path: <linux-kernel+bounces-429078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48649E1714
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D9A281395
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857D1DED6A;
	Tue,  3 Dec 2024 09:19:52 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8741CD204
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217591; cv=none; b=LSeGDc3T3LuFojqUgqu5JegOF05fxuWMcEdvK7sctw75Kxm0H5OiP1j3ZN+qTsjSmQJiyftkq/mqU5SzwMO8cFHiGzjcZGRwghKrNPyOBZjMm9mBgw8YK1a6QRKFAuJlOTHf0vr0z6hLXeGq8dlb7qC9H/N/ePUMOOWLGzcKh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217591; c=relaxed/simple;
	bh=14V9PCQ/4Z1S2g9xr0Hp31oAQ795slzZhXNLnjSGKi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m81/lt5CHU3VDoeg77tasBNncGyjJTIm4493V5I8xJUsPNZMLbU+RSmbOTn06xkYkrgZUJka2+UP800HQ63abmSKP45OV8Rq76SaXEIYGAgXM3ECPUdKwp9xL93f31j2ndEKCkn14n9yAGTSJPioB2q2cyCc+kvZ/gPfY8BY68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2ZqR28TGz9sgW;
	Tue,  3 Dec 2024 10:19:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sw3a-00yiEBN; Tue,  3 Dec 2024 10:19:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2ZqR1M5Yz9sgV;
	Tue,  3 Dec 2024 10:19:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DFE48B765;
	Tue,  3 Dec 2024 10:19:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 64fMgQM2bso5; Tue,  3 Dec 2024 10:19:47 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DDB438B763;
	Tue,  3 Dec 2024 10:19:46 +0100 (CET)
Message-ID: <fecc5d0f-0e84-4a77-bc1e-934e54037724@csgroup.eu>
Date: Tue, 3 Dec 2024 10:19:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] macintosh: Fix spelling mistake "toogle" to "toggle"
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20241203084200.7350-1-zhujun2@cmss.chinamobile.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241203084200.7350-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 03/12/2024 à 09:42, Zhu Jun a écrit :
> There is a spelling mistake, Please fix it.

This text doesn't belong to a commit message, the patch cannot be 
applied with such a message.

By the way, can you explain why it is so urgent to fix a minor typo like 
this on a so old driver that hasn't got more than half a dozen of 
commits in the last 10 years, none of them been functionnal changes ?

Anybody who reads this comment will understand it despite the typo. To 
be honest most people won't even notice the type while reading.

Before sending such patches, have in mind the cost of handling such a 
change compared to its real benefit.


> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   drivers/macintosh/adbhid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
> index b2fe7a3dc471..943a7123786a 100644
> --- a/drivers/macintosh/adbhid.c
> +++ b/drivers/macintosh/adbhid.c
> @@ -604,7 +604,7 @@ adbhid_buttons_input(unsigned char *data, int nb, int autopoll)
>   
>   			case 0x7f:
>   			case 0xff:
> -				/* keypad overlay toogle */
> +				/* keypad overlay toggle */
>   				break;
>   
>   			default:


