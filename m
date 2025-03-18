Return-Path: <linux-kernel+bounces-565794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF3DA66F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402233ABC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333D1F8BC5;
	Tue, 18 Mar 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mEb5W4Yy"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06842AB4;
	Tue, 18 Mar 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288730; cv=none; b=e3KjjGlwCgaRc3innvJnK6y6/93B+s2gaLezdXzlPlGZMM10zxutBKHzzG5ACpnOlVmKgMdZ7Cllq0BeifsaeZljahDBUVn4EcnNb3+xkRwdPgXIEz6yFsbEfEXMQwkNHDMQ8HpErMICT0zx+tn6pbld0Ggq62e3duzOjUtTiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288730; c=relaxed/simple;
	bh=kVRUQzGSk66YW7u0x8fVsXfnKGIeaJiNsuHjxLSiOTw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckSQR7yP6xLJkU5xHDrIuRKk8mOCaCVuS7HKcTqNpJmcOXPv7RYWsSZjdoMWg4EHJ4nhloLDEJhYOTM8D9JFE1fDFnfUo+1B0XZy/31QLhN3PtyuxI5/mXmV3AeNKXuUyNRRGudd8axKHSO/omtW/cJQx2VUm/epeNw2+zCy9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mEb5W4Yy; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742288718; x=1742547918;
	bh=kVRUQzGSk66YW7u0x8fVsXfnKGIeaJiNsuHjxLSiOTw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mEb5W4YycgPIfevEIDUWVq2FJz3xBEX+dXeB87hIpZrmkNoievewpa2kL4tnlT595
	 LtHlBz3E3zlEwF338ut0Gw7Z9uP5kyNZqHaQSk8z4Q8lPMsp9cPZsXelPkhVRBY8N1
	 hl3VDULYEgu1QHMi6YCzZMfXDSWetqTlFXaSjXln0fGhTS798ZlMEY6eC7x01pdmbO
	 wZczB+cLGUKo59zozFOI1ED958MoFrBrZVfFnsS5jvD79YI2bBPq6AznXzZhV5jKeg
	 DlMy1uU1lLsSryu3fiLk7HCgX7DdTpKsG2kdkXLOJmcNQLnmMKooFk/XAYrfq+m7Gx
	 Mi/GGiL4xcbBw==
Date: Tue, 18 Mar 2025 09:05:15 +0000
To: Christian <christiansantoslima21@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, ~lkcamp/patches@lists.sr.ht, richard120310@gmail.com
Subject: Re: [PATCH v4] Add methods for FromBytes trait.
Message-ID: <D8J9SWEGNPVM.SVZXLT3LHVSA@proton.me>
In-Reply-To: <CABm2a9c92FHGSHbg98B8UjPNF_=JNCV7_Pe3CambvSm2vxiBcw@mail.gmail.com>
References: <20250314034910.134463-1-christiansantoslima21@gmail.com> <D8FXFGYZTEXT.24UM4V3HZ5MWH@proton.me> <CABm2a9c92FHGSHbg98B8UjPNF_=JNCV7_Pe3CambvSm2vxiBcw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1844032a7298dd53e4ac435a16d2f51942c7462d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 18, 2025 at 12:14 AM CET, Christian wrote:
> Hi, Benno.
>
>> It usually is a good idea to include a changelog and a link to any prior
>> versions after this `---`. It won't be included in the final commit
>> message, but help reviewers and others keep track of this series.
>
> Yeah, my bad. I forgot.
>
>> I think this section should go before the `Safety` section.
>
> I followed this section:
> https://docs.kernel.org/rust/coding-guidelines.html#code-documentation,
> but no problem, I'll change.

Ah I see, I'll change that then.

>> Why is this trait becoming safe?
>
> I thought that if we change to a Result and get the Err case, it's not
> a problem to be safe.

A trait being `unsafe` means that the implementer needs to justify why
their implementation is correct. The fact that you change the return
type to `Result` doesn't change that the type must be transmutable from
sufficiently many bytes.

>> IMO it makes more sense for the return type to be `Option<&Self>`.
>
> I agree. I'll change.
>
>> This must also require that `Self: AsBytes`, since otherwise the user
>> could write padding bytes into the original slice.
>
> Did you mean `ToBytes`? Should I create another patch with an empty trait=
, e.g
> ```
> unsafe trait ToBytes {}
> ```
> or create the trait and its methods?

Nope, I mean `AsBytes`, it already exists in `rust/kernel/transmute.rs`.

>> Also the parameter name `mut_slice_of_bytes` is a bit long, how about
>> `bytes`?
>
> I liked it, I'll change to `bytes` and `bytes_mut`

I wouldn't put `_mut` in the parameter name, just name both of them
`bytes`.

>> What is this safety comment for?
>
> Idk if I should create another safety comment or just continue. In
> this case, I choose the first and submit the patch. So how should I
> proceed?

I don't understand, the safety comment that you added there doesn't make
any sense to me. I wouldn't have added it.

---
Cheers,
Benno


