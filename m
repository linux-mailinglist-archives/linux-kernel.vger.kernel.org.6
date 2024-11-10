Return-Path: <linux-kernel+bounces-403052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55749C303A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 02:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3782A1F2169B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE141C94;
	Sun, 10 Nov 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KEwDTFNv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B536B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731201542; cv=none; b=a9B12bnDSaL+gexqvZ3lUIP+5pLNYnL9fHn2Ok9ChsxKi9yLnXpA/ZgdWQmdzkUqhnjlX1duV9pAq6s0HFo8IHNBBW0l30kizDUAUZJszNLHO/IJq2uf0lo3cOCKShQpar7ZklqvbkzAvY28PUhY8EWeOJKTxeZgIhZkXj4gTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731201542; c=relaxed/simple;
	bh=B8ixCLuVKUYKS9xihdaOhnYVSSKfetpcnhI0XYqdHuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAJiZ0yn6XribFl8CqOCSf4p/4vrAC6BPczYl0jfFI+CBoLnfaQoYsRoR68iWrMenRhoGBpJ32/kbsKNgbGyaM0gWR1F9G0zFbKz6VRFYGwnq15gAm+zLXRyVbwF3MdzDZavNsNKhbBx2bgLtNYlUsURNJRO8HWwUD6umZJkRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KEwDTFNv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=f3svKQpsO2Ae6fHwdoFwbyqzKUkHVYU0iPtw3sIlW54=; b=KEwDTFNvWF9+/evQ81lSag2qFZ
	+v4wYmtvf/+JT3MqOB/zpZhbNxJ3lZ2Hj1CNXMMqwowqOL3BRPodwcdG+W4VHz7Gs34dxz7J6H0YH
	pCgnGqZuCxUWJFX4cuoBf7AapbePuynJg34Z0HvOSg6ZSyC+sIjd9XIReZOcGcosWqvTlC1E67K4Q
	ISHiz9htAxPnyEIPvj53XEbn4HeuKysVWVaBEzPSGLqzlvqeqU33T2kxbpscJitSeicoJWWrGws4P
	8HocCbld4QeuD8hhZ0pqLvmtlrhpW//agmCaedamY5g/UrGkA98d/7+oY7VLfqOOJ2gQRKo69uitz
	WRl1UiYA==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9wbD-0000000Ao5s-0sU4;
	Sun, 10 Nov 2024 01:18:45 +0000
Message-ID: <8ec8cefe-cdde-4336-9274-01057e31945d@infradead.org>
Date: Sun, 10 Nov 2024 10:18:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/ps3: Mark ps3_setup_uhc_device() __init
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <31fe9435056fcfbf82c3a01693be278d5ce4ad0f.1730899557.git.geert+renesas@glider.be>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <31fe9435056fcfbf82c3a01693be278d5ce4ad0f.1730899557.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

On 11/6/24 22:26, Geert Uytterhoeven wrote:
> ps3_setup_uhc_device() is only called from ps3_setup_ehci_device() and
> ps3_setup_ohci_device(), which are both marked __init.  Hence replace
> the former's __ref marker by __init.
> 
> Note that before commit bd721ea73e1f9655 ("treewide: replace obsolete
> _refok by __ref"), the function was marked __init_refok, which probably
> should have been __init in the first place.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/powerpc/platforms/ps3/device-init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
> index b18e1c92e554ce87..61722133eb2d3f99 100644
> --- a/arch/powerpc/platforms/ps3/device-init.c
> +++ b/arch/powerpc/platforms/ps3/device-init.c
> @@ -178,7 +178,7 @@ static int __init ps3_setup_gelic_device(
>  	return result;
>  }
>  
> -static int __ref ps3_setup_uhc_device(
> +static int __init ps3_setup_uhc_device(
>  	const struct ps3_repository_device *repo, enum ps3_match_id match_id,
>  	enum ps3_interrupt_type interrupt_type, enum ps3_reg_type reg_type)
>  {

I tested this on PS3 and it seems to work OK.
Acked-by: Geoff Levand <geoff@infradead.org>



