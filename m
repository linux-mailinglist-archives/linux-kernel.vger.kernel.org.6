Return-Path: <linux-kernel+bounces-530179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CDDA4302F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4F41773DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91245206F3A;
	Mon, 24 Feb 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Vi/zuP9k"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE98202F93;
	Mon, 24 Feb 2025 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436580; cv=pass; b=XSkQhRoCAhWa8kJImRmRfDKURbLBET3rbYM9UYD/dfbGHGWOrsdJ4NKFBQqGsmCYsvqer62WvnFDo4n5xqvceit55KEniT3EsEl8ohhyD7r0G1bA59w08BMJJ0ye6Gl5rXR/OHvPgapRUh+JHhO7WE57unR1gRyU5VN0uKzxFl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436580; c=relaxed/simple;
	bh=FGn/OcZD++sMSp+EacZdPtWL50VqZpRylr+EGHDXth0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I445s995mQIBsEmJ0Lg4bKpOyZqUi/pxkF1w7oB/sAZvg4YRE5fSCOnzgUMbs8VuxNlk70Y7GGm540NiuAG8VJHck5MC17QEtYbC5INvlpkydNFcwzRoNTyiKZaPys/O/Wg3U5LwqOE5BJqJYQjLqMmKyyHNsVRo82RPRq2xCBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Vi/zuP9k; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740436545; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eHWtoo5rdNpFEt3CzgTvU8EObGuS0KRK4kWHO+zNBcduUwfCpRaLwAmwAhf1noIm3VLUUcxdRnLhlvWO432AyhzOg9roesQE5vKxkx7VpggUdlJ1oBVLvCKZQHvEW9CNpWJOgR8D6VUTErRP7Lq2RAQRwdqqbxfF6C9nxKecZQI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740436545; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SdyERRxHHdW7zgOlR6t3ukNnwkuWUi84nscbihMEp6w=; 
	b=C3XMPYXlXmHMqazBpUXkiTSVuskL194HkWOJbTPrf2/U99cg3khIXYR0ltvQZDOqyDrK4Kqj4XBGPbk3ylIQRlMbeb/bXBmMFpF6+l8o/PRloESdgAh7mHzL9zV0xA/A15iJsEi2yftDP+gojmLSDRwo1K8k8ZWh69ZiLDdEC1w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740436545;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=SdyERRxHHdW7zgOlR6t3ukNnwkuWUi84nscbihMEp6w=;
	b=Vi/zuP9kxsLmIC3oWyRFl53ZGoN7CLm9BayLmRbEnPPtbwWELD5cVT3fW5nEmTFI
	SjdRi+5+YAmE++c2XW37rnCI0lQwEIj79zGLeoLJ6TPT9wQ1x8BQvg0DCQzTMVekYUl
	Y/ioV8lmkM0DbXw/L2YN6pMzDeEnJ/bePYKGorLE=
Received: by mx.zohomail.com with SMTPS id 1740436543880453.22386984310026;
	Mon, 24 Feb 2025 14:35:43 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <6f154af8-6379-4b1f-9e30-2b99f7f736dd@gmail.com>
Date: Mon, 24 Feb 2025 19:35:26 -0300
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 aliceryhl@google.com,
 dakr@kernel.org,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 iommu@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <39A0DA3F-0ECF-4FD2-A46E-4F831C194C17@collabora.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <87seo3z9qr.fsf@kernel.org> <6f154af8-6379-4b1f-9e30-2b99f7f736dd@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Abdiel

> On 24 Feb 2025, at 13:27, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
>=20
> On 24/02/2025 16:40, Andreas Hindborg wrote:
>> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
>> [...]
>>> +/// Inform the kernel about the device's DMA addressing =
capabilities. This will set the mask for
>>> +/// both streaming and coherent APIs together.
>>> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
>>> +    // SAFETY: device pointer is guaranteed as valid by invariant =
on `Device`.
>>> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), =
mask) }
>>> +}
>>> +
>>> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for =
streaming mappings.
>>> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
>>> +    // SAFETY: device pointer is guaranteed as valid by invariant =
on `Device`.
>>> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
>>> +}
>> Sorry if it was asked before, I am late to the party. But would it =
make
>> sense to put these to functions on `Device` and make them take =
`&self`.
>=20
> Thanks for checking this. The API is about the dma addressing =
capabalities of the device, my thoughts would be to group them with the =
rest of the dma API? But either way, I don't have a strong preference. =
I'll let others comment.
>=20
> Daniel, Danilo?
>=20
> Regards,
> Abdiel

IIRC, that was already suggested by either Alice or someone else =
previously. Also (and again IIRC), you were going to
split that part into a separate patch?=20

=E2=80=94 Daniel=

