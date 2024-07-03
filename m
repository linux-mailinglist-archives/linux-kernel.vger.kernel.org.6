Return-Path: <linux-kernel+bounces-240031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B19926828
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AD4285903
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628118754E;
	Wed,  3 Jul 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="hZqOvw4C"
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D914778E;
	Wed,  3 Jul 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031357; cv=none; b=cfC64FxjN5ggelJ8QgfCoTPgApJcmYjAenO2gGLCvxFEXZSvFN4VjkgPJaHk9esO7e0YSySIP4FE8fgvVs0m1mycxvxisvYU5rcv9yBe+eFHgr0hV6bqOB5vSykpzq9HyL7/i4qv+/AJwt6lgaQEFgqVretxC49zVdGXU02vttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031357; c=relaxed/simple;
	bh=L3NcVxEzp5nQ+zMdZm1I8lzij8qXeXyjjQ5F2gqLdxo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syQsOuSJ5nv62BnB22kU/whtyOrBXgAymapqfirzKfi1dUfGfad5NCbCiGggJsiG7UP9HVtPEF+3gjZebmDPyomph2p0UqRCccfFAzx6Lx64puHlUbvxrvf2yIMJD6O6A/k1/Wa2/xcNa+j8+jlXOY5IhHjHGRlUp8LUQDTs61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=hZqOvw4C; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1720031346; x=1720290546;
	bh=L3NcVxEzp5nQ+zMdZm1I8lzij8qXeXyjjQ5F2gqLdxo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hZqOvw4CIHvkRdDkrAH9bxLznrjrViPUamKEtIiq+lresBwXhY5AQ1qoU1+PJ+Ai1
	 qF5Th2gj6114phfrjYL1mRmWtGlPJw8ZXAobejJaQiuM5aRLH1w7tRy++vs/xG4Z+X
	 CaROtuntJqF6ztjpGWXjwW8S/MBsrFK9Uud0/RBJfYA6vNJ3424gJq1yFq3kvUy1Sd
	 5UiB7bjR2/P2vpCqSTiCeYFojAvnWkSQm3p6wckFYpohZjUiCQA3lNoMu4uY9EIxJ6
	 DarSTn1bf/QW/itvAlTogVg+QjLXSMnOnJrZGMwYOv0xJofMdT+LAzRPm9o7RA1cmt
	 6wyy6H0VZcxxA==
Date: Wed, 03 Jul 2024 18:29:02 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 00/13] Support several Rust toolchain versions
Message-ID: <875xtm8h3s.fsf@metaspace.dk>
In-Reply-To: <CANiq72nPyZJL7TA5wXT__wKp3z5Eoue=RB_Yphh+NCe_AkRpGA@mail.gmail.com>
References: <87a5iy8jlm.fsf@metaspace.dk> <CANiq72nPyZJL7TA5wXT__wKp3z5Eoue=RB_Yphh+NCe_AkRpGA@mail.gmail.com>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: cc9662937d5efc6765c4103eeebf592912e06793
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Wed, Jul 3, 2024 at 7:35=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk=
> wrote:
>>
>> Maybe because I am on v6.9?
>
> Yeah, you need https://lore.kernel.org/rust-for-linux/20240401212303.5373=
55-4-ojeda@kernel.org/
> -- please see the "## LLVM's data layout" section in the commit
> message.

I applied it to the rnull tree based on v6.10-rc3 [1] and ran some tests
with rustc 1.78.0 and 1.79.0 without encountering any problems.


Tested-by: Andreas Hindborg <a.hindborg@samsung.com>


Best regards,
Andreas


[1] https://github.com/metaspace/linux/tree/rnull-v6.10-rc3


