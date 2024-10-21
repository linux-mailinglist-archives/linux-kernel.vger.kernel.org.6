Return-Path: <linux-kernel+bounces-374648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F39A6E05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0281C2154E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF913AA4C;
	Mon, 21 Oct 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn65PwxP"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5912D1FA;
	Mon, 21 Oct 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524217; cv=none; b=fPCIapAe8NsXRqnfN0Tk6sJ2455eEKzEZnTgP99P0Z++GO/rWG1A4BPvX3Ukl8gubqFB0Q9z1fzvpjpXipr4yMZ7Hv1r8x+X4aSuM5phoN1r8ORTZ0IZ7XMjCNiJdFvTuRCm0h+67KzlP1aQ4bzG8l+vpv1BiXojMuELIYoi/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524217; c=relaxed/simple;
	bh=0b7m3+CWKkl08XMKsvFUcu+a5QeAtXLznP93kJE3qu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJbv3a6XabTko3tOyx+mMLpEe4bptX1nGiecHMb/5pZ2Zok4k7YHp28pPPyzEC9lpC25Fevq5uRv/3GXtFSmOwHnRI/7pxiEpqATZacj0fsqdSsDcQdm2UtzAFYl19cJSjuEWNEvxYYQXe0dYBGjLUZkLjs6DawhdmlvSMOyc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn65PwxP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4603aced3a5so38027071cf.1;
        Mon, 21 Oct 2024 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729524214; x=1730129014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL+S5yhz9ZStuMaFm2Xen6icqivhg7HUf3U2q5/c+oY=;
        b=Hn65PwxPhZNbZKSgg6/cpnxaW1h67OuS8j3JhGKkWGAI+UyEhp2+yEdWqi8tUhtyEk
         igYXGzUFNLWFX3p94yhJx3JUn4y6fKF9aT5fKx7Cj2+dFCSHyOzTfDX4oGyA4qakEEFR
         P7xJeCZ/A/0NgIhiqRl5O6g8wuXZo3nPeFsGUm3oX+H1b69dcEbmU2A5QQ7so5lxYXGW
         djnuyUpiBgfQ2G7eM4wtTqZFbv4vr+JON1cgk53at/lM/NuV9pFZ7sDcb2H6QXiYKUPT
         Co1YFxIz1MGS+EP67EV2XQ/uVcYwrpCud5I1/e6tiwFLmjWnc3/8ZRQFN0vsLI16Axx3
         2DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524214; x=1730129014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL+S5yhz9ZStuMaFm2Xen6icqivhg7HUf3U2q5/c+oY=;
        b=u9x0fBI5lrIIaP4OoBhbTk4JSdYwWbEW5QiTMP/e98MUJg4qjA9ebIIrAO2bi56U+Q
         QtRmZ78hv0R4IHzzqxDUe+6e1N07JmSSnV6b9cggn46+gkXKewFmxVjIz1aHjC6gXRcU
         QdRVAiW85PNyc6x4rHS9mC+QVjwbS9PuiNmPtO1zl1G7zN7YrRtyIcPTO8ZZTSmz86bQ
         Eslp9ZFM0A9HmXUV7ThkwSN5t0NNES6vrzeolq2AZ2NwaOw7Guv0BwIVTb+BJj5Ow5ln
         MeH1sSKK9aUCv/DXN2StDAaFnzo1YB0XqmRv347FVF6wB8FnM1ey1PWjH9wwBAK0xsKX
         qkXw==
X-Forwarded-Encrypted: i=1; AJvYcCXZFgCv3Ust3ImGzXUdDBgEWn8odc6UYfiZrVCZZRUoLkhXTq9pQmP5g4sbAOrSjGkBHqYja4Xd0roLGDFZses=@vger.kernel.org, AJvYcCXZl70fyrAaoROT6G1Imf5d9fBinnYd0g5jTbOngSpzEbN+pTw+7EUR54LSszVpZPwVl0gox8Sc8NECCug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVjDXp+JpjI/czxpctmqQAi0xsqhZENYi2b3xcB5alaIFXpgo
	kssymdiDvfB7gVFQU3nBkiz4lmFNEryehN/FQuXbbnTxNeBESq4M
X-Google-Smtp-Source: AGHT+IH7dkX6rkN3zhfDx+ZiAEFDv2QCdX8xvJyYSZ/DtBtckKOr6qaNgpobmk+CQyIqiUwXIdbqLg==
X-Received: by 2002:a05:622a:1a24:b0:460:9e6b:1f9d with SMTP id d75a77b69052e-460fe6acc00mr2176521cf.21.1729524214319;
        Mon, 21 Oct 2024 08:23:34 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c95aafsm18605121cf.40.2024.10.21.08.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:23:33 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 470DB1200076;
	Mon, 21 Oct 2024 11:23:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 21 Oct 2024 11:23:33 -0400
X-ME-Sender: <xms:9XEWZ2g1WfBr1jMFgUpYIVPP3LXqyV6SQi57xvi-rmcWAd4ANlEf2Q>
    <xme:9XEWZ3BJzS8HLkQGwq-wfYnUDRBkHugkrBjjyV36ROw0JeKX_4mVVD-QOgNFSAhWr
    wgQAE1FmZgK3hzzbQ>
