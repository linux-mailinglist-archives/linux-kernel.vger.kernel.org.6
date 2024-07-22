Return-Path: <linux-kernel+bounces-258414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FB9387A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CB22811E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56313FEE;
	Mon, 22 Jul 2024 03:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mAUe6gIe"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49632F26;
	Mon, 22 Jul 2024 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721618367; cv=none; b=DaMGQhfmL8LtXFqNxTrC0dH/JCtqpcgwy3PVBf4Smg8DFoCnJiuo2r0fIiPfZHlYmtR5j04sqojcgPsHeAAj2ltwo64uyQJrP4+T9I1IYzbdAJk/cR9/m8RjfkNZxjn0u9ezPhpVU9lFN2WyVdLiyKBkaGfgDhpdroVq4KgXod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721618367; c=relaxed/simple;
	bh=wye4r1HfY7WZznXdzfU5VxDZfni1iAUUr/d5XIo6Jq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvpLrmusIFBmGsn2Q604NZzzQJHH5YP30ugEiM75PSFKgtbmqWujSkpuz8vBPzDG928Z3v0EzFts59WYRaDQAS3ahdK4jSIxS+mthilTDrA7sP/JNlom66pBUQQrnCCzLRyL1BAbdnlGLZTdW8ZutzUGvObt7GEsm77F2iluQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mAUe6gIe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OqQ7Ad3pnI0/vcgVTdh0MskWrmbQyGmAqbAsmVaqd1Y=; b=mAUe6gIeOLy4cAuH1gDlOti3ke
	Yk5LIe4Dlf+eM2y3xj8leCZ4lZbZkCgShrQ6xRqCVljEecE8X5LmJ6Zf+2K2BKVn1EnK36K++s46u
	IJ9Ad9phLL3xv96azGTQWqDvnQEP7s51aX2O0PxAcVZtDy25lWgLA0ociL6mOYbG+T/K2sh0pcueO
	8RjXWK7V+QrrFqTzWLnkCdOzdDJPfQ+UROfjR/WSnPI7t301ItMISxT4XtU+kMQIHOAYM7zP7fYxf
	wG4Q42gOB898FhzAzqlfKl2+k9CC7FRY9eCXk4jdImxMGPtupE8ZwAwQJ4fEjT7ll2JE3NiYpqqba
	WB4jIOFg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVja8-00000008Bhn-3Eod;
	Mon, 22 Jul 2024 03:19:24 +0000
Message-ID: <1c22a0c1-e661-4f12-92c1-7e475526e2df@infradead.org>
Date: Sun, 21 Jul 2024 20:19:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] xz: Documentation/staging/xz.rst: Revise
 thoroughly
To: Lasse Collin <lasse.collin@tukaani.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Sam James <sam@gentoo.org>, linux-kernel@vger.kernel.org,
 Rui Li <me@lirui.org>, linux-doc@vger.kernel.org
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
 <20240721133633.47721-8-lasse.collin@tukaani.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240721133633.47721-8-lasse.collin@tukaani.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/24 6:36 AM, Lasse Collin wrote:
> Add SPDX license identifier.
> 
> Omit xz_dec_test info. That isn't relevant to developers of non-XZ code.
> 
> Revise the docs about xzkern and add xzkern_with_size. The latter was
> added to scripts/Makefile.lib in the commit 7ce7e984ab2b ("kbuild: rename
> cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}").
> 
> Omit contact info as MAINTAINERS has it.
> 
> Omit other info that is outdated or not relevant in the kernel context.
> 
> Include the xz_dec kernel-doc from include/linux/xz.h.
> 
> Cc: Rui Li <me@lirui.org>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Sam James <sam@gentoo.org>
> Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
> ---
>  Documentation/staging/xz.rst | 160 +++++++++++++++--------------------
>  1 file changed, 67 insertions(+), 93 deletions(-)
> 


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

