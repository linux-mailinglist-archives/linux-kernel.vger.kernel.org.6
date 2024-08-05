Return-Path: <linux-kernel+bounces-274715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F6947BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526F3B20C91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8B15ADA6;
	Mon,  5 Aug 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kjejdseU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5EG5Q1A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF4155C8D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864474; cv=none; b=L8RUhh82sllPO5GwYJJG9gjmczbCCzdDtEV/RJSCd7Sp/cTHPSgkTrx2qj6O0p9M24ABOxB73MMDMrLzRvm7PQetspO7NIbw8dO1xKF93TSSiNTrfTHq7HEMup3yO2QBqyOPecXxJ78Z8/4jPXaRmToGvPyyBsiRS4PuAhYt/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864474; c=relaxed/simple;
	bh=E4mcGbKa8RzQm62+PrAyFu68EddvBgW3kPvFGPzmGzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4moiKGjbxHEfm8xFdql2mmb+/XNStidC2W4bb3a1I7p/7vbB7H8H5tv92wnQ8F/BJqGeJ2uUAs7Q/VKL9CqwQajheZuOYdXW/W5uGN/CsvuDWOKIyfTod20VLudk7r0wH1ZCTmJ39IZhHsCqkwCWD/PUiuk2yWObE2/oB2mH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kjejdseU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5EG5Q1A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 Aug 2024 15:27:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722864470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4J3UinGKGx1IFKmZakRPbgM9zeI4qFB5Cx4byDEE5qo=;
	b=kjejdseUkGX9AhKuK/bun9ZoDgZkRJvrT/fG2+CT+Df6maZFoHOGGQfn7yIkkqSeMWYGfi
	HlvQznsWuBBwwV9zRDPrTD2V5/BANt4voiJl3Po2fIxshhaIQsEJwCVa9KFcs+34PDhbpD
	AIXVkVgPLmT0SCdPdCikiiXZAxcTsWJ5LyUQ1w4kz7MUY/fSwYnFslXg88zJzeyMdSCqiU
	DGl8fmmgs/2b3gKo2tiTW343NT+FM8PuoS1Pp6BbHKHyCt0HEgqxA9BwQiQvqKwoBI4e6i
	VkfDMbSirhR7VGMn7x/lNJlGwb7dXJm5lEdLEIi5s0QmBCu999e3wz/XGA40oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722864470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4J3UinGKGx1IFKmZakRPbgM9zeI4qFB5Cx4byDEE5qo=;
	b=C5EG5Q1AEg0yNpgKxscH0HLS8lDcB5adAV9fE1HMOZaq95z2OD1Ow10Gptc4ZIkuw53Y1l
	AvLfo02B7r9yfUCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com
Subject: Re: [PATCH 1/2] hrtimer: Document, that PI boosted tasks have no
 timer slack
Message-ID: <20240805132749.jtD28XKa@linutronix.de>
References: <20240805124116.21394-1-felix.moessbauer@siemens.com>
 <20240805124116.21394-2-felix.moessbauer@siemens.com>
 <87cymn5div.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cymn5div.ffs@tglx>

On 2024-08-05 15:02:00 [+0200], Thomas Gleixner wrote:
> On Mon, Aug 05 2024 at 14:41, Felix Moessbauer wrote:
> > The documentation of schedule_hrtimeout_range already states, that RT
> > and DL tasks do not have a timer slack. However, no information about PI
> > boosted tasks is given. The current implementation consistently ignores
> > the timer slack also for PI boosted tasks (all tasks with a rt priority
> > at time of programming the timer).
> 
> Which is wrong. This condition should not use rt_task() it should use
> task_is_realtime() instead.

There is also the series 20240610192018.1567075-1-qyousef@layalina.io

> Thanks,
> 
>         tglx

Sebastian

