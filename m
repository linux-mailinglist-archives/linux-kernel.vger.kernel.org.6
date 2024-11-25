Return-Path: <linux-kernel+bounces-421221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1509D882C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E202163E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D61B0F25;
	Mon, 25 Nov 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N5Z4I4YD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580416419;
	Mon, 25 Nov 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545484; cv=none; b=IhyHmdZzSQinn/iqkWafdYbi9PsCB7HofAVXbDmHbs2ScSld/lMPpPbh2jenzvFHxHAzys0OjUf9U7cZrBs/WNyD6IDWl9DWXRoSCCtqeEPmuey0FcE2b8sKZKF+rsYTHcOx5HddY56iFQ7dROxBt3qtm69PKgITAayyoUEaLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545484; c=relaxed/simple;
	bh=LAHssef6DoLue75QVqb4uwrLzdjY64IUlkaE8Cl0yKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+tOthPiBCh7ra3O+NWd98LEULGIu3hjkRlStwfhR8VggRRijrWWBcW4hFFMfx5BJ1b8oQUvDc2FW6BA7fMZnCULezakRbNmdNLZAWpIRlXoMqWqa9+bZD57UHqJ4yrbmMhrXjqGbmEsbc6q3MmkMm3KUscNZEg5zr756Nhg4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N5Z4I4YD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1J2qpV2V6Ep395c4GdNijbZbpMm+WSwMQ5mc7jMGpvU=; b=N5Z4I4YD/wNb7/Hc7lg5wLa/HW
	u0H/P+k1qIHcJxywH9nKf8rG9X/ziIjAmhv0i0PlofX6mdlRPa5MY3wIKqD9JnbjmK11Y0+cIKWgO
	sB5LLZzUKQ7VCaiXaGXjqMOlkZ1vh1w2dES4UqGVT7lzdG6bizAsiqkLLJWvcck+EG6dxrRRdlxzL
	FgmTqZ0VDo6uyeRCOGtrxbKgGaPNdSeejElth4GZKvZhob6c18jM6PyqPuwkcnqT9sUlUd9aUZ0U9
	m25OCBE0sl9LS803g8fZmXxRu7m3yhi9JsDhWV29GY1Kwx8dum9pjAwQHrt+1l0ShETUz8cE70tFH
	mHVkXVNw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFaDt-000000016OR-34u1;
	Mon, 25 Nov 2024 14:37:58 +0000
Message-ID: <1322e260-57f0-47c5-b28e-41817feae8a7@infradead.org>
Date: Mon, 25 Nov 2024 06:37:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/Documentation: Update algo in init_size
 description of boot protocol
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, Cloud Hsu <cloudhsu@google.com>,
 Chris Koch <chrisko@google.com>
References: <20241125105005.1616154-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241125105005.1616154-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/24 2:49 AM, Andy Shevchenko wrote:
> The init_size description of boot protocol has an example of the runtime
> start address for the compressed bzImage. For non-relocatable kernel
> it relies on the pref_address value (if not 0), but for relocatable case
> only pays respect to the load_addres and kernel_alignment, and it is
> inaccurate for the latter. Boot loader must consider the pref_address
> as the Linux kernel relocates to it before being decompressed as nicely
> described in the commit 43b1d3e68ee7 message.
> 
> Due to this inaccuracy some of the bootloaders (*) made a mistake in
> the calculations and if kernel image is big enough, this may lead to
> unbootable configurations.
> 
> *)
>   In particular, kexec-tools missed that and resently got a couple of
>   changes which will be part of v2.0.30 release. For the record,
>   the 43b1d3e68ee7 fixed only kernel kexec implementation and also missed
>   to update the init_size description.
> 
> While at it, make an example C-like looking as it's done elsewhere in
> the document and fix indentation as presribed by the reStructuredText
> specifications, so the syntax highliting will work properly.
> 
> Fixes: 43b1d3e68ee7 ("kexec: Allocate kernel above bzImage's pref_address")
> Fixes: d297366ba692 ("x86: document new bzImage fields")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: fixed the style to follow both rST and kernel conventions (Ingo, Randy)
> 
>  Documentation/arch/x86/boot.rst | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

