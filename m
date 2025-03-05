Return-Path: <linux-kernel+bounces-546371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566CBA4F9C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0431D16CA01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE0204859;
	Wed,  5 Mar 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="ksPkvL1n"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CA20297E;
	Wed,  5 Mar 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166321; cv=none; b=F9a1krXmmXb4hVEkrwBvnhJ9S0W5M8ijbWv0EaCTA72En3aAaiT419SaOlRMhpFSJlbf5SbR1lRpZZSn9xUU94vPHjqrHaXyKsseMvmRkT98r8nR9PnAuZ+yfRz1Xm6L6DENgFUfjNvhSTnY9Zc7dhFcV9iC7izeg5u7BmulwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166321; c=relaxed/simple;
	bh=E/FKPevlAxP3oxUVkYlXCqIls7TTWoJBsmljo3PBFgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/fOOQYpvRSfqA8dBd8+3WLtkLP7YmWBL80I4cf/wg+EKJaXf25jBNI8VrF/ypTW4G+kxHeEoGK60P7yIOILjCZ+gRxXWKI2U5//U9+6wbyA/4AMha68fsqeKsMCde5ZTqa60o4OzICGaksMxtSWZjXrde0GO58EmdxZE3ZdKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=ksPkvL1n; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166318; bh=E/FKPevlAxP3oxUVkYlXCqIls7TTWoJBsmljo3PBFgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ksPkvL1nqL/RMhgb1y9F9V9zGTvTgLcRQfKIcb5plR+ohQW+9frFSh5S58VCx5xnM
	 HQEz+WGWRUlEsSUuljHP1eOZEwSd04R/NZZsDxeZ2FH+SCYTUYFBFC1pS/gCOccFGB
	 f/PoIMXS0lRND7WepaMO6TGDQVjOvNYhYvfhob6k=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/22] rust: pin-init: move proc-macro documentation
 into pin-init crate
In-Reply-To: <20250304225245.2033120-5-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:36 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-5-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:18:37 +0100
Message-ID: <m28qpjj0nm.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Move the documentation of proc-macros from pin-init-internal into
> pin-init. This is because documentation can only reference types from
> dependencies and pin-init-internal cannot have pin-init as a dependency,
> as that would be cyclic.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

