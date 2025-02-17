Return-Path: <linux-kernel+bounces-517762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA9FA38574
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03C8173AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC421CC68;
	Mon, 17 Feb 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kaTR/S/j"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242A21CC55
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801017; cv=none; b=EkOO/HyEg9JKky37hJmNkAaVfhPfRgAI38NrohU1zhT7+IZyBh3OGipKL1G4tm/QcvwGgzlGmHhTIGsGJ4ISN4lN3xkimYcRRONHTGYwne36monSSKZDB8sYhrn9h/aoo4HQ1yAyFH7P3tUvQvEW1R0zRqpOe62jAwUzYWeAD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801017; c=relaxed/simple;
	bh=7oZ9P/mSayH2YvOgoPsdAp7K+sHh9HuAmb2ZJbdyC4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+dIyTqv8/jSCKjcREN/T0VX2gfWwp6gHqDYNq4QYVIBNoFUAs/wVOINEy58AGi89M5x82FoNv+S9kLmiPmKPSR00n7XERS+ammmL23IJlm0DCN2k7GqGuh+WhcdxeMsQtX6qqUoD8wl/ZXRU0KkYsPNTZyPzInUSPkY9i6LAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kaTR/S/j; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <43fa75f9-e6e3-4d80-b3b0-a97387fb2a07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739801012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYrIjHN3bDUdNdxr8x/b61vyO4g+se/BxMY16UM3TFI=;
	b=kaTR/S/j0cJ+sB3YHCx8KUwbtoYaG9GYB52hz4/cZW96pvX+ubr/u2tcTD2ZMdB1jgS/MP
	3vB22SV1q6/GSpluKacXG+pWtuOc4i4n5WudY4ryAzoGWrETvs0ZkZxRJR+p6pNv7hG718
	W8MivihF0RxYH0FXmXx2jbdEmzMM53E=
Date: Mon, 17 Feb 2025 14:03:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] crypto: bpf - Add MODULE_DESCRIPTION for skcipher
To: Arnd Bergmann <arnd@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217125601.3408746-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250217125601.3408746-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/02/2025 12:55, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All modules should have a description, building with extra warnings
> enabled prints this outfor the for bpf_crypto_skcipher module:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/bpf_crypto_skcipher.o
> 
> Add a description line.
> 
> Fixes: fda4f71282b2 ("bpf: crypto: add skcipher to bpf crypto")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   crypto/bpf_crypto_skcipher.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
> index b5e657415770..a88798d3e8c8 100644
> --- a/crypto/bpf_crypto_skcipher.c
> +++ b/crypto/bpf_crypto_skcipher.c
> @@ -80,3 +80,4 @@ static void __exit bpf_crypto_skcipher_exit(void)
>   module_init(bpf_crypto_skcipher_init);
>   module_exit(bpf_crypto_skcipher_exit);
>   MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Symmetric key cipher support for BPF");

Thanks for fixing!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

