Return-Path: <linux-kernel+bounces-372591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D69A4AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B011F2124C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630F6193416;
	Sat, 19 Oct 2024 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwHTPF0v"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DD36C;
	Sat, 19 Oct 2024 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729299803; cv=none; b=g5lITUECaIxOdGPCJKzW3UbsbGOvcjDHw5aFNUuFeE4NmpHI9Z3xW6w2Dk6FMKm1HsGFh4Bt819oGSrK9q1NwCxrddpD8YhdCMBwR884q3S8lHeZkL4Gp4TQWMkxINFg9cxAT3RgOGZtAbOccrx7vA2GzpbYHFpMRd34xcR87hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729299803; c=relaxed/simple;
	bh=XJ20+2M9kmFE3OQoOiW0tN/yYTRLldsVa1t0EtnnltU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GahA/H7CL5LBGGJTJ+MWvL1S2J+PPRJyJhs04dOei7PrVNyeSpzrLDg2tNtAGzHPsBS1pARe9VMcfuwLdTML6cw6S2Jh/PA9ara3Ih+FJ+yzrs1PC3a9tE1zcYCCF/riYAMU+hzB5c+T8/0lx7HjxFJ7PO2A38Kvx/RyulMw518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwHTPF0v; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460c2418e37so321251cf.0;
        Fri, 18 Oct 2024 18:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729299798; x=1729904598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlPYJZaQP8Fj05Oo19XFduawLBLRxaNYP6oof4b5/K4=;
        b=hwHTPF0vIeX4/HMYFnoSP2MKwxLWzCpdC6EDxJZmupDtiTOdN8/w70SxqSbtMZtlg9
         NVhbvP4VnLSIk3K74jA+lAWYEwsr+0cGtsW3Sq/3gA4E1V9fehQHA4cbLrTuIDv41j5L
         nC37TlJTXYdw2I0lfj3PDfG3V6/F/rhhbSbASLMmbJjhSZB4Iow5IXR94u5V4q+vYgxc
         2gHUJW8zFpcBQh5aKMKRpZ17RiMZ8dWdO0SiVVjameY4o4a1hiuKIK5fjt1t8Mxdd9Z4
         v3v7qKcrljzg/G5U1JJS5ozcabY69zZ6TFxaTTqn6CWm4r6u3lpuo3ViY7FMEkuCilfo
         Bbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729299798; x=1729904598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlPYJZaQP8Fj05Oo19XFduawLBLRxaNYP6oof4b5/K4=;
        b=KoIpR3codLaWbkHbSbgEnLScJYZqL7uPPiay3Fss91ipe/qCSdpeVD9COcvbCh8WyN
         1d/xyA/Gz3CitgeuaL2vopPfalQ+rGrcJS0NQ6la+PiaYkWkfuQK0hfbC3gLwkoXgkmz
         CWsiqidxn01TjlaxUwugT/HM6HCfFoI1x8vyum6UMkYWiB195f3U/d5xoY+BoLStKvup
         z9BMaXbyIJ0f0EcM1o6HX81PQuqsPAdpwzyX/D4Gt4ylRWmTo0KXrzjOJohd1pJ6y5aB
         XRKHv5kvU3FyARhP4RJMhP/qEbsVqO1FRH+VV/WAPwT/k8IJTc6xk5z4MiLjI7NQeh/9
         ejaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW81o5rhrjaWjJyz4tYlQzht1tPtWB1TUeiN+Asu9nMazHnpRmSkJVtVvqvRMk4K31INNL1dMNemSrsfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybVJGfmSGhTkD4JAAhSPJ2KPsTNMVTUd9LVMH7R+vYGi4II63C
	vyG2idDfJYCGsnJIvlg5uZxDcwFSB0UzypL0mFrFW74tmouwcxB7
X-Google-Smtp-Source: AGHT+IGR3MXpnANxTUeAFjtmp3C3IK2vauQ30it8XfX3zIUmKybP1+8r45yjyUUgI3OnR5NxQjt1zg==
X-Received: by 2002:ac8:5814:0:b0:460:8f0a:511c with SMTP id d75a77b69052e-460aedde522mr61663581cf.46.1729299797637;
        Fri, 18 Oct 2024 18:03:17 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde122a159sm12104156d6.100.2024.10.18.18.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 18:03:17 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41ACC1200066;
	Fri, 18 Oct 2024 21:03:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 18 Oct 2024 21:03:16 -0400
