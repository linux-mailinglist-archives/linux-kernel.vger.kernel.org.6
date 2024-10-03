Return-Path: <linux-kernel+bounces-349036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE998EFDB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA1AB21538
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A52198836;
	Thu,  3 Oct 2024 12:59:27 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF7148823
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960366; cv=none; b=Ne0rY+Zh9gQ/O21HomI+BFqg/gQBTZtfpnghondff9nCFxu57X8eTJig44IoVrxNnr3gpciO+qRP4QngnCzzepGJ5A6z3Ba+1ysRTQBlZjkVTIH7CrJA7B8NPXA7lm84HbGI2Q17fdJJOV5f0IMjgZ3sl9Kf7TlqskWHO8jl46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960366; c=relaxed/simple;
	bh=UTMNQw0IdDudeIExK4erI5RZUCkw+2pVdvx/C4tRVVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQoWsEfYSn4z7FdSHvXx2e+qNui/qRCqPmiZSFVN1dMjUV+ZrfMPzmZcWnKpIQ49dV6EZzo0mN44dr0LQMq2SH9mLDb0fcKZlb1M8nzn456qwmTDyWfxzDAI8hnKFvajUtagVVNLDF29ktzt1E01YTP+cSI3zYZ11LL1t1mfw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XKBZy60wHz9sRs;
	Thu,  3 Oct 2024 14:59:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRgm6DxfkxIY; Thu,  3 Oct 2024 14:59:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XKBZy53hKz9sRr;
	Thu,  3 Oct 2024 14:59:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DBC48B779;
	Thu,  3 Oct 2024 14:59:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 15ndNuq3FRUV; Thu,  3 Oct 2024 14:59:22 +0200 (CEST)
Received: from [192.168.232.22] (PO26607.IDSI0.si.c-s.fr [192.168.232.22])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BFCDB8B770;
	Thu,  3 Oct 2024 14:59:21 +0200 (CEST)
Message-ID: <f14cd0d3-5e27-47a0-9673-f176ede7e3ac@csgroup.eu>
Date: Thu, 3 Oct 2024 14:59:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ps3: Correct some typos in comments
To: Shen Lichuan <shenlichuan@vivo.com>, geoff@infradead.org,
 mpe@ellerman.id.au
Cc: npiggin@gmail.com, naveen@kernel.org, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240930023234.7457-1-shenlichuan@vivo.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240930023234.7457-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/09/2024 à 04:32, Shen Lichuan a écrit :
> [Vous ne recevez pas souvent de courriers de shenlichuan@vivo.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:

What is confusing in those typos ? Sure they are typos but I can't see 
any confusing meaning behind. There is no ambiguity.

I would agree if for instance you had "live" instead of "leave", but 
here I can't see any alternative meaning.

> 
> -in the code comments:
> drivers/ps3/ps3-lpm.c:94: rigths ==> rights
> drivers/ps3/ps3-sys-manager.c:365: acnowledge ==> acknowledge
> drivers/ps3/ps3-vuart.c:470: remaning ==> remaining
> drivers/ps3/ps3-vuart.c:471: transmision ==> transmission
> drivers/ps3/sys-manager-core.c:15: Staticly ==> Statically
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>   drivers/ps3/ps3-lpm.c          | 2 +-
>   drivers/ps3/ps3-sys-manager.c  | 2 +-
>   drivers/ps3/ps3-vuart.c        | 4 ++--
>   drivers/ps3/sys-manager-core.c | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
> index 200ad8751860..188ae2572674 100644
> --- a/drivers/ps3/ps3-lpm.c
> +++ b/drivers/ps3/ps3-lpm.c
> @@ -91,7 +91,7 @@ struct ps3_lpm_shadow_regs {
>    * struct ps3_lpm_priv - Private lpm device data.
>    *
>    * @open: An atomic variable indicating the lpm driver has been opened.
> - * @rights: The lpm rigths granted by the system policy module.  A logical
> + * @rights: The lpm rights granted by the system policy module.  A logical
>    *  OR of enum ps3_lpm_rights.
>    * @node_id: The node id of a BE processor whose performance monitor this
>    *  lpar has the right to use.
> diff --git a/drivers/ps3/ps3-sys-manager.c b/drivers/ps3/ps3-sys-manager.c
> index ad8ef59dea34..ab798b52910e 100644
> --- a/drivers/ps3/ps3-sys-manager.c
> +++ b/drivers/ps3/ps3-sys-manager.c
> @@ -362,7 +362,7 @@ static int ps3_sys_manager_send_request_shutdown(
>    * ps3_sys_manager_send_response - Send a 'response' to the system manager.
>    * @status: zero = success, others fail.
>    *
> - * The guest sends this message to the system manager to acnowledge success or
> + * The guest sends this message to the system manager to acknowledge success or
>    * failure of a command sent by the system manager.
>    */
> 
> diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
> index 6328abd51ffa..5cb92535a4a1 100644
> --- a/drivers/ps3/ps3-vuart.c
> +++ b/drivers/ps3/ps3-vuart.c
> @@ -467,8 +467,8 @@ struct list_buffer {
>    *
>    * If the port is idle on entry as much of the incoming data is written to
>    * the port as the port will accept.  Otherwise a list buffer is created
> - * and any remaning incoming data is copied to that buffer.  The buffer is
> - * then enqueued for transmision via the transmit interrupt.
> + * and any remaining incoming data is copied to that buffer.  The buffer is
> + * then enqueued for transmission via the transmit interrupt.
>    */
> 
>   int ps3_vuart_write(struct ps3_system_bus_device *dev, const void *buf,
> diff --git a/drivers/ps3/sys-manager-core.c b/drivers/ps3/sys-manager-core.c
> index e061b7d0632b..f50032ad9702 100644
> --- a/drivers/ps3/sys-manager-core.c
> +++ b/drivers/ps3/sys-manager-core.c
> @@ -12,7 +12,7 @@
>   #include <asm/ps3.h>
> 
>   /**
> - * Staticly linked routines that allow late binding of a loaded sys-manager
> + * Statically linked routines that allow late binding of a loaded sys-manager
>    * module.
>    */
> 
> --
> 2.17.1
> 

