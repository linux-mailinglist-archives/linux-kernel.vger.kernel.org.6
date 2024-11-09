Return-Path: <linux-kernel+bounces-403042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF49C3014
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 00:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC21F217E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 23:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BE11A0B12;
	Sat,  9 Nov 2024 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="U5N3BRcD"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26611E4BE;
	Sat,  9 Nov 2024 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731195224; cv=pass; b=mkAHxMxG6yUySqI1X14uHr4aA/8fqwerofMdAuk3eym21Uruu3IJG7ww3MKlw+37y03PQvbPDdVxUsoQzodiwlU0y+wsKNUHxVMJ6PANgt2yRsvC5rA5R+CPFpxx61Zjcbu/ODUqu40TNTEJsFJ6D/eRJfbmPSeKD2H18F2DVrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731195224; c=relaxed/simple;
	bh=OTChu5Xh2WDzZYFci/Hlm2qvkrxX+jwft25slN/Aayk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZNEmcBmLQTyFrpvSa7VvqcO0F+ZmwCjxWG2whikopIK08G9TcHpUTOtldL4OvUUm8wAY/yJcAkwWO/QlHnVoSv8fxVMjvBstuzk+wne8FUjQ5SXznhTffU+EcezINpzSp3b0IMYlV+sDpwKn4+kUL3qucIofjv4pMtIcLnQJW54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=U5N3BRcD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731195206; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D8AHu1Meo6IpkWljgXCohFH2DR5rDPngrAjHkGVGboAIL8dYNq61iSUunvC97i2JQ3ezbJtoe0pGDWxbUCmzenXppJSZV1kyepNHmhHsgiFJzRnII6+ddpiNi656s1Mn/rfN8SRGw9NfPhP918QVjp4goX7W/dkthej28qbRRq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731195206; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OTChu5Xh2WDzZYFci/Hlm2qvkrxX+jwft25slN/Aayk=; 
	b=LXAYnGIHkSxQ3Z4/aMwdCkweKK+yl6b/XZMogivvlq30RwrE4jR5Mgd9TYuzhRs9oQZL4KkYEfZSLd0hCFBwHWBktRpAiMvozj1BEdw6EiqgXap7eG8E0g5qVOOBdVW0l22bVn/28Z2VQE3e/UxEVpOkUDG34PM+IgqSPva3om4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731195206;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=OTChu5Xh2WDzZYFci/Hlm2qvkrxX+jwft25slN/Aayk=;
	b=U5N3BRcDY4KoPkckbBvrE36IjVs+mRVKq2Nkr7i6UpWjl5ZwKBtHuZtEDKE4yDav
	2dctwxq7H0kao+ox6+KFcFrG7OCu6yAnJ6duh/ZTgyN+Bn7Vf/eVUa3Fs+5kzjVNjIC
	POesevw7/2jwehBxUc+1BViFv4E9aEV3dhU6Tcvc=
Received: by mx.zohomail.com with SMTPS id 1731195204964700.2759917507861;
	Sat, 9 Nov 2024 15:33:24 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3] rust: transmute: Add implementation for FromBytes
 trait
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20241109055442.85190-1-christiansantoslima21@gmail.com>
Date: Sat, 9 Nov 2024 20:33:09 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 ~lkcamp/patches@lists.sr.ht,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0A689E8-4192-4851-9650-5B76F5A30086@collabora.com>
References: <20241109055442.85190-1-christiansantoslima21@gmail.com>
To: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

+cc Abdiel

Hi Christian,


> On 9 Nov 2024, at 02:54, Christian dos Santos de Lima =
<christiansantoslima21@gmail.com> wrote:
>=20
> Add implementation and documentation for FromBytes trait.
>=20
> Add new feature block in order to allow using ToBytes
> and bound to from_bytes_mut function. I'm adding this feature
> because is possible create a value with disallowed bit pattern
> and as_byte_mut could create such value by mutating the array and
> accessing the original value. So adding ToBytes this can be avoided.

I=E2=80=99ve read this a couple of times. It=E2=80=99s hard to =
understand what you=E2=80=99re trying to say.

There are some grammar errors, but the even the key idea is hard to =
understand. IOW,
I had to go on Github to get the extra context needed to understand this =
part below:

> possible create a value with disallowed bit pattern
> and as_byte_mut could create such value by mutating the array and
> accessing the original value. So adding ToBytes this can be avoided.


Also, core::simd::ToBytes? Maybe Bjorn meant a new =
kernel::transmute::ToBytes trait?

Christian, are you aware of Abdiel=E2=80=99s dma_alloc_coherent patch =
[0]? How is this patch
an improvement over the simpler code below, for example?

> + fn cpu_buf(&self) -> &[T]
> + {
> + // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
> + // is valid for reads for `self.count * size_of::<T>` bytes.
> + unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
> + }
> +
> + fn cpu_buf_mut(&mut self) -> &mut [T]
> + {
> + // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
> + // is valid for reads for `self.count * size_of::<T>` bytes.
> + unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) =
}
> + }

I believe that most users would have a pointer to memory allocated on =
the C side, as you can
see from Abdiel=E2=80=99s excerpt above. Without a user, it=E2=80=99s =
hard to know why we need this, specially
given the simd::ToBytes bound.

Just my 2c.

=E2=80=94 Daniel


[0] =
https://lore.kernel.org/rust-for-linux/20241105104726.3111058-3-abdiel.jan=
ulgue@gmail.com/=

