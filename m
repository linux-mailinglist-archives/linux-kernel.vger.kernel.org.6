Return-Path: <linux-kernel+bounces-572390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A90A6C9E3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA481744E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3F81FAC4D;
	Sat, 22 Mar 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prkca6eX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086742056;
	Sat, 22 Mar 2025 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742642198; cv=none; b=YjOcuK4KcR88QbklJaJ65N86Ldh+2k580BRNg+hd7DzP04zeAirAIIxzaVkDF6SPH+ri6CS+XxVDeORh76oJlrI0LCUSa6yHCS4gXUHnDDs+d1dkGOrYepZJ31VtBSqNvIHrrChHWQkaJJycDAJZJ04ZeCcMespOBXZldcXrpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742642198; c=relaxed/simple;
	bh=/0507CEN/UCBW1XFee4UVNEfifTU32fi6iuHytZvrYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uq6BY/N8c8VszFC9bBRL88+t7D3MsP+bj6jH9r6iI+P3dP2zruZh67Df57U4+oJQ4l00SDZNHVPMfseqRFCZSRBVXjkqrQgLlFNVifsGtTzZ44piDTJaGdwaMPMJoKGN7643c2ZnhdurmduHfWDIuMNlN+lpNVCpBVNk/+RW9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prkca6eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B50DC4CEDD;
	Sat, 22 Mar 2025 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742642198;
	bh=/0507CEN/UCBW1XFee4UVNEfifTU32fi6iuHytZvrYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=prkca6eXpeTnyCegC4XnPFgyhSDZ/ASwCo9kGP4LKDQPfMx1hu1cLqKqrp+Re4Vj5
	 rr5+54hg2oqQxOdtk9Q3xjhhdsqkAwzmnO+4Oy7RdfSytJxLLyQZ5WMzv0o2DEKGnX
	 eQhgA+9aVfvAuNRskjEIxdeE7HwBjUc7BoQkn+b+Yqa0q+SZ8XEFwJDvI2/Z6iVWvO
	 Yki47jjBEMdwgkBXTZYFSx9w0KCro5aHVMjUl/F0K5xS3WicgPbHALWY2P8V0aagtJ
	 /OhXFzbi07NHnCu9IPkJqyrSMS1FLszlTHRiwrzDtvOm7i4VawcFLEavRNWvyurG+U
	 vl/hrl0v0fYIw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,  "Frederic Weisbecker"
 <frederic@kernel.org>,  "Thomas Gleixner" <tglx@linutronix.de>,
  linux-kernel@vger.kernel.org,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>
Subject: Re: [GIT PULL] Rust `hrtimer` support for v6.15
In-Reply-To: <87tt7md1s6.fsf@kernel.org> (Andreas Hindborg's message of "Fri,
	21 Mar 2025 13:10:07 +0100")
References: <87pliljcvy.fsf@kernel.org> <87tt7md1s6.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 12:15:53 +0100
Message-ID: <87r02pb9jq.fsf@kernel.org>
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

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi Miguel,
>
> Andreas Hindborg <a.hindborg@kernel.org> writes:
>
>> Hi Miguel,
>>
>> Please pull the Rust support for hrtimer for v6.15.
>>
>> This initial support allows for intrusive use of timers without
>> allocating when starting a timer. We support `Pin<Box<T>>`, `Arc<T>`,
>> `Pin<&T>` and `Pin<&mut T>` pointer types for working with these
>> intrusive timers. We support at most one `HrTimer` field in a struct for
>> use with this API.
>>
>> For now, the primary users will be the Rust null block driver, `rnull`,
>> and the Rust kernel mode setting driver `rkvms`. I expect us to add more
>> features to the API as the demands from users grow.
>>
>> The PR also includes two changes for the core rust and rust/alloc
>> subsytems that are dependencies of the hrtimer Rust API: `Arc::as_ptr`
>> and `Box::into_pin`. The alloc change was Ack'd by Danilo.
>>
>> The commits were in linux-next since next-20250313.
>
> Please find an updated pull request below.
>
> As discussed, I fixed the UB you fund in:
>
>   rust: hrtimer: allow timer restart from timer handler
>
> by casting to `u32` when assigning enum values. The commits below this
> commit are unchanged, the later commits were replayed on top of the
> changed commit.

I'm sorry, but I have to do another update. My usual workflow missed a
clippy warning because it depends on clippy warnings being treated as
errors when building with `W=e`. I forgot that is not upstream yet.

I added `#[allow(clippy::unnecessary_cast)]` to silence clippy in the
cases where the types match for `HrTimerRestart`.

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://github.com/rust-for-linux/linux.git tags/rust-hrtimer-for-v6.15-v3

for you to fetch changes up to 142d93914b8575753f56f0c3571bd81f214b7418:

  rust: hrtimer: add maintainer entry (2025-03-22 12:08:54 +0100)


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
 rust/kernel/time/hrtimer.rs         | 519 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     | 100 +++++++
 rust/kernel/time/hrtimer/pin.rs     | 104 ++++++++
 rust/kernel/time/hrtimer/pin_mut.rs | 108 ++++++++
 rust/kernel/time/hrtimer/tbox.rs    | 120 +++++++++
 9 files changed, 1051 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/time/hrtimer.rs
 create mode 100644 rust/kernel/time/hrtimer/arc.rs
 create mode 100644 rust/kernel/time/hrtimer/pin.rs
 create mode 100644 rust/kernel/time/hrtimer/pin_mut.rs
 create mode 100644 rust/kernel/time/hrtimer/tbox.rs
-----BEGIN PGP SIGNATURE-----

iQJKBAEBCAA0FiEEEsH5R1a/fCoV1sAS4bgaPnkoY3cFAmfem+kWHGEuaGluZGJv
cmdAa2VybmVsLm9yZwAKCRDhuBo+eShjd81tD/94J4FDlaOlfz/WMkbxQo2B3lef
XztcyQ6G3zPfyMOZ50ZrbvQPyHtnKPxjD0rjfuCCQnzmcKs0fqUxcBKXpvRusi0Q
dC3f8fBT7n+8wvU6eOO/gzR0pblvu4yepardP/MSPaTH4pBF0xgaRFqM3S8syejY
elHnw1y9mSH7EbSJFJvVIodXLE0MXifb5FicN5iawQ27IeBCdZDoQa0x/tLBsYpY
8CkAqsWUUU424dvGrKjcsUjfLYJXiXfDQmuLi5tReVpoWF8g47DmbnLv+s/4r87S
fOLaNyzn81tStYze0+DaEOpkXID6y64EyfwmXGV09CRJAE432tbBxRzouKTvDZxt
gO9VPBGtoN7tm6bzobQuCTXsLlrNCIh36Ju952uR1fjgQ8uNg15qPgZdRi++K2Rq
KX7LEQTONpkfm0brPj4mZQjOwU2iQRdytwQrE15mMjqvAjQuZLDyYuPmyCiz6YeQ
LdbC7oJC0n9LX23H97mTHiuq3AXZzskt5twrL9a4ol3mBSPopyiGM78/qIoqXI5k
Vz4pu8pxwm6VEyHeShWBFTi+Xw2mlSE7q2JiBEug2IZAY9qI8yrKj29rFvYw1JlE
v/ur2emLJtWsCudzr0eNgjoQqHC/aRu41LtAfJA1rJzwdRwrod6zE0plvWTNVkTG
zDTqNl4OVmIifTK9Kg==
=CxhJ
-----END PGP SIGNATURE-----


