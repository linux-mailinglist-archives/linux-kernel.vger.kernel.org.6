Return-Path: <linux-kernel+bounces-533443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE1BA45A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58BB3A526D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8BF238157;
	Wed, 26 Feb 2025 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+XlRRuo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F513238140;
	Wed, 26 Feb 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562980; cv=none; b=U6TEDIUh/Uq/9Y3cF632LnV5eHXb9I/zVdRc3ft4FwvkPE4GL87jSpFpfU68dQ2GIzYfijuc+LG2Dwv/9Ej5+y+jkKT1qcxsXNRkXxjaJ4gXfmvVTwVHwMC8hyILTJfDsOj6XCk9M9EVrz4VAEp1bxXuao4IOQzCNMdgaPfAdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562980; c=relaxed/simple;
	bh=fqSdCAw3iG+/gf4XMmrjEA97tSNw5S/67jAUlLyL7GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9pmkclO2Mg9ApvPwLsmF7qtSMRyKiJc/fIZ1Rz6Zwsprt25xZTV/5C5y9ViC1lhocRFjeHcyxjHVk5cr0ys0UJXQJsXtIiDmK+AcG97b1oqTcDP/B/KANnT6qOttVWYobl/qqWFiejsPN2jF2V8uF/CX7oblDM1AK7Cajpw81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+XlRRuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF646C4CED6;
	Wed, 26 Feb 2025 09:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740562980;
	bh=fqSdCAw3iG+/gf4XMmrjEA97tSNw5S/67jAUlLyL7GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+XlRRuoSFUbZ5QGi2r5vT/WJZaIQz201WqIZOJr19smd78wE84r+ZfPY2ovFkX59
	 /YCsBnFZmn06jfDrbgv4WQwTWl1JkLHOhEO0gNPE9OGdl+As5lQEH0HuCds+2ITFic
	 5gC5OhJvTxAwGxvE3oYJWAiYjwcaYtgNb8yvNFIW62IInEbucRWpCzowJSJn7McNIR
	 yjlqCxcLlMeNBY2xTfOSKogY0qFWtXclYsTIM5x/p2X6uEWh81AD+oILju2wJ5x4zh
	 iuF0lf7a87gVqc2sGEQvwNGIOzVy7YQKo9l8S7NSn8YNPeBzFZCXBXK17jUmi6Fei/
	 5eXjuQlYgGovQ==
Date: Wed, 26 Feb 2025 10:42:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: kernel@dakr.org, a.hindborg@kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, lyude@redhat.com,
	mairacanal@riseup.net, ojeda@kernel.org, rafael@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to
 Registration::new()
Message-ID: <Z77iHj56551mDybd@pollux>
References: <ea2466c4d250ff953b3be9602a3671fb@dakr.org>
 <20250226092339.989767-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226092339.989767-1-aliceryhl@google.com>

On Wed, Feb 26, 2025 at 09:23:39AM +0000, Alice Ryhl wrote:
> On Wed, Feb 26, 2025 at 10:06 AM <kernel@dakr.org> wrote:
> >
> > On 2025-02-26 09:38, Alice Ryhl wrote:
> > > On Tue, Feb 25, 2025 at 10:31 PM Lyude Paul <lyude@redhat.com> wrote:
> > >>
> > >> A little late in the review of the faux device interface, we added the
> > >> ability to specify a parent device when creating new faux devices -
> > >> but
> > >> this never got ported over to the rust bindings. So, let's add the
> > >> missing
> > >> argument now so we don't have to convert other users later down the
> > >> line.
> > >>
> > >> Signed-off-by: Lyude Paul <lyude@redhat.com>
> > >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> ---
> > >>  rust/kernel/faux.rs              | 10 ++++++++--
> > >>  samples/rust/rust_driver_faux.rs |  2 +-
> > >>  2 files changed, 9 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> > >> index 41751403cd868..ae99ea3d114ef 100644
> > >> --- a/rust/kernel/faux.rs
> > >> +++ b/rust/kernel/faux.rs
> > >> @@ -23,11 +23,17 @@
> > >>
> > >>  impl Registration {
> > >>      /// Create and register a new faux device with the given name.
> > >> -    pub fn new(name: &CStr) -> Result<Self> {
> > >> +    pub fn new(name: &CStr, parent: Option<&device::Device>) ->
> > >> Result<Self> {
> > >>          // SAFETY:
> > >>          // - `name` is copied by this function into its own storage
> > >>          // - `faux_ops` is safe to leave NULL according to the C API
> > >> -        let dev = unsafe {
> > >> bindings::faux_device_create(name.as_char_ptr(), null_mut(), null())
> > >> };
> > >> +        let dev = unsafe {
> > >> +            bindings::faux_device_create(
> > >> +                name.as_char_ptr(),
> > >> +                parent.map_or(null_mut(), |p| p.as_raw()),
> > >> +                null(),
> > >
> > > This function signature only requires that `parent` is valid for the
> > > duration of this call to `new`, but `faux_device_create` stashes a
> > > pointer without touching the refcount. How do you ensure that the
> > > `parent` pointer does not become dangling?
> >
> > I was wondering the same, but it seems that the subsequent device_add()
> > call takes care of that:
> >
> > https://elixir.bootlin.com/linux/v6.14-rc3/source/drivers/base/core.c#L3588
> >
> > device_del() drops the reference.
> >
> > This makes device->parent only valid for the duration between
> > faux_device_create() and faux_device_remove().
> >
> > But this detail shouldn’t be relevant for this API.
> 
> I think this could use a few more comments to explain it. E.g.:
> 
> diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> index 531e9d789ee0..674db8863d96 100644
> --- a/drivers/base/faux.c
> +++ b/drivers/base/faux.c
> @@ -131,6 +131,7 @@ struct faux_device *faux_device_create_with_groups(const char *name,
>  
>         device_initialize(dev);
>         dev->release = faux_device_release;
> +       /* The refcount of dev->parent is incremented in device_add. */

Yeah, this one is a bit odd to rely on a subsequent device_add() call, it
clearly deserves a comment.

>         if (parent)
>                 dev->parent = parent;
>         else
> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 7673501ebe37..713ee6842e3f 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs
> @@ -28,6 +28,7 @@ pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<Self> {
>          // SAFETY:
>          // - `name` is copied by this function into its own storage
>          // - `faux_ops` is safe to leave NULL according to the C API
> +        // - `faux_device_create` ensures that `parent` stays alive until `faux_device_destroy`.

Not sure that's a safety requirement for faux_device_create().

The typical convention is that a caller must hold a reference to the object
behind the pointer when passing it to another function. If the callee decides
to store the pointer elsewhere, it's on the callee to take an additional
reference.

I think if we want to add something to the safety comment, it should be somthing
along the line of "the type of `parent` implies that for the duration of this
call `parent` is a valid device with a non-zero reference count".

>          let dev = unsafe {
>              bindings::faux_device_create(
>                  name.as_char_ptr(),
> 

