Return-Path: <linux-kernel+bounces-231651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FDA919B63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313B5B23356
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C4194147;
	Wed, 26 Jun 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IUvcKIQL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77F15E5B9;
	Wed, 26 Jun 2024 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445522; cv=none; b=Zh5+7mHuHsk81XWdLRcyP/vbLRlG9QY3+BY6AAgPg/XWo6dXo73sVbvaD0RxZ/hChIVgMNJ5CwK83hxtkku+LN4Z49uPbkUT7TVZWx6SU5St98JJkriFIER7svIIIb2Uu1dDetGZkSmneHrZU9C4HBkVuj1p/lE35qIc4tbdjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445522; c=relaxed/simple;
	bh=j7Yo6m/AqThOVdj5U+fqGLmSlhqAs/PdzOzaPqiPTPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPfQruSCopb7Zfb3nFHlvztaSOZvTLy8CisbhlJ3uUAdhz5WvmLU8uPluKAzmhb/wbiAoJuBxX+ULlyB7S1HtLdJ0CqhVmOO9PIFK+Xi0COx3za4F85+1leSFhVOJil1gQ81EybSO3ulByB3hYNG/Hx/asuyYF5KW6A+K11fjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IUvcKIQL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2kstE+ZWklYYPqS7I36sd/47PFuKzgdS4DMx22ywkXM=; b=IUvcKIQLQATzN5JRSKkmPrhX8I
	KLhcBudm0beFokr9nkSa7yil6gFd71+fZUxCfVXtuRAxAiLBpHK6Cww2UmPxFU6dMWCshGicE6DVH
	oAHa5tDaL5OiLDl8o0U7eXdbyNQPTzxPyUKkHFUSiZAO9kr/p8hitndDMEA0KpMCZirU7uUfg64Sv
	oVSbknsTt4Ui8Bk9nqxzi3fQ0+QK/MU8PtD/vfb7yulA1ZlJ5YLZ0ONukvIa9IV9Alus5B9UZZQJP
	+eInrfXhs8eTYceaBFNSiBGvGCyWjfXv6Iu9rz7dgqVsTWw3WjdKzwSjZLsVDWQ5yvsoCB+ZUn3Pu
	PvAnNZOw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMcKC-00000008fHs-2FMx;
	Wed, 26 Jun 2024 23:45:16 +0000
Message-ID: <994dce8b-08cb-474d-a3eb-3970028752e6@infradead.org>
Date: Wed, 26 Jun 2024 16:45:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] arm64: add attrs and format to ptdump document
To: Maxwell Bland <mbland@motorola.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3>
 <uz7euxemnah4fhoyj7brop67mqjzzkm6tctf5s7alkhvrmhkgw@ziq4h7kzsdvz>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <uz7euxemnah4fhoyj7brop67mqjzzkm6tctf5s7alkhvrmhkgw@ziq4h7kzsdvz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/24 3:16 PM, Maxwell Bland wrote:
> Update the ptdump content with a precise explanation of the attribute
> symbols and the coalescing of identical entries implicit in the code.
> 
> Remove unnecessary layout example given the existing cat example,
> and opt instead for a precise, clear explanation of address markers,
> format, attributes.
> 
> Update example to match the new cosmetic and intermediate-directory
> printing changes.
> 
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
>  Documentation/arch/arm64/ptdump.rst | 126 ++++++++++++++--------------
>  1 file changed, 61 insertions(+), 65 deletions(-)

This now passes my review FWIW. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

