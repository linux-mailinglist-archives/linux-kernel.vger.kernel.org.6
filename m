Return-Path: <linux-kernel+bounces-546400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85482A4FA2B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C440A3AD697
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE8204C24;
	Wed,  5 Mar 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="nDmgViY2"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043C1FDA7A;
	Wed,  5 Mar 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167214; cv=none; b=gvLXIqsHA5MS5DsqCI9oOiPNcp2E2Fwt7DHcLCuAWLAU7d/zLZdB71my9wVDC3EswvVTTHDgpLpWxPMZJa6bYP99AyREb34TdQWn9Co12WXyal54nfcJOd7GtAW7oHQCxT5h0EDA47dAb5gdXWtlU1lzc7S0KMCzTfnFnQuGuHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167214; c=relaxed/simple;
	bh=Tr7xXGYgnHGG5ptfWz4kyX2lZc9vIm3Oo3afbBKYIfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fuV6kLAuO7AigWOdOOP95Kt2RaDNJjauugU2XIrB+Sb11hxsTVZMHJjyP0OcaklCl3FzrRKAuFIPA1R9ZxsPMTlIwD7JCgOypKBq5yrKX94JXiO0iF9XZWF//wPZk0JK3dFvXakOxpt7PHbLFa3PyB3SnxY/z+r821H/LeCApII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=nDmgViY2; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741167211; bh=Tr7xXGYgnHGG5ptfWz4kyX2lZc9vIm3Oo3afbBKYIfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nDmgViY2RVGHIjxx/jlr8GoMISK0bGDPx4qFOESI/tNtPzmNoktGBEGtgbURnz8xr
	 Yt+IjV5aEOLIQC0sWJwG2dHOm9AdRySXtSEAxSALnGgbNDMlrJKexKJpC5TifAFfEb
	 rAZm3k99dVSrhUOtK9Y5745VULK/GZaysXLjKqP8=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/22] rust: pin-init: synchronize documentation with
 the user-space version
In-Reply-To: <20250304225245.2033120-18-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:42 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-18-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:33:30 +0100
Message-ID: <m2bjufg6tx.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Synchronize documentation and examples with the user-space version.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

