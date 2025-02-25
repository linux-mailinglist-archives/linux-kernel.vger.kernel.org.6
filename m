Return-Path: <linux-kernel+bounces-531131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CA3A43C87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64810189260C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAFE267B72;
	Tue, 25 Feb 2025 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gs9tJBBj"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA860267B18;
	Tue, 25 Feb 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481203; cv=pass; b=chAJQQynesXPYyFV8ZVwGN+wVHQOQLsDhedOGLodzwggAxWn8WV1iHathV1dpovu/doJkNqstDnxG45EfcljOEgUhqzWfgpY87PFXi5AfIbgXl4A/O0DBANX7lt3G7vseul7LD63II4NXPsjPlEf6GapVPrSKv6sDkdo4A/6pIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481203; c=relaxed/simple;
	bh=kMJF5RSaJ61dbim2W+thvBAvxXWLB/VBFcKTy/Oq1fs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XpPO3E0epPVnsyvfgm0d6yj1pGqsCQEehZ7k0RaEhZxCvqBc5bNQQSCPZWWugHalKzKkfchuHg5bUxuoL/SbZIG5vbUBrReWQIYhCNXncK6KfABpOYokyd49onvZQ2/vmO7ZqKL/4XKVpnDHMdM/6yZ3LyblWZdyHQoQfrjH2Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=gs9tJBBj; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740481157; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EEOktX0Ife7MXXH/CydtCb+of+IdoQY8sPzF9qw+AIVj0BXhzRCEKxj9yQovTZ1xs5U1aYWGm82OplGqPtfveycV7rlPsklHz5wtON5m0isbiYak7ZLxfC6bsnPhqfKKD97gHDGe2WSRNbMaNfxPtZ4Lgt1ym6I5iN0EDZzGO/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740481157; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kMJF5RSaJ61dbim2W+thvBAvxXWLB/VBFcKTy/Oq1fs=; 
	b=egVWqt3dpXAKwR1H8Ap+krgj0jnBOHFu8dCv664ce42cAGg53HtLNFNANr4kJp2NieuI9T9Y655Y3R03YghkXWUgtk0/fnhx8Zik466WJt+55Kj/PQQsHgYlhf6rn3kwyGFgMMWu3HbjwgMHKORjE2m6s1o5ru7fVn5pwQmYb/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740481157;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=kMJF5RSaJ61dbim2W+thvBAvxXWLB/VBFcKTy/Oq1fs=;
	b=gs9tJBBjU5wjlAeRpSVZNDM9Cv4pqPytKW1YT6grFjwuFh0zQAOslFSHzyzpFzLa
	t3VIVorJVI2t+h4NJb2sH1aDOg0kGfCZ8Lg21y/ae3nWX7cJMLW0U5KGnywghoFo0Xr
	Sytpbk0s4dqQoKk5UUX0/bE//funywJHL3reCaWk=
Received: by mx.zohomail.com with SMTPS id 1740481154165258.02998640409817;
	Tue, 25 Feb 2025 02:59:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v4 3/4] rust: configfs: add a sample demonstrating
 configfs usage
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <87jz9ewcf1.fsf@kernel.org>
Date: Tue, 25 Feb 2025 07:58:56 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Fiona Behrens <me@kloenk.dev>,
 Charalampos Mitrodimas <charmitro@posteo.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E46FCD7-E913-43DF-91F7-417EF41A35B7@collabora.com>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
 <20250224-configfs-v4-3-9af9b5e611f6@kernel.org>
 <gFsQNuXNmyVQmdawZnfoGhTe3Fu7W0K5VeoiM5tjROpKWVojf48IOHIQT0JY77AFiTPPLHk3f_gjzEGilH7vLQ==@protonmail.internalid>
 <CB975A56-A8D5-4615-8755-04D7B0BBBCA5@collabora.com>
 <87jz9ewcf1.fsf@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External


>>=20
>> As I said in the previous patch, this macro is a bit complex. Is =
there anything more you can do with it?
>>=20
>> If so, it better be in this driver, because I hardly think anybody =
will go through the source code itself
>> to figure out. My 2c.
>=20
> I can add some inline comments on the usage here. Is that what you are
> thinking of?
>=20

That can=E2=80=99t hurt, but my point is, if you can think of any other =
example that is substantially different from
what you have, include it, specially if it involves some different =
syntax somehow.

Otherwise this is fine as is.

=E2=80=94 Daniel=

