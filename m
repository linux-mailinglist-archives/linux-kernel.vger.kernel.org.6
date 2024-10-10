Return-Path: <linux-kernel+bounces-360082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552499943F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA91F2856E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966E81E285E;
	Thu, 10 Oct 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aD+NPpQb"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89D1E32C5;
	Thu, 10 Oct 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594325; cv=pass; b=mPqVyY8PajdPbOtor7GsaOwjUETjGk/v6R/Upf+9W7tEYYcQbltcig6DGNyc+DnHdrlal9kcKso8m0EOdtoa7yBL7Bqyi6aF97/Z1N/aZAn4Kb8uHyVlw8wjbNpbru0IFAiMy4p+cZoxmQCWMuee6Y/ZY9A5kvNHhVlmtRBAWeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594325; c=relaxed/simple;
	bh=AyzvQX4BvqiEXeegFCAAuOQqgfifSbkORUuQC8kOYEI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T+l6wxSXtj36NwabtziueP4IfjdtE8M0H+cX8YZWfj3Jq4SVwRxuMbUzV9v6Fe7/7jKfDBXBHAjdFE4RLCGPpa+xer+pFbKeTddADlfnWsaC91vGs5tQ6MtNWLMwwsolwZmqyUQ1hPR2byTLBB7JaD7rdf4S+jjkitKLXrgBNuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aD+NPpQb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728594274; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cYlyaeIHYTwyfmbnfzSInpDN1qo7N37ZUk7euOLlMT+gcvzBMbi9HhztMGAdjSIAiOZYic165AA3mz57xI4ebh25ACbP7ZIqT35Gt+b8PwrFoxuOAoGNoO9Y1DvxYi0cgOiDteOh7hcvOCXBqFFVqwTUFLbG14RPiQ6cNhKHKjs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728594274; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MqVYCQFj+yKHI41/NIewCZ7t8Wq2doPeQIymj6djC1M=; 
	b=QAIFD6CXBjJyv08QigWVulWNPPz1LmdlmebQc0bjInFwxnKttv7NHKU9oRUPwY4A5OZNw4Mzt+lj/0OZPdopeguC6g/+081h0BUJqpbesCnMP2wF38LCZi/Bn0/KY4CpmLg/LwynfZZGYxJxrPrM6raxqYcEw1sZucqdEhGKaR0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728594274;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=MqVYCQFj+yKHI41/NIewCZ7t8Wq2doPeQIymj6djC1M=;
	b=aD+NPpQbVrLRKciiWpBmI3tSjtCxeufeo+cqsbHO+QQLfYca0Z/TUjy5Rhk/uHlG
	iyCIp4odqeUYxE8p2jg1qVhYhMX/X0y8feDgVBxCaLVMkyIaJvIMe1myuQBIi9o1w15
	2eWKQxDayooDBcki8aXRcDyiakKC4ofY7LClO2aE=
Received: by mx.zohomail.com with SMTPS id 1728594273134157.01325990589646;
	Thu, 10 Oct 2024 14:04:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v6 1/3] rust: Introduce irq module
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240916213025.477225-2-lyude@redhat.com>
Date: Thu, 10 Oct 2024 18:00:52 -0300
Cc: rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org,
 Benno Lossin <benno.lossin@proton.me>,
 Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92D047CB-EF1E-4749-86DD-7A8226C45031@collabora.com>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-2-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-ZohoMailClient: External


Hi Lyude.


> On 16 Sep 2024, at 18:28, Lyude Paul <lyude@redhat.com> wrote:
>=20
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions =
as
> expecting that IRQs are already disabled on the local CPU.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>=20
> ---
>=20
> V2:
> * Actually make it so that we check whether or not we have interrupts
>  disabled with debug assertions
> * Fix issues in the documentation (added suggestions, missing periods, =
made
>  sure that all rustdoc examples compile properly)
> * Pass IrqDisabled by value, not reference
> * Ensure that IrqDisabled is !Send and !Sync using
>  PhantomData<(&'a (), *mut ())>
> * Add all of the suggested derives from Benno Lossin
>=20
> V3:
> * Use `impl` for FnOnce bounds in with_irqs_disabled()
> * Use higher-ranked trait bounds for the lifetime of =
with_irqs_disabled()
> * Wording changes in the documentation for the module itself
>=20
> V4:
> * Use the actual unsafe constructor for IrqDisabled in
>  with_irqs_disabled()
> * Fix comment style in with_irqs_disabled example
> * Check before calling local_irq_restore() in with_irqs_disabled that
>  interrupts are still disabled. It would have been nice to do this =
from a
>  Drop implementation like I hoped, but I realized rust doesn't allow =
that
>  for types that implement Copy.
> * Document that interrupts can't be re-enabled within the `cb` =
provided to
>  `with_irqs_disabled`, and link to the github issue I just filed about
>  this that describes the solution for this.
>=20
> V5:
> * Rebase against rust-next for the helpers split
> * Fix typo (enabled -> disabled) - Dirk
>=20
> V6:
> * s/indicate/require/ in IrqDisabled docs
> * Reword comment above with_irqs_disabled in code example requested by
>  Benno
> * Add paragraph to with_irqs_disabled docs requested by Benno
> * Apply the comments from Boqun's review for V4 that I missed
> * Document type invariants of `IrqDisabled`
>=20
> This patch depends on
> =
https://lore.kernel.org/rust-for-linux/ZuKNszXSw-LbgW1e@boqun-archlinux/
>=20
> ---
> rust/helpers/helpers.c |  1 +
> rust/helpers/irq.c     | 22 ++++++++++
> rust/kernel/irq.rs     | 96 ++++++++++++++++++++++++++++++++++++++++++
> rust/kernel/lib.rs     |  1 +
> 4 files changed, 120 insertions(+)
> create mode 100644 rust/helpers/irq.c
> create mode 100644 rust/kernel/irq.rs
>=20
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a96..0bb48df454bd8 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -12,6 +12,7 @@
> #include "build_assert.c"
> #include "build_bug.c"
> #include "err.c"
> +#include "irq.c"
> #include "kunit.c"
> #include "mutex.c"
> #include "page.c"
> diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
> new file mode 100644
> index 0000000000000..ec1e8d700a220
> --- /dev/null
> +++ b/rust/helpers/irq.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/irqflags.h>
> +
> +unsigned long rust_helper_local_irq_save(void)
> +{
> + unsigned long flags;
> +
> + local_irq_save(flags);
> +
> + return flags;
> +}
> +
> +void rust_helper_local_irq_restore(unsigned long flags)
> +{
> + local_irq_restore(flags);
> +}
> +
> +bool rust_helper_irqs_disabled(void)
> +{
> + return irqs_disabled();
> +}
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 0000000000000..ee3a4549aa389
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to control processor interrupts. =
[`with_irqs_disabled()`] may be
> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] =
can be used for annotating code
> +//! that requires interrupts to be disabled.
> +
> +use bindings;
> +use core::marker::*;
> +use crate::types::NotThreadSafe;