X-ME-Received: <xmr:9XEWZ-E8A5UV8Aiu6KDHU_S7r2p7X6lCqijkkv9V2pmX_dDOUZtMzlXgTxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeetieekteduvdetleevhfeggeehleevtdeiffev
    iedvhfeigfetffefvddukeehtdenucffohhmrghinhepmhihpggtohhunhhtvghrrdgrsh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphht
    thhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpth
    htohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:9XEWZ_R9Yt18q8NqorJjgNJtOV9r897S_uWSBRVG0imGk_kb0SimuQ>
    <xmx:9XEWZzydTLHhgxJjJIDtE8OP54PeFs6zfus0xbzDTa5Fe1ExJnXHlg>
    <xmx:9XEWZ952Gc86DfQMiDifJNpH7Q1q5PCeMjq11WawtQmS-OP87-SuzA>
    <xmx:9XEWZwyi6JlKN66pL7gNlrsdAaeyBS8OKp_gBa-H-n1nPJzWCQ5tTA>
    <xmx:9XEWZ_iTZF3hcW8m_wUVIUrGczIHwL9l2Aq0LQ-vOpABVzJfhjtIJVvD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 11:23:32 -0400 (EDT)
Date: Mon, 21 Oct 2024 08:22:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v5] rust: add global lock support
Message-ID: <ZxZxzjEaSZ8e_6mn@boqun-archlinux>
References: <20241021-static-mutex-v5-1-8d118a6a99b7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-static-mutex-v5-1-8d118a6a99b7@google.com>

On Mon, Oct 21, 2024 at 01:17:23PM +0000, Alice Ryhl wrote:
[...]
> +///
> +/// A global mutex used to protect all instances of a given struct.
> +///
> +/// ```
> +/// # mod ex {
> +/// # use kernel::prelude::*;
> +/// kernel::sync::global_lock! {
> +///     // SAFETY: Initialized in module initializer before first use.
> +///     unsafe(uninit) static MY_MUTEX: Mutex<(), Guard = MyGuard, LockedBy = LockedByMyMutex> = ();

Thanks! This looks much better now ;-)

But I still want to get rid of "LockedBy=", so I've tried and seems it
works, please see the below diff on top of your patch, I think it's
better because:

* Users don't to pick up the names for the locked_by type ;-)
* It moves a significant amount of code out of macros.
* By having:

    struct MyStruct {
        my_counter: GlobalLockedBy<MyGuard, u32>,
    }

  , it's much clear for users to see which guard is used to protected
  `my_counter`.

I prefer this way. Any concern about doing this?

Regards,
Boqun

> +/// }
> +///
> +/// /// All instances of this struct are protected by `MY_MUTEX`.
> +/// struct MyStruct {
> +///     my_counter: LockedByMyMutex<u32>,
> +/// }
> +///
> +/// impl MyStruct {
> +///     /// Increment the counter in this instance.
> +///     ///
> +///     /// The caller must hold the `MY_MUTEX` mutex.
> +///     fn increment(&self, guard: &mut MyGuard) -> u32 {
> +///         let my_counter = self.my_counter.as_mut(guard);
> +///         *my_counter += 1;
> +///         *my_counter
> +///     }
> +/// }
> +///
> +/// impl kernel::Module for MyModule {
> +///     fn init(_module: &'static ThisModule) -> Result<Self> {
> +///         // SAFETY: called exactly once
> +///         unsafe { MY_MUTEX.init() };
> +///
> +///         Ok(MyModule {})
> +///     }
> +/// }
> +/// # struct MyModule {}
> +/// # }
> +/// ```

[...]

----------------------------------->8
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 9b3b401f3fcc..0d227541faef 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -15,6 +15,8 @@
 
 pub(super) mod global;
 
+pub use global::{GlobalGuard, GlobalLockedBy};
+
 /// The "backend" of a lock.
 ///
 /// It is the actual implementation of the lock, without the need to repeat patterns used in all
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 803f19db4545..bef188938d5a 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -4,6 +4,63 @@
 
 //! Support for defining statics containing locks.
 
