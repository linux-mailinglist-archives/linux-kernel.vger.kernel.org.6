Return-Path: <linux-kernel+bounces-546372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2DFA4F9C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD9188676E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9C2045B5;
	Wed,  5 Mar 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="YTVKsgtW"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5120409A;
	Wed,  5 Mar 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166369; cv=none; b=ZQP8OuF//5Xj3Lob9VCsLvdkkr24fzgT8J2Z2RQ43JuZW6rrAYJaKVCEHdtVwRw1UcDZcqGf+4740vk3/rnN5hqXUnEuId0/LX0UC+HTHMsqpSm0t708fNNV38c5V9OV4IAiJtUK5ateqDFNh7Q3Fnsv58tACQaJ478rWPGwGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166369; c=relaxed/simple;
	bh=Z1XS6ukud7fp1OfWOfCX8gJb/w0mT1sUEAYzKF88IzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SiQUY7qPgT+qaCUZVtaN7sWlEyx+tSv4C/mEmPYflzylYq0HcnceRczPa2/ueEf+FIuK5vTF2lZ6qWKIphg6yRYOJtUn9+9a7fpqrOUfyqldkGxF4D+n6e61D/PeFeJvcAAib76kUqyMa/iSuZeDCwGAWfV8S09MHqw8QSsDBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=YTVKsgtW; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166366; bh=Z1XS6ukud7fp1OfWOfCX8gJb/w0mT1sUEAYzKF88IzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YTVKsgtWce2AD1opLOHPCpOsmTwJYH4rSO0ZzjYryIXLlPK+nEWdbd/RS1BsDI/WF
	 F7CQyFcJfKVL4yQsTTv9pGJOqhHeQwProrn/gja7muJT14mAbRZsq6jl5I41lbrYLX
	 DRexkrklTiB6144gfgKlLLEtUTN7J4T2G24Mh9gY=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  linux-kernel@vger.kernel.org,  rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 05/22] rust: pin-init: change examples to the user-space
 version
In-Reply-To: <20250304225245.2033120-6-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:46 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-6-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:19:26 +0100
Message-ID: <m234frj0m9.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Replace the examples in the documentation by the ones from the
> user-space version and introduce the standalone examples from the
> user-space version such as the `CMutex<T>` type.
>
> The `CMutex<T>` example from the pinned-init repository [1] is used in
> several documentation examples in the user-space version instead of the
> kernel `Mutex<T>` type (as it's not available). In order to split off
> the pin-init crate, all examples need to be free of kernel-specific
> types.
>
> Link: https://github.com/rust-for-Linux/pinned-init [1]
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

