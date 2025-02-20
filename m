Return-Path: <linux-kernel+bounces-523322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F7A3D51A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A8C3BCDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688F1F03D2;
	Thu, 20 Feb 2025 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="F548C7qr"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC01DE4D2;
	Thu, 20 Feb 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044592; cv=pass; b=EEs2I79OqPG9uFqai6yOT/5RykDnzxxUsIpCWLrVmtwJ2Qecuh1YIdXM8sacSs2PtHlEU3PnNyLypSIkW+DQm/Hoxrt4FQI2TuTb2aApPyy06GDAOzbeLyAu1A9bk0urI7rgmP8UZ6W2tsRqAkXv0f9zki29GStsdzeDzdHcpTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044592; c=relaxed/simple;
	bh=X0VeiW5jvO2DWfIISsx666tpZYWzFwJZKbBhi8i0+Bw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tgyGSvTvCF/gNFOR6QOriV7wR5VK7AFunIHQh8woos08ZaholDGHoRIzozT8VKUJTpE/eLfL5jHRAKQ2G6hTpZv7zE8KaZ8cJgnuc7yjWLwsZXIH8OzbfgEayZ6dAnivvFjQJ3j1yEoblP7u3JQpsoT5l91AbIiizqPDxwVL83Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=F548C7qr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740044565; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YnRMlazNktHPkIJxQHEi2TMJg93m1xEYcwaZ5kYWLqBbXibFI7b4rQzbSFsKfju+zqCReMD8HK0YqRFfrw6a2VQV4lMC9Jz4PywCcTJNQH4XYZ5Go8aKZ2wEibi0anZn1hWwI7r4fjQ8CGjoj+Fj2zd7GzBuQt34XDtBxbeZEmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740044565; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G1w/QgJH/sS0bXOc4MnMWKj+MEaxGsFuliB931Wa9fw=; 
	b=lh34xO7OIpdHb5j3v5PvWf8nFdWsL9Qn8SuYw7oP6Yf9IPezdyHsAQ3H4lyPKTTw3dBCUDLlDSucQLxbKgi/7i38YeCmsrRtCH1FfuWRPIvIBr9Op20pDxM/7sMHwR52CMbblLpLPO97xa7YtGX/V3rKnxXiuPMnYOPyuL6+GKs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740044565;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=G1w/QgJH/sS0bXOc4MnMWKj+MEaxGsFuliB931Wa9fw=;
	b=F548C7qr110UvJghNgsV248jCxTkN4C0LyWnXWK+PYvWLy+sScWufzCmt1EijPuh
	+be+DkTZqoSsxbm4JXB/hJLA92Y+GUAJ/GdtNU+yJ2ydDiYJEq+MXEnPj1YL+EhuTSI
	bbLsYuQrEBe6hy7fhvifrLdEQMi9aaJvVjxIjecw=
Received: by mx.zohomail.com with SMTPS id 1740044562759715.5588790038047;
	Thu, 20 Feb 2025 01:42:42 -0800 (PST)
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
In-Reply-To: <Z7aHQBYXZ5jlGRte@finisterre.sirena.org.uk>
Date: Thu, 20 Feb 2025 06:42:25 -0300
Cc: lgirdwood@gmail.com,
 sebastian.reichel@collabora.com,
 sjoerd.simons@collabora.co.uk,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org,
 benno.lossin@proton.me,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7099F7DD-C806-4DA9-A7C5-595428289497@collabora.com>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <Z7ZjzJ2Rfrt8j0s1@finisterre.sirena.org.uk>
 <5E354BB7-9CD5-4615-8EAF-98B9F498713A@collabora.com>
 <Z7aHQBYXZ5jlGRte@finisterre.sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Mark,

>=20
>> I asked for a few opinions privately and was told that =E2=80=9Cif =
the C API prefers not to do that
>> why should you?=E2=80=9D
>=20
> Well, the C API also doesn't ignore either enable or disable =
attempts...
> the theory is that if the consumer messed up it's safer to not power =
the
> hardware off suddenly when something might not have been cleaned up.
> The general approach the API takes is to only take actions it's been
> explicitly asked to do, that way we're not hard coding anything that
> causes trouble for consumers and since we need constraints to enable =
any
> action that gets taken we're less likely to have default behaviour
> causing hardware damage somehow.  If we think we've lost track of the
> reference counting we just scream about it but don't try to take
> corrective action.

So, are you OK with this approach? i.e.:

> ```
>  fn drop(&mut self) {
>=20
>    while self.enabled_count > 0 {
>=20
>            if let Err(e) =3D self.disable() {
>              break;
>            }
>        }
>  }
> ```

Where `enable()` increments self.enable_count and `disable()` decrements =
it.

>>> Perhaps an enable should be an object that's allocated and carried =
about
>>> by whatever's holding the reference, I don't know if that plays =
nicely
>>> with how Rust likes to ensure safety with this stuff?
>=20
>> As I said, this doesn=E2=80=99t work very well, unless someone =
corrects my reasoning on a
>=20
> I don't think I saw the previous mail?

You didn=E2=80=99t get this?

=
https://lore.kernel.org/rust-for-linux/Z7aHQBYXZ5jlGRte@finisterre.sirena.=
org.uk/T/#m9348ad4fdc056d7f6d0bfec6529d4c80afdcd335


=E2=80=94 Daniel=

