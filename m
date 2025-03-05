Return-Path: <linux-kernel+bounces-546405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65065A4FA3D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2561710EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F5C205511;
	Wed,  5 Mar 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="p+F7Uy89"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C29204F79;
	Wed,  5 Mar 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167353; cv=none; b=BrYuHh6pA0xlgiFIiusJNUOqVF2UEbY2RejhNbGg6aH2UoLOyEaB2gmmh3egUmRia1g5NgeQotIHwYY14HRM0MZpkguTxmLIGppvfmewNuAaFVBym/A56iRiwc5ZIZOZAKMmA59H9fCaSSUBr7NADGRO/bOPxYLEu7zhPRn6gTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167353; c=relaxed/simple;
	bh=GHUWpDrry/6boIg5nDt2BPkgd8ZHOrcBFue9Y1erYs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bS/aVYyNFRfsUX9E8Pp6wbb4EZWnFytbLEVnwm94zSvHKfHJ1XUgChh/FuDNY+VtpPDIw7pxehH8TFkyfhUv8Wao3/z6QZ6S7Bs3ajGJQPBY4xU419mEi5KTmSgAQrmcg8fxc9gKP9UnamofqwVyp2lAb8noBNT6bkmIzWze/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=p+F7Uy89; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741167350; bh=GHUWpDrry/6boIg5nDt2BPkgd8ZHOrcBFue9Y1erYs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=p+F7Uy89F2eH2vL8a6KoD9ICAzOWuWk+Ve0NFSQrR3byOtAh5W84ZUYIbB0F8FOL6
	 i0gP03CHZjMEZQj1xcckI9bOawJwt2u6ciU5CZj5h4NfjQf/2jVc3MOeeLZxqeq61v
	 J/p3DoJ8QUCGoXg1UnicI941Hu/TeBtEy54Zcd8s=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/22] rust: pin-init: re-enable doctests
In-Reply-To: <20250304225245.2033120-22-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:56:18 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-22-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:35:49 +0100
Message-ID: <m2zfhzes5m.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> The pin-init crate is now compiled in a standalone fashion, so revert
> the earlier commit that disabled the doctests in pin-init in order to
> avoid build errors while transitioning the crate into a standalone
> version.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

