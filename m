Return-Path: <linux-kernel+bounces-572782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45FFA6CEB1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266903A88EC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119ED2036FB;
	Sun, 23 Mar 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gRn3yOp/"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8C1DB933;
	Sun, 23 Mar 2025 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725697; cv=none; b=X5yXnlQFphVHyTvHF4f9p4MYq02X4jeeewdAAncnobgvpm2BJYOinbDf5s+38U1bgD84eAZq8Yfte9Xb7rJ6YLjgIQ+GNsWoBdqFWZJ0mOZ+JIgNyg4Vx6Bvwz4fCxzsJTNHtuCJ3peDKBGeqMwEto17n2MvmAeoWwX4XEfzoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725697; c=relaxed/simple;
	bh=kJQdhs4Yn3iNBIXS0n/J39EQi/RBNxC9l81xHA3vYxw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBPkyD5M6i7UKKNcer7n9L6wJ8tdpv2mXndPIO2eT4FQYWdLDmexIeez/H3EHkHgX7bI4jQ+3rJ/mtX+xivbyjVi8qd3Ve2MKnOWkfVGcTkTGdygqEq/XdFRQYv4splUb/HAVfqpbw7JXFdWq8o91iJkZIMnDpWue10n5k/5lPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gRn3yOp/; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742725690; x=1742984890;
	bh=APuFgz6SVUioqb6/BR7NN+NPohXPkNmiAUPQoHNus80=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gRn3yOp/umxwI8pu6knJXh2Fq2LgpLWLvQ43B6qEDeFPJ40dz7ajCE5+lGrg/n1Ru
	 BwfbM5+aOq3qhwGxwtc+zBeOovr0vB8DIJZJCznj174zXqtfk3aU7SETyy6deaCEKk
	 eX5V6UyD6QdIyXES/q8/9eJIV1BnCm5BTqcfTXKyLbSGxMlkK1TynpstXzar7xbpT+
	 MQf4UA4GQk4Pm9BIlnkcwJbtLUzTfHCuJbi+6laIBdwN5xvcJg4J6sm8NyESMlykrs
	 L6hKDgDYFZEj49zkFYKpiz1x3+Zqo1ovwVJM5nEgQD9q2X3qvBq3ytUxsyiRCiABI1
	 BgnULZeXROr4g==
Date: Sun, 23 Mar 2025 10:27:59 +0000
To: Andrew Ballance <andrewjballance@gmail.com>, ojeda@kernel.org, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: alex.gaynor@gmail.com, jubalh@iodoru.org
Subject: Re: [PATCH] rust: print: add rustdoc link to std::format
Message-ID: <D8NKOYBU4B7C.2QEMXLVBOZK9U@proton.me>
In-Reply-To: <20250323055948.89865-1-andrewjballance@gmail.com>
References: <20250323055948.89865-1-andrewjballance@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e1ccb88736d660d9c06bc736c71fc02f6906af70
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 23, 2025 at 6:59 AM CET, Andrew Ballance wrote:
> Adds a url link to the rust std's format! to the pr_* macro docs.
>
> Additionally replaces refrences to alloc::format[1] with std::format[2]
> because they are identical but less likely to cause confusion with the
> kernel's alloc crate.
>
> Link: https://doc.rust-lang.org/alloc/macro.format.html [1]
> Link: https://doc.rust-lang.org/std/macro.format.html [2]
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  rust/kernel/print.rs | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

There are also instances of `alloc::format!` in `rust/kernel/device.rs`.
Could you also add those? Thanks!

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


