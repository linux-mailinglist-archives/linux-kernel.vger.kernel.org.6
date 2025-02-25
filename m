Return-Path: <linux-kernel+bounces-530896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2F6A439F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFE816F509
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C626157E;
	Tue, 25 Feb 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hvrX7kV1"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77255207653;
	Tue, 25 Feb 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476397; cv=pass; b=ngiSj0d9kFTLaDXGuEWUlJb+z1WopAjg73DJUNginOLZ1S6u68BK/iG3IspWaVSgEnM4wGqeLdgFQ4Y3Hutjxj240jg1g9BBxOVuHPmRaqDO20IMp6zGiACTdcbKAM0yBve4oPSltjNqI7wMt92dZXSbBn1m9kcZ9/wNOOaECKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476397; c=relaxed/simple;
	bh=UzMDKQkt/APhAY845N7QOMHur70PW2mkFrgoMVI+9Hk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K/fPZ535K6GdgWJstqsqdeQThbgXifcbSMh7SLgyca2nA4qVPcC3W89R9b5zXrpdzMQaGBfNf64Bzbi3M4tGsBRDsJqyjn8fQQZQiH+J7Ax/ZwAsiJqNUsfAaZA6KBiIhnGNIYfKYxbSdkJcg8unR4nYJLXN3LKtEx5tYGUBmBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hvrX7kV1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740476343; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lKfwm+GPGJHlomdOtbhL4nq673l9r+hfg/rzvXJLptro37IyLVJkuwTn1bISBbdYQNzNv6iqLdiv2RJZ1LV/waygQ+hbKlWlCvOc1QvjSf1PQ6MjlyjvIIe9iOlURL9rdVsbs7TBUpGznokogv9nvxAYzTwiSYdH+93d/+JQREM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740476343; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aFI/b2Tgjv0Ejq2UEKDmEnSYenBMkOjErWg/HfODXaM=; 
	b=MeuxPlFZhCK/HUxOfsw3E5IfUTYhlHyX1xaYNNkRqt+4aqso1ZuFGo1ac5qjswMaukwdpgBedPpzodtdGTae4I3fw7Wmyg7mfSgoZ29RkDih9oxyD65kwzP92Rw1GW/bC7ZDJxkFMVU3VtyQJem3y7gMUi28ZmmtuMsVFyWZpYA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740476343;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aFI/b2Tgjv0Ejq2UEKDmEnSYenBMkOjErWg/HfODXaM=;
	b=hvrX7kV1Khy07WyM9Yc3x1OUPJLy6kTcKN3Vbpr9KTLdMwsEtnni2IsI14jk1Wda
	KbzQCO3d8TrVmvgEK9Wp++bjQNC/kF7wF9lIzGWqa8MOTp1/E7RS3MnCywn16nOc478
	9ZP6m8TMz4yMjzzRzroG2dewbuQFAMxZGc3Ovo9M=
Received: by mx.zohomail.com with SMTPS id 1740476340814587.5627182901516;
	Tue, 25 Feb 2025 01:39:00 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v4 4/4] MAINTAINERS: add entry for configfs Rust
 abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250224-configfs-v4-4-9af9b5e611f6@kernel.org>
Date: Tue, 25 Feb 2025 06:38:44 -0300
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
Content-Transfer-Encoding: 7bit
Message-Id: <FF9232AA-9511-4E55-BC7C-EE42EBB8FBC1@collabora.com>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
 <20250224-configfs-v4-4-9af9b5e611f6@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Andreas,

> On 24 Feb 2025, at 10:21, Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> Update MAINTAINERS with entry for Rust configfs abstractions.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> MAINTAINERS | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..9b4d5c12eb43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5870,6 +5870,13 @@ F: fs/configfs/
> F: include/linux/configfs.h
> F: samples/configfs/
> 
> +CONFIGFS [RUST]
> +M: Andreas Hindborg <a.hindborg@kernel.org>
> +L: rust-for-linux@vger.kernel.org
> +S: Supported
> +F: rust/kernel/configfs.rs
> +F: samples/rust/rust_configfs.rs
> +
> CONGATEC BOARD CONTROLLER MFD DRIVER
> M: Thomas Richard <thomas.richard@bootlin.com>
> S: Maintained
> 
> -- 
> 2.47.0
> 
> 

Acked-by: Daniel Almeida <daniel.almeida@collabora.com>

