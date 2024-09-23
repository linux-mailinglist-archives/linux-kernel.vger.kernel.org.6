Return-Path: <linux-kernel+bounces-336036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0477497EE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FF21C21735
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22B19415E;
	Mon, 23 Sep 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UTkt1LQj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LkMGVOAp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35568F6E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106056; cv=none; b=sWWwSnJKC+s7DSFtI4TN7G++641AYd66uvk5EJyaayO/X6u1DomvnMfYtqRbVqe3S+PP+pFXjmEz2E8OJJqFIq9dXwXCD+Wj5C2GL/KOJ72g7k8D/PV9IC3IeuL3IGnL7a7KJuKVDrECyac2BWeMQi7HFXNmL54Knh7M9ST/NNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106056; c=relaxed/simple;
	bh=9vJJpC5+0WR5sknL4xlRUl40GP4+dTmaZVoUqg9jXnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=caY4UIay68e0bQB6SlzGLi8P+oC84r9GT55lb79RGMC403J/Gl5khRgzKwAPUWtCHLtotMIIvVM5/fiqW3IYrhzCtfce70Z8pNdUyLFj4wDCBTqSYEE3BBDx7S7Xi62l/Me7eLw3DLLc6XX2kHNSWSkSoqrRlbNoy68WjDlAzNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UTkt1LQj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LkMGVOAp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727106053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mC7V0Rd5P9n4QcbqaigkaEAy3M25kzk2U3Dwye5kaU=;
	b=UTkt1LQjtRWZVp75ros9JY1aFGJTCofiL/VP/WkKtjvk50ZBZTXmQwoITztqUjMRZAVlNi
	LJVUUIY0YffGMpl6vs2lwXEg0izriacY4ZfZEjZs1AZ5/5OuJeObX+0oxj8J+jMkvwAVwz
	ARFpg7oI0VoMO1aDDpdHevkf3NtcTRA19ZE2Lj6kKJL4yIYmvl3DxYQuIQu/fNQgENqeYQ
	3FbcJT5Ju4UuV8LZKxiUSFwCHvmYjwiNsypr4UXgy0iTEbrL+/tfpwYQrNzyBApPJzmPZL
	hBHy22PaK0t7xxny4lWAdTJw/ZzwGs+MqTxWNQIfUDhNBDQvbwto2cA6yWmvRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727106053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mC7V0Rd5P9n4QcbqaigkaEAy3M25kzk2U3Dwye5kaU=;
	b=LkMGVOAppFgeo/haDuX15toDwwfUoKnEzhj6uxK9S6YJgBYBCyNsSoHwddd7jF5OQkNi/H
	cgdbxwFV3VNAhQAA==
To: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 06/15] delay: Rework udelay and ndelay
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-6-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-6-b0d3f33ccfe0@linutronix.de>
Date: Mon, 23 Sep 2024 17:40:52 +0200
Message-ID: <87bk0eidiz.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

> udelay() as well as ndelay() are defines and no functions and are using
> constants to be able to transform a sleep time into loops and to prevent
> too long udelays/ndelays. There was a compiler error with non-const 8 bit
> arguments which was fixed by commit a87e553fabe8 ("asm-generic: delay.h fix
> udelay and ndelay for 8 bit args"). When using a function, the non-const 8
> bit argument is type casted and the problem would be gone.
>
> Transform udelay() and ndelay() into proper functions, remove the no longer
> and confusing division, add defines for the magic values and add some
> explanations as well.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v2: New in v2 (as suggested by Thomas)
> ---
>  include/asm-generic/delay.h | 64 +++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 28 deletions(-)
>
> diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
> index 70a1b20f3e1a..40d30dc2488b 100644
> --- a/include/asm-generic/delay.h
> +++ b/include/asm-generic/delay.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_GENERIC_DELAY_H
>  #define __ASM_GENERIC_DELAY_H
>  
> +#include <vdso/time64.h>

There was a build failure for i386 (missing include
<linux/math.h>). Will be updated with v3.

Thanks,

	Anna-Maria


