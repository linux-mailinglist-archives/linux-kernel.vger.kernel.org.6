Return-Path: <linux-kernel+bounces-546402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE25A4FA34
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B7118911C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10D20550B;
	Wed,  5 Mar 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="ZO4a1LYp"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87A1C84D7;
	Wed,  5 Mar 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167339; cv=none; b=OUzs32l6y/002PmiEoBuy6PrYcHYwcK1Z3ep5z3nJ+d8kD5IE1qvHQDIuHFtXVp4hWRRQywOhB9/qYGJOBrw0aqZDQvxP7iQk/RiBSYNYjnQNJT5AVOoYsTdB2q/obx+TXCmdYjPUnvsQMJMhM+ZwdbYOCVrvL/oEdzIhMBgx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167339; c=relaxed/simple;
	bh=bC0B9IdI9bn2u2daXcEWKZ/+m4BITBqlIJm0uMYC3GA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qH5WmqVJrxMDoG4MAcBZp1nI5kV9W6rFLc66OidTjYPBWLGF6F6xppQMDRHnEiFy9tNBNu9HBGVjah+f+6NgTnHyRkStNZKrja5p0PDvW64dwqK1x3PkkxJJWsPnO4g0gnnwYMeTTD0kv/HLDoo/CwrB7x4kKXHYqABZpvLtJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=ZO4a1LYp; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741167336; bh=bC0B9IdI9bn2u2daXcEWKZ/+m4BITBqlIJm0uMYC3GA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZO4a1LYpjmKAuvM09tmpAHC6tLqgICsE9J/4VKdFT/dRO17OeshbDuoPKoKMD5USm
	 xklaGh28vNicYAl7tKrDmZgAJecu25qyLwn1UCb0fdwTJZLubOYqh23ELg6v32qLtU
	 FgPKHVhcBDV6hcpC3pp+gvM5DI3xRy0NYFfwESg4=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  linux-kernel@vger.kernel.org,  rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 20/22] rust: pin-init: add miscellaneous files from the
 user-space version
In-Reply-To: <20250304225245.2033120-21-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:56:10 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-21-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:35:35 +0100
Message-ID: <m25xkng6qg.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Add readme and contribution guidelines of the user-space version of
> pin-init.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

