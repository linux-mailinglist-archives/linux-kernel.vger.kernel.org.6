Return-Path: <linux-kernel+bounces-410582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9F9CDD8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5921F21A84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213E1B4F1C;
	Fri, 15 Nov 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="levsZHAE"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB9188012;
	Fri, 15 Nov 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670395; cv=none; b=QxGjnRuyRSHaq3D0usvugxmM1GhbTELhFMAtQC/cZAfntAAE6cWCI27weLWb0D68FnnO6wZ3k7Xg9gsh+s6jr9z6CuX6ZR1h82lUDg5ayGm8p4gs/SySmGFfRNG+DsuqVPyg0O0U2BiXrahvTFmsVwiWZhXIh6HpQ5PptOklk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670395; c=relaxed/simple;
	bh=Nxzat4vHRdclRaoIm4+iVX1cAPmTrt08GI0MXaIEekU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwxw1790KlfzHpmPe8GTtzynHRNWbtFykYGTxc9nwVFi+gDsTJwu23dmSPNxx2Tuh7OGIkjH8X7XRs99FcdKUsiaCT0Egn9vAfO+OG8cTUdQkN3KLOJvS3ZBO4aM3SQiHjuCBxIDl2wFs76ZxwaoYiahKLcxNKPwMaCKC6VdP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=levsZHAE; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id AD991427ED;
	Fri, 15 Nov 2024 11:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1731670382;
	bh=Nxzat4vHRdclRaoIm4+iVX1cAPmTrt08GI0MXaIEekU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=levsZHAEPoR7zrOHfAA7hsHN2d27gPeay+g/VvAQaK8jxJzk8d4+dHZYGMSzAD0ZZ
	 0IfP4Bf6NQdbnQ6DxJlFJ2fK6G0V8v1IIl641QE18si//TIKGpaQC4ue9zHCja7XwQ
	 J0r8GCmTWM2yZ9RBdwOpady/vp6F5hV1IVMVnzKcdLH7tvQt5b+vITIGvEeIoayTzG
	 9A+D1LW2AvpnbIee3iSImsr2FCgio6S+g9Y0MFkEY5bkSdLqpoPqzLMd7Wz6+aINpK
	 X93BP507DBjeIKN/GA2UB7iW9CyFm9GUPV2iUNpYrxwvX6e+Q//yXwpFA31vUuRMFB
	 Qm35A9gkkX31Q==
Message-ID: <3b843e34-48f3-41ca-bd83-9bc137ca6c76@asahilina.net>
Date: Fri, 15 Nov 2024 20:32:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/29] Generic `Allocator` support for Rust
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org,
 alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, mcanal@igalia.com, zhiw@nvidia.com,
 cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org, asahi@lists.linux.dev
References: <20241004154149.93856-1-dakr@kernel.org>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We (Asahi Linux) noticed that this doesn't support unsized types, which
is a regression from the alloc Box. drm/asahi uses boxed trait objects
to generalize across certain object types like render commands, so this
breaks the driver.

Is there a plan to add this back in? AIUI this would need the
coerce_unsized unstable feature, but is there any other blocker?

