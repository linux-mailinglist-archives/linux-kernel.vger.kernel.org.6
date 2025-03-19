Return-Path: <linux-kernel+bounces-568530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD24DA696E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0265519C2B45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01672066C8;
	Wed, 19 Mar 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N2oKp1af"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0A1E5205;
	Wed, 19 Mar 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406866; cv=none; b=aCA0vUbaCMDclq3Sxa5FJNUs2fr0PC3a/zFeBIpCUqrWGkas3w0nAjmZzTKb/WlvLuoaeoKpUlDUbcWUrG9H8N/OvwKFoac0V1gJ/T6VAddjUHY1T2ZWb+lzgqd1hMzp5NcqggBLQKdYrIJo2BSXMZ67xxA/UrSf+LcbRu6zgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406866; c=relaxed/simple;
	bh=A2W3tf9c8X1e/coKyb3j7iSo7GVo023grE9XKwCba9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBQsiKTkmWmEoa9yFzEcN2a9ThfZuslfHQm1Y3f5G6g8454CX8ft82xoI42cT+c++7yUqtiNgctETNVujeSQ9jN87HtB/Wre4dp3gBL6uucVQtPtN+zvMuQ5+Apq9CIPC8tmm8MVTU5COwjH2FcYTSFIIRloDeQvkj4mFzvvgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N2oKp1af; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=eTV9kEnBTpo50xIXS04EvzIHiq8JEnXHCWFvZ7c+R70=; b=N2oKp1afCI7Ksxore91tedeWxD
	Bl4BsBDP/31Sbej2gU1qxCGOKhbxXXTPhI7pJatol4OUjOi7QF575wOexGDuXN/+x9t2N7fUm94bC
	0rEHPkrcUEIVa7oOvky9bTWhzxN0xe9TD420ZkSBXKTaUsDCZQisft1i8A0Vya0wZYFjy6gSbF/O8
	fc8hgebZ4dSkN25nwrY8jpSB6Vt8fcz9NjSRWPK96NLOia3Fzb3qUfRFkGQpwUylq6seNItuY5lYV
	9VmgrBaLW6Fzy6vJ8Py6p7GUB1gu5buFtrOIJdq0hCCO6YfMrOP8XReMeJX6kqd78SZMEMZiE5nll
	tcY0OynQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuxcQ-0000000DCUq-23v7;
	Wed, 19 Mar 2025 17:54:18 +0000
Message-ID: <4c71b7bd-5264-4a64-81bc-297dcf1c81a1@infradead.org>
Date: Wed, 19 Mar 2025 10:54:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 55/57] docs: irq-domain.rst: Simple improvements
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, tglx@linutronix.de
Cc: maz@kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20250319092951.37667-1-jirislaby@kernel.org>
 <20250319092951.37667-56-jirislaby@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250319092951.37667-56-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/25 2:29 AM, Jiri Slaby (SUSE) wrote:
> The improvements include:
> * Capitals in headlines.
> * Added commas: for easier reading, it is always desired to add commas
>   at some places in text. Like before adverbs or after fronted
>   sentences.
> * 3rd person -> add 's' to verbs.
> * End some sentences with period and start a new one. Avoid thus heavy
>   sentences.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/core-api/irq/irq-domain.rst | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
> index 775dd43b3340..c2f2728b1a35 100644
> --- a/Documentation/core-api/irq/irq-domain.rst
> +++ b/Documentation/core-api/irq/irq-domain.rst
> @@ -1,19 +1,19 @@
>  ===============================================
> -The irq_domain interrupt number mapping library
> +The irq_domain Interrupt Number Mapping Library
>  ===============================================
>  
>  The current design of the Linux kernel uses a single large number
>  space where each separate IRQ source is assigned a different number.
>  This is simple when there is only one interrupt controller, but in
> -systems with multiple interrupt controllers the kernel must ensure
> +systems with multiple interrupt controllers, the kernel must ensure
>  that each one gets assigned non-overlapping allocations of Linux
>  IRQ numbers.
>  

(I'm OK with all of the changes here except this one:)

>  The number of interrupt controllers registered as unique irqchips> -show a rising tendency: for example subdrivers of different kinds
> +shows a rising tendency. For example, subdrivers of different kinds
>  such as GPIO controllers avoid reimplementing identical callback
>  mechanisms as the IRQ core system by modelling their interrupt
> -handlers as irqchips, i.e. in effect cascading interrupt controllers.
> +handlers as irqchips. I.e. in effect cascading interrupt controllers.

I would just add a comma after "i.e.". In the new + line, the "I.e." part
is not a sentence.

>  
>  Here the interrupt number loose all kind of correspondence to
>  hardware interrupt numbers: whereas in the past, IRQ numbers could
> @@ -21,15 +21,15 @@ be chosen so they matched the hardware IRQ line into the root
>  interrupt controller (i.e. the component actually fireing the
>  interrupt line to the CPU) nowadays this number is just a number.
>  
> -For this reason we need a mechanism to separate controller-local
> -interrupt numbers, called hardware irq's, from Linux IRQ numbers.
> +For this reason, we need a mechanism to separate controller-local
> +interrupt numbers, called hardware IRQs, from Linux IRQ numbers.
>  
>  The irq_alloc_desc*() and irq_free_desc*() APIs provide allocation of
>  irq numbers, but they don't provide any support for reverse mapping of
>  the controller-local IRQ (hwirq) number into the Linux IRQ number
>  space.
>  
> -The irq_domain library adds mapping between hwirq and IRQ numbers on
> +The irq_domain library adds a mapping between hwirq and IRQ numbers on
>  top of the irq_alloc_desc*() API.  An irq_domain to manage mapping is
>  preferred over interrupt controller drivers open coding their own
>  reverse mapping scheme.
> @@ -38,7 +38,7 @@ irq_domain also implements translation from an abstract irq_fwspec
>  structure to hwirq numbers (Device Tree and ACPI GSI so far), and can
>  be easily extended to support other IRQ topology data sources.
>  
> -irq_domain usage
> +irq_domain Usage
>  ================
>  
>  An interrupt controller driver creates and registers an irq_domain by
> @@ -77,7 +77,7 @@ If the driver has the Linux IRQ number or the irq_data pointer, and
>  needs to know the associated hwirq number (such as in the irq_chip
>  callbacks) then it can be directly obtained from irq_data->hwirq.
>  
> -Types of irq_domain mappings
> +Types of irq_domain Mappings
>  ============================
>  
>  There are several mechanisms available for reverse mapping from hwirq
> @@ -102,7 +102,7 @@ map are fixed time lookup for IRQ numbers, and irq_descs are only
>  allocated for in-use IRQs.  The disadvantage is that the table must be
>  as large as the largest possible hwirq number.
>  
> -The majority of drivers should use the linear map.
> +The majority of drivers should use the Linear map.
>  
>  Tree
>  ----
> @@ -190,7 +190,7 @@ that the driver using the simple domain call irq_create_mapping()
>  before any irq_find_mapping() since the latter will actually work
>  for the static IRQ assignment case.
>  
> -Hierarchy IRQ domain
> +Hierarchy IRQ Domain
>  --------------------
>  
>  On some architectures, there may be multiple interrupt controllers

thanks.
-- 
~Randy


