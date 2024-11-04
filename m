Return-Path: <linux-kernel+bounces-395439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A79BBDE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50591C21E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC718DF8F;
	Mon,  4 Nov 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GSqPSLPZ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B4AD2D;
	Mon,  4 Nov 2024 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747997; cv=pass; b=JtdIe/VDNXco1aZye9cn+4wsAURHZbMHn//T8wlIMeFAzdAZo5eUuEQhLVx4y3uhOmKuvXzwIb1I5H9YnmvdtPlj34E0C2lFFoQXEn7yXfQJqFToOUbBuinb4W2qZpAIPPwDFcchCoOdGRVOvuQ1ra+LsmuV11bxyBexRJZpO/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747997; c=relaxed/simple;
	bh=zbNYl5RY5/49ulL2/Ro5OEqk2Qd270rdKotK9zKL22Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iymzzAAW7pnwpVZ138xlU5GupJV1y8yDqPyBOuSa0f+X/RKV2vuFM3MgMp/f3ts4jGjRAa2Gqb6rGdp279C2cQkCjjixFUe4jfeQ5IHPF/z3xvwaRsz311CnBWcGMXTW+NqnD5FX3WiRHBw1H7yPvuKd1gEbQ04dNLxIQoz1UJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GSqPSLPZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730747981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YAICD64OoN8Pc21yQvw+tGpyKyfTqhyZ4pXFZ0KjgoBaS7FDnWi6SE20HiyYXHqHh8DwtRVLnxsSKk03RVCXeYZJgZ0c1yBnXOjgJxOgYwqz6/PX26ZcQZ/ch+FrcBluIOSFHs/dSWKhpmfbUqhW8rNb97xy/2qgy/4BfJpfBAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730747981; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zbNYl5RY5/49ulL2/Ro5OEqk2Qd270rdKotK9zKL22Y=; 
	b=YEdlHIiYCsbStUMX7DxdneuaxjTEOJ1rkJZWbJrvjgYb8hJkpUsOA0WbPkSe9LSDp1XXjwcQCkh3wy/621kgiiLE4i0kCHfTMGURgeeTy2CqPhleIYWPnshqS18eYZWtTfDnPB/Te5nt629K/9P6zVtIGBXRJlars1mCdXIzzJA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730747981;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=zbNYl5RY5/49ulL2/Ro5OEqk2Qd270rdKotK9zKL22Y=;
	b=GSqPSLPZog18hHwrB4G04pY2YrzAEOR3yfB2qn9Z9l97I22oXxhjPA2t+tpYgDqO
	g9Ook03lkYk/IEgIgiG6RtbSjelF1hEDkdvD7NGR14Py9s7zx97I+evhBQoSA9ltV+t
	Sh794x5mR9IH3i1s95zC5QOFbdwH0rrujbvruXi0=
Received: by mx.zohomail.com with SMTPS id 1730747979393312.83221910305576;
	Mon, 4 Nov 2024 11:19:39 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] rust: irq: add support for request_irq()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjmfzTU_88H4mGiv++CbBj0xB5AoiimULCEx_b0wsMmMw@mail.gmail.com>
Date: Mon, 4 Nov 2024 16:19:23 -0300
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D72CA8B1-E71E-410C-AD7E-D7A81CC3F807@collabora.com>
References: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
 <CAH5fLgjmfzTU_88H4mGiv++CbBj0xB5AoiimULCEx_b0wsMmMw@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Alice,


> On 29 Oct 2024, at 08:59, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> Both regular and threaded versions are supported.
>>=20
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> Why implement request_irq over devm_request_irq?
>=20
> Alice
>=20

As we spoke earlier, and for the record, devm will automate the
lifetime of a resource, taking care to relinquish it when the driver
is unloaded.

I feel better with an explicit `Drop` implementation, which is why
the devm versions were not chosen. IMHO, the problem it was
designed to solve often simply does not apply to Rust code.

=E2=80=94 Daniel


