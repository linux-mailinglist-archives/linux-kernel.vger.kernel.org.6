Return-Path: <linux-kernel+bounces-532677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D283A450D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A34188CB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74D235BF4;
	Tue, 25 Feb 2025 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lplbe7pz"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2834235374
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524639; cv=none; b=g2aq/QMBuroT/F2YeqZ5klCCNBxmHI7KRHeO1r/TVAYdW0drxEdxxqkEBidvSDse3fvUoNxhftYZ+Ww1ZSUfnZEXrUosWavF+rV4UpQQOiuq7yY9mVVW613o89j25llppUV0mAlmpZH/uUvWZpJaiYvlL5k015AyKnRMgsOUf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524639; c=relaxed/simple;
	bh=pBz9I+KEaZOCbjA3ZwZoxg+hI8zX2LqoHPTGBpCbDpw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2Az2s3pMguBey/2uUBK5uKnSsUh0ZecxQc3npm2nzvzelLwVMBv5Xe84N2E30YvttuYXXckbEyagqvw2GvOsVIovbKi3MMWmmZdo5SEMK1vji+ykK5gv20AninA06ym+seEZcop8HKaPZP6JAxfdHX362ZJFRy5QXCEeOZSe2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lplbe7pz; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740524629; x=1740783829;
	bh=pBz9I+KEaZOCbjA3ZwZoxg+hI8zX2LqoHPTGBpCbDpw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lplbe7pzev/w97HAXcMMMF629/PR7plhtfwLzZZ6S2FhCJ+B1twvwwMoFHMubBxr/
	 oGTYZlftNzw9ppNA8QIZ5/lZpwusmMar2uSmH2Os+um4gAULhWiHEZfKMB+J4/uzJF
	 U1QFWWyqnm4rJ2Rp6YlGZKqCBJBGrhRNlJ0SpESLeUWQwUH8LnWyqBP15qlMeoGng0
	 6Evjuw/G73Blw4DEPcdmzvtyXUAnb/nziyezdleWFjOPWUHIC5ExbIokVoea6Ie/u3
	 iITUnOR0OuTsDadYK2Tx2cGJiXzsg8kMUKCbikBHFNWG/VJDIoiGrvhuGrvjtmRHBv
	 3v9mdz2IE2eDg==
Date: Tue, 25 Feb 2025 23:03:44 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <ad82d675-80fc-4826-957b-6b6a66d4c9aa@proton.me>
In-Reply-To: <CANiq72=L4AHq0dNYV-KBsYy_TJwfDRwR+GTJn81EXs=xefvdsQ@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me> <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com> <a4b79751-f1c8-4476-98a5-c59fb2e545ad@proton.me> <CAFJgqgRdiQ29bWvwsu11yokZb4OFF7pYYUU=ES6CYv9847KgVg@mail.gmail.com> <c05cb400-969d-44a1-bd40-9b799ed894d7@proton.me> <CAFJgqgTs3h5YagY1RU2AZf3wKWKfXiPTE2mx7CuWyzN=ee-k3g@mail.gmail.com> <137dd7ef-b8f6-43df-87e0-115f913d0465@proton.me> <CANiq72=L4AHq0dNYV-KBsYy_TJwfDRwR+GTJn81EXs=xefvdsQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fc2b64091c08ed25fd75ed65619672fc39128744
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.02.25 23:47, Miguel Ojeda wrote:
> On Tue, Feb 25, 2025 at 11:38=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> I do not get UB when I comment out any of the commented lines. Can you
>> share the output of MIRI?
>=20
> I think he means when only having one of the `pz`s definitions out of
> the 4, i.e. uncommenting the first and commenting the last one that is
> live in the example.

Ah of course :facepalm:, thanks for clarifying :)

---
Cheers,
Benno


