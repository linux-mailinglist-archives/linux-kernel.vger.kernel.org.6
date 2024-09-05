Return-Path: <linux-kernel+bounces-316622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55196D20B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF96284EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB491990C8;
	Thu,  5 Sep 2024 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mkHPDC3z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbLfx54Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA061990C0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524670; cv=none; b=Ww4N8dLfxCOwOi5FXiF8KblyeicfZ0hVRq8/PXBzi971FmWTAvCVUvHF5rxtLzY06Bng947LBQ5DjzTAKkXm1Kk/7MWlR+MfGkB/ZObUmF4f3yfsxjaGhAq07xJXUnZFwIkkXD1vXAnzpyvGImGByUOOXR2zip4xJwFNjFcXqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524670; c=relaxed/simple;
	bh=Ws/mSEVV1xRXKEnj5qb2uECKNf5Q65+XUhsFtevtIh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F+meAVEuOckDfXE/kBADFyS1rYtg6cbseT39cq88TbdUQg0CUcsFgF7vEjmHgDm0xH/U//KMVF8Wc45/+gUhlK6RHWi/Drbrjfw+FnSF4QXaJegG6YdAhKSA4cc8bV7LwBbZ+QMH3XEuXroq+QmINj3T2tvRD634Cg8MfUv1yvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mkHPDC3z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbLfx54Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725524667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRJU5TXxUgA/Yl66ATB5SjrMWF8+2GHU00hqM88SVOw=;
	b=mkHPDC3zTjhP5jwaKv3VLXhIs9tByi4c+9/Mu/7Ep2DD6nd5QcrfP5z3LOOVWzSeOW1liM
	kNx6mCKsfXikdQejwk7ulcLtfHI5xcc43kzFg+OmCyi53KEOwj+JVZ+eAfq1viip4v9HFC
	b9WV5Idxn7DqK7evPZwfhcu7lgDY8dhRXqtWjTYInFcS4XDuKejhLJo1+B68JtzeOUq6EU
	JxQ2uPYS3qKRpXlXVz5vPPy0UgCC/ayD4LKg9YItEuZzsPyzGDhZJW2loMBQlp7twgVWP6
	E7iJU/WfD5pSnoQ1z3fms6liEgBFPmI51B9/gd7cJYUCaSYTO6E3nC/iCW9GFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725524667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRJU5TXxUgA/Yl66ATB5SjrMWF8+2GHU00hqM88SVOw=;
	b=KbLfx54Y3EdQAKa8sim/2ySxwB0+frKrBMjwaGbK5nhEX/+ex7GEvIj1jEnJEMWTSa/bHb
	FOSO5gyJvJ6GSBCw==
To: Mark Brown <broonie@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 11/15] regulator: core: Use fsleep() to get best sleep
 mechanism
In-Reply-To: <544ffae4-b67b-4152-bebf-21a90c00fb76@sirena.org.uk>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-11-e98760256370@linutronix.de>
 <544ffae4-b67b-4152-bebf-21a90c00fb76@sirena.org.uk>
Date: Thu, 05 Sep 2024 10:24:26 +0200
Message-ID: <87seue4if9.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> On Wed, Sep 04, 2024 at 03:05:01PM +0200, Anna-Maria Behnsen wrote:
>> _regulator_delay_helper() implements the recommondation of the outdated
>> documentation which sleep mechanism should be used. There is already a
>> function in place which does everything and also maps to reality called
>> fsleep().
>
>> - * Delay for the requested amount of time as per the guidelines in:
>> + * For details please refere to fsleep() function description.
>
>> -static void _regulator_delay_helper(unsigned int delay)
>> +static inline void _regulator_delay_helper(unsigned int delay)
>
> Gien that this just becomes a trivial wrapper for fsleep() why not just
> replace all the calls with fsleep() and remove the function entirely?

Nothing to say against it! I will change it.

Thanks,

	Anna-Maria


