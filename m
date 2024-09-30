Return-Path: <linux-kernel+bounces-343707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A7D989E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECAD1F20EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA1188739;
	Mon, 30 Sep 2024 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TuOVTlXU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcL3FtD+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447717B4FF;
	Mon, 30 Sep 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689008; cv=none; b=cn67wTdAgCisJZd+Ck0tdLMx63/9eYPEM3gWd6KB04hLASMDMbGKW8AOPttZRrNdIoNw0kGO+RitsnzYIj7m7xMlHJyul+CQxCcgSPktPaUjNmLCN4tCt9W8HXI9OvGj5DMXIoixRMMo1vbLkBn3nbu2Lt9Xshh6pN2CoMhLViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689008; c=relaxed/simple;
	bh=0l1QIaZpXfV94Reph5s6R6yN4fGgxSRIVkO1DwBfha8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DrVZlr0paxORXgzK4EhCUvk/fHOZrAXf5B5JxxfBVRHBKmgRja162z3gjKsGxCs414tH3PEiSad1OF985quKvo4l9/AeieGT/PXZTzeY8EeOsSvd3yKG5GNyYVYjx9TkWrwyl7YNFYmjy3gznuftBBsO1Mk1y6kBI+5MBKz6vag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TuOVTlXU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcL3FtD+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727689005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqCx5BHAew2ihqzQT4FG3YqTOD3x5uITQ1bdx1BgNpM=;
	b=TuOVTlXU9om9AdoPRhotdkPNSFt7xA+2nPIJHFMoDx89Km7qS9DWIBcmry0MM8aUOzpKza
	xAHx7QMoqphBo+GdMVvz/WJy/+UdehVDujAnVs/ap/1/Zqw8cLyJrrIa6lQ5OFOaqiSM1K
	n/maOYYHJtgPvW6qCdQIW2SxgZqMwJWYLJkXld31EIic5j5h96kyoIiJf6mnsmLlIUqF03
	suzB4s7un10DNhmcit1y/v6+zpzKVGsTYBnxAnbO4BQQOPAS+uJNbd0eI+mMTRa7cFK48q
	hXfKfVwg9pEZ2jqcQT0gMLksNzNF50oebeTQsQFu6+t8mTOr0ACq2oSdP+toEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727689005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqCx5BHAew2ihqzQT4FG3YqTOD3x5uITQ1bdx1BgNpM=;
	b=hcL3FtD+TWvdZCb7YeCqNR6DIyDenf0jgDp/dp1y3d+mRq96SjkyrWN8hLEMOOsxdYhj0z
	612F8Y9skjdM20AA==
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Frederic
 Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice
 Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Date: Mon, 30 Sep 2024 11:36:44 +0200
Message-ID: <877cat32kz.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Andreas,

Andreas Hindborg <a.hindborg@kernel.org> writes:

> Hi!
>
> This series adds support for using the `hrtimer` subsystem from Rust code.
>
> I tried breaking up the code in some smaller patches, hopefully that will
> ease the review process a bit.
>
> The major change in this series is the use of a handle to carry ownership
> of the callback target. In v1, we used the armed timer to carry ownership
> of the callback target. This caused issues when the live timer became the
> last owner of the callback target, because the target would be dropped in
> timer callback context. That is solved by using a handle instead.
>
> A request from Thomas on v1 was to add a more complete API. While I did add
> more features, we are still missing some. In the interest of getting the
> patches on list prior to LPC 2024, I am leaving out the following planned
> features:
>
>  - hrtimer_sleeper, schedule_hrtimeout, hrtimer_nanosleep  and friends
>  - introspection functions:
>    - try_cancel
>    - get_remaining
>    - active
>    - queued
>    - callback_running
>  - hrtimer_forward
>  - access to timer callback target through timer handle

Regarding the API: I had a closer look at it after the discussion during
LPC. It's possible to change the API (prevent setting the mode in start
as well), but it is not as straight forward, as it originally seems to
be. So this will take some time to be changed completely.

But what we will do in short term is to create htimer_setup(). This will
do the job of hrtimer_init() but expand it by the argument of the
hrtimer function callback.

This is just an information update for you. So you can proceed right now
with the current API and we keep you in the loop for further changes.

Thanks,

	Anna-Maria


