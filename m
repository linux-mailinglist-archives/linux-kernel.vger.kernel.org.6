Return-Path: <linux-kernel+bounces-324370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C45974BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CC81C21A19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7D13AD29;
	Wed, 11 Sep 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c75rQumd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYt86Ang"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4C2C190
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040759; cv=none; b=PIBbKZ6HbymewDQz4NlbR8utz2Tqed4ttpc+A7Tw+zpucKBE/C+AF7+5/hmjqO9a3Tr2mSYhVc1sZxHbhr7l476+FLQn43uY4BxAZFRScB3uCQPJlU9CnyYhGtU+ixvMFk2YAgCtlThRrXFNMOWVyLEKhOUE/K1t2t3WJ/SrK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040759; c=relaxed/simple;
	bh=388Rc/PiRqYAZUv/59jOHlJX28P68TxdEAFj7JPsqwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ibyC+e9dqz5llGXG+AOQd25nNkqg1NIoAjIVZUIJ1iIPzmCOlPXLNIn5J5pJQfs8UrxGqGbk6c/EMnCvryQx6577jR2P5/RD+QCQ0XZartNZt+xa+OxkZs7PZQ5ISJgg6kK3Mzjl9q5G05dMFhKHBVDDvbd6Zbjh2/NlSQ1r22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c75rQumd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYt86Ang; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726040756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g62CuygDRqWMEaC8YeuPdW2KogHbLy3GihrNQ+eFKn8=;
	b=c75rQumdkOsGqpDC1jZE3w+NzQXQQ+P5UKhJiofDJKgPQBKXqMH2nKgKzDI75Xm2+GjytE
	+RfYhCVRnYVa7ZFyCaFMMCwVznXWI+OkUUbvs69D9z/YcpjOFiNyPbh5nM27G+ENqmKzZM
	1W0O0Z+hBDbe9NX1jMVL6W1v8nQg3bX8+GLJxQGpX1w3UkV8+lUIICl9mH2W9+TQ4Uk3ju
	GXK30yzTpA0Ah8b6JcmEAVPRMEnX2pU5o9JMDXTjhaoPKBMeYAZo7wRC/ia/09heZDTAhr
	ui8LS7GGNen1K2rqs+M00D0644jCmIjBUoQkIABtEZf2H5JnVj6JtLypJFIzww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726040756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g62CuygDRqWMEaC8YeuPdW2KogHbLy3GihrNQ+eFKn8=;
	b=gYt86AngWdXKj3A5YfzOylS4l97yC1KRewDEGDuORNwFKkR3rTzDc1jjOCfSGCRVx2mOPq
	+yw8fCCw0WvOplAg==
To: Joe Perches <joe@perches.com>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonathan
 Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2 09/15] timers: Add a warning to usleep_range_state()
 for wrong order of arguments
In-Reply-To: <ece8c4be2d489703fdd6962b16ed573d3b83cde0.camel@perches.com>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-9-b0d3f33ccfe0@linutronix.de>
 <ece8c4be2d489703fdd6962b16ed573d3b83cde0.camel@perches.com>
Date: Wed, 11 Sep 2024 09:45:56 +0200
Message-ID: <8734m6eiq3.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Perches <joe@perches.com> writes:

> On Wed, 2024-09-11 at 07:13 +0200, Anna-Maria Behnsen wrote:
>> There is a warning in checkpatch script that triggers, when min and max
>> arguments of usleep_range_state() are in reverse order. This check does
>> only cover callsites which uses constants. Move this check into the code as
>> a WARN_ON_ONCE() to also cover callsites not using constants and get rid of
>> it in checkpatch.
>
> I don't disagree that a runtime test is useful
> and relatively cost free.
>
> But checkpatch is for patches.
>
> There's no reason as far as I can tell to remove
> this source code test.
>
> Why make the test runtime only?
>

Sure, we can keep the test in checkpatch as well and I will only add the
runtime check. Then I would change the link to the documentation in
checkpatch into a link to the updated function description. Before I do
any update there, I want to wait for your answer to the other patch of
the queue.

Thanks,

	Anna-Maria


