Return-Path: <linux-kernel+bounces-571215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A9A6BA82
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE33B880A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D027B22D7A4;
	Fri, 21 Mar 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxqkxxiJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA122D797;
	Fri, 21 Mar 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559299; cv=none; b=FJmHGxEkM4mD/Mi006MjMiOkytPupXEtxhroiSWAnVS8WCTjiaiQWwisdNslt39k07o1aCpVIVug6OfZmiMUHmOWY/bA/r4kGIKa0Ticei2BI+/rmJkTuv0weKzs8Y6nlvp9skzfbCEAKPWtajWcEpPomVRUXcvN5n0zSY6MMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559299; c=relaxed/simple;
	bh=jy30EXuNa8upxpkBQWSMCwf+q4I7fePKwXreoaYc4f8=;
	h=From:To:Cc:Subject:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=RHFCbaTn/Xa0GszadKpjFZlNaaiOY4kPkeTdSqqFaV0Dds2D7m4dez12Ye8qJ0E4qMPIMlOcFtI2+ZKE/4hnaCkaJODrYVPXSjN0z0oVchNgjpuP1q1AGULBUaKLttrvltC6blnnGnUthzGAPo7HNP1k1wx77Kst1NbL1ISkEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxqkxxiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACB0C4CEE3;
	Fri, 21 Mar 2025 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742559299;
	bh=jy30EXuNa8upxpkBQWSMCwf+q4I7fePKwXreoaYc4f8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dxqkxxiJgMXNjR2nWBVTvRGUpThYQhgRtcoIJjBQC7sVl3js12k713F9ArXW/5rLu
	 2BBcEiy6SRmotn+73UQ0Su+RQLBU+6t2q+CsrPVqiuXbfC+mM2dAxe3E+MPBtapsEa
	 HpO5sEX/DtKHz8MYO1y2ybQJ3XNES7xu6HkB3Tzq/pdFSX4dTFhYwD2IOfhPrxGjJk
	 fplF+b6HsLJVXpPXzEjcri6KxcRQ7DJftRSYlO7sNM+Y8K6qAaLzd1u36mXtepiqmv
	 gI4WZQhUiePEg8q2T7V/ct1pZlhJh925NZ1yBe+OcCuRZFYtW+EHAj9l0uovzcJHm+
	 J1jFZl5NqAYgg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,  "Frederic Weisbecker"
 <frederic@kernel.org>,  "Thomas Gleixner" <tglx@linutronix.de>,
  linux-kernel@vger.kernel.org,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>
