Return-Path: <linux-kernel+bounces-359588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E882998DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DBB1C23C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16691198831;
	Thu, 10 Oct 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bzwChKQF"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649027468;
	Thu, 10 Oct 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578418; cv=pass; b=OhfeR/fp9zECbIFmywoErC8faetBcNb/Rn2Dm6VaCZSkuW5JAoxh5p1+0JuaJyG98rBYJaMUlzhcg3E8oJvTISb48enG8mTTQCXNeXmqdFu8GqQMjwUPsUHQ0zFOJH1k12y0Mma7r7tNt82GB3wr/3YERPfqGnjfEfsxR72KivE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578418; c=relaxed/simple;
	bh=0Mfn8+fqlQUzraPGWvmYUvBv/Z3eDjDbyLo0ocDJ2Mc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f3L5+lszYskE09ZcnaQpIAdpeZq/UOYmAUSg1hmZQzecHIEO+WIUTgBiOaSw1l2jWwXHDA9A1XWdsgD65IVwi5LcY2ZExcjT0FqME5S29l6tOgPgE3ydTMJ/EKda2JT8dIAKeLfnoi8Yg5vSJHUpnSvvneGTn+nce0RZPxj6DkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bzwChKQF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728578373; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QDgT/pCN+yW9CHonBe+vho5IRaxixyhmTma4+fR6rMDSy4Qm+CCAnMcI6xWOEEkaG8suMkRJQTXfeTAqxqO7n8vlaMTaFTgI+ciI1JMkbTSyVS9MuQFaF1OEVBrN6pTHIiX+AQf/0BxZTB2p2Db0oapUPpdtWEZ5pU+8WO9E2VA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728578373; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0Mfn8+fqlQUzraPGWvmYUvBv/Z3eDjDbyLo0ocDJ2Mc=; 
	b=Lp0lkWwQzE2F/Dxg49NzYEp4Rheu6YjizinV2O0gF0gf8hvmRQ7zFon6MWmRoQkgzY6SSOzuJwL/ct8WpNmFx+x1xOkP32upykTFu+A+wSYkBL8zCoQVsjcTKec5Ov/beDApATJvrF65MAtpzXhDRkxsnh+pyvtinAC7Wt1AV8s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728578373;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=0Mfn8+fqlQUzraPGWvmYUvBv/Z3eDjDbyLo0ocDJ2Mc=;
	b=bzwChKQFPlV1cYlgk+5+HmveOygLY4nM/MfL3eO2GzLh88coZlLFUlo3yFD9mv7V
	4orzuE7L47ZkbAUqjShdeKwRAYL0VqRVWK3JtkN5hjtC81zzQQKvdVfh0EWmNaxFcfo
	eXnEUFi/zn7IkRJ93ZCy4vqnc8ei3Y0ai6uRYHGk=
Received: by mx.zohomail.com with SMTPS id 1728578372375338.21083008491826;
	Thu, 10 Oct 2024 09:39:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v6 0/3] rust: Add irq abstraction, SpinLockIrq
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240916213025.477225-1-lyude@redhat.com>
Date: Thu, 10 Oct 2024 13:39:14 -0300
Cc: rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B146E21-8EFE-411D-8E20-A9A3D9775091@collabora.com>
References: <20240916213025.477225-1-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-ZohoMailClient: External

Hi Lyude,


> On 16 Sep 2024, at 18:28, Lyude Paul <lyude@redhat.com> wrote:
>=20
> This adds a simple interface for disabling and enabling CPUs, along =
with
> the ability to mark a function as expecting interrupts be disabled -
> along with adding bindings for =
spin_lock_irqsave/spin_lock_irqrestore().
>=20
> Current example usecase (very much WIP driver) in rvkms:
>=20
> =
https://gitlab.freedesktop.org/lyudess/linux/-/commits/rvkms-example-08012=
024
>=20
> specifically drivers/gpu/drm/rvkms/crtc.rs
>=20
> This series depends on
> =
https://lore.kernel.org/rust-for-linux/ZuKNszXSw-LbgW1e@boqun-archlinux/

You probably mean
=
https://lore.kernel.org/rust-for-linux/20240808-alice-file-v9-1-2cb7b934e0=
e1@google.com/
instead?


=E2=80=94 Daniel=