Missing rustfmt on this file

> +
> +/// A token that is only available in contexts where IRQs are =
disabled.
> +///
> +/// [`IrqDisabled`] is marker made available when interrupts are not =
active. Certain functions take
> +/// an [`IrqDisabled`] in order to require that they may only be run =
in IRQ-free contexts.
> +///
> +/// This is a marker type; it has no size, and is simply used as a =
compile-time guarantee that
> +/// interrupts are disabled where required.
> +///
> +/// This token can be created by [`with_irqs_disabled`]. See =
[`with_irqs_disabled`] for examples and
> +/// further information.
> +///
> +/// # Invariants
> +///
> +/// IRQs are disabled when an object of this type exists.
> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), NotThreadSafe)>);
> +
> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] token in an interrupt disabled =
context.
> +    ///
> +    /// This creates an [`IrqDisabled`] token, which can be passed to =
functions that must be run
> +    /// without interrupts. If debug assertions are enabled, this =
function will assert that
> +    /// interrupts are disabled upon creation. Otherwise, it has no =
size or cost at runtime.
> +    ///
> +    /// # Panics
> +    ///
> +    /// If debug assertions are enabled, this function will panic if =
interrupts are not disabled
> +    /// upon creation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is =
already known that interrupts have
> +    /// been disabled for the current CPU, and the user is making a =
promise that they will remain
> +    /// disabled at least until this [`IrqDisabled`] is dropped.
> +    pub unsafe fn new() -> Self {
> +        // SAFETY: FFI call with no special requirements
> +        debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +        // INVARIANT: The safety requirements of this function ensure =
that IRQs are disabled.
> +        Self(PhantomData)
> +    }
> +}
> +
> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This disables interrupts, creates an [`IrqDisabled`] token and =
passes it to `cb`. The previous
> +/// interrupt state will be restored once the closure completes. Note =
that interrupts must be
> +/// disabled for the entire duration of `cb`, they cannot be =
re-enabled. In the future, this may be
> +/// expanded on [as documented =
here](https://github.com/Rust-for-Linux/linux/issues/1115).
> +///
> +/// # Examples
> +///
> +/// Using [`with_irqs_disabled`] to call a function that can only be =
called with interrupts
> +/// disabled:
> +///
> +/// ```
> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> +///
> +/// // Requiring interrupts be disabled to call a function
> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> +///     // When this token is available, IRQs are known to be =
disabled. Actions that rely on this
> +///     // can be safely performed
> +/// }
> +///
> +/// // Disables interrupts, their previous state will be restored =
once the closure completes.
> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) =
-> T) -> T {
> +    // SAFETY: FFI call with no special requirements
> +    let flags =3D unsafe { bindings::local_irq_save() };
> +
> +    // SAFETY: We just disabled IRQs using `local_irq_save()`
> +    let ret =3D cb(unsafe { IrqDisabled::new() });
> +
> +    // Confirm that IRQs are still disabled now that the callback has =
finished
> +    // SAFETY: FFI call with no special requirements
> +    debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +    // SAFETY: `flags` comes from our previous call to local_irq_save
> +    unsafe { bindings::local_irq_restore(flags) };
> +
> +    ret
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f10b06a78b9d5..df10c58e95c19 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
> pub mod firmware;
> pub mod init;
> pub mod ioctl;
> +pub mod irq;
> #[cfg(CONFIG_KUNIT)]
> pub mod kunit;
> pub mod list;
> --=20
> 2.46.0
>=20

=E2=80=94Daniel


