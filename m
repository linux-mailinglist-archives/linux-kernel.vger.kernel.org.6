Return-Path: <linux-kernel+bounces-255606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F59342D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9482C1C214A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2941836F7;
	Wed, 17 Jul 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="h8bCcZk1"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F2433D0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246067; cv=none; b=rF7B5soTeNJ+rvio/WMPSzFxPcYS09KSPYFjDzfpDBX5Uh1I1e3OjWM287immAzyOkzzM+LveXTuc+4jt9PtRgf9ro8REtNRu0khUeKdcVUfoEr/Mq/CGCaB0o2PnlEZzn2kyLGUupG8jjrV01COtduIXFMQnUC3NUVAZZxS8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246067; c=relaxed/simple;
	bh=0s0SddSeTuGrJ1laxk/JMS46syAuIUDRNFG+AKO22BA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoNbHODH9oqQIVnHmgOxQqiUF3bKdKOKH299HgkamfPAmH72Her8zohsRn9PaJZNSGgqXuYR6uyQATplPo+HWWZXnUsM7k+dz4WD5QrKg/GkHy6mpZqbA1r0f5pfJDqYpfRydF0xSOeQR/mnDg4uqvcRvFbBT6DvFfZsBtqApEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=h8bCcZk1; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721246062; x=1721505262;
	bh=e5x3kmpFuQF+/sLbsGqQ7KQCx1e2yyOtsQpsFj0qtZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h8bCcZk1DS1/EHyD7JH5n8Av/DHN6OyBiRcuBjmlaL7EiXmyIIKBgYTxXwhjhVbVC
	 1UUYqHu3gsP9UPu2Zm//HJJgmIGAsU3RmK75+5fgvbiTqMQVDLoFXiGa2+zHjA4P2d
	 FF47mxYYOWgZ14imiTqawgxDDL60RxQMTsOjqtkPCnvYopJJWrm7fAuvgC+eBPgZr5
	 vBSoZekUmtSKNKRDv9SQWp88YzJ5gxPGZ1KWfZ0v29pRhMJl2t1Ng5cA7ZxiTreuWC
	 X0a1Jzcj2emuTSM68NWkK2ts3BBojST5C+3V0stYlqKNb3/pvgdVTG2xPDYBQv8Zv8
	 D8k9SZYJf6bgA==
Date: Wed, 17 Jul 2024 19:54:14 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <323ad3d0-e478-4ed9-875c-335ced829afd@proton.me>
In-Reply-To: <Zoxfjfl9Izaz2Wtj@boqun-archlinux>
References: <20240708205325.1275473-1-benno.lossin@proton.me> <ZoxWyr3fL8GkyOAR@boqun-archlinux> <Zoxfjfl9Izaz2Wtj@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5a16a5dd66736c6e7adbc740079b5efdfd16af58
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.07.24 23:52, Boqun Feng wrote:
> On Mon, Jul 08, 2024 at 02:14:50PM -0700, Boqun Feng wrote:
>> On Mon, Jul 08, 2024 at 08:53:38PM +0000, Benno Lossin wrote:
>>> Sometimes (see [1]) it is necessary to drop the value inside of a
>>> `Box<T>`, but retain the allocation. For example to reuse the allocatio=
n
>>> in the future.
>>> Introduce a new function `drop_contents` that turns a `Box<T>` into
>>> `Box<MaybeUninit<T>>` by dropping the value.
>>>
>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-32=
3e134390ce@google.com/ [1]
>>> ---
>>>  rust/kernel/alloc/box_ext.rs | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.r=
s
>>> index cdbb5ad166d9..6cf79f96d6c7 100644
>>> --- a/rust/kernel/alloc/box_ext.rs
>>> +++ b/rust/kernel/alloc/box_ext.rs
>>> @@ -5,6 +5,7 @@
>>>  use super::{AllocError, Flags};
>>>  use alloc::boxed::Box;
>>>  use core::mem::MaybeUninit;
>>> +use core::ptr;
>>>  use core::result::Result;
>>>
>>>  /// Extensions to [`Box`].
>>> @@ -18,6 +19,18 @@ pub trait BoxExt<T>: Sized {
>>>      ///
>>>      /// The allocation may fail, in which case an error is returned.
>>>      fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocEr=
ror>;
>>> +
>>> +    /// Drops the contents, but keeps the allocation.
>>> +    ///
>=20
> (I spoke too soon ;-))
>=20
>>> +    /// # Examples
>>> +    ///
>>> +    /// ```
>=20
> need a `use` here:
>=20
> =09use kernel::alloc::{flags, box_ext::BoxExt};

Oops, should have checked that.

>>> +    /// let value =3D Box::new([0; 32], flags::GFP_KERNEL)
>=20
> missing a '?' and a ';' at the end of this line.
>=20
>>> +    /// let value =3D value.drop_contents();
>>> +    /// // Now we can re-use `value`:
>>> +    /// Box::write(value, [1; 32]);
>=20
> Need a line:
>=20
> =09# Ok::<(), Error>(())
>=20
> here.
>>> +    /// ```
>>> +    fn drop_contents(self) -> Box<MaybeUninit<T>>;
>>>  }
>>>
> [...]
>=20
> I queued this patch in rust-dev with these fixes applied, FYI.

Thanks!

@Miguel, when you take this, then apply the fixes that Boqun suggested.

---
Cheers,
Benno


