Return-Path: <linux-kernel+bounces-545027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00BDA4E837
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80AE17CFE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB5427C86B;
	Tue,  4 Mar 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aYEeSW6P"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E02517BB;
	Tue,  4 Mar 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106943; cv=pass; b=F8mDs2z/uo0ChYHAJycPRyB9lxrCeuvLgl9dGdA6Gt7Gv5nQY7xipxMr6ESmrGTz2pJRiUXbuoSWYwpLg4/0elb1bpQHWUZKSuPg2YTJN0dHMDAia+b3fRCLQEZebKts1jR58EFd6wCWTdX5CH4dRMiaa8WgBO1d/Z1V3K3t5kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106943; c=relaxed/simple;
	bh=4RAoUkuf7ewwJ8cnrWg8tsLrSLar35HtgkvQotfrXug=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SiLvpzpdQCe4dkbz9vfDcMVUcSQlZdBAPOQ2E1qVHW85WsmQbWSVpZCD/obtP1EmK4nc1QzpqXizAN48oh5IFCua8+GATPaIXKuulglEkwLzEf1qlIQNxnkYzqdiWmA2vk4XssOh3q4HU0MYUV+xpnQklsVTM2synOiQn63tCsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aYEeSW6P; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741106922; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oD6ujRjG+rsYxCx4iGEyaaiezw/7wmwGdhJZAMizG4U8lFLrUl+m4d/2FWA9Vk55Zzyp6IJzFNBWQLVHxw7S4+aR/s3c4BurtrA+YVdeI814VUvKQffCvVlHGvHNXGaTxsUS5PlPJqubP9dAi0UpLAiK+3QQFuW92qdOjwctNN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741106922; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dwy5+ghU3OdxRxXJ5Gg2zsehsrGVRP88ZDUxKwxlNq8=; 
	b=GotW3QTbO8u6iESn0fn7Mly94JXRKfTNeqUsQmApfpVfnvxgtNpeF77VZdJs4VAYGfd8jD5nCm+Lx0QLalU2bZNfL2rzWhuwmmE8ss2YFezIgMm7V5u2o3Xzl/XZslXWFRm4DCtKy9Wl5fXqrqLxihh476cy0NRTdnhO7STvhJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741106922;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=dwy5+ghU3OdxRxXJ5Gg2zsehsrGVRP88ZDUxKwxlNq8=;
	b=aYEeSW6PsY8U0KJa4Sy+jfb6NwH6ByLrAY0Ioui7hBX6296opa/L2UGvo2IVT5el
	gOObVd4rtiXEvHXe/5vt4ifnwSg8/nHE2KSyuzGdJY18S33/A5m/O9Zd2bDTV9N8QAk
	GECH72e8TOvsIfEKhBa9HWkNqt6QYVvAZj2KpH6g=
Received: by mx.zohomail.com with SMTPS id 1741106920056781.2730201045849;
	Tue, 4 Mar 2025 08:48:40 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v2] rust: irq: add support for request_irq()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <87cyewhpxj.fsf@kernel.org>
Date: Tue, 4 Mar 2025 13:48:30 -0300
Cc: ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,
 tmgross@umich.edu,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Alice Ryhl <aliceryhl@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE595E8E-CB77-4E8B-B6EF-215CCAF5580A@collabora.com>
References: <u-vC1KbeOK3Fd2PClzinb8LmqS_dntOW-pOSmZIFWotCZeTOg30xR_GYUc4oReAKZeuuu7ZaXWzfeTkpGMlr0A==@protonmail.internalid>
 <20250122163932.46697-1-daniel.almeida@collabora.com>
 <87cyewhpxj.fsf@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Andreas,

I will address your other comments later this week, as I=E2=80=99m off =
for a few days.

> On 4 Mar 2025, at 10:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>=20
>> Add support for registering IRQ handlers in Rust.
>>=20
>> IRQ handlers are extensively used in drivers when some peripheral =
wants to
>> obtain the CPU attention. Registering a handler will make the system =
invoke the
>> passed-in function whenever the chosen IRQ line is triggered.
>>=20
>> Both regular and threaded IRQ handlers are supported through a =
Handler (or
>> ThreadedHandler) trait that is meant to be implemented by a type =
that:
>>=20
>> a) provides a function to be run by the system when the IRQ fires =
and,
>>=20
>> b) holds the shared data (i.e.: `T`) between process and IRQ =
contexts.
>>=20
>> The requirement that T is Sync derives from the fact that handlers =
might run
>> concurrently with other processes executing the same driver, creating =
the
>> potential for data races.
>>=20
>> Ideally, some interior mutability must be in place if T is to be =
mutated. This
>> should usually be done through the in-flight SpinLockIrq type.
>>=20
>> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> What is the base commit to apply this patch to? I am getting some
> compiler errors when trying it out:
>=20
>   error[E0308]: mismatched types
>     --> =
/home/aeh/src/linux-rust/linux/rust/kernel/irq/request.rs:240:21
>       |
>   237 |                 bindings::request_irq(
>       |                 --------------------- arguments to this =
function are incorrect
>   ...
>   240 |                     flags.0,
>       |                     ^^^^^^^ expected `usize`, found `u64`
>       |
>=20
> [...]

This patch needs a rebase. I=E2=80=99ve been waiting for Lyude & Boqun
new SpinLockIrq series, which just came out last week.

I=E2=80=99ll work on a v3 soon.




