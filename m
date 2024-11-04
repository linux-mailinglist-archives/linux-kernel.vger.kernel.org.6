Return-Path: <linux-kernel+bounces-395489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809BA9BBE9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD6C2827C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05991D5ACE;
	Mon,  4 Nov 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="cuG0pVGR"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6F41D5ACC;
	Mon,  4 Nov 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751066; cv=pass; b=PIb2OrMAynXZSG6CyyGGq1N5xihW3ENGBPQ6E17qUDiW6AowlSOqnTyCSpL9HGAlemMLPKgifQ7EUUwlornj25C3G6smTst+eCTdFXGDMJS9/25aXZEndDloli6NouMegkYCrJ0CrMsynS0+EYK+riPMAMoA1TCMLOMzgnC0rOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751066; c=relaxed/simple;
	bh=4+x9MC5vXV+H0w4kYzXf16x3TkSrj72vXjDhMrMnKys=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c7v0MpW+mgjGXr168DfRvF9HYi1JWwcLyUffgf1MzOLeYKAVHI5NolZ8v1FDwi9aXM4CGk5fg27daNWMYBDTjAf5P9O0q1QciV+YyaiC8doOtuklEblFIldAtXOzMej2rrMXXXEMbFBhp0lGWx59YbtJhHMJlCQgLzHVrIGzUMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=cuG0pVGR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730751046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DNiJTIOq5KyRkwmBjqj2bN1SPvnbtULBgbiNmj/zRF6KoTHddG+LcQ616OBfOquYtxRmCoxBwU0Qe4DtzVprkONFXF+ygOwCYbq9ivlO9//DGljQX48zHfMuVdnMGXQlSxvRAJJxwdJiVTuOaRt6LWSgokjBjzOlGhM4OBa9QNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730751046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zZeWPEoD8myYFBQDadziLxRjtNlmI25spnkRIwgIVC4=; 
	b=JvAwT7Fyaolh9SirD0OmrCo66GJLXI9jLXzUlRxqHRbi9ZS63WjqVrSCemDAf6+RDd0mPRBBiULvR6HCLX8vbfHFsc+uesSntsFMh65Gdeuc6wO1paod86/8GfHn+nk5Nsl5nk+qr3f0OQPQqKcE5tHctavW83IYrTvCr7eXjeI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730751046;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=zZeWPEoD8myYFBQDadziLxRjtNlmI25spnkRIwgIVC4=;
	b=cuG0pVGRSFAsa98gy1TpSu+fgXncfuhl3TG2QhDLzdLCB18Dv+RxCQDGGR4ML7Tn
	oJs1LzoizRXtrDooyUth67pMjljHR7A1sDgDoFOUNYevEAYd6TDf2E+tbPNwZ2uqTnc
	+T2uk5RzlUrACKD/NMaHPMfVwX3lW47ZjcGe7z4g=
Received: by mx.zohomail.com with SMTPS id 1730751045250713.8181828510562;
	Mon, 4 Nov 2024 12:10:45 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] rust: irq: add support for request_irq()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjRJtdpcOZySpRN-keLSMJjJdfXZGOhy_cEbiM3uNU7Tw@mail.gmail.com>
Date: Mon, 4 Nov 2024 17:10:30 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <45D09BD8-208C-4195-BACB-95B0922C5324@collabora.com>
References: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
 <CAH5fLgjRJtdpcOZySpRN-keLSMJjJdfXZGOhy_cEbiM3uNU7Tw@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Alice, thanks for the review!


> On 28 Oct 2024, at 12:29, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> Both regular and threaded versions are supported.
>>=20
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20

Yeah, as I was saying, my latest patches were sent with some provisional
commit messages. Sometimes these things slip through.

In fact, as this was my first time switching to b4, it took me a while =
to
realize I had sent the patches to myself only, so you can see I started =
off
with the =E2=80=9Cwrong foot=E2=80=9D here.

