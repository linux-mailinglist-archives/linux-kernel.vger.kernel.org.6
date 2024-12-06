Return-Path: <linux-kernel+bounces-434909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12A9E6CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F0165CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F51FC107;
	Fri,  6 Dec 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVFeU+xb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A331AD9F9;
	Fri,  6 Dec 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482644; cv=none; b=c4+jyrKYabzhikyEa4WOEjqwxhBPs7GmuLHjTe4mWVJ59VHWZNByiCiT7+OJ2bdSnCTXPrkAOOrqklvGcuLI1qBsmCsksrLCEg16ugp1wkhLBn+JagbY0LkQni1XUpQ7dZ24bVaUXvPS6QYNPhIL33D9n5k+pH9uHQhjWBqB6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482644; c=relaxed/simple;
	bh=493X2n2vOfE1OgV61+WHiLcT3iF4s0GbKho/Bs2KECs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnY2MavdcRghzQSCpMhL2k4ihv7723ILP/JI+wsvNbQkTrYy5zt0ILPTnWGtagtuDNz/7NfAf4P3aWT/OxnfFYdJ9pSqMcmZAMCCmooCujSs+Ln+qLz2yxBRZdMWw/U/eA++kOCILa5pEyrVoVFaqp5Q8IKrbOoyG3pdmdFdmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVFeU+xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51D3C4CED1;
	Fri,  6 Dec 2024 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733482643;
	bh=493X2n2vOfE1OgV61+WHiLcT3iF4s0GbKho/Bs2KECs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVFeU+xbCvIa0Jc6cMBM9h0lDiBmHcH8i4e6U2x/8E7avEZ7t/77kpNkIARCexwXB
	 9srV0pZ0Qk2m22ETzbmDwrrgQbGBE1xxXwedOqMxUYKGxKX33y5+CQrvmqOe2jAGVv
	 kgiTrJFrV6K9Buj8WF26sa2fyRw6nHfutq6882t860DwK7EiqImE/2zF1hTProqo7f
	 9DmHzSKLQFVmhMD/qCkLS4YCiZvKsNDRs+wsWzLIV8P97u9EVNaGTXeuEr67mRZ36F
	 oR1xqK0Bv3vYVck9ZJXtJ1f740ZL9CHiAjnH3AZYbXujzX7qaGwPZ5iROAdca/r3Mo
	 puj/foDpgHBoA==
Date: Fri, 6 Dec 2024 11:57:18 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jimmy Ostler <jtostler1@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, felipe_life@live.com, gary@garyguo.net,
	kernel@valentinobst.de, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v2] rust: alloc: Add doctest for `ArrayLayout`
Message-ID: <Z1LYjiwaE8iDPj3H@pollux>
References: <Z1GP-QPDFDjS6qLo@cassiopeiae>
 <20241205230429.1067406-1-jtostler1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205230429.1067406-1-jtostler1@gmail.com>

On Thu, Dec 05, 2024 at 03:04:28PM -0800, Jimmy Ostler wrote:
> On Thu, Dec 5, 2024 at 3:35 AM Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Hi Jimmy,
> >
> > Thanks for the patch!
> >
> > On Thu, Dec 05, 2024 at 02:56:27AM -0800, Jimmy Ostler wrote:
> > > Add a rustdoc example and Kunit test to the `ArrayLayout` struct's
> > > `ArrayLayout::new()` function.
> > >
> > > Add an implementation of `From<LayoutError> for Error` for the
> > > `kernel::alloc::LayoutError`. This is necessary for the new test to
> > > compile.
> >
> > Please split this into a separate patch.
> 
> Got it, the next version will be split into separate patches.
> 
> > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > index 52c502432447..ac8526140d7a 100644
> > > --- a/rust/kernel/error.rs
> > > +++ b/rust/kernel/error.rs
> > > @@ -4,9 +4,10 @@
> > >  //!
> > >  //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
> > > 
> > > -use crate::{alloc::AllocError, str::CStr};
> > > -
> > > -use core::alloc::LayoutError;
> > > +use crate::{
> > > +    alloc::{layout::LayoutError, AllocError},
> > > +    str::CStr,
> > > +};
> >
> > I think this part of the change would be enough, since we don't make use of the
> > `From` implementation of `core::alloc::LayoutError` anywhere.
> >
> > I think we can add it (again), once it's needed.
> 
> Okay, that makes sense. It is still used in the documentation for the
> macro `stack_try_pin_init`, and it is hidden and not used as a test, but
> it would probably be prudent to change that for consistency, as
> `Box::new` no longer returns `core::alloc::AllocError`.

It seems you're confusing `LayoutError` and `AllocError` here.

This is about the former. But you're right that `AllocError` can be fixed up in
a few places too.

Do you plan to send a patch for this as well?

> I can add that into the v3 patchset, unless there's some reason we
> should leave it.
> 
> > > 
> > >  use core::fmt;
> > >  use core::num::NonZeroI32;
> > > @@ -223,6 +224,12 @@ fn from(_: LayoutError) -> Error {
> > >      }
> > >  }
> > > 
> > > +impl From<core::alloc::LayoutError> for Error {
> > > +    fn from(_: core::alloc::LayoutError) -> Error {
> > > +        code::ENOMEM
> > > +    }
> > > +}
> > > +
> > >  impl From<core::fmt::Error> for Error {
> > >      fn from(_: core::fmt::Error) -> Error {
> > >          code::EINVAL
> > >
> > > base-commit: 1dc707e647bc919834eff9636c8d00b78c782545
> > > --
> > > 2.47.1
> > >
> 
> Thanks!
> 
> Jimmy Ostler

