Return-Path: <linux-kernel+bounces-440119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CCD9EB917
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875051889A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F772046A4;
	Tue, 10 Dec 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rAjs3hp+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FA86320;
	Tue, 10 Dec 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854356; cv=none; b=jbsX0zdTTnufKAQI615/2Q/AJkPI858/0kjyn9CrHs6G3vQuib/JBy1RJlyu+ULIjJxwy5tiu69+WEFoHuhFvMYZNr/gR892YzyF3IUY/f4OoEiQQyiRev/X8fquPy5w7D4AEAZK+NqRgy/RLMoJDuYHyAGCasirc/FMTiNQU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854356; c=relaxed/simple;
	bh=t7CrIq08hMEBB7V/Ly4XFysngLUOyFusWVp18WQWAkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBN5Lzx5z++SgdNmRD/DhmY/o8iuCkn41oQADbdombeLQDFGLar5h2dHYkX80jZ7nenFenvGagXMCdy3PDp34rrHABcJKzz8RQe5pN8gwfIsZakL95E5lQ8cGUukNzpCKVDeU+HOuaLMr53Zs4yUAZjFyeT6aRg9FT6iTz/hDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rAjs3hp+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=b7oDiXPiJY9WwPRA3kiAOcynjvwhmPmForwOjuK8hWc=; b=rAjs3hp+lI4OjrmZk7Z+PbPkh6
	jzmlgWIEjpWKseQfQqNMyju0umSChmh5qjSqz4/tR1r9Xl+t9/vPwnX5l8h2J/vNp1ULsJMD3shOc
	JD+qRo928zNTzoMmZhP+eBzbADv32tsCAfmudF/aenfcTF8TYOFY1mUevSkpygjsAmXqriKH2Wa50
	NZiVt6O75tekZcAwCmBn4DHeLXqhxe4DL67tHE91BE3BQ5P0u0eFVB7HMSS+pQIw75z1IGAzvfEj3
	PITH8BHgdJl9B3xl3DAs8ixcczVug8lwwbK0S79lGy45JlwI3EKz5pvtATl82/ZRG1UmdoxlZD3Ev
	sJkuMhwA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL4if-00000003iCn-2WLk;
	Tue, 10 Dec 2024 18:12:26 +0000
Message-ID: <dcc786a8-744c-4829-9d1a-1764ad85479a@infradead.org>
Date: Tue, 10 Dec 2024 10:12:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: Get -export option working again
To: Akira Yokosawa <akiyks@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Akira,


On 12/10/24 3:04 AM, Akira Yokosawa wrote:
> Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> literal"), exported symbols marked by EXPORT_SYMBOL_NS(_GPL) are
> ignored by "kernel-doc -export" in fresh build of "make htmldocs".
> 
> This is because regex in the perl script for those markers fails to
> match the new signatures:
> 
>   - EXPORT_SYMBOL_NS(symbol, "ns");
>   - EXPORT_SYMBOL_NS_GPL(symbol, "ns");
> 
> Update the regex so that it matches quoted string.
> 
> Note: Escape sequence of \w is good for C identifiers, but can be
> too strict for quoted strings.  Instead, use \S, which matches any
> non-whitespace character, for compatibility with possible extension
> of namespace convention in the future [1].
> 
> Fixes: cdd30ebb1b9f ("module: Convert symbol namespace to string literal")
> Link: https://lore.kernel.org/CAK7LNATMufXP0EA6QUE9hBkZMa6vJO6ZiaYuak2AhOrd2nSVKQ@mail.gmail.com/ [1]
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> ---
> This fixes regression in v6.13-rc2.
> 
> Quick reproducer:
> 
>     ./script/kernel-doc -rst -export drivers/iommu/iommufd/device.c
> 
> On v6.13-rc2, kernel-doc will say:
> 
>      drivers/iommu/iommufd/device.c:1: warning: no structured comments found
> 

I wondered where those warnings were coming from.
Thanks for the explanation and fix.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


> With this patch applied, you'll get reST formatted kernel-doc comments. 
> 
> Akira
>  
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index f66070176ba3..4ee843d3600e 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -267,7 +267,7 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
>  my $doc_inline_end = '^\s*\*/\s*$';
>  my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
>  my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
> -my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*\w+\)\s*;';
> +my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*;';
>  my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
>  my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
>  
> 
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4

-- 
~Randy