X-ME-Sender: <xms:VAUTZx3CBiRRuKdoDrQx-426zgfRmYBKcd2fyRa8K_I93TVpigBlHw>
    <xme:VAUTZ4HQ-MkXLlJIQqk3FBC7BYZoRrjwk44PyaBs9vdJyzeMFXFmUlrQ53JdHKNl3
    Z17rtjy0y0iZIGGNA>
X-ME-Received: <xmr:VAUTZx4FkZab8BRBjvIVjPvVMBfofOLcBRddL-kcbO2tslY4WpbSko4Ynd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegueehkeeijeegteegtdduhedvhfdvieettdei
    vdeuhfeigeevteffhfelteejteenucffohhmrghinhepghgvthdrmhgrphdprhhushhtqd
    hlrghnghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvuges
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhm
    rghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:VAUTZ-2N42aH--ced-Xkr4_P-zuEAeFyIIaGvSqqS6kMXpmeoCe9Vg>
    <xmx:VAUTZ0EgJtllGey8xWIkpX9PlLEdIUQERw-xa1mY9iSz18JtFaIu9w>
    <xmx:VAUTZ_-9CFGjH-8q5jOk4Wh3RAM9dnK2TwRAeR3GvwOQI7vq_RfKNg>
    <xmx:VAUTZxmRHRcbmpQfDwSeQjVI690bnXoYmBbeQq4uNe3NA63QdJS7bQ>
    <xmx:VAUTZ4EKsOE7y_nL7plpuSjgqZGzZ3yw7yVnUI_B3vwxSnWkiSSk9Qkr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 21:03:15 -0400 (EDT)
Date: Fri, 18 Oct 2024 18:03:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Filipe Xavier <felipe_life@live.com>, Fiona Behrens <me@kloenk.dev>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v8 2/3] rust: sync: Introduce lock::Backend::Context and
 lock::BackendWithContext
Message-ID: <ZxMFUpBnNTRC_cD3@Boquns-Mac-mini.local>
References: <20241018232306.476664-1-lyude@redhat.com>
 <20241018232306.476664-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018232306.476664-3-lyude@redhat.com>

