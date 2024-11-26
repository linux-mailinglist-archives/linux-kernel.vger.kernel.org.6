Return-Path: <linux-kernel+bounces-421804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D09D9062
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BFB22C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA02940B;
	Tue, 26 Nov 2024 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCVVXk05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0438C;
	Tue, 26 Nov 2024 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732587913; cv=none; b=ly3zOJWruKaoxCOXJGdopv9t9DaGqdibOsrCm59s9PZabUaGHOw8tNnKhrBEesaMeQ2liUSBAnKFSbvzgpwM2x7Y4dQbvkVr0Suq/ffKnRLDZ7xqYJK8w559lF8dz/derYNkkITpaEKMHVDV7NjU1H0EONqZxKXMWY0eIlXoEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732587913; c=relaxed/simple;
	bh=RwhUruaEr06rrOqJcpnHuIRR2dkoYbYXkLrg7BUQ2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UP10rj50Wn04UrKl+h1Mza+d7BlP0M5pdw9zDsi2OE9MnFF2bMCRzhBh1Jmor1fL7TiJ65g4ZkWkAmr7yBRt1WIFv5vLXIC9mETDIcBoKCGtSHd/tu8H7t13BMm6kJK7lGp26p9ILhuv+7hXGTrN1XXCR8qj8HMBExzGR72kKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCVVXk05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA10EC4CECE;
	Tue, 26 Nov 2024 02:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732587912;
	bh=RwhUruaEr06rrOqJcpnHuIRR2dkoYbYXkLrg7BUQ2uY=;
	h=From:To:Cc:Subject:Date:From;
	b=VCVVXk05QRKhh6Bttr81QAsRFt+ZaV2a0sCkLZEuk+j5HzTWpgPyX6s4SWI9n1PS2
	 7m94fb5rkVZGTUq3sPcT8rmy6VYhtpOBnzv00/JMsWgjH2Z7HgsP1dXpAksRX0R9QF
	 WWsWOhzrfPzt3IMxGm7kFAu8N6oO25f2P1XKdnbuuS06iMblqgFPQ9DhbLR93qBG8+
	 rb1DMV33EDOXh0W177o6tASgelrlf0ICMRjnO5q7GOy3agAUPu5tceJA+fB4khSWsv
	 qp3mDfTDXIhFByIj3dM+vauLTXPJf0wa/+kuCsnB3DOVKzzNryQIeildYi9lKf2y8w
	 RO/bzQxyI7ZqA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.13
Date: Tue, 26 Nov 2024 03:24:58 +0100
Message-ID: <20241126022500.718070-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the next round of the Rust support.

Most commits have been in linux-next for weeks, except the latest three
which are a couple fixes and a ignore-Clippy-warning flag addition to
keep things clean for the upcoming Rust release on Thrusday.

You already merged the vfs Rust file PR, the trace Rust support PR and
the net-next PR which had a small Rust change. You may also get a
char-misc PR as well as another vfs Rust PR (pid_namespace).

Conflicts expected with both the vfs ones, trace-rust and char-misc.
The conflicts aren't too bad -- the resolutions in -next are fine.

Please pull for v6.13 -- thanks!

Cheers,
Miguel

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.13

for you to fetch changes up to b7ed2b6f4e8d7f64649795e76ee9db67300de8eb:

  rust: alloc: Fix `ArrayLayout` allocations (2024-11-25 00:11:07 +0100)

----------------------------------------------------------------
Rust changes for v6.13

Toolchain and infrastructure:

 - Enable a series of lints, including safety-related ones, e.g. the
   compiler will now warn about missing safety comments, as well as
   unnecessary ones. How safety documentation is organized is a frequent
   source of review comments, thus having the compiler guide new
   developers on where they are expected (and where not) is very nice.

 - Start using '#[expect]': an interesting feature in Rust (stabilized
   in 1.81.0) that makes the compiler warn if an expected warning was
   _not_ emitted. This is useful to avoid forgetting cleaning up locally
   ignored diagnostics ('#[allow]'s).

 - Introduce '.clippy.toml' configuration file for Clippy, the Rust
   linter, which will allow us to tweak its behaviour. For instance, our
   first use cases are declaring a disallowed macro and, more
   importantly, enabling the checking of private items.

 - Lints-related fixes and cleanups related to the items above.

 - Migrate from 'receiver_trait' to 'arbitrary_self_types': to get the
   kernel into stable Rust, one of the major pieces of the puzzle is the
   support to write custom types that can be used as 'self', i.e. as
   receivers, since the kernel needs to write types such as 'Arc' that
   common userspace Rust would not. 'arbitrary_self_types' has been
   accepted to become stable, and this is one of the steps required to
   get there.

 - Remove usage of the 'new_uninit' unstable feature.

 - Use custom C FFI types. Includes a new 'ffi' crate to contain our
   custom mapping, instead of using the standard library 'core::ffi'
   one. The actual remapping will be introduced in a later cycle.

 - Map '__kernel_{size_t,ssize_t,ptrdiff_t}' to 'usize'/'isize' instead
   of 32/64-bit integers.

 - Fix 'size_t' in bindgen generated prototypes of C builtins.

 - Warn on bindgen < 0.69.5 and libclang >= 19.1 due to a double issue
   in the projects, which we managed to trigger with the upcoming
   tracepoint support. It includes a build test since some distributions
   backported the fix (e.g. Debian -- thanks!). All major distributions
   we list should be now OK except Ubuntu non-LTS.

