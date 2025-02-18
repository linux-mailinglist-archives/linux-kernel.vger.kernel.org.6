Return-Path: <linux-kernel+bounces-519173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1607A398C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA45188FB60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E825C23496A;
	Tue, 18 Feb 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8lrmkG8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B38233157;
	Tue, 18 Feb 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874367; cv=none; b=DDX90Aq6zc/RYA+ceDTtt8fuJ6HkwarRufyg/32hf2RcY0JPlPnib2SD/tue+Pm+a961+hV0YheaKjpcWux3g1rkoG+bTEwu3yAyhKh26du4q43ZigwRRcKW3fcCMehtvu0u9jilSQ6RO//hLwEC+HPAK+KPbPALuB3KYMtBs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874367; c=relaxed/simple;
	bh=JV3Jjgs2g98a9pyFx/aQlL5hzStoNO6JYJtzz5JcTmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvKyAhzmf3VW7WjS6vSknAF+Bont2+PzKZ+Smj1z6DQcdbQnFhGtgshzDI+HCkCf+fnKjJwUJqd5izXmib/9uDVncsuJ2EmkIzQK6WyAUlAa7utpGJtL0XbkjYRDQ9nP7pHpJ4im9nOhxQpNnthI3CBgK/2UXcRJrSaWB07uB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8lrmkG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB00DC4CEE2;
	Tue, 18 Feb 2025 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739874365;
	bh=JV3Jjgs2g98a9pyFx/aQlL5hzStoNO6JYJtzz5JcTmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8lrmkG86ZMXNRL66jiYnjf2vCvfSoIkuBcmywXPGYoRahN6L2RJWaa+1wtp4mrSz
	 iWEtBIggtxjIT7ZKSahBnLc4m7CDwA//2oPUlSqpsBc1c9zDZGe35894jrmm82t37E
	 qOgKwWGebn7GIxWqIxaXoCz9GJF2JmSxoXG+qowBiWw/pfpMIm0HTwP0efe9jw3fQ5
	 J2PoA5MYsi0Qgn6q9ambR/40p1hnZIwahDweefxG2tm+xs7FJnsSbh0XObGQfZZeF8
	 oMjQB5d2UR37Fdg7mj7vDfGvJZFJtOIOtv7fq5IexDvWLCejBFcg6sJYFx9/wMYHfo
	 xXbNkq/8m6IRg==
Date: Tue, 18 Feb 2025 11:26:01 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z7RgOd_57wcSUyB0@pollux>
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <Z7OrKX3zzjrzZdyz@pollux>
 <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>

On Tue, Feb 18, 2025 at 11:46:26AM +1000, Dave Airlie wrote:
> > 1. How to avoid unnecessary calls to try_access().
> >
> > This is why I made Boot0.read() take a &RevocableGuard<'_, Bar0> as argument. I
> > think we can just call try_access() once and then propage the guard through the
> > callchain, where necessary.
> 
> Nope, you can't do that, RevocableGuard holds a lock and things
> explode badly in lockdep if you do.

Yes, try_access() marks the begin of an RCU read side critical section. Hence,
sections holding the guard should be kept as short as possible.

What I meant is that for a series of I/O operations we can still pass the guard
to subsequent functions doing the actual I/O ops.

More generally, I also thought about whether we should also provide an SRCU
variant of Revocable and hence Devres. Maybe we even want to replace it with
SRCU entirely to ensure that drivers can't stall the RCU grace period for too
long by accident.