On Fri, Oct 18, 2024 at 07:22:26PM -0400, Lyude Paul wrote:
> Now that we've introduced an `IrqDisabled` token for marking contexts in
> which IRQs are disabled, we need a way to be able to pass it to locks that
> require that IRQs are disabled. In order to continue using the
> `lock::Backend` type instead of inventing our own thing, we accomplish this
> by adding the associated Context type, along with a `lock_with()` function
> that can accept a Context when acquiring a lock. To allow current users of
> context-less locks to keep using the normal `lock()` method, we take an
> example from Wedson Almeida Filho's work and add a `where T<'a>: Default`
> bound to `lock()` so that it can only be called on lock types where the
> context is simply a placeholder value, then re-implement it through the new
> `lock_with()` function.
> 
> We additionally add a BackendWithContext trait, to handle calling the
> various locking primatives necessary for these types - along with providing
> a `lock_with_new()` function for using those primitives and creating the
> relevant context tokens.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> 
> ---
> 
> V3:
> * Use explicit lifetimes in lock_with() to ensure self and _context have
>   the same lifetime (Benno)
> * Use () for locks that don't need a Context instead of PhantomData (Benno)
> V4:
> * Fix typo (Dirk)
> V7:
> * Introduce BackendWithContext and lock_with_new following tglx's feedback
> * Name functions lock_with_context_saved and unlock_with_context_restored
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/sync/lock.rs          | 118 ++++++++++++++++++++++++++++--
>  rust/kernel/sync/lock/mutex.rs    |   1 +
>  rust/kernel/sync/lock/spinlock.rs |   1 +
>  3 files changed, 115 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 7b4859b05d3a7..8949a69dd53c5 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -12,7 +12,7 @@
>      str::CStr,
>      types::{NotThreadSafe, Opaque, ScopeGuard},
>  };
> -use core::{cell::UnsafeCell, marker::PhantomPinned};
> +use core::{cell::UnsafeCell, marker::PhantomPinned, mem::ManuallyDrop};
>  use macros::pin_data;
>  
>  pub mod mutex;
> @@ -43,6 +43,11 @@ pub unsafe trait Backend {
>      /// [`unlock`]: Backend::unlock
>      type GuardState;
>  
> +    /// The context which must be provided to acquire the lock.
> +    ///
> +    /// Can be `()`, or another type if [`BackendWithContext`] is implemented.
> +    type Context<'a>;
> +
>      /// Initialises the lock.
>      ///
>      /// # Safety
> @@ -89,6 +94,54 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
>      }
>  }
>  
> +/// An additional trait for [`Backend`] implementations with a non-`()` [`Context`].
> +///
> +/// Restricts the context in which a [`Lock`] may be locked. It can initially be created using
> +/// [`Lock::lock_with_new`], and can be reused to acquire additional [`Lock`] objects using
> +/// [`Lock::lock_with`].
> +///
> +/// An example of a locking context would be a context in which local CPU interrupts are disabled,
> +/// where we must restrict the ability to acquire the [`Lock`] so that it can only be acquired
> +/// within that context.
> +///
> +/// [`Context`]: `Backend::Context`
> +pub trait BackendWithContext: Backend {
> +    /// The type that represents the state of this [`Context`].
> +    ///
> +    /// [`Context`]: Backend::Context
> +    type ContextState;
> +
> +    /// Fulfills the invariants of [`State`] and acquires the lock, making the caller its owner.
> +    ///
> +    /// This returns any state data ([`Context::State`]) needed upon unlock.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Same as [`Backend::lock`].
> +    ///
> +    /// [`State`]: Context::State
> +    unsafe fn lock_with_context_saved<'a>(
> +        ptr: *mut Self::State,
> +    ) -> (Self::Context<'a>, Self::ContextState, Self::GuardState);
> +
> +    /// Performs the final unlock within [`Context`].
> +    ///
> +    /// Passes the [`Context::State`] returned from [`first_lock`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// * This function may only be called after [`first_lock`].
> +    /// * `state` must be the value returned from [`first_lock`].
> +    ///
> +    /// [`first_lock`]: Backend::first_lock
> +    /// [`Context`]: Backend::Context
> +    unsafe fn unlock_with_context_restored(
> +        ptr: *mut Self::State,
> +        guard_state: &Self::GuardState,
> +        context_state: Self::ContextState,
> +    );
> +}
> +
>  /// A mutual exclusion primitive.
>  ///
>  /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
> @@ -132,8 +185,9 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
>  }
>  
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
> -    /// Acquires the lock and gives the caller access to the data protected by it.
> -    pub fn lock(&self) -> Guard<'_, T, B> {
> +    /// Acquires the lock with the given context and gives the caller access to the data protected
> +    /// by it.
> +    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B> {
>          // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
>          // that `init` was called.
>          let state = unsafe { B::lock(self.state.get()) };
> @@ -141,14 +195,68 @@ pub fn lock(&self) -> Guard<'_, T, B> {
>          unsafe { Guard::new(self, state) }
>      }
>  
> -    /// Tries to acquire the lock.
> +    /// Acquires the lock and gives the caller access to the data protected by it.
> +    #[inline]
> +    pub fn lock<'a>(&'a self) -> Guard<'a, T, B>
> +    where
> +        B::Context<'a>: Default,
> +    {
> +        self.lock_with(Default::default())
> +    }
> +
> +    /// Tries to acquire the lock with the given context.
>      ///
>      /// Returns a guard that can be used to access the data protected by the lock if successful.
> -    pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
> +    pub fn try_lock_with<'a>(&'a self, _context: B::Context<'a>) -> Option<Guard<'a, T, B>> {
>          // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
>          // that `init` was called.
>          unsafe { B::try_lock(self.state.get()).map(|state| Guard::new(self, state)) }
>      }
> +
> +    /// Tries to acquire the lock.
> +    ///
> +    /// Returns a guard that can be used to access the data protected by the lock if successful.
> +    #[inline]
> +    pub fn try_lock<'a>(&'a self) -> Option<Guard<'a, T, B>>
> +    where
> +        B::Context<'a>: Default,
> +    {
> +        self.try_lock_with(Default::default())
> +    }
> +}
> +
> +impl<T: ?Sized, B: BackendWithContext> Lock<T, B> {
> +    /// Acquire the lock with a new [`Context`].
> +    ///
> +    /// Creates a new instance of [`Context`], and then calls `cb` with said [`Context`] and a
> +    /// [`Guard`] for `self`. The [`Context`] will be dropped once `cb` finishes, and it may be used
> +    /// within `cb` to acquire additional locks.
> +    ///
> +    /// [`Context`]: Backend::Context
> +    pub fn lock_with_new<'a, R>(
> +        &self,
> +        cb: impl FnOnce(&mut Guard<'_, T, B>, B::Context<'a>) -> R,

I think this needs to be:

        cb: impl FnOnce(&mut Guard<'_, T, B>, B::Context<'_>) -> R,

i.e. using wildcard life for B::Context, which is equal to:

        cb: impl for<'b> FnOnce(&mut Guard<'b, T, B>, B::Context<'b>) -> R,

, which makes the lifetime of B::Context bound to the closure instead of
`lock_with_new()`. Otherwise, users can leak the `Context` outside:

    let irq_disabled_leak = lock1.lock_with_new(|_, irq_disabled| {
        irq_disabled
    });

playground:

	https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=520dc80444e6f3cc8c5782c7f0095cfe

> +    ) -> R {
> +        let ptr = self.state.get();
> +
> +        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
> +        // that `init` was called.
> +        let (context, context_state, guard_state) = unsafe { B::lock_with_context_saved(ptr) };
> +
> +        // We don't want Guard's destructor to get called, since we'll drop the lock manually with
> +        // B::unlock_with_context_restored later. So we store it in a ManuallyDrop and pass it to cb
> +        // via reference.
> +        // SAFETY: We acquired the lock when we called [`B::lock_with_context_saved`] above.
> +        let mut guard = ManuallyDrop::new(unsafe { Guard::new(self, guard_state) });
> +
> +        let result = cb(&mut guard, context);
> +
> +        // SAFETY: We called `B::lock_with_context_saved` above, `context_state` was returned from
> +        // there.
> +        unsafe { B::unlock_with_context_restored(ptr, &guard.state, context_state) };
> +

I think we have a soundness issue here, users can do:

(let's say we support static locks, which is a solid thing we want to
have)

static l1: SpinLockIrq<32> = ...;

    <in a function>

    let l2: &SpinLockIrq<i32> = ..;

    l2.lock_with_new(|guard2, context| {
        let mut guard1 = l1.lock_with(context);
	core::mem::swap(&mut guard1, guard2);
	drop(guard1); // actually unlock l2.
    }) // but when the cb returns, we dropped `l2` as well.

I have played this for a while, looks to me, only a static lock `l1` can
make the code pass the borrow checker, I'm not sure whether it is a
borrow checker implementation limitation, or this is by design. Because
lifetime of `guard1` should be `static` and lifetime of `guard2` should 
be `for<'a>, 'a`, seems they are interchangeable right now? A simplified
example:

	https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=8bcc1132734a7bd2420f766524af56a7

Regards,
Boqun

> +        result
> +    }
>  }
>  
>  /// A lock guard.
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
> index 9ce43ccb45158..9a873cb5b438b 100644
> --- a/rust/kernel/sync/lock/mutex.rs
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -93,6 +93,7 @@ macro_rules! new_mutex {
>  unsafe impl super::Backend for MutexBackend {
>      type State = bindings::mutex;
>      type GuardState = ();
> +    type Context<'a> = ();
>  
>      unsafe fn init(
>          ptr: *mut Self::State,
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 040dc16975a68..9fbfd96ffba3e 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -92,6 +92,7 @@ macro_rules! new_spinlock {
>  unsafe impl super::Backend for SpinLockBackend {
>      type State = bindings::spinlock_t;
>      type GuardState = ();
> +    type Context<'a> = ();
>  
>      unsafe fn init(
>          ptr: *mut Self::State,
> -- 
> 2.47.0
> 