'macros' crate:

 - Adapt the build system to be able run the doctests there too; and
   clean up and enable the corresponding doctests.

'kernel' crate:

 - Add 'alloc' module with generic kernel allocator support and remove
   the dependency on the Rust standard library 'alloc' and the extension
   traits we used to provide fallible methods with flags.

   Add the 'Allocator' trait and its implementations '{K,V,KV}malloc'.
   Add the 'Box' type (a heap allocation for a single value of type 'T'
   that is also generic over an allocator and considers the kernel's GFP
   flags) and its shorthand aliases '{K,V,KV}Box'. Add 'ArrayLayout'
   type. Add 'Vec' (a contiguous growable array type) and its shorthand
   aliases '{K,V,KV}Vec', including iterator support.

   For instance, now we may write code such as:

       let mut v = KVec::new();
       v.push(1, GFP_KERNEL)?;
       assert_eq!(&v, &[1]);

   Treewide, move as well old users to these new types.

 - 'sync' module: add global lock support, including the
   'GlobalLockBackend' trait; the 'Global{Lock,Guard,LockedBy}' types
    and the 'global_lock!' macro. Add the 'Lock::try_lock' method.

 - 'error' module: optimize 'Error' type to use 'NonZeroI32' and make
   conversion functions public.

 - 'page' module: add 'page_align' function.

 - Add 'transmute' module with the existing 'FromBytes' and 'AsBytes'
   traits.

 - 'block::mq::request' module: improve rendered documentation.

 - 'types' module: extend 'Opaque' type documentation and add simple
   examples for the 'Either' types.

drm/panic:

 - Clean up a series of Clippy warnings.

Documentation:

 - Add coding guidelines for lints and the '#[expect]' feature.

 - Add Ubuntu to the list of distributions in the Quick Start guide.

MAINTAINERS:
 - Add Danilo Krummrich as maintainer of the new 'alloc' module.

And a few other small cleanups and fixes.

----------------------------------------------------------------
Alice Ryhl (2):
      rust: page: add Rust version of PAGE_ALIGN
      rust: sync: add global lock support

Aliet Exposito Garcia (1):
      rust: kernel: move `FromBytes` and `AsBytes` traits to a new `transmute` module

Asahi Lina (1):
      rust: alloc: Fix `ArrayLayout` allocations

Benno Lossin (1):
      rust: alloc: introduce `ArrayLayout`

Danilo Krummrich (28):
      rust: alloc: add `Allocator` trait
      rust: alloc: separate `aligned_size` from `krealloc_aligned`
      rust: alloc: rename `KernelAllocator` to `Kmalloc`
      rust: alloc: implement `ReallocFunc`
      rust: alloc: make `allocator` module public
      rust: alloc: implement `Allocator` for `Kmalloc`
      rust: alloc: add module `allocator_test`
      rust: alloc: implement `Vmalloc` allocator
      rust: alloc: implement `KVmalloc` allocator
      rust: alloc: add __GFP_NOWARN to `Flags`
      rust: alloc: implement kernel `Box`
      rust: treewide: switch to our kernel `Box` type
      rust: alloc: remove extension of std's `Box`
      rust: alloc: add `Box` to prelude
      rust: alloc: implement kernel `Vec` type
      rust: alloc: implement `IntoIterator` for `Vec`
      rust: alloc: implement `collect` for `IntoIter`
      rust: treewide: switch to the kernel `Vec` type
      rust: alloc: remove `VecExt` extension
      rust: alloc: add `Vec` to prelude
      rust: error: use `core::alloc::LayoutError`
      rust: error: check for config `test` in `Error::name`
      rust: alloc: implement `contains` for `Flags`
      rust: alloc: implement `Cmalloc` in module allocator_test
      rust: str: test: replace `alloc::format`
      rust: alloc: update module comment of alloc.rs
      kbuild: rust: remove the `alloc` crate and `GlobalAlloc`
      MAINTAINERS: add entry for the Rust `alloc` module

