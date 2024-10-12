Return-Path: <linux-kernel+bounces-362283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AA299B306
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448E71F2358E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18C1547E2;
	Sat, 12 Oct 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="seZ+uet6"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC8154434
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728729001; cv=none; b=iudEU9PXeEoHTAHegpDzNXh3OUiVrnCRswBNX47OHhjf8xylw8svWGrvG0N6TqF/cDO+pf/OIe1n6J1Diw9+qO9mFOxPMm9M2D6YznDtOJpVNvC1ojayg2TJgcwG/VHj6kvNRLVQ1TR7OK+c5GZgArUuqFWJJKgyc8S4ZgylueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728729001; c=relaxed/simple;
	bh=On/+Rznt90q0UfrTICfcUuUflHb78u73+P2S8+Fef7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkzCDhnzRAkWSkiuPC1Ke7Kc8VmCVW8977hH8o1Y/FDpnLMR1EkToX2YFmthtQY/F9qSyx2Ikv0BVT2lnImwX3NQWHnNVNHByEgKpeivgyCGWCqXOqlgw177s7J93128pb5r8JlbaQ5gienohEzBjHi7uDhdbjF75LqirPu02xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=seZ+uet6; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 11D5A31E5F;
	Sat, 12 Oct 2024 12:21:37 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1728728497; bh=iVXD6oivaFEJvIsOfoLMoofcixQB2A9pHqcyMG6+++w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=seZ+uet6nA1Bab0yiFIHjVT307XCuzMXK3VQwkOPR+AfpCGIfEfM5mSQB1KKUYfDC
	 VYEqY3fQJI8wtE9Btg8E1oMsQJZhcKAfjpbHauaga5iBJhzEe19qHNOlbQGPt6EtWS
	 /+y6OEOJEoc9mG2WQhVaXF0ojWlPHsk6e/VzudyMWxfab9obhrGk5UP7GS3OE79hNZ
	 opB66nSa8AX+BdtK6O2lE2w7fjNIlBUBUPotxFSFehCuPtvmpJUcvecZiSDdNwoWeY
	 J7lfeybY+BZrpdNjt7EMhqT1Z0xuesHKhAK3KQFLNx82uk31yHAWQ6qz7xzPHyw+Wf
	 uuQNO09Pk4rnA==
Date: Sat, 12 Oct 2024 12:21:30 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Michael Kelley <mhklinux@outlook.com>, Andrew Morton
 <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: fix a typo
Message-ID: <20241012122130.5ad43ff4@meshulam.tesarici.cz>
In-Reply-To: <20241012100817.323007-1-sui.jingfeng@linux.dev>
References: <20241012100817.323007-1-sui.jingfeng@linux.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 18:08:17 +0800
Sui Jingfeng <sui.jingfeng@linux.dev> wrote:

> Replace the 'One' with 'On'.

Yeah, that's right. Thank you!

Reviewed-by: Petr Tesarik <petr@tesarici.cz>

Petr T

> Fixes: af2880ec4402 ("scatterlist: add dedicated config for DMA flags")
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  include/linux/scatterlist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index e61d164622db..c5e2239b550e 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -273,7 +273,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>  }
>  
>  /*
> - * One 64-bit architectures there is a 4-byte padding in struct scatterlist
> + * On 64-bit architectures there is a 4-byte padding in struct scatterlist
>   * (assuming also CONFIG_NEED_SG_DMA_LENGTH is set). Use this padding for DMA
>   * flags bits to indicate when a specific dma address is a bus address or the
>   * buffer may have been bounced via SWIOTLB.


