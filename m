Return-Path: <linux-kernel+bounces-575455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCDEA70292
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D25C16E98E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109EC258CFA;
	Tue, 25 Mar 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="B/mRhEa4"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BFD257421;
	Tue, 25 Mar 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910008; cv=pass; b=OmJQad5wbDthmOlMq2SFtwJocsej6E5lBbxnv8wUtQPMkv3SgI4vLBo9gDZd9D5tAscUW8nPpJ/3hzQtG2yOXKmuCdNM0IrMeTcFwYmmZYAC5/91c+VU0ThPLU9I+Fj3XlQfKobhC5EE24FQWm7ZmLeC/m2j0c5hreOyA3RIpQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910008; c=relaxed/simple;
	bh=E1aLYMGnS7zKaLY/UfigWOGLX5sjhXJl+77d7eid4vU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EskKMUeXkOMWZpNtQBOEG7DPIsof6JjwYmNBBkhSKZIbY8LA3ywqVuib/u5UGb+0U1iR5vGav3wCaqO4bpz5kt3h00QBch1RVA5WjhmDHkI+wfoXw57aY/dnYqqK6V0G6wq0Osyav03f8jMMhZkhvtb8sIZOwdtiTVepHb/0WpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=B/mRhEa4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742909981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JK8Afb3KUgbrCxmWZlnLN9jcBM10Klc6bIpIEl6jHNexPloQsRLdqFYV1SqCZnMDFDY88X8tPmRhE0+b9/TiB4EHEcd5q77NV5a7rYORIITi6AHxtkp6RKNb3JHJq33T7+SCO1rkNg/SU59MQHrBj3qZp3KLgQrEZKkNGI9+VOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742909981; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E1aLYMGnS7zKaLY/UfigWOGLX5sjhXJl+77d7eid4vU=; 
	b=VCa+IKIzfxwOjBv7+51ra9ot4DvryeQdFUV5quXUv4wqhjIzUQuq8n9gfzxYv9punyorHHvIIlGOUTKH9y6iJIjWMKFuDix3goaK9Nsze5kt6dXnqPU4bLj/7h4+/BPdqE430eD7d7MDdS/7uYQU1oBejWsRzUbpWBCd4sIBrbo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742909981;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=E1aLYMGnS7zKaLY/UfigWOGLX5sjhXJl+77d7eid4vU=;
	b=B/mRhEa4JAqwExkPR9JLiW4JHiboptNPN0hF5f1x3P0s3JVNRf9dIgioG4QV8BBF
	TQ0DUWpB7cGV+YHbHDSq73NMrf8QzXCT62U8jy8f/5OXEKtaEWRscfemvn719NlVtgw
	ktVzQajUYFhaQBcXpxLyBFeHL6hKYtoZFMrFnXnA=
Received: by mx.zohomail.com with SMTPS id 1742909980149878.2853274737729;
	Tue, 25 Mar 2025 06:39:40 -0700 (PDT)
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
In-Reply-To: <FB3D0F03-B162-4AD5-B288-4E307421276B@collabora.com>
Date: Tue, 25 Mar 2025 10:39:24 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
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
Message-Id: <3DC4063A-3E9E-412B-AAF4-AA0C33DEEBFC@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-5-1f51f9c907eb@gmail.com>
 <FB3D0F03-B162-4AD5-B288-4E307421276B@collabora.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Ah, by the way:


> On 25 Mar 2025, at 10:37, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
> Hi Tamir,
>=20
>> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>>=20
>> Python type hints allow static analysis tools like mypy to detect =
type
>> errors during development, improving the developer experience.
>>=20
>> Python type hints have been present in the kernel since 2019 at the
>> latest; see commit 6ebf5866f2e8 ("kunit: tool: add Python wrappers =
for
>> running KUnit tests").
>>=20
>> Run `mypy --strict scripts/generate_rust_analyzer.py --python-version
>> 3.8` to verify. Note that `mypy` no longer supports python < 3.8.

$ mypy --strict scripts/generate_rust_analyzer.py --python-version 3.8
Success: no issues found in 1 source file

=E2=80=94 Daniel=

