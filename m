Return-Path: <linux-kernel+bounces-344003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53CC98A265
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4731F20F25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDDF18E354;
	Mon, 30 Sep 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PDnoEoDx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3404155312;
	Mon, 30 Sep 2024 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699285; cv=none; b=LGAI0jdiVxh3ENQEpHVi8skdXEJwQs5AqQVRy7ZKW/u8pcvpQ24jS3CLOcndd9dLwzcT03Ioh7pDvEno6XA8P9yGvGyBWmedMMbrY5GoFemsIdyV7I13cBby5g5zdwA/k3gSjA5gX3+nqZ0Kcxv3H5gSKDTCc4qJkrFH7ZUvLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699285; c=relaxed/simple;
	bh=olQxUjUujOS4T2mMsKlVpArogN+6ojBSjpk7l3yrKUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOYQtQV3don3I7y0PJQSbgkKaQF0ZyIT+DX5GqX/rLOS66shfe8vIwpXlleqk8ZjrKM+QdB7b85GghARwxLagkFLYpKmq3Q3ws5GAWgIEMP2qVLXS7tpu8cdJHiLvgCClChEXvVviMYsEM6N1v6LSyWKTEwqseqbsjppEPdFD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PDnoEoDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A29C4CEC7;
	Mon, 30 Sep 2024 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727699284;
	bh=olQxUjUujOS4T2mMsKlVpArogN+6ojBSjpk7l3yrKUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDnoEoDx+oFzJvOOvKAJtY6bGmWa5I4u8arSiXVp3a9kCOKyyVRpfvsonqsMQlIeP
	 K0suLCrAONic75rDBMEkhcGs+ukBAg0f17c4imGqCo+XLDL0eKNGcN88cjOziRqeXO
	 /z8msEfzlIGhIrkSGD4AzFDjlhvU9aQ94FS9UWGw=
Date: Mon, 30 Sep 2024 14:28:01 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Guilherme =?iso-8859-1?Q?Gi=E1como_Sim=F5es?= <trintaeoitogc@gmail.com>,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] device: rust: change the name function
Message-ID: <2024093035-stream-chowder-3b95@gregkh>
References: <CAM_RzfbQK5fzqXQN89JCEzD1Bz5ZtQdAz3xD0yaYFx_GC7Pm0Q@mail.gmail.com>
 <2024093044-emblaze-disrupt-d479@gregkh>
 <ZvqVedQhdyiWREcd@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvqVedQhdyiWREcd@pollux>

On Mon, Sep 30, 2024 at 02:11:37PM +0200, Danilo Krummrich wrote:
> On Mon, Sep 30, 2024 at 01:35:09PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > >      /// While not officially documented, this should be the case for
> > > any `struct device`.
> > > -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> > > +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
> > 
> > With this change, nothing broke?  Does nothing call this code yet?  I
> > thought the firmware interface did that, but I could be wrong...
> 
> The firmware code uses the `Device` structure, but it doesn't create a
> reference from a raw pointer.
> 
> This function should probably only ever be called from bus abstractions. I
> thought the PHY layer needed this urgently (which also was the reason we merged
> it already), so I'd expect the PHY code to use it.
> 
> Though, they might just use `as_ref`.

Ah, then no harm in renaming it now, great!

When it's resent in a way we can apply it, I'll be glad to queue it up.

thanks,

greg k-h

