Return-Path: <linux-kernel+bounces-562819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0FA6334D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 03:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DFD3AE02C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F996F31E;
	Sun, 16 Mar 2025 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rKGg+q+2"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2420328;
	Sun, 16 Mar 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742090851; cv=none; b=ZD9rOOuNpFJ4cqGU39/SylrUuyojpG5J5gW1hphOti9Rrf6bEUtSwjWX1Mh20nrIqIbGr5ch5SO9hk6UYnGdiMHN98m873qvKOc9gY2BUnIWhBiFE5oiygQxGjzNTqWCtVlKMNYUnmhgOxMwXoCWN2uzlGKvFgONEt+3Ey7oalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742090851; c=relaxed/simple;
	bh=Ev22rK7cc16tyszcZE6I8fb+5s/qOR2us6bG6wbbdkc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaZx1LPMi8ZJ3BiOSyzjyhgBOZACfK/vg/qp9JHw37ki/8Fw+ZGco2l+4hjyVvroe4UY0ShTPr/w8SttEyou918rhCVxfqP7r3TNzgBDfF/eVyNLTeyXWdzKJgBG0fv46Q72dWyJXp+oCvdUFHNWVl5hmSd5b1J0GCh2zKmXibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rKGg+q+2; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742090847; x=1742350047;
	bh=S9wvDxFFV55Kpm0wLouwtnx2HBvBJqfAtgQP31lkJo0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=rKGg+q+2KkXH0Ntn+txbqmNh6wohiKHA7wxeIKTlzqqe8FaL6lduNJmWpuraCsZxO
	 nZRBupsu3te1ufPPtMKKsiMzZBbAymryfllxe4vH/ZRHt5sGYWd39Z2Fpw3aWeUIgp
	 rIMjBtC5NNz9Fr3mao0QWpQcdBbgNd13dMdd7d7mbsqRVhoKJ+X7Gkp1NqebsUzojf
	 JHBtHAATL+ZOtJ4xuoh2I538dwr4ZsOYF8x1p5hpaFHwobg7B5vGWPiptsy+qoWKg0
	 YQZauRmQVjVEMV+3nTQzdAVKklbQTDUzTsEZsmjlDjAhWTZLSB0FavPms/2W2fri9c
	 VvnvE5Emt3vHg==
Date: Sun, 16 Mar 2025 02:07:23 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH RFC 1/3] rust: core abstractions for HID drivers
Message-ID: <87r02xhgoa.fsf@protonmail.com>
In-Reply-To: <Z9MxI0u2yCfSzTvD@cassiopeiae>
References: <20250313160220.6410-2-sergeantsagara@protonmail.com> <20250313160220.6410-4-sergeantsagara@protonmail.com> <Z9MxI0u2yCfSzTvD@cassiopeiae>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: a809a0f3d843457d74b3a960eda86d103553a560
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Mar, 2025 20:25:23 +0100 "Danilo Krummrich" <dakr@kernel.org> wr=
ote:
> On Thu, Mar 13, 2025 at 04:03:35PM +0000, Rahul Rameshbabu wrote:
>> These abstractions enable the development of HID drivers in Rust by bind=
ing
>> with the HID core C API. They provide Rust types that map to the
>> equivalents in C. In this initial draft, only hid_device and hid_device_=
id
>> are provided direct Rust type equivalents. hid_driver is specially wrapp=
ed
>> with a custom Driver type. The module_hid_driver! macro provides analogo=
us
>> functionality to its C equivalent.
>>
>> Future work for these abstractions would include more bindings for commo=
n
>> HID-related types, such as hid_field, hid_report_enum, and hid_report.
>> Providing Rust equivalents to useful core HID functions will also be
>> necessary for HID driver development in Rust.
>>
>> Some concerns with this initial draft
>>   - The need for a DeviceId and DeviceIdShallow type.
>>     + DeviceIdShallow is used to guarantee the safety requirement for th=
e
>>       Sync trait.
>>   - The create_hid_driver call in the module_hid_driver! macro does not =
use
>>     Pin semantics for passing the ID_TABLE. I could not get Pin semantic=
s
>>     to work in a const fn. I get a feeling this might be safe but need h=
elp
>>     reviewing this.
>
> For a lot of things in this patch we have common infrastructure, please s=
ee
> rust/kernel/{device.rs, driver.rs, device_id.rs}. I think you should make=
 use of
> the common infrastructure that solves the corresponding problems already.

Absolutely! 9b90864bb42b ("rust: implement `IdArray`, `IdTable` and
`RawDeviceId`"). The types here look really useful, so I am sorry for
missing this. Will refactor my next revision to make use of this common
infrastructure.

>
> It provides generic infrastructure for handling device IDs, a generalized
> Registration type, based on InPlaceModule with a common module_driver!
> implementation for busses to implement their corresponding module macro, =
etc.

Wow, module_driver! is very nice. On one hand, out of all of Rust's
semantics, writing macro_rules! and proc macros were difficult for me
before I started working on this. I think I am a bit better with them
now after this. On the other hand looking at how module_pci_driver is
implemented, I love how much this common infrastructure simplifies the
effort for various buses. Will be moving to this in my next revision as
well.

>
> There are two busses upstream, which are based on this infrastructure:
> rust/kernel/{pci.rs, platform.rs}.

Thanks for the pointers.

>
> There is a patch series that improves soundness of those two bus abstract=
ions
> [1], which should be taken into consideration too. Even though your
> implementation isn't prone to the addressed issue, it would be good to al=
ign
> things accordingly.
>
> There is a third bus abstraction (auxiliary) on the mailing list [2], whi=
ch
> already implements the mentioned improvements, which you can use as canon=
ical
> example too.
>
> [1] https://lore.kernel.org/rust-for-linux/20250313021550.133041-1-dakr@k=
ernel.org/
> [2] https://lore.kernel.org/rust-for-linux/20250313022454.147118-1-dakr@k=
ernel.org/

Will base my work on top of the patches in
https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=
=3Drust/device.

Haven't had a chance yet to go through the patches in detail but the
main one of importance seems to be "rust: device: implement device
context marker" which adds the Normal and Core contexts for restricting
certain device functions from being called in certain bus callbacks
only. Will look at how the auxiliary bus abstraction makes use of this.

>

I did have a question with regards to a pattern of "getters" that I have
been implementing in my abstractions. Benjamin Tissoires brought up that
the pattern looked repetitive and was wondering if it can be generated
dynamically. I replied that I was of the opinion that it could not[1].

[1] https://lore.kernel.org/rust-for-linux/Z9MxI0u2yCfSzTvD@cassiopeiae/T/#=
m1b5b1ca96503a542c0da3089ef3f97e606032240

Thanks for the review,
Rahul Rameshbabu

>> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
>> ---
>>  drivers/hid/Kconfig             |   8 ++
>>  rust/bindings/bindings_helper.h |   1 +
>>  rust/kernel/hid.rs              | 245 ++++++++++++++++++++++++++++++++
>>  rust/kernel/lib.rs              |   2 +
>>  4 files changed, 256 insertions(+)
>>  create mode 100644 rust/kernel/hid.rs



