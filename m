Return-Path: <linux-kernel+bounces-546367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3817DA4F9B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D1A1893014
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D082045B5;
	Wed,  5 Mar 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="MBwejrHQ"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA013202F9A;
	Wed,  5 Mar 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166275; cv=none; b=VvjkE0GVYouzUVaz1evYxVqyhP319NOocHvL6DM3ySsLxEoAH711sVN0QV6jVVjDN9mNXUOdwS7iKOWKEclh6a+DKLeUnART6YEToxrLXONPjF1qHy7Du/mHWnGW8d/uUKwL6AU9nfMcd+pT5KkyInmQ/+DOf2DYD/atFHzAliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166275; c=relaxed/simple;
	bh=Soc0YSLHU6HWKBbq2Br9e0PCdzmO9GPifsJushSfXIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KosxOmSJpFjjCyH/ejV4TGraTPk0xKfrksOlBgg1Zl5xGCQYdMlfC38vRb7hl95b1IQ9X1qaan65ee1qiHCafHRLD7mN32anNmQnIdtmsZo780hV8hKHaPxGiY5rPhW60GfvX7RUunRqaXmSUp84RQgZOh6E+PSI7+mNdpYl15Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=MBwejrHQ; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166271; bh=Soc0YSLHU6HWKBbq2Br9e0PCdzmO9GPifsJushSfXIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MBwejrHQqRUWNFK45Bgd7sgBKVyTF2Jj9vmqM6Eebq6MD5AjtWgLhEgyLm9lxsDzj
	 DvYIJ4xK2FE++Y7v8UKvv/MdkLpiCQAP5fGlflT2T9o0K877NpiX9MaKlnr+n5b1Fb
	 QLPxlqr9jxFbAy3KOZOAW09cg/5+NnPu0Jdj3sDU=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  linux-kernel@vger.kernel.org,  rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 03/22] rust: add extensions to the pin-init crate and
 move relevant documentation there
In-Reply-To: <20250304225245.2033120-4-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:26 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-4-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:17:51 +0100
Message-ID: <m2eczbj0ow.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> In preparation of splitting off the pin-init crate from the kernel
> crate, move all kernel-specific documentation from pin-init back into
> the kernel crate.
> This new file will also be populated by kernel-specific extensions to
> the pin-init crate by the next commits.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

