Return-Path: <linux-kernel+bounces-568555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2A5A6975D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B48A58EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A98206F11;
	Wed, 19 Mar 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUl5A6/M"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD31AF0D7;
	Wed, 19 Mar 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407298; cv=none; b=K4bBaG5aLi7zyUWJ/XuQ7JXA2akv6KXFu1+10L2+s7HgNPro9FalfKsgY+QAA2zdj14J75iQjopR3t+qAkfAC53lesHZNMZyydYhy5S3fRv/4iAgfHEUsvnhWqHJY30U1A8KOlNhwhvTBSTXdigrY5XGopi6QZEVjVeJNbETqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407298; c=relaxed/simple;
	bh=oQE5SWEQZo+51U7+Wy6AQNae+ZlEYPOsFBF8ZFt2r30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsHFqIbDkzYUMTltk+DOPb8TNsyDWsJhu7PN0LX/P3Lpq0fkQHd2qV89K7t1PTX5R3wF1M810ipkAEUKRmhMNZ4HEa3NKz9sWkoQ9M18CFktRq+4lYYV54zruAIt8+5wMIjo0J/fXcwKmMizOarJ1jwafe3DzlcZ5QuZH2vD6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dUl5A6/M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=9ZQ/8u1bPwOt3oNHK9qL/WApsP/XQrqSOmmJ930SPGc=; b=dUl5A6/MqdWgl1juDVkqKPiS9r
	tsCLHriDCeA99lFYbDJSYL1G6DYjXzifeWAIrm4nc+vyjayxVLhMIC1TTfS6QPdB8ZayKRUnaun4s
	5wnOcNzdmaDWhFHp0WjIh0HnNqph5Xszmi0eqd5r3ruxI5znMK400pEqkdUXvQrJKRDkNZAMexHuR
	wfHs3CjXXXTZtyfWB3wbfNwl5AoZQyT5k2MY4UHL00SaYHaF3cQYFYQrzKDJfuXMM8yhxetDq8kDL
	uSnbDyQQB4uyYewL/IyHqz/3wmxZApS4OJdfUOFhjSsc+x3nFWCmFXa6EMV8D/JlTHzs42NyxYDxK
	t6j0uaxA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuxjS-0000000DF5N-3QER;
	Wed, 19 Mar 2025 18:01:35 +0000
Message-ID: <907fba96-d8f5-428e-b762-738abc8f88a4@infradead.org>
Date: Wed, 19 Mar 2025 11:01:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 56/57] docs: irqdomain: Update
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, tglx@linutronix.de
Cc: maz@kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20250319092951.37667-1-jirislaby@kernel.org>
 <20250319092951.37667-57-jirislaby@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250319092951.37667-57-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/25 2:29 AM, Jiri Slaby (SUSE) wrote:
> The irqdomain documentaion became obsolete over time. Update and extend
> it a bit with respect to the current code and HW.
> 
> Most notably the doubled documentation of irq_domain (from .rst and .h)
> was unified and let only in .rst. A reference link was added to .h.
> 
> Furthermore:
> * Some 'struct' keywords added, so that the respective structs are
>   hyperlinked.
> * :c:member: used where appropriate to mark a member of a struct.
> * Some wording rephrased to improve readability/understanding.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/core-api/irq/irq-domain.rst | 122 +++++++++++++---------
>  include/linux/irqdomain.h                 |  26 +----
>  2 files changed, 76 insertions(+), 72 deletions(-)
> 
> diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
> index c2f2728b1a35..7a418b3135de 100644
> --- a/Documentation/core-api/irq/irq-domain.rst
> +++ b/Documentation/core-api/irq/irq-domain.rst
> @@ -3,8 +3,8 @@ The irq_domain Interrupt Number Mapping Library
>  ===============================================
>  
>  The current design of the Linux kernel uses a single large number
> -space where each separate IRQ source is assigned a different number.
> -This is simple when there is only one interrupt controller, but in
> +space where each separate IRQ source is assigned a unique number.
> +This is simple when there is only one interrupt controller. But in
>  systems with multiple interrupt controllers, the kernel must ensure
>  that each one gets assigned non-overlapping allocations of Linux
>  IRQ numbers.
> @@ -15,45 +15,64 @@ such as GPIO controllers avoid reimplementing identical callback
>  mechanisms as the IRQ core system by modelling their interrupt
>  handlers as irqchips. I.e. in effect cascading interrupt controllers.
>  
> -Here the interrupt number loose all kind of correspondence to
> -hardware interrupt numbers: whereas in the past, IRQ numbers could
> -be chosen so they matched the hardware IRQ line into the root
> -interrupt controller (i.e. the component actually fireing the
> -interrupt line to the CPU) nowadays this number is just a number.
> +So in the past, IRQ numbers could be chosen so that they match the
> +hardware IRQ line into the root interrupt controller (i.e. the
> +component actually firing the interrupt line to the CPU). Nowadays,
> +this number is just a number and the number loose all kind of

                                               loses

> +correspondence to hardware interrupt numbers.
>  

[snip]

-- 
~Randy