Deepak Thukral (1):
      rust: std_vendor: update dbg macro from Rust upstream

Dirk Behme (1):
      rust: types: extend `Opaque` documentation

Ethan D. Twardy (4):
      rust: kbuild: expand rusttest target for macros
      rust: enable macros::module! tests
      rust: macros: enable paste! use from macro_rules!
      rust: macros: enable the rest of the tests

Filipe Xavier (3):
      rust: error: make conversion functions public
      rust: lock: add trylock method support for lock backend
      rust: error: optimize error type to use nonzero

Francesco Zardi (1):
      rust: block: fix formatting of `kernel::block::mq::request` module

Gary Guo (4):
      rust: enable arbitrary_self_types and remove `Receiver`
      rust: fix size_t in bindgen prototypes of C builtins
      rust: map `__kernel_size_t` and friends also to usize/isize
      rust: use custom FFI integer types

Miguel Ojeda (23):
      docs: rust: quick-start: add Ubuntu
      rust: workqueue: remove unneeded ``#[allow(clippy::new_ret_no_self)]`
      rust: sort global Rust flags
      rust: types: avoid repetition in `{As,From}Bytes` impls
      rust: enable `clippy::undocumented_unsafe_blocks` lint
      rust: enable `clippy::unnecessary_safety_comment` lint
      rust: enable `clippy::unnecessary_safety_doc` lint
      rust: enable `clippy::ignored_unit_patterns` lint
      rust: enable `rustdoc::unescaped_backticks` lint
      rust: init: remove unneeded `#[allow(clippy::disallowed_names)]`
      rust: sync: remove unneeded `#[allow(clippy::non_send_fields_in_send_ty)]`
      rust: introduce `.clippy.toml`
      rust: replace `clippy::dbg_macro` with `disallowed_macros`
      rust: rbtree: fix `SAFETY` comments that should be `# Safety` sections
      rust: provide proper code documentation titles
      rust: enable Clippy's `check-private-items`
      Documentation: rust: add coding guidelines on lints
      rust: start using the `#[expect(...)]` attribute
      Documentation: rust: discuss `#[expect(...)]` in the guidelines
      rust: std_vendor: simplify `{ .. macro! .. }` with inner attributes
      rust: warn on bindgen < 0.69.5 and libclang >= 19.1
      rust: allow `clippy::needless_lifetimes`
      docs: rust: remove spurious item in `expect` list

Nell Shamrell-Harrington (1):
      rust: types: add examples for the `Either` type

Paolo Bonzini (1):
      rust: macros: fix documentation of the paste! macro

Tamir Duberstein (2):
      rust: exports: improve grammar in commentary
      rust: helpers: remove unnecessary header includes

Thomas Böhler (7):
      drm/panic: avoid reimplementing Iterator::find
      drm/panic: remove unnecessary borrow in alignment_pattern
      drm/panic: prefer eliding lifetimes
      drm/panic: remove redundant field when assigning value
      drm/panic: correctly indent continuation of line in list item
      drm/panic: allow verbose boolean for clarity
      drm/panic: allow verbose version check

