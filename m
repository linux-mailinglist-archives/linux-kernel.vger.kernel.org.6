Return-Path: <linux-kernel+bounces-575552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9EA70404
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8851899CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BB525A35D;
	Tue, 25 Mar 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Dpgy+j9n"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A74255E20;
	Tue, 25 Mar 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913662; cv=pass; b=QyWRmJ7yx9iG4kc7G7bccHPUVCWLz6vYfiosI5c9OnVqtUO5KaFuUKa8ek+uXGZeBtzzQDefajgly5e8XGXV8iWUxpbTQDq9nwe7yElTqo24WbzEaJi/ZwbxIHvjU9F7jQPHJLYZ3Lmy9P7SwnX6PGt/1aAkHR56DorY3Go9eB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913662; c=relaxed/simple;
	bh=63lOYZV7NkFONXEi2MTSmxaYbqmMmjBPS/7IpjDqqfU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DaL8NFBiKvIrx+Arw10sLjZmMZzJ6nR0s3kySOI8RpQo7d3LyMz13QE3qtruNEN8EeA7mZwdb/DbysOs93px6ffl/vMoypbcCIdugtx8Arb+m9R2df5Xc6aFfwq2REJ4imUVbPk4+6KRdUIZFhGkVwGywpPutdGdWSx0u7eIhow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Dpgy+j9n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742913635; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mSK7534lsmuMY1yU3gzoUV4tV9NhSWqiA1nNa+QGr3tJ1iDqZQdkBB1krYOQQ8Kx73pVuKGStY0yEd+LMqMO8DlIWWfAJthF7lu0C3z3gEhK9gyFp4Qh9JZoEh7euxkXOV2RnvXfEUEM5FoEFo64vUSzbXmpEPkX0Q0u/g/nurI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742913635; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=63lOYZV7NkFONXEi2MTSmxaYbqmMmjBPS/7IpjDqqfU=; 
	b=YRmQFIRSoaE051hfd9AeUGSOqAv4Nb5xB+lS0L7cGG3NnPmHuf0VpFq5cZXxOFlbeMcFXy+Q6pkFnYInRL11pN8IgXxyxLSFhj4J5vOJ1hWqUjfU7FvFKp8FaibDnARHwhuTTS9850NBZDJ5nfPdN1q1WyJcu5+t0CSFLbZXEuc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742913635;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=63lOYZV7NkFONXEi2MTSmxaYbqmMmjBPS/7IpjDqqfU=;
	b=Dpgy+j9nXqCUsuO7ZDmq6VCajWqGeZZqZ9vqo2DVta1FVyf3kqief2gogvd2uIiT
	dQHuIuDMEDh3dgQASRoJ42Of6JLLV3CrZkeFxxoC3czJz8sxitdFQQShdKDc0z0hQmj
	YgxjpKT8e1L3aweyqkbQQ/3s+/L4aMjI9acSr+Rk=
Received: by mx.zohomail.com with SMTPS id 174291363222697.63769696253098;
	Tue, 25 Mar 2025 07:40:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 05/11] scripts: generate_rust_analyzer.py: add type
 hints
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CANiq72k0J1PqH6mQ3DJVMbM=yrzXsFZU5NpDX-rPU-DP_4QHeA@mail.gmail.com>
Date: Tue, 25 Mar 2025 11:40:16 -0300
Cc: Tamir Duberstein <tamird@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Boris-Chengbiao Zhou <bobo1239@web.de>,
 Kees Cook <kees@kernel.org>,
 Fiona Behrens <me@kloenk.dev>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A2F6F3A-D86E-4F9D-B0F9-6E37FE15E8EA@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-5-1f51f9c907eb@gmail.com>
 <FB3D0F03-B162-4AD5-B288-4E307421276B@collabora.com>
 <3DC4063A-3E9E-412B-AAF4-AA0C33DEEBFC@collabora.com>
 <CANiq72k0J1PqH6mQ3DJVMbM=yrzXsFZU5NpDX-rPU-DP_4QHeA@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Miguel,

> On 25 Mar 2025, at 11:19, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> On Tue, Mar 25, 2025 at 2:39=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> $ mypy --strict scripts/generate_rust_analyzer.py --python-version =
3.8
>> Success: no issues found in 1 source file
>=20
> Should this be a Tested-by? Or am I confused and did you mean =
something else?
>=20
> Cheers,
> Miguel

Yes, that was a bit convoluted, sorry.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>=

