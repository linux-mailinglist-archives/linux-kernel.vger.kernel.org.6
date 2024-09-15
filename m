Return-Path: <linux-kernel+bounces-329855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC839796BC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF04D1C21029
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118711C6F4F;
	Sun, 15 Sep 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZeC2L5Vu"
Received: from msa.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE51C984A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726405034; cv=none; b=JoSZIX6G03z09NwxTOksoMkDONEMCr52ZAXSosx7JThxlOB1xcEAbhXBMeBlXRx6pZohtQRqnPhNkVEbqPxJYVF3RSYRd0M1s01dQwzfgrFlhp9BLed0nMMBlDo2LjA2+jktguQqLBq+fA6ZoWvE0akvIKdpJjGgDuKSB/EEssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726405034; c=relaxed/simple;
	bh=Zo0i9LCWm9pWXBCYWV30JJSumaO6Rc3f6TyU79jwDX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSt6PNNxLLpgj8izd0YqDOr6NMyMoswRIrnNzy+lOjFA7xaJolCD1HH0ubpgc99ayHMvmTu2nyWU/HneOYZKEvwat0NI8LwjAT6oc+xbQA9FOcUcNxhnfshi3L2IlythWTJHvDYfc2qmS+kGzLMazxLKyIJN1Vl8Nnv41OHpWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZeC2L5Vu; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pooHsbcfYOCyZpooHsQ3e6; Sun, 15 Sep 2024 14:57:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726405023;
	bh=p1KHFbFn3yM7elOd8STGzD4T8dWI9H2ZO0ztDzDVFD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ZeC2L5VuTVJGzhlF/v+mxrm5L++hnfcftsMdM08XGGDRdIZClebn+m0s+Ap0if+dy
	 aLCOqrjXQNRVfI8TznZyUfVD7/MGnRNoloLvwGMhLBlC0KLEuuhRpg7cyo202RZkM9
	 luu0vMBUGzNRNjKnuMmAB0k2IeGFut4EfPtUUcSfOVqeCMWHqB+eMlRfemQxpoxLsT
	 7Mbw0hdK+ECJyqcTlwWxdviReU0hlVTB/iMO09shwmW+HRRRn/xQQIDsjBgjEbk7bK
	 sPZB7DBtM6sH22iYpTQ7HRLly+ev2IBUyh7ZjWMa3fjuAUFZaJSMNYlmx050TWjfkf
	 KzxbCIlWbNJMw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 15 Sep 2024 14:57:03 +0200
X-ME-IP: 90.11.132.44
Message-ID: <1a997ce3-1060-45c8-88cc-c75d49745fd4@wanadoo.fr>
Date: Sun, 15 Sep 2024 14:56:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethernet: chelsio: fix a typo
To: Andrew Kreimer <algonell@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20240915125204.107241-1-algonell@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240915125204.107241-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/09/2024 à 14:52, Andrew Kreimer a écrit :
> Fix a typo in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>   drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> index 4c883170683b..ad82119db20b 100644
> --- a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> +++ b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> @@ -49,7 +49,7 @@
>   /******************************************************************************/
>   /** S/UNI-1x10GE-XP REGISTER ADDRESS MAP                                     **/
>   /******************************************************************************/
> -/* Refer to the Register Bit Masks bellow for the naming of each register and */
> +/* Refer to the Register Bit Masks below for the naming of each register and */
>   /* to the S/UNI-1x10GE-XP Data Sheet for the signification of each bit        */
>   /******************************************************************************/
>   

Hi,

Nitpick: a space should be added between "and" and "*/" to keep a nice 
layout.

CJ