> I left some comments below:
>=20
>> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
>> new file mode 100644
>> index =
0000000000000000000000000000000000000000..4b5c5b80c3f43d482132423c2c52cfa5=
696b7661
>> --- /dev/null
>> +++ b/rust/kernel/irq/request.rs
>> @@ -0,0 +1,450 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright 2019 Collabora ltd.
>=20
> should this be 2024?
>=20
>> +/// The value that can be returned from an IrqHandler;
>> +pub enum IrqReturn {
>> +    /// The interrupt was not from this device or was not handled.
>> +    None =3D bindings::irqreturn_IRQ_NONE as _,
>> +
>> +    /// The interrupt was handled by this device.
>> +    Handled =3D bindings::irqreturn_IRQ_HANDLED as _,
>> +}
>> +
>> +/// Callbacks for an IRQ handler.
>> +pub trait Handler: Sync {
>> +    /// The actual handler function. As usual, sleeps are not =
allowed in IRQ
>> +    /// context.
>> +    fn handle_irq(&self) -> IrqReturn;
>> +}
>> +
>> +/// A registration of an IRQ handler for a given IRQ line.
>> +///
>> +/// # Invariants
>> +///
>> +/// * We own an irq handler using `&self` as its private data.
>=20
> The invariants section is usually last.
>=20
>> +/// # Examples
>> +///
>> +/// The following is an example of using `Registration`:
>> +///
>> +/// ```
>> +/// use kernel::prelude::*;
>> +/// use kernel::irq;
>> +/// use kernel::irq::Registration;
>> +/// use kernel::sync::Arc;
>> +/// use kernel::sync::lock::SpinLock;
>> +///
>> +/// // Declare a struct that will be passed in when the interrupt =
fires. The u32
>> +/// // merely serves as an example of some internal data.
>> +/// struct Data(u32);
>> +///
>> +/// // [`handle_irq`] returns &self. This example illustrates =
interior
>> +/// // mutability can be used when share the data between process =
context and IRQ
>> +/// // context.
>> +/// //
>> +/// // Ideally, this example would be using a version of SpinLock =
that is aware
>> +/// // of `spin_lock_irqsave` and `spin_lock_irqrestore`, but that =
is not yet
>> +/// // implemented.
>> +///
>> +/// type Handler =3D SpinLock<Data>;
>=20
> I doubt this will compile outside of the kernel crate. It fails the
> orphan rule because your driver neither owns the SpinLock type or the
> Handler trait. You should move `SpinLock` inside `Data` instead.
>=20
>> +/// impl kernel::irq::Handler for Handler {
>> +///     // This is executing in IRQ context in some CPU. Other CPUs =
can still
>> +///     // try to access to data.
>> +///     fn handle_irq(&self) -> irq::IrqReturn {
>> +///         // We now have exclusive access to the data by locking =
the SpinLock.
>> +///         let mut handler =3D self.lock();
>> +///         handler.0 +=3D 1;
>> +///
>> +///         IrqReturn::Handled
>> +///     }
>> +/// }
>> +///
>> +/// // This is running in process context.
>> +/// fn register_irq(irq: u32, handler: Handler) -> =
Result<irq::Registration<Handler>> {
>=20
> Please try compiling the example. The return type should be
> Result<Arc<irq::Registration<Handler>>>.

Sorry, I was under the impression that `rustdoc` would compile the =
examples too.

>=20
>> +///     let registration =3D Registration::register(irq, =
irq::flags::SHARED, "my-device", handler)?;
>> +///
>> +///     // You can have as many references to the registration as =
you want, so
>> +///     // multiple parts of the driver can access it.
>> +///     let registration =3D Arc::pin_init(registration)?;
>> +///
>> +///     // The handler may be called immediately after the function =
above
>> +///     // returns, possibly in a different CPU.
>> +///
>> +///     // The data can be accessed from the process context too.
>> +///     registration.handler().lock().0 =3D 42;
>> +///
>> +///     Ok(registration)
>> +/// }
>> +///
>> +/// # Ok::<(), Error>(())
>> +///```
>> +#[pin_data(PinnedDrop)]
>> +pub struct Registration<T: Handler> {
>> +    irq: u32,
>> +    #[pin]
>> +    handler: Opaque<T>,
>> +}
>> +
>> +impl<T: Handler> Registration<T> {
>> +    /// Registers the IRQ handler with the system for the given IRQ =
number. The
>> +    /// handler must be able to be called as soon as this function =
returns.
>> +    pub fn register(
>> +        irq: u32,
>> +        flags: Flags,
>> +        name: &'static CStr,
>=20
> Does the name need to be 'static?

Actually, the lifetime relationship that we want to express here is that =
`name` should
live for at least as long as &self.

Most of the time in C, this is solved by having `name` point to a =
statically allocated string,
usually a string literal, so this version of the patch implemented that.

What about:

```
Registration<=E2=80=98a> {
	name: PhantomData<&=E2=80=98a CStr>
}
```

Where calling register() with some c_str!(=E2=80=9Cfoo=E2=80=9D) would =
create a Registration<=E2=80=99static>
anyways?


>> +        handler: T,
>> +    ) -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {
>> +            irq,
>> +            handler: Opaque::new(handler)
>> +        })
>> +        .pin_chain(move |slot| {
>> +            // SAFETY:
>> +            // - `handler` points to a valid function defined below.
>> +            // - only valid flags can be constructed using the =
`flags` module.
>> +            // - `devname` is a nul-terminated string with a 'static =
lifetime.
>> +            // - `ptr` is a cookie used to identify the handler. The =
same cookie is
>> +            // passed back when the system calls the handler.
>> +            to_result(unsafe {
>> +                bindings::request_irq(
>> +                    irq,
>> +                    Some(handle_irq_callback::<T>),
>> +                    flags.0,
>> +                    name.as_char_ptr(),
>> +                    &*slot as *const _ as *mut core::ffi::c_void,
>=20
> Can simplify to `slot as *mut c_void` or `slot.cast()`.
>=20
>> +                )
>> +            })?;
>> +
>> +            Ok(())
>> +        })
>> +    }
>> +
>> +    /// Returns a reference to the handler that was registered with =
the system.
>> +    pub fn handler(&self) -> &T {
>> +        // SAFETY: `handler` is initialized in `register`.
>> +        unsafe { &*self.handler.get() }
>=20
> This relies on T being Sync as it could also get accessed by the irq
> handler in parallel. You probably want the SAFETY comment to mention
> that.
>=20
>> +    }
>> +}
>> +
>> +#[pinned_drop]
>> +impl<T: Handler> PinnedDrop for Registration<T> {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // SAFETY:
>> +        // - `self.irq` is the same as the one passed to =
`reques_irq`.
>> +        // -  `&self` was passed to `request_irq` as the cookie. It =
is
>> +        // guaranteed to be unique by the type system, since each =
call to
>> +        // `register` will return a different instance of =
`Registration`.
>> +        //
>> +        // Notice that this will block until all handlers finish =
executing, so,
>> +        // at no point will &self be invalid while the handler is =
running.
>> +        unsafe { bindings::free_irq(self.irq, &*self as *const _ as =
*mut core::ffi::c_void) };
>=20
> I can't tell if this creates a pointer to the Registration or a
> pointer to a pointer to the Registration. Please spell out the type:
> ```
> &*self as *const Self as *mut core::ffi::c_void
> ```

My thought process here is that Pin<Ptr<T>> dereferences to Ptr::Target, =
i.e. Self,
which is then borrowed, i.e. &Self.

I do not see how this can create a pointer to a pointer, but you=E2=80=99r=
e right, it=E2=80=99s
always good to be more explicit by spelling out the full type. I will =
fix that.


>=20
>> +    }
>> +}
>> +
>> +/// The value that can be returned from =
`ThreadedHandler::handle_irq`.
>> +pub enum ThreadedIrqReturn {
>> +    /// The interrupt was not from this device or was not handled.
>> +    None =3D bindings::irqreturn_IRQ_NONE as _,
>> +
>> +    /// The interrupt was handled by this device.
>> +    Handled =3D bindings::irqreturn_IRQ_HANDLED as _,
>> +
>> +    /// The handler wants the handler thread to wake up.
>> +    WakeThread =3D bindings::irqreturn_IRQ_WAKE_THREAD as _,
>> +}
>> +
>> +/// The value that can be returned from =
`ThreadedFnHandler::thread_fn`.
>> +pub enum ThreadedFnReturn {
>> +    /// The thread function did not make any progress.
>> +    None =3D bindings::irqreturn_IRQ_NONE as _,
>> +
>> +    /// The thread function ran successfully.
>> +    Handled =3D bindings::irqreturn_IRQ_HANDLED as _,
>> +}
>=20
> This is the same as IrqReturn?

Thanks for noticing this. It indeed ended up as the same type after all.

>=20
>> +/// Callbacks for a threaded IRQ handler.
>> +pub trait ThreadedHandler: Sync {
>> +    /// The actual handler function. As usual, sleeps are not =
allowed in IRQ
>> +    /// context.
>> +    fn handle_irq(&self) -> ThreadedIrqReturn;
>> +
>> +    /// The threaded handler function. This function is called from =
the irq
>> +    /// handler thread, which is automatically created by the =
system.
>> +    fn thread_fn(&self) -> ThreadedFnReturn;
>> +}
>=20
> Most of my comments above also reply to ThreadedHandler.
>=20
> Alice

=E2=80=94 Daniel