+use core::{cell::UnsafeCell, marker::PhantomData};
+
+/// A marker for the guard type of a global lock.
+///
+/// # Safety
+///
+/// Implementers must guarantee that the type is a guard type of a global lock, that is,  the
+/// existence of the object represents a unique global lock is held.
+pub unsafe trait GlobalGuard { }
+
+/// Data protected by a global lock.
+pub struct GlobalLockedBy<G: GlobalGuard, T: ?Sized>(PhantomData<fn(&G)>, UnsafeCell<T>);
+
+impl<G: GlobalGuard, T> GlobalLockedBy<G, T> {
+    /// Creates a new data.
+    pub const fn new(val: T) -> Self {
+        Self(PhantomData, UnsafeCell::new(val))
+    }
+}
+
+impl<G: GlobalGuard, T: ?Sized> GlobalLockedBy<G, T> {
+    /// Returns the immutable reference to the data with the lock held.
+    ///
+    /// With an immutable reference of the [`GlobalGuard`], the function is safe because the
+    /// corresponding global lock is held.
+    pub fn as_ref(&self, _guard: &G) -> &T {
+        // SAFETY: Per the safety requirement of `GlobalGuard`, the lock is held, and with the
+        // shared reference of the guard, it's safe to return an immutable reference to the object.
+        unsafe { &*self.1.get() }
+    }
+
+    /// Returns the mutable reference to the data with the lock held.
+    ///
+    /// With a mutable reference of the [`GlobalGuard`], the function is safe because the
+    /// corresponding global lock is held, and the exclusive reference of the guard guarantees the
+    /// exclusive access of `T`.
+    #[allow(clippy::mut_from_ref)]
+    pub fn as_mut(&self, _guard: &mut G) -> &mut T {
+        // SAFETY: Per the safety requirement of `GlobalGuard`, the lock is held, and with the
+        // exclusive reference of the guard, it's safe to return a mutable reference to the object.
+        unsafe { &mut *self.1.get() }
+    }
+
+    /// Returns the mutable references to the data.
+    pub fn get_mut(&mut self) -> &mut T {
+        self.1.get_mut()
+    }
+}
+
+// SAFETY: `GlobalLockedBy` can be transferred across thread boundaries iff the data it protects
+// can.
+unsafe impl<G: GlobalGuard, T: ?Sized + Send> Send for GlobalLockedBy<G, T> {}
+
+// SAFETY: `GlobalLockedBy` serialises the interior mutability it provides, so it is `Sync` as long
+// as the data it protects is `Send`.
+unsafe impl<G: GlobalGuard, T: ?Sized + Send> Sync for GlobalLockedBy<G, T> {}
+
 /// Defines a global lock.
 ///
 /// The global mutex must be initialized before first use. Usually this is done by calling `init`
@@ -44,14 +101,15 @@
 /// ```
 /// # mod ex {
 /// # use kernel::prelude::*;
+/// use kernel::sync::lock::GlobalLockedBy;
 /// kernel::sync::global_lock! {
 ///     // SAFETY: Initialized in module initializer before first use.
-///     unsafe(uninit) static MY_MUTEX: Mutex<(), Guard = MyGuard, LockedBy = LockedByMyMutex> = ();
+///     unsafe(uninit) static MY_MUTEX: Mutex<(), Guard = MyGuard> = ();
 /// }
 ///
 /// /// All instances of this struct are protected by `MY_MUTEX`.
 /// struct MyStruct {
-///     my_counter: LockedByMyMutex<u32>,
+///     my_counter: GlobalLockedBy<MyGuard, u32>,
 /// }
 ///
 /// impl MyStruct {
@@ -81,7 +139,7 @@ macro_rules! global_lock {
     {
         $(#[$meta:meta])* $pub:vis
         unsafe(uninit) static $name:ident: $kind:ident<$valuety:ty
-            $(, Guard = $guard:ident $(, LockedBy = $locked_by:ident)?)?
+            $(, Guard = $guard:ident)?
         > = $value:expr;
     } => {
         $crate::macros::paste! {
@@ -167,44 +225,13 @@ fn deref_mut(&mut self) -> &mut Val {
                     }
                 }
 
-                $(
-                pub struct $locked_by<T: ?Sized>(::core::cell::UnsafeCell<T>);
-
-                // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it
-                // protects can.
-                unsafe impl<T: ?Sized + Send> Send for $locked_by<T> {}
-
-                // SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
-                // data it protects is `Send`.
-                unsafe impl<T: ?Sized + Send> Sync for $locked_by<T> {}
-
-                impl<T> $locked_by<T> {
-                    pub fn new(val: T) -> Self {
-                        Self(::core::cell::UnsafeCell::new(val))
-                    }
-                }
-
-                impl<T: ?Sized> $locked_by<T> {
-                    pub fn as_ref<'a>(&'a self, _guard: &'a $guard) -> &'a T {
-                        // SAFETY: The lock is globally unique, so there can only be one guard.
-                        unsafe { &*self.0.get() }
-                    }
-
-                    pub fn as_mut<'a>(&'a self, _guard: &'a mut $guard) -> &'a mut T {
-                        // SAFETY: The lock is globally unique, so there can only be one guard.
-                        unsafe { &mut *self.0.get() }
-                    }
-
-                    pub fn get_mut(&mut self) -> &mut T {
-                        self.0.get_mut()
-                    }
-                }
-                )?)?
+                // SAFETY: `$guard` is a guard type for a unique global lock.
+                unsafe impl $crate::sync::lock::GlobalGuard for $guard {}
+                )?
             }
 
             use [< __static_lock_mod_ $name >]::[< __static_lock_wrapper_ $name >];
-            $( $pub use [< __static_lock_mod_ $name >]::$guard;
-            $( $pub use [< __static_lock_mod_ $name >]::$locked_by; )?)?
+            $( $pub use [< __static_lock_mod_ $name >]::$guard;)?
 
             $(#[$meta])*
             #[allow(private_interfaces)]

