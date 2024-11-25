Return-Path: <linux-kernel+bounces-421274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC9B9D8A79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0669B361C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC91B3927;
	Mon, 25 Nov 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="mLo5nxQJ"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971441B3926
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547641; cv=none; b=S833Dv6cGUhuysBq0kHb8ldexO21Fqo3NLgdtkeZo7TevJPES4Gi+SmbIFuIO8MY2O1nukQouxdwxuPI2vtnfPPWmiBEvSQyDI5fsbA499XR0Gm6FcUQ/zEOYBHTzAnLK+BapgiW9uyCbKkcTdUg7TXXXYfWkkVIe4hRZ674+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547641; c=relaxed/simple;
	bh=2hjSyxx8c/zdwxqo9ElfouuQgclYVzAS4IIPML9Vlek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQ17JFKVA5Z8BQo82ubRdyUuxcsWvOjk31zr5i489rTucLkaJW5KtOEQA86LNLBlWeCiohlrstcLjyFDr+nNcLEpp1Obj+vHG3i6jv0rECfuQ06O9o+n/urSkSbInot77Nv5sKM29EJLTKLlvsAfE45FZ+1ScelGOUfs35GW5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=mLo5nxQJ; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Xxq3j42vjz9shC;
	Mon, 25 Nov 2024 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1732547633; bh=2hjSyxx8c/zdwxqo9ElfouuQgclYVzAS4IIPML9Vlek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mLo5nxQJIwPsTmRRaBphdhVu+RZpFWbyiwYGKNmozla5gjHQ2UyAczKEq0vYAbRvw
	 b+myQca/5VkaT57ydWb5TLZoogZWEE3auf+TK8RoiE8LuN06qqsD6dLQlGR1HEIqcp
	 In4Z0IRKKZyQOiWW9zBQeoVJASwcnLZUFTxcHI/U=
X-Riseup-User-ID: FA0C77BC8E9F753F356B4CC57E08E7B9EB412D51409956FF8C5A542CF7E5EDAB
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Xxq3T2DC4zJs8R;
	Mon, 25 Nov 2024 15:13:41 +0000 (UTC)
Message-ID: <8e7f8783-5745-46fd-9a95-a5ed36065f77@riseup.net>
Date: Mon, 25 Nov 2024 16:13:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] x86/cpu/topology: remove limit of CPUs due to
 noapic on x86_64
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org
References: <20241124174510.2561-1-ffmancera@riseup.net>
 <Z0Q3ZNoQsoiCAiiA@gmail.com>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <Z0Q3ZNoQsoiCAiiA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2024 09:37, Ingo Molnar wrote:
> 
> * Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> 
>> On x86_64 the command line parameter "noapic" should not limit the
>> number of possible CPUs, as it only limits the use of IRQ sharing or
>> device IRQ remapping. Only on x86_32 the command line parameter
>> "nolapic" limits the number of possible CPUs to one. This restores the
>> behavior previous to the rework of possible CPU management.
> 
> So what's the motivation? Arguably the x86-64 boot option behavior was
> weird: a working local APIC is very much needed to have an SMP system.
> 

Sorry if I am wrong here but I am not an expert on the matter. I 
believed that "noapic" disables I/O APIC which handles external 
interrupts while the local APICs are still enabled as they are managed 
by "nolapic". If that is the case, SMP should still be possible.

If both I/O APIC and Local APICs are disabled then the kernel should 
fallback to a single CPU mode. That is the behavior that kernel has with 
my patch.

The motivation is to fix multiple users with systems that requires 
"noapic" to work and after the rework their systems are using a single CPU.

References:
[1] https://bugzilla.redhat.com/show_bug.cgi?id=2295026
[2] 
https://discussion.fedoraproject.org/t/fedora-sees-only-1-cpu-core-after-updating-the-kernel-from-6-8-x-to-6-9-x/121385/17

> If we want to disable IRQ sharing or device IRQ remapping, then that
> should have an appropriately named boot command line option. Does some
> system require that perhaps?
> 
> Thanks,
> 
> 	Ingo


