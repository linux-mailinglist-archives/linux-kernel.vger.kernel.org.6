Return-Path: <linux-kernel+bounces-521750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F1A3C1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F2D188959D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31411EB9E5;
	Wed, 19 Feb 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="V/O4Svi+"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364A1E00BF;
	Wed, 19 Feb 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974461; cv=none; b=U0qCk5rdEoazlqCbcsqLELFfR84E5ztnuz01Hg8O8prmkzDH/p/fd8yhtKdcko/MivvtrAU73w7czltwchJfx6T8SXY50tRN7JF9Q/6DExVHOk/7e4uGmjY8Bowq9Q2vA+FhKqgMI2Wk8mZmb8Jvg/EnsJ7tXTwbX+psjTkj5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974461; c=relaxed/simple;
	bh=nmJ4ZvLLFI6LL0PkBqcWvO+4q3PB/WXRBiH66z1+dQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2nYGVV5ctrb0leNUBd1hB/Mtn31a3MDcrHhMOYO8XJX3KgTDWtEg9V49bV2yJkMr0uFK7OOfoSJ++9iZN1DtwlJBmQhWHPAWBUaJE2KSaBvMVdtq9uxuN1k6ZK0VFljQwSuLZ1plPNnozVWFOWQ5u23yOiTOdaKXIWWWseonFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=V/O4Svi+; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1739974458;
	bh=nmJ4ZvLLFI6LL0PkBqcWvO+4q3PB/WXRBiH66z1+dQg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=V/O4Svi+fwpZCG27kiFpvgSBNGfGszwoxKf4G6rH6eDYFeADAhn+CV/wAwOgcdCE1
	 XHOVF5zUzW+U4+m3d9vPvOhYZYrF6fDWKhjjitsEta8j+srvVZhS5r28Mnn8b7CFcY
	 p0asKWDa4KoAqEVAH7oVVvou54QriyK62nSYvYao=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 461A31C2556;
	Wed, 19 Feb 2025 09:14:18 -0500 (EST)
Message-ID: <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
Subject: Re: Rust kernel policy
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Christoph Hellwig
	 <hch@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>,  linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Wed, 19 Feb 2025 09:14:17 -0500
In-Reply-To: <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	 <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-19 at 11:05 +0300, Dan Carpenter wrote:
> On Tue, Feb 18, 2025 at 08:08:18AM -0800, Christoph Hellwig wrote:
> > But that also shows how core maintainers are put off by trivial
> > things like checking for integer overflows or compiler enforced
> > synchronization (as in the clang thread sanitizer).
> > How are we're going to bridge the gap between a part of the kernel
> > that is not even accepting relatively easy rules for improving
> > safety vs another one that enforces even strong rules.
> 
> Yeah.  It's an ironic thing...
> 
>         unsigned long total = nr * size;
> 
>         if (nr > ULONG_MAX / size)
>                 return -EINVAL;
> 
> In an ideal world, people who write code like that should receive a
> permanent ban from promoting Rust.

I look at most of the bugfixes flowing through subsystems I watch and a
lot of them are in error legs.  Usually around kfree cockups (either
forgetting or freeing to early).  Could we possibly fix a lot of this
by adopting the _cleanup_ annotations[1]?  I've been working in systemd
code recently and they seem to make great use of this for error leg
simplification.

Regards,

James

[1] https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-cleanup-variable-attribute
https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-cleanup-variable-attribute

