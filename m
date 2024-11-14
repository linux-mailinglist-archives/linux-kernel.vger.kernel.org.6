Return-Path: <linux-kernel+bounces-408741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802809C82F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3BE1F22D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126DE1E7C0F;
	Thu, 14 Nov 2024 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRSr+GmG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAD15A848;
	Thu, 14 Nov 2024 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731564747; cv=none; b=fAuZch0XMwl5VSUDbaPV+8XnNUjoi1NEqB0gzgByrp1aThQQjDOFG0LARm12q8Tri5ZHkrSq47lD+u6xG3DdHOZZKOj0lo6sBfAXsQzMMYe7DsOckeaaOS7dUEDuUgqawZdgrFboypMY84PfZzGoJwNxglOftBt0tvXBBtTeIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731564747; c=relaxed/simple;
	bh=O/qvjC4UbbLIvN9ummr5bft1Of0+DuPZVn8I/U/idSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrYM68PL14wg7bngYK34PFVbdSXOhw8CkCA41r0NusLLtkWCXBPt6CduGu3UCU9qKtBJPMDUVFsT+Ragk7ByzKW/Ga54Jd3JE0tTR/+jDQkQ7TmxMiUod4QHAb1h/Kj/1ctXE7o9Ip6xVe/GwhLnMkm3GjIW82O5riZwPj9rEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aRSr+GmG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jUCKr6wUh2Tqi3yTL8VvbBPynxI0kl0wP1daAbyP1eg=; b=aRSr+GmGFu7GRcY5RjFrI3eIO4
	O5rA2/ajbuSJL0fT2dlGd4tycHNUiXiUT7k42c3w4HZyTmBnp5ppdRDvtroQW3RtsKyxlepAFnsN4
	qzcm088o5tV06tT/FRub4nipJ6UEforI6ACAEV44GqG4SOXtsvXBWSZD1TuP87W+w4IiAvxFxA6vd
	oxzF+WWSBEGBzBoJE7q2aOC4ojeIdTDNmfV/dtkr1urIpI9QFHyDX6zaWQThRwvRGLwJijAd5Mte1
	s7aSdIO6GHfwWHmnUhrAic7AcMnAW6PNOEGXtqQTYnzQEbj5uU+rQ93+sHCJ5FrjMS7tCA7wi0wkz
	hzzay00g==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBT5U-0000000DSOl-31ER;
	Thu, 14 Nov 2024 06:12:17 +0000
Message-ID: <e42a99c5-1229-4bc6-9437-018d9effe371@infradead.org>
Date: Wed, 13 Nov 2024 22:12:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] modernize DMA api documentation
To: anish kumar <yesanishhere@gmail.com>, corbet@lwn.net, tj@kernel.org,
 akpm@linux-foundation.org, ptesarik@suse.com, xavier_qy@163.com,
 vbabka@suse.cz, tintinm2017@gmail.com
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241113063425.21042-1-yesanishhere@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241113063425.21042-1-yesanishhere@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 11/12/24 10:34 PM, anish kumar wrote:
> Dear maintainers,
> 
> This patch series is inspired by the ongoing discussion in the following thread:
> https://lore.kernel.org/lkml/20241111063847.GB23992@lst.de/
> 
> As part of an effort to modernize the documentation, the first patch in
> this series converts the relevant document to use kernel-doc comments directly
> within the source code, replacing the previous method of manually adding
> documentation. This change will help streamline the documentation workflow and
> ensure it remains synchronized with the code.
> 
> I am still getting below errors and wondering if there is a better
> way to write this patch.
> 
> /home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:89:  
>     ./mm/dmapool.c:229: WARNING: Duplicate C declaration, also defined at  
>     core-api/mm-api:224. Declaration is:  
>     '.. c:function:: struct dma_pool *dma_pool_create (const char *name,  
>     struct device *dev, size_t size, size_t align, size_t boundary)'.
> 
> /home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:92:  
>     ./mm/dmapool.c:420: WARNING: Duplicate C declaration, also defined at  
>     core-api/mm-api:404. Declaration is:  
>     '.. c:function:: void *dma_pool_alloc (struct dma_pool *pool, gfp_t mem_flags,  
>     dma_addr_t *handle)'.
> 
> /home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:98:  
>     ./mm/dmapool.c:229: WARNING: Duplicate C declaration, also defined at  
>     core-api/mm-api:224. Declaration is:  
>     '.. c:function:: struct dma_pool *dma_pool_create (const char *name,  
>     struct device *dev, size_t size, size_t align, size_t boundary)'.
> 
> /home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:101:  
>     ./mm/dmapool.c:466: WARNING: Duplicate C declaration, also defined at  
>     core-api/mm-api:450. Declaration is:  
>     '.. c:function:: void dma_pool_free (struct dma_pool *pool, void *vaddr,  
>     dma_addr_t dma)'.
> 
> /home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:104:  
>     ./mm/dmapool.c:366: WARNING: Duplicate C declaration, also defined at  
>     core-api/mm-api:360.
> 

If you are going to add these APIs in dma-api.rst, you need to remove them from
mm-api.rst (IMO). That should remove these Duplicate warnings.


> Thank you for considering this patch. I look forward to your feedback.
> 
> anish kumar (2):
>   dmapool: Improve dma api kernel-doc comments
>   dmapool: Documentation: use the kernel-doc comment
> 
>  Documentation/core-api/dma-api.rst | 66 ++++++------------------------
>  mm/dmapool.c                       | 40 ++++++++++++------
>  2 files changed, 40 insertions(+), 66 deletions(-)
> 

-- 
~Randy


