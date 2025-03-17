Return-Path: <linux-kernel+bounces-564389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C592DA653FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB3B188B1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64CB24501F;
	Mon, 17 Mar 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ToKl/xxx"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCD24337D;
	Mon, 17 Mar 2025 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222552; cv=none; b=PWaLs0rLa96c1ur8WIzsH7whWJGvk1md02/xbnatMsY05RGLUdt3fL4hfzZMKUKbteL+QL0m8YlogDPZrHSlx2IcB/7Oz7L1eqamaRB6nT5DmrOCOkqA+TkZMS9kqy7gGYop+/PLnsmGo1axz2Iri69bMw5/YJl67g4yO7aXAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222552; c=relaxed/simple;
	bh=B7w4fF/AQBq5dEVwxdmK1HtwIC8KWcaPAsFWCNa0C2U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9hwresmiacpdrsGZw24x7HxHd7na31j3M86LCxubmQLZsJLrJc0VNOWUt2fwlD0O/XuwL4v2mX7pSk0KM2eAqcOX8QphKkxi/xlGbBkabjKsRVrLapLXkb7IIQ28SGbo1/bsql8MbZ0YWcn9aFJZZUYPOYVOg5Wpt9fUbrZpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ToKl/xxx; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742222548; x=1742481748;
	bh=B7w4fF/AQBq5dEVwxdmK1HtwIC8KWcaPAsFWCNa0C2U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ToKl/xxxpx+5YIjI0l2d3U66G5GtgDC1CcUY33hlP+2YCs1G3xywS8/rb+xCyJfk8
	 7QwgfrHvxjAzYc88oY8J8iYMGsIwF53WyT2x6Mpqoa9zdVSNej1lR9c7kF6dtOrE84
	 htRcjMafXeKfVORHk6Gf1ThpPMmEcWw918B0KhvPoU69MitX8kmOte3ZtfKuV29G1k
	 PZzca7AZmj+njtUZhx4Gcw3jsOdPkSyljrTG1VMdRPgEV7Raq5jXX1zTGqcq5fSzvk
	 30n28sXXnG0PnfbTL/gEQbBKg6XsDYanWwDJuX3DjbyWZSjp+D0gtDBVDNFq1W3mgo
	 y2dl9pz/eSsgg==
Date: Mon, 17 Mar 2025 14:42:23 +0000
To: Alice Ryhl <aliceryhl@google.com>, Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <D8IMCFZJ2G7C.28DHUZGDB596P@proton.me>
In-Reply-To: <Z9gcqHihXLg6kcZb@google.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me> <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com> <Z9gL5hQWvCNy5XNH@google.com> <Z9gcqHihXLg6kcZb@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d709fa82dd85d03fde09c7bd5a390a1cececf112
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 1:59 PM CET, Alice Ryhl wrote:
> On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
>> On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
>> > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> > >
>> > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
>> > > > Add `Vec::dec_len` that reduces the length of the receiver. This m=
ethod
>> > > > is intended to be used from methods that remove elements from `Vec=
` such
>> > > > as `truncate`, `pop`, `remove`, and others. This method is intenti=
onally
>> > > > not `pub`.
>> > >
>> > > I think it should be `pub`. Otherwise we're loosing functionality
>> > > compared to now. If one decides to give the raw pointer to some C AP=
I
>> > > that takes ownership of the pointer, then I want them to be able to =
call
>> > > `dec_len` manually.
>> >=20
>> > This is premature. It is trivial to make this function pub when the ne=
ed arises.
>>=20
>> Normally I'd agree with Benno, but in this case I think having it
>> private is preferable. The function is safe, so it's too easy for
>> end-users to confuse it with truncate.
>
> Thinking more about this ... I think we should have `set_len` and
> `inc_len` instead. That way, both methods are unsafe so people will not
> accidentally use `set_len` when they meant to use `truncate`.

I agree for this on the public API. The way I usually saw `set_len`
being used for decrementing was truncation without dropping the old
values. And that is going to be `vec.dec_len(vec.len())` with the
current design. `vec.set_len(0);` is much clearer in that respect.

But for the internals, I'd say that `dec_len` is nicer, so for `pop` one
would then use `self.dec_len(1)`.

How about we keep `set_len` and make `dec_len` a private, safe helper?

---
Cheers,
Benno


