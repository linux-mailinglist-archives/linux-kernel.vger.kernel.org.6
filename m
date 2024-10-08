Return-Path: <linux-kernel+bounces-355585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489F499545B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65E31F26A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE71E0488;
	Tue,  8 Oct 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ntaS+xUF"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC81DF241
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404769; cv=none; b=RzdQ3JAGXVJr4sTz9jQdPxIQC8FffATzmIDn2yAbBUjT0yofCUbozrBUeNjT3y2+w6l/SPJrcXvnfRfYB8etptjzwGt4ZW/TmAo0HeU7f+KmbboOPZAlmBDXBs2D4cGeX44m8OvdupOpUwVsR+buV2HwdD7BDdXxovwmLmsE9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404769; c=relaxed/simple;
	bh=0pbwWg3Pts4fZk3o2buLENaA8gdALMFvOFJvpAibZy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edVh+YDMj/vcMy38WVOiDCyT9/11BXpB/lRbX7H8Hcr00TwvlSbB3HXTHpqBa/xugGST9bh+L7fH1DEPled4aaBwuybWQ/WE+Lrtxw3LsBUV5Jc0UJ1dtbx6AQE8zwdJlcdGjRieRzJ8gFmPcrRjYW7YbVn8N5L24U6SaG5X2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ntaS+xUF; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <988d7c7d-dedd-4ceb-ad8a-9a9962b7bb0c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728404766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqUxlflk7LSIOE/nIYBpnpZcHrExrT5UAZ6hZitSDnE=;
	b=ntaS+xUFVtV0CxaH/tjycK2u+IRAPDjlEIk3hqWN4hl7y0mib1cxQdbM4i78Et2pwy67gp
	JcKHTRKKd3D8NrZRT0WuEhAfubjhjfP3mrmlET4kCshJjpflElftk2tRpFZK1vgm/r8CHB
	D0kUh2YcZMpbt4y2h3Xo998rr0DVJsA=
Date: Wed, 9 Oct 2024 00:25:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] Docs/mm: Fix a mistakes for pfn in page_tables.rst
To: Pengyu Zhang <zpenya1314@gmail.com>
Cc: corbet@lwn.net, rppt@kernel.org, linus.walleij@linaro.org,
 fmdefrancesco@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241008161050.14732-1-zpenya1314@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20241008161050.14732-1-zpenya1314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

s/mistakes/mistake/ in the Subject line.

On 2024/10/9 00:10, Pengyu Zhang wrote:
> The documentation incorrectly calculate the pfn value as 0x3fffff,
> which should be 0x3ffff instead.It is obtained by right-shifting
                                  ^
Add a space.

> 0xffffc000 by 14 bits.
> 
> This patch corrects the value to prevent any potential confusion
> for developers referencing this document.
> 
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
> ---
>  Documentation/mm/page_tables.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
> index be47b192a596..e7c69cc32493 100644
> --- a/Documentation/mm/page_tables.rst
> +++ b/Documentation/mm/page_tables.rst
> @@ -29,7 +29,7 @@ address.
>  With a page granularity of 4KB and a address range of 32 bits, pfn 0 is at
>  address 0x00000000, pfn 1 is at address 0x00001000, pfn 2 is at 0x00002000
>  and so on until we reach pfn 0xfffff at 0xfffff000. With 16KB pages pfs are
> -at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3fffff.
> +at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3ffff.
>  
>  As you can see, with 4KB pages the page base address uses bits 12-31 of the
>  address, and this is why `PAGE_SHIFT` in this case is defined as 12 and

Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>

