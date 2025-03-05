Return-Path: <linux-kernel+bounces-546364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B270BA4F9B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E083D16D741
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4CA202971;
	Wed,  5 Mar 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="p0fDzK/K"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF32E338B;
	Wed,  5 Mar 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166244; cv=none; b=E7VWxFIUn5JI9B9+Zd2/CT5ymMH8DKRJH1AQvtLYG5iAciw12k78AALU8AWG4QDS4ZGWWB9RYQ13dms39ml79d2e8Wn7SxNwTi8c3K5ipr9yliHw1ZkpuV2Y+W2Tr1Sa6b4+Jx2SXNvm3Lu6R577p1+1irWALH4h8f7sn5c7w9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166244; c=relaxed/simple;
	bh=acNOMy7mV6Z/cnth2NOyNI2JDtET0bUYAwTdvmlj5Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjkR2L5B2Eat8HSXLTYsd0n0XPc25A8k9YGiXthtaBRo5RjRSJ7rqRjcSTWX2X0QnrLfBHpkI1hjxp2BokFcaI3/UBThDlUnYHqNNe0N4IM1IxdLaaiXwtWv0mNEQKzpTSk9/iBTNEIy93JVT9g/5J7nzzEfrTwjgzO/Hr34+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=p0fDzK/K; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166237; bh=acNOMy7mV6Z/cnth2NOyNI2JDtET0bUYAwTdvmlj5Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=p0fDzK/KjCjSYZZtXWyXO4PjOJbZAsf2VjsuG2h/WAYIiO3DqIxAqHWOY5d52G6DW
	 L5m+mrQdXf0+dXUwsEs1v0qz1nyUzF88HjuCX7O0T+K7InXZjoSSOlla83prPbv1nZ
	 QydwY1kmDUKbY8/A803uQjtWzYpSzkecWMufHdyY=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] rust: init: disable doctests
In-Reply-To: <20250304225245.2033120-2-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:03 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-2-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:17:16 +0100
Message-ID: <m2plivj0pv.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> This is the first commit in a series that splits off the pin-init crate
> from the kernel crate.
>
> The build system cannot handle doctests in the kernel crate in files
> outside of `rust/kernel/`. Since subsequent commits will move files out
> of that directory, but will still compile them as part of the kernel
> crate, ignore all doctests in the to-be-moved files.
>
> The tests will be re-enabled later when the separation into its own
> crate has been completed, since then the doctests of that new crate will
> be handled as normal host doctests.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

