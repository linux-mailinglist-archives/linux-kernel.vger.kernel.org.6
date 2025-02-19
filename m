Return-Path: <linux-kernel+bounces-522090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADC2A3C5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812053A3D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185A12144A9;
	Wed, 19 Feb 2025 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GsU00JH5"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101221423F;
	Wed, 19 Feb 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985076; cv=pass; b=TKlxl4fDnJyNO8CnSEX9W+fZ21kcjd1/WdwO9bUwzqYb8F6yexQR2XjW44I3PIuZkvcQliRySydclppUdyhdrVEoZECfoiAK52cKHAlPu0Uk+cozdMGT3NpRLE3tgFojvVoZpl5NbF8+Ew+rH1QTw4Iy3iXzq2CEfyG0O6yoDsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985076; c=relaxed/simple;
	bh=64//cwvqZljD4DhFAn2LbHsdiVrVrYGj0JhPZZKChF0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KG83Iwb8rVH44WAWgZIfXaIzCpPBqnY9oGuZlE0Jjao8SGQBEzzU+Av6W2TCvkhw3J5Doa6v+Vt3K3dUF6vzErSH/eLRFUxTkr1qIuT8Jeid9Us1vgXHfKY/7vneHuq1CMatASlw+2aVoXaU8ytJujs4IqUYpkasbo/opZPTW+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GsU00JH5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739985048; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B2gQVaWKYzh9iY/yq6HzDStvCZuc2z27HYNs55w+7ixPz9ccT/gUQSk5WDVLo/okYCync4b0f5+FtPfgDb1R2wLKeu9XPfcrJ651+PPTrehwDWrrS6Ami3vfp1x6NICau1YMrpw0TwlY0TeaXGtKtG9gzs05odx+gKH7aipenow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739985048; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=64//cwvqZljD4DhFAn2LbHsdiVrVrYGj0JhPZZKChF0=; 
	b=kJr/8t/3snpCPutPOGSF+Uv30Wj6TPJXHWjYeFwQt4uzS3bO5J39qxfgSDj4ahTMrMNFw4PIMphDSY4uOaCXvWjpE0f2Led6Q+SnJ9mc8cgdfMeAWf/oKKkZfZ2PcDssZEhZF+39be8zX/saeYrYzJfZxQ9xu0MiSVmU4CsMvDU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739985048;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=64//cwvqZljD4DhFAn2LbHsdiVrVrYGj0JhPZZKChF0=;
	b=GsU00JH5GuZ25c9v3NmLIvoWgw0Q/HYE0/HIN7FjgWSsn4urIZ5dwUa03INZbCBK
	P2dWMJyNGWsuXGZL365CspqPxQndUX8K8/oyXH0RQKkilRPm0G83p2gmt2nmf0dLuwW
	Q+793qYsAx6h48FA3rk9nkxLW5TISKoSeZmGgveo=
Received: by mx.zohomail.com with SMTPS id 1739985042434177.93514813296724;
	Wed, 19 Feb 2025 09:10:42 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgiErvnziU-hSCV6djNq7Q56ZfX9gZudmX7+r06hWoX0Tw@mail.gmail.com>
Date: Wed, 19 Feb 2025 14:10:24 -0300
Cc: lgirdwood@gmail.com,
 broonie@kernel.org,
 sebastian.reichel@collabora.com,
 sjoerd.simons@collabora.co.uk,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org,
 benno.lossin@proton.me,
 tmgross@umich.edu,
 dakr@kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <CAH5fLgiErvnziU-hSCV6djNq7Q56ZfX9gZudmX7+r06hWoX0Tw@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Alice,

> On 19 Feb 2025, at 13:28, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> I wonder if enabled vs disabled should be two different types?
>=20
> Alice

I thought about having two types too, but I think it complicates the =
design.


```
let foo: Regulator =3D Regulator::get(/*=E2=80=A6*/)?;
let foo_enabled: EnabledRegulator =3D foo.enable()?:
```

Let=E2=80=99s first agree that `Regulator::drop` is the right place to =
have `regulator_put`, since
`Regulator::get()` acquired the reference in the first place.

This means that now, `EnabledRegulator` has to depend on `Regulator` =
somehow to ensure
a proper drop order. Otherwise you might have an enabled regulator for =
which you don=E2=80=99t own
the refcount. Furthermore, if Regulator drops while EnabledRegulator is =
alive, you get a splat.

In a driver, you now have to store both Regulator - for the refcount - =
and EnabledRegulator
- as a way to tell the system you need that regulator to be active.

If EnabledRegulator is a guard type, this doesn=E2=80=99t work, as it =
creates a self-reference - on top
of being extremely clunky.

You can then have EnabledRegulator consume Regulator, but this assumes =
that the regulator
will be on all the time, which is not true. A simple pattern of

```
regulator_enable()
do_fancy_stuff()
regulator_disable()
```

Becomes a pain when one type consumes the other:

```
self.my_regulator.enable() // error, moves out of `&self`
```=20

I am sure we can find ways around that, but a simple `bool` here seems =
to fix this problem.

Now you only have to store `Regulator`. If you need another part of your =
code to also keep
the regulator enabled, you store a `Regulator` there and enable that as =
well. All calls to
enable and disable will be automatically balanced for all instances of =
`Regulator` by
virtue of the `enabled` bool as well.

=E2=80=94 Daniel


