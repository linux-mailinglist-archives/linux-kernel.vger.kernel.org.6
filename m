Return-Path: <linux-kernel+bounces-519362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AADA39C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9293B5D30
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681AB2417FD;
	Tue, 18 Feb 2025 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="k2o8+YsR"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18B10F4;
	Tue, 18 Feb 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881228; cv=pass; b=sytStNd5nX1a5UNPT9M7otKh2FXv9tPDh9z2b3D2sbtHgkmx5jGr1jEoQMpgYWYSNsUWxzG9jzP3oUZ/Hvo/d8raqq/n0aIp2RrH8JAx/+vBFss34ujob3/kaVJ9E7kbI7PofqufS1+Nmsq89sy+agTVQtChkwV1uSyLVGEzA2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881228; c=relaxed/simple;
	bh=7wG+k/J27UhE0wr9moyh2JThWcB7wEZyZUkzLHmMNAc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YMkl7amyO0D6fn+tBCiVuri41gt8OVjjzx6YYoC9rVpvLufnhrEOgdMCNrn66MoH0uEZkq/o/w0Ug5mCO/0t79RXTCwk2X2Z/sl91nVvSE+bQYaSdG2KTXQdSNnvbo+p6bRbz2EeH9whmKGonNYb5XceUPE1dWOYl6Nvgu5cTF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=k2o8+YsR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739881194; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oGjXYGqxVAaQvjPL6J0oChYi7O14uxalRxAVSbOKNImPXpApIvWUQq2ILUaSiOvArjnGS07kGjCHwaXHtyf8AgMZJbnnfi3E5GzyBrAD5+gMTYj7VMAROAfNihIfANS3uxSTAgXJBzoucH7P8Ch7QGjD1WpoQ/qZ9KDNNsxwOjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739881194; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7wG+k/J27UhE0wr9moyh2JThWcB7wEZyZUkzLHmMNAc=; 
	b=ZFW7JcyThRzv5FOvC4onq+bxF4M8EaRZk6aZD/JMEb9Tt6UiYac2mC1Xdj4MZBkwXlM3jR0JR4I9ktA4cI2umuSaK1K6HXbXtSZuhOST0ajwjoNQRtW9yvJW8S1z2mQ8XTB7s3LXv1VYLhvf6EcqZK5Ck/uifFl3I4m8dUh5NRs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739881194;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=7wG+k/J27UhE0wr9moyh2JThWcB7wEZyZUkzLHmMNAc=;
	b=k2o8+YsRfBvh1gD5rj+DG2L7sdQoD7piyxZp0lABE4/bbdDs5gFtBKlLDVTVJz0T
	JBbiJuECpD65vbol2UnZghnPNwCd5qFBq5HQn6f0d85ixjXuMY1APaC3pWEh/A0z37s
	QkMwt+/1GnT6tHXOx7EycRrmU1saERxg/p5qo9Oc=
Received: by mx.zohomail.com with SMTPS id 1739881191996449.9203601583672;
	Tue, 18 Feb 2025 04:19:51 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <2b019479-2d32-433f-af78-c3378dee4e2b@gmail.com>
Date: Tue, 18 Feb 2025 09:19:34 -0300
Cc: Robin Murphy <robin.murphy@arm.com>,
 rust-for-linux@vger.kernel.org,
 dakr@kernel.org,
 aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4FEFE5F-77C4-4ADB-AEFA-2580CA75BCFD@collabora.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <633274AD-E55C-4A90-AB72-33D3E176176F@collabora.com>
 <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
 <2b019479-2d32-433f-af78-c3378dee4e2b@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Abdiel,

> On 18 Feb 2025, at 06:58, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
> Hi Robin,
>=20
> On 17/02/2025 15:52, Robin Murphy wrote:
>> FWIW we've been wanting to steer away from relying on the default =
mask in new code, so it would be quite neat to actually enforce that =
allocations fail if dma_coherent_mask hasn't been explicitly set =
(assuming it's sufficiently cheap to keep a flag in the Device handle or =
something like that - it's not the end of the world if it isn't =
practical).
>=20
> I just had a quick look on how to possible approach this and indeed =
would refactor the Device binding a bit. If it is okay with you this =
could go in a follow-up patch? I was hoping to upstream the initial =
support first - at least with the dma_set_mask/dma_set_coherent_mask put =
in place already.
>=20
> Thanks!
> /Abdiel
>=20

FYI: I don=E2=80=99t mind a follow-up patch.=20

=E2=80=94 Daniel=

