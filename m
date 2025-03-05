Return-Path: <linux-kernel+bounces-546390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9DCA4F9FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E501316E0A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA9B20469B;
	Wed,  5 Mar 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="RdFJ+cpt"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE42040A9;
	Wed,  5 Mar 2025 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166878; cv=none; b=X/Y4ncXCfibSW4jyfjipH331ldgrH+CUz1DHcXIH3+j5u7QzbCt3QbUCiaMW9ht01mwu0fQ2LASCvmUci3V/vUV1+LBPQy7tK2j1OdsA2G4toDVLK1FCoIdKa21JO2FZMRZ4GmCrPrW1+YHy30+jNkpY5Cp4EFetQlYptBQoL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166878; c=relaxed/simple;
	bh=AtN+2Jqi37lJLGQt/ZNnCkvfOrFTJL92hMBXaet3rK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoOsfDxgzndpcfq+iZwCxsa7wmY8vV6eo7zg04JOy4mbeahtcPeFMsFbxVWltKDdWe6I9VgdO14rINkJ7xwC5eaNoGzvIm4bDnTac46q6ePIqsf8hvgZimTWPT31GfEZq98L9q2KRm0hnzh6yX++3NYBg79G5IpnPD/g08ufXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=RdFJ+cpt; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166873; bh=AtN+2Jqi37lJLGQt/ZNnCkvfOrFTJL92hMBXaet3rK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RdFJ+cptPNTlJnUTzyDTmUlWnA9P0PEh7TTS81vRvevxLaxhgw9Tlf5M6LZQ95sbo
	 UOSpn4rAx1H6GRBwipKdxaVegKAFpOFckAMLu5ojGbBNssQj9bzAl5Yev7bhitFGUZ
	 PHSkT3XB+vOkVhjRlO8HHRBWBy5XitF63gVTlnSY=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/22] rust: pin-init: remove kernel-crate dependency
In-Reply-To: <20250304225245.2033120-13-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:54:50 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-13-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:27:53 +0100
Message-ID: <m2y0xjg73a.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> In order to make pin-init a standalone crate, remove dependencies on
> kernel-specific code such as `ScopeGuard` and `KBox`.
>
> `ScopeGuard` is only used in the `[pin_]init_array_from_fn` functions
> and can easily be replaced by a primitive construct.
>
> `KBox` is only used for type variance of unsized types and can also
> easily be replaced.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

