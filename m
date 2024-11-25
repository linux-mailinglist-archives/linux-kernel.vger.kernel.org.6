Return-Path: <linux-kernel+bounces-420596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E2D9D7D09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D24B235F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CFE18C006;
	Mon, 25 Nov 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rBhIqzTS"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042418B47C;
	Mon, 25 Nov 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523905; cv=none; b=SI3nzPKwuWv4L+4e7YXPRjhcjF3Fs4zUEs81uanzdOzG/Nt8H6w1ssVeLwOzLGg8ucgoTU7pQcsuqlT7uKgUQHEwCrMuLxU/aI+SqR3UUsUA4AK8Ei0xqQRr2G4lkQ+LYDUohZdFgARQjteyxKMaGnjz3kgQo4WrIcb5GDgLLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523905; c=relaxed/simple;
	bh=q6ID1YSLBNj16wmegqD5NXVom8VnfquGhuEwXZg0V8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWOQiqTxxpyGWYrZ2kyjqrhtJx2VlwWQx/G4u74hkCc/8506/R3C9hhqlJu2h7fO98S5sVXKKBosR3SpndEgQFS5ukH4wedKxho/B0yACw2EL20dtdAeexMs+LeyttYwE9z1CZArRwT2Imy/+sf90Pw+iN7fq73KaA7i8V4p1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rBhIqzTS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+xt2q+vlfr3bovTTZE4n2ZJgwD+1Q9yVnx7KQddEfLw=; b=rBhIqzTSsTAhNUTC3HCG0ZHFzh
	Tr7XwCWjtWEDjjGv6219EvUKJ+SX8f8Bv5SB2hT0rkaqnqRhFhvcQ9VsWUwxMgXtTBp/SpIv6RWSM
	SUBom4kD1xvVzMaGBANBTZrHLo9yXpriKrRngl2Htt8cW4VmyWsgAFWlygP3b0873bhS1Pq4lV0Uk
	5mhT4oDDfl7xFI9H/Y3EkhGSduzmieIUg3h6LJYoUfT+rmAZcsqj8uOiwQxkL2w9keGom3EuNPm71
	hBsT0tCkN/IfL6xyAcxqgDjVIMNo8jxHjKA9SqtU1Yih1n2j1G/kfCMsstQQN2yZfdm0HQ+0/cHch
	XDL0Ctew==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFUbo-0000000146Q-2Rk2;
	Mon, 25 Nov 2024 08:38:18 +0000
Message-ID: <d2dfc0a4-d9dc-4dd2-a669-097dcf3491b5@infradead.org>
Date: Mon, 25 Nov 2024 00:38:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/Documentation: Update algo in init_size
 description of boot protocol
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, Cloud Hsu <cloudhsu@google.com>,
 Chris Koch <chrisko@google.com>
References: <20241125083136.1540424-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241125083136.1540424-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 11/25/24 12:31 AM, Andy Shevchenko wrote:
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
> the document and fix indentation, so the syntax highliting will work
> properly in some editors (vim).
> 
> Fixes: 43b1d3e68ee7 ("kexec: Allocate kernel above bzImage's pref_address")
> Fixes: d297366ba692 ("x86: document new bzImage fields")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/arch/x86/boot.rst | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> index 4fd492cb4970..01f08d94e8df 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -896,10 +896,19 @@ Offset/size:	0x260/4
>  
>    The kernel runtime start address is determined by the following algorithm::
>  
> -	if (relocatable_kernel)
> -	runtime_start = align_up(load_address, kernel_alignment)
> -	else
> -	runtime_start = pref_address
> +    if ( relocatable_kernel ) {
> +      if ( load_address < pref_address )

What's up with the extra spaces around ( and ) ... and inconsistent with
the lines below?

> +        load_address = pref_address;
> +      runtime_start = align_up(load_address, kernel_alignment);
> +    } else {
> +      runtime_start = pref_address;
> +    }
> +
> +Hence the necessary memory window location and size can be estimated by
> +a boot loader as::
> +
> +    memory_window_start = runtime_start;
> +    memory_window_size = init_size;
>  
>  ============	===============
>  Field name:	handover_offset

-- 
~Randy