Yutaro Ohno (1):
      rust: kernel: fix THIS_MODULE header path in ThisModule doc comment

 .clippy.toml                                       |   9 +
 .gitignore                                         |   1 +
 Documentation/rust/coding-guidelines.rst           | 146 ++++
 Documentation/rust/quick-start.rst                 |  17 +
 MAINTAINERS                                        |   8 +
 Makefile                                           |  16 +-
 drivers/block/rnull.rs                             |   4 +-
 drivers/gpu/drm/drm_panic_qr.rs                    |  23 +-
 mm/kasan/kasan_test_rust.rs                        |   3 +-
 rust/Makefile                                      |  93 ++-
 rust/bindgen_parameters                            |   5 +
 rust/bindings/bindings_helper.h                    |   1 +
 rust/bindings/lib.rs                               |   6 +
 rust/exports.c                                     |   7 +-
 rust/ffi.rs                                        |  13 +
 rust/helpers/build_bug.c                           |   1 -
 rust/helpers/err.c                                 |   1 -
 rust/helpers/helpers.c                             |   1 +
 rust/helpers/kunit.c                               |   1 -
 rust/helpers/mutex.c                               |   1 -
 rust/helpers/refcount.c                            |   1 -
 rust/helpers/signal.c                              |   1 -
 rust/helpers/slab.c                                |   6 +
 rust/helpers/spinlock.c                            |   6 +-
 rust/helpers/task.c                                |   1 -
 rust/helpers/vmalloc.c                             |   9 +
 rust/helpers/wait.c                                |   1 -
 rust/helpers/workqueue.c                           |   1 -
 rust/kernel/alloc.rs                               | 150 +++-
 rust/kernel/alloc/allocator.rs                     | 208 +++--
 rust/kernel/alloc/allocator_test.rs                |  95 +++
 rust/kernel/alloc/box_ext.rs                       |  89 --
 rust/kernel/alloc/kbox.rs                          | 456 ++++++++++
 rust/kernel/alloc/kvec.rs                          | 913 +++++++++++++++++++++
 rust/kernel/alloc/layout.rs                        |  91 ++
 rust/kernel/alloc/vec_ext.rs                       | 185 -----
 rust/kernel/block/mq/operations.rs                 |  18 +-
 rust/kernel/block/mq/raw_writer.rs                 |   2 +-
 rust/kernel/block/mq/request.rs                    |  67 +-
 rust/kernel/block/mq/tag_set.rs                    |   2 +-
 rust/kernel/error.rs                               |  79 +-
 rust/kernel/init.rs                                | 127 +--
 rust/kernel/init/__internal.rs                     |  13 +-
 rust/kernel/init/macros.rs                         |  18 +-
 rust/kernel/ioctl.rs                               |   2 +-
 rust/kernel/lib.rs                                 |  10 +-
 rust/kernel/list.rs                                |   1 +
 rust/kernel/list/arc.rs                            |   3 -
 rust/kernel/list/arc_field.rs                      |   2 +-
 rust/kernel/net/phy.rs                             |  16 +-
 rust/kernel/page.rs                                |  10 +
 rust/kernel/prelude.rs                             |   5 +-
 rust/kernel/print.rs                               |   5 +-
 rust/kernel/rbtree.rs                              |  58 +-
 rust/kernel/std_vendor.rs                          |  38 +-
 rust/kernel/str.rs                                 |  46 +-
 rust/kernel/sync.rs                                |   1 +
 rust/kernel/sync/arc.rs                            |  31 +-
 rust/kernel/sync/arc/std_vendor.rs                 |   2 +
 rust/kernel/sync/condvar.rs                        |   7 +-
 rust/kernel/sync/lock.rs                           |  27 +-
 rust/kernel/sync/lock/global.rs                    | 301 +++++++
 rust/kernel/sync/lock/mutex.rs                     |  15 +-
 rust/kernel/sync/lock/spinlock.rs                  |  15 +-
 rust/kernel/sync/locked_by.rs                      |   2 +-
 rust/kernel/task.rs                                |   8 +-
 rust/kernel/time.rs                                |   4 +-
 rust/kernel/transmute.rs                           |  71 ++
 rust/kernel/types.rs                               | 196 ++---
 rust/kernel/uaccess.rs                             |  25 +-
 rust/kernel/workqueue.rs                           |  29 +-
 rust/macros/lib.rs                                 | 142 +++-
 rust/macros/module.rs                              |   8 +-
 rust/macros/paste.rs                               |  15 +-
 rust/uapi/lib.rs                                   |   6 +
 samples/rust/rust_minimal.rs                       |   4 +-
 samples/rust/rust_print.rs                         |   1 +
 scripts/Makefile.build                             |   4 +-
 scripts/generate_rust_analyzer.py                  |  11 +-
 scripts/rust_is_available.sh                       |  15 +
 .../rust_is_available_bindgen_libclang_concat.h    |   3 +
 scripts/rust_is_available_test.py                  |  34 +-
 82 files changed, 3172 insertions(+), 897 deletions(-)
 create mode 100644 .clippy.toml
 create mode 100644 rust/ffi.rs
 create mode 100644 rust/helpers/vmalloc.c
 create mode 100644 rust/kernel/alloc/allocator_test.rs
 delete mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/kbox.rs
 create mode 100644 rust/kernel/alloc/kvec.rs
 create mode 100644 rust/kernel/alloc/layout.rs
 delete mode 100644 rust/kernel/alloc/vec_ext.rs
 create mode 100644 rust/kernel/sync/lock/global.rs
 create mode 100644 rust/kernel/transmute.rs
 create mode 100644 scripts/rust_is_available_bindgen_libclang_concat.h