On 10/5/24 12:41 AM, Danilo Krummrich wrote:
> Hi,
> 
> This patch series adds generic kernel allocator support for Rust, which so far
> is limited to `kmalloc` allocations.
> 
> In order to abstain from (re-)adding unstable Rust features to the kernel, this
> patch series does not extend the `Allocator` trait from Rust's `alloc` crate,
> nor does it extend the `BoxExt` and `VecExt` extensions.
> 
> Instead, this series introduces a kernel specific `Allocator` trait, which is
> implemented by the `Kmalloc`, `Vmalloc` and `KVmalloc` allocators, also
> implemented in the context of this series.
> 
> As a consequence we need our own kernel `Box<T, A>` and `Vec<T, A>` types.
> Additionally, this series adds the following type aliases:
> 
> ```
> pub type KBox<T> = Box<T, Kmalloc>;
> pub type VBox<T> = Box<T, Vmalloc>;
> pub type KVBox<T> = Box<T, KVmalloc>;
> 
> 
> pub type KVec<T> = Vec<T, Kmalloc>;
> pub type VVec<T> = Vec<T, Vmalloc>;
> pub type KVVec<T> = Vec<T, KVmalloc>;
> ```
> 
> With that, we can start using the kernel `Box` and `Vec` types throughout the
> tree and remove the now obolete extensions `BoxExt` and `VecExt`.
> 
> For a final cleanup, this series removes the last minor dependencies to Rust's
> `alloc` crate and removes it from the entire kernel build.
> 
> The series ensures not to break the `rusttest` make target by implementing the
> `allocator_test` module providing a stub implementation for all kernel
> `Allocator`s.
> 
> This patch series passes all KUnit tests, including the ones added by this
> series. Additionally, the tests were run with `kmemleak` and `KASAN` enabled,
> without any issues.
> 
> This series is based on [1], which hit -mm/mm-stable, and is also available
> in [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm
> 
> Changes in v9:
>   - rebase onto rust-next (lint series)
>   - `Vec`:
>     - add missing invariant comments
>     - fix missing `#![feature(inline_const)]`
>     - add note for `kvec!` that GFP_KERNEL is used for allocation
>   - `ArrayLayout`: fix missing import for `size_of::<T>`
>   - `Box`: fix missing safety comment
> 
> Changes in v8:
>   - rebase onto rust-next (v6.12-rc1), including the -mm dependencies from [1]
>   - introduce `ArrayLayout` and rework the `Allocator` trait to take an
>     `old_layout` argument
>   - split up "rust: alloc: implement `Allocator` for `Kmalloc`" in three
>     separate patches (introduce `ReallocFunc`, make allocator module public and
>     implement `Kmalloc`)
>   - wrap `impl_slice_eq!` pattern in `$()*`
>   - couple of style changes suggested by Benno and Gary
> 
> Changes in v7:
>  - rebase onto rust-next resolving recent conflicts (93dc3be19450447a3a7090bd1dfb9f3daac3e8d2)
>  - documentation / safety comment changes suggested by Benno and Boqun
>  - rename `ptr` to `current` in `IntoIter::next` (Alice)
>  - remove unnecessary braces in `kvec!` (Benno)
>  - add `debug_assert!` in `Vec::set_len` (Benno)
>  - remove unused args in `impl_slice_eq!` (Benno)
>  - simplify `if` statement in `Cmalloc::realloc` (Benno)
> 
> Changes in v6:
>  - rebase onto rust-dev
>  - keep compiler annotations for {k,v,kv}realloc()
>  - documentation changes suggested by Alice, Benno
>  - remove `Box::into_pin`
>  - fix typo in `Send` and `Sync` for `Box` and `Vec`
>  - `kvec!` changes suggested by Alice
>  - free `src` after copy in `Cmalloc`
>  - handle `n == 0` in `Vec::extend_with`
> 
> Changes in v5:
>  - (safety) comment / documentation fixes suggested by Alice, Benno and Gary
>  - remove `Unique<T>` and implement `Send` and `Sync` for `Box` and `Vec`
>  - use `KMALLOC_MAX_SIZE` for `KVmalloc` test and add a `Kmalloc` test that
>    expects to fail for `KMALLOC_MAX_SIZE`
>  - create use constants `KREALLOC`, `VREALLOC` and `KVREALLOC` for
>    `ReallocFuncs`
>  - drop `Box::drop_contents` for now, will add it again, once I actually rebase
>    on the original patch that introduces it
>  - improve usage of `size_of_val` in `Box`
>  - move `InPlaceInit` and `ForeignOwnable` impls into kbox.rs
>  - fix missing `Box` conversions in rnull.rs
>  - reworked `Cmalloc` to keep track of the size of memory allocations itself
>  - remove `GlobalAlloc` together with the `alloc` crate to avoid a linker error
>  - remove `alloc` from scripts/generate_rust_analyzer.py
> 
> Changes in v4:
>  - (safety) comment fixes suggested by Alice and Boqun
>  - remove `Box::from_raw_alloc` and `Box::into_raw_alloc`, we don't need them
>  - in `Box::drop` call `size_of_val` before `drop_in_place`
>  - implement ForeignOwnable for Pin<Box<T>> as suggested by Alice
>  - in `Vec::extend_with`, iterate over `n` instead of `spare.len()`
>  - for `Vmalloc` and `KVmalloc` fail allocation for alignments larger than
>    PAGE_SIZE for now (will add support for larger alignments in a separate
>    series)
>  - implement `Cmalloc` in `allocator_test` and type alias all kernel allocator
>    types to it, such that we can use the kernel's `Box` and `Vec` types in
>    userspace tests (rusttest)
>    - this makes patch "rust: str: test: replace `alloc::format`" rather trivial
> 
> Changes in v3:
>  - Box:
>    - minor documentation fixes
>    - removed unnecessary imports in doc tests
>    - dropeed `self` argument from some remaining `Box` methods
>    - implement `InPlaceInit` for Box<T, A> rather than specifically for `KBox<T>`
>  - Vec:
>    - minor documentation fixes
>    - removed useless `Vec::allocator` method
>    - in `Vec::extend_with` use `Vec::spare_capacity_mut` instead of raw pointer operations
>    - added a few missing safety comments
>    - pass GFP flags to `Vec::collect`
>  - fixed a rustdoc warning in alloc.rs
>  - fixed the allocator_test module to implement the `Allocator` trait correctly
>  - rebased to rust-next
> 
> Changes in v2:
>   - preserve `impl GlobalAlloc for Kmalloc` and remove it at the end (Benno)
>   - remove `&self` parameter from all `Allocator` functions (Benno)
>   - various documentation fixes for `Allocator` (Benno)
>   - use `NonNull<u8>` for `Allocator::free` and `Option<NonNull<u8>>` for
>     `Allocator::realloc` (Benno)
>   - fix leak of `IntoIter` in `Vec::collect` (Boqun)
>   - always realloc (try to shrink) in `Vec::collect`, it's up the the
>     `Allocator` to provide a heuristic whether it makes sense to actually shrink
>   - rename `KBox<T, A>` -> `Box<T, A>` and `KVec<T, A>` -> `Vec<T, A>` and
>     provide type aliases `KBox<T>`, `VBox<T>`, `KVBox<T>`, etc.
>     - This allows for much cleaner code and, in combination with removing
>       `&self` parameters from `Allocator`s, gets us rid of the need for
>       `Box::new` and `Box::new_alloc` and all other "_alloc" postfixed
>       functions.
>     - Before: `KBox::new_alloc(foo, Vmalloc)?`
>     - After:  `VBox::new(foo)?`, which resolves to
>               `Box::<Foo,  Vmalloc>::new(foo)?;
> 
> Benno Lossin (1):
>   rust: alloc: introduce `ArrayLayout`
> 
> Danilo Krummrich (28):
>   rust: alloc: add `Allocator` trait
>   rust: alloc: separate `aligned_size` from `krealloc_aligned`
>   rust: alloc: rename `KernelAllocator` to `Kmalloc`
>   rust: alloc: implement `ReallocFunc`
>   rust: alloc: make `allocator` module public
>   rust: alloc: implement `Allocator` for `Kmalloc`
>   rust: alloc: add module `allocator_test`
>   rust: alloc: implement `Vmalloc` allocator
>   rust: alloc: implement `KVmalloc` allocator
>   rust: alloc: add __GFP_NOWARN to `Flags`
>   rust: alloc: implement kernel `Box`
>   rust: treewide: switch to our kernel `Box` type
>   rust: alloc: remove extension of std's `Box`
>   rust: alloc: add `Box` to prelude
>   rust: alloc: implement kernel `Vec` type
>   rust: alloc: implement `IntoIterator` for `Vec`
>   rust: alloc: implement `collect` for `IntoIter`
>   rust: treewide: switch to the kernel `Vec` type
>   rust: alloc: remove `VecExt` extension
>   rust: alloc: add `Vec` to prelude
>   rust: error: use `core::alloc::LayoutError`
>   rust: error: check for config `test` in `Error::name`
>   rust: alloc: implement `contains` for `Flags`
>   rust: alloc: implement `Cmalloc` in module allocator_test
>   rust: str: test: replace `alloc::format`
>   rust: alloc: update module comment of alloc.rs
>   kbuild: rust: remove the `alloc` crate and `GlobalAlloc`
>   MAINTAINERS: add entry for the Rust `alloc` module
> 
>  MAINTAINERS                         |   7 +
>  drivers/block/rnull.rs              |   4 +-
>  rust/Makefile                       |  43 +-
>  rust/bindings/bindings_helper.h     |   1 +
>  rust/exports.c                      |   1 -
>  rust/helpers/helpers.c              |   1 +
>  rust/helpers/slab.c                 |   6 +
>  rust/helpers/vmalloc.c              |   9 +
>  rust/kernel/alloc.rs                | 150 ++++-
>  rust/kernel/alloc/allocator.rs      | 210 +++++--
>  rust/kernel/alloc/allocator_test.rs |  95 +++
>  rust/kernel/alloc/box_ext.rs        |  89 ---
>  rust/kernel/alloc/kbox.rs           | 456 ++++++++++++++
>  rust/kernel/alloc/kvec.rs           | 914 ++++++++++++++++++++++++++++
>  rust/kernel/alloc/layout.rs         |  91 +++
>  rust/kernel/alloc/vec_ext.rs        | 185 ------
>  rust/kernel/error.rs                |   6 +-
>  rust/kernel/init.rs                 |  95 +--
>  rust/kernel/init/__internal.rs      |   2 +-
>  rust/kernel/lib.rs                  |   2 +-
>  rust/kernel/prelude.rs              |   5 +-
>  rust/kernel/rbtree.rs               |  49 +-
>  rust/kernel/str.rs                  |  35 +-
>  rust/kernel/sync/arc.rs             |  17 +-
>  rust/kernel/sync/condvar.rs         |   4 +-
>  rust/kernel/sync/lock/mutex.rs      |   2 +-
>  rust/kernel/sync/lock/spinlock.rs   |   2 +-
>  rust/kernel/sync/locked_by.rs       |   2 +-
>  rust/kernel/types.rs                |  52 +-
>  rust/kernel/uaccess.rs              |  17 +-
>  rust/kernel/workqueue.rs            |  20 +-
>  rust/macros/lib.rs                  |  12 +-
>  samples/rust/rust_minimal.rs        |   4 +-
>  scripts/Makefile.build              |   4 +-
>  scripts/generate_rust_analyzer.py   |  11 +-
>  35 files changed, 2025 insertions(+), 578 deletions(-)
>  create mode 100644 rust/helpers/vmalloc.c
>  create mode 100644 rust/kernel/alloc/allocator_test.rs
>  delete mode 100644 rust/kernel/alloc/box_ext.rs
>  create mode 100644 rust/kernel/alloc/kbox.rs
>  create mode 100644 rust/kernel/alloc/kvec.rs
>  create mode 100644 rust/kernel/alloc/layout.rs
>  delete mode 100644 rust/kernel/alloc/vec_ext.rs
> 
> 
> base-commit: 7f4a2c6cacb0efad2bd9ae5062ab1b75e13c6c1f

~~ Lina