Subject: Re: [GIT PULL] Rust `hrtimer` support for v6.15
In-Reply-To: <87pliljcvy.fsf@kernel.org> (Andreas Hindborg's message of "Thu,
	13 Mar 2025 14:09:21 +0100")
Message-ID: <87tt7md1s6.fsf@kernel.org>
References: <87pliljcvy.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Mar 2025 13:10:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Miguel,

Andreas Hindborg <a.hindborg@kernel.org> writes:

> Hi Miguel,
>
> Please pull the Rust support for hrtimer for v6.15.
>
> This initial support allows for intrusive use of timers without
> allocating when starting a timer. We support `Pin<Box<T>>`, `Arc<T>`,
> `Pin<&T>` and `Pin<&mut T>` pointer types for working with these
> intrusive timers. We support at most one `HrTimer` field in a struct for
> use with this API.
>
> For now, the primary users will be the Rust null block driver, `rnull`,
> and the Rust kernel mode setting driver `rkvms`. I expect us to add more
> features to the API as the demands from users grow.
>
> The PR also includes two changes for the core rust and rust/alloc
> subsytems that are dependencies of the hrtimer Rust API: `Arc::as_ptr`
> and `Box::into_pin`. The alloc change was Ack'd by Danilo.
>
> The commits were in linux-next since next-20250313.

Please find an updated pull request below.

As discussed, I fixed the UB you fund in:

  rust: hrtimer: allow timer restart from timer handler

by casting to `u32` when assigning enum values. The commits below this
commit are unchanged, the later commits were replayed on top of the
changed commit.

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://github.com/rust-for-linux/linux.git tags/rust-hrtimer-for-v6.15-v2

for you to fetch changes up to ac4f9157e8d7f6a9793209a693cb3e3a6f840983:

  rust: hrtimer: add maintainer entry (2025-03-21 12:56:38 +0100)


Best regards,
Andreas Hindborg


- ----------------------------------------------------------------
Rust hrtimer API for v6.15

Introduce Rust support for the `hrtimer` subsystem:

 - Add a way to use the `hrtimer` subsystem from Rust. Rust code can now set up
   intrusive timers without allocating when starting the timer.

 - Add support for `Pin<Box<_>>`, `Arc<_>`, `Pin<&_>` and `Pin<&mut _>` as
   pointer types for use with timer callbacks.

 - Add support for setting clock source and timer mode.

`kernel` crate:

 - Add `Arc::as_ptr` for converting an `Arc` to a raw pointer. This is a
   dependency for the `hrtimer` API.

 - Add `Box::into_pin` for converting a `Box<_>` into a `Pin<Box<_>>` to align
   with Rust `alloc`. This is a dependency for the `hrtimer` API.

- ----------------------------------------------------------------
Andreas Hindborg (13):
      rust: hrtimer: introduce hrtimer support
      rust: sync: add `Arc::as_ptr`
      rust: hrtimer: implement `HrTimerPointer` for `Arc`
      rust: hrtimer: allow timer restart from timer handler
      rust: hrtimer: add `UnsafeHrTimerPointer`
      rust: hrtimer: add `hrtimer::ScopedHrTimerPointer`
      rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&T>`
      rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&mut T>`
      rust: alloc: add `Box::into_pin`
      rust: hrtimer: implement `HrTimerPointer` for `Pin<Box<T>>`
      rust: hrtimer: add `HrTimerMode`
      rust: hrtimer: add clocksource selection through `ClockId`
      rust: hrtimer: add maintainer entry

 MAINTAINERS                         |  15 ++
 rust/kernel/alloc/kbox.rs           |   6 +
 rust/kernel/sync/arc.rs             |  13 +-
 rust/kernel/time.rs                 |  68 +++++
 rust/kernel/time/hrtimer.rs         | 517 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     | 100 +++++++
 rust/kernel/time/hrtimer/pin.rs     | 104 ++++++++
 rust/kernel/time/hrtimer/pin_mut.rs | 108 ++++++++
 rust/kernel/time/hrtimer/tbox.rs    | 120 +++++++++
 9 files changed, 1049 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/time/hrtimer.rs
 create mode 100644 rust/kernel/time/hrtimer/arc.rs
 create mode 100644 rust/kernel/time/hrtimer/pin.rs
 create mode 100644 rust/kernel/time/hrtimer/pin_mut.rs
 create mode 100644 rust/kernel/time/hrtimer/tbox.rs
-----BEGIN PGP SIGNATURE-----

iQJKBAEBCAA0FiEEEsH5R1a/fCoV1sAS4bgaPnkoY3cFAmfdVykWHGEuaGluZGJv
cmdAa2VybmVsLm9yZwAKCRDhuBo+eShjd18rD/0UMWTrZZRm/KPD2V9oZzoT/yYy
cM9nANXm7FXJJMUaqzKv0rzKl7bxqo6wJwaNJPFBCSkVEKAQhuJo35+REiXTr7nU
8UnTUtNWl8nhX9q1+fMmQqTwZpYGlydTFn0cjyFtqQe9ahPhfCR/iF+kvb/VtR/s
3ow8v93epAXy01/4fwcWW7Iozu5GqvTyyz4H8n+6B8UNVSgQp+lo4sylfl27EtQn
7i/hrAQYaLv765UrxYsQVNyxL2qU3XXKOlDKr0KY9GFXuMVSwm765rbobGNXeD4Q
kEZ9BU70ebS29ZHHsTncUN0AuiE22iwL/dMdZaSvyjMrD4WgH3oLbtVIuRjLQNJ1
D4hCryTc5gHvRHJ6ZYZJNv4dqRJ0CJ0GqdR3g19Yi6U8S8GD5HK7QGz84RusiM33
6LoKEO/XauPPaHP/ZlyDIJmuwrKRz+t9SNiEMmDFtl6UjPq/N4ghqG4zsG3wRbWq
VBFDKP3nxaOOKTXSF0D7yGec4eENuo6EuGswoXoS4OvC0c9i8KwKBkutoLVw1c4l
OYrwDeloyAP6V/cKbVgvxKeq3j/MKiBfYsuJBV3iQe8L7r0qoLQrCtM+dzWTRaxT
IVkKSBnRReVyVNsatf4jmBBwN1eAeNaWUCYy+w8AdCLoGggchjSNizW+FqorR3KQ
u6wfok7Z9QtTDT4HOA==
=B5KA
-----END PGP SIGNATURE-----


