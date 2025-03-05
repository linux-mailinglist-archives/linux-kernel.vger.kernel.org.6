Return-Path: <linux-kernel+bounces-546385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C1A4F9EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ACE18879AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76EA20468F;
	Wed,  5 Mar 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="H6j08skL"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED12040A8;
	Wed,  5 Mar 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166774; cv=none; b=jZjT6IUGZYVQpsEAnGKlKT1YgON6AWqGmiqZM5DiOS7QkVVOLasG7tpcx/Nf2gUjuHWEQOm0pqxcwfSJHjPTBwsRuyjN0tjsPscywYgQxvsJobnhZsdp5WoSKE2b/B/+DXZMQsnvxhyjX8ZaMfBoxlsOcwwD3HrMU0yJUMl4b2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166774; c=relaxed/simple;
	bh=go4650quXYH8hfP8sikjU3HfXTfx5hHTioHzr9meBdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UBH47kzmdC+0Ajh4djJ21sRmxYoDbO+kp2ToaAiM6Jach2CbBJGlufhzQ3MiQTeI2TP22spMku6SlHvUzlbq2EHGL0N+l1InjHgmcGvuG/hOweySdh0CmRR13frnbtbtIENnFaJzJPU8hgZbqva3uDp7XUOdiLEQ/StwDVHJLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=H6j08skL; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166771; bh=go4650quXYH8hfP8sikjU3HfXTfx5hHTioHzr9meBdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=H6j08skLI+gtK8GIBTH85STeSD1WdAsDG9XMkhKWqAqGOv/EdSxQA4xGy8LrZqgWO
	 vBNI64pF99UQEcZvmfN8P6j4/XPJfvYFaXnsZtOYh+7jXQjpyiMXsnpc6bjrdRUkjH
	 1UEEIVr6DwjiyqvsUO434xqtvpD8wk3SrZ3Vf5mE=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/22] rust: pin-init: fix documentation links
In-Reply-To: <20250304225245.2033120-12-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:54:41 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-12-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:26:10 +0100
Message-ID: <m24j07hlql.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Before switching to compile the `pin-init` crate directly, change
> any links that would be invalid to links that are valid both before and
> after the switch.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

