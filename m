Return-Path: <linux-kernel+bounces-571031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC3A6B817
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C332B18994F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB021F1531;
	Fri, 21 Mar 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QbJ6E+ib"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8541F0E37;
	Fri, 21 Mar 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550745; cv=none; b=OGXKgo64PR/6YdcyFIZ66/rPpZ/cUdf0g/G35fp8HIGEOGeR0EYVYSORPCI6ctVhFPqljQ8TvRjg6W3RxW8XONS6yIsPM1QTuX8WrP0dA0EOShemCqwTNHbqhmnooVzEKwO+9ekHLpf5EcER/6oJ5+xwBgBUZrmMyQBjn9QDGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550745; c=relaxed/simple;
	bh=A1kS9QPOoTAn+dehoy04C8w9Xgm8ruwRrLjm4PhGYLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yxn3jBaeWkb/oUuwyplyQSlYwtQ7/WUZbDtxGnJ/doonbLyOTf7OrfVZ5yakQogSTfT14FwvorfoYmGmt9Farszq/BC5KiUND373DZljp8suwQBG6MfoqZDamPyerB2zUOzDDeGNqZKHaR2sCC2NE1XuMLcT5P0qeMEXa0jnWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QbJ6E+ib; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742550740; x=1742809940;
	bh=A1kS9QPOoTAn+dehoy04C8w9Xgm8ruwRrLjm4PhGYLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QbJ6E+iblf+GesYm9zOCsXxWdk3Sc0PwsXZkYb7E1fdWjD/TwoHEkQYOoGRYcx8VV
	 T23oH0tyKl7cZGCJDCbjokLVAhihJ/lehkWNmoK3m0xSKglhSCcFKAGBOzJnC6Rciq
	 U+qsYfhqFfibOedP3tsPkOuJ9tO4/3gxG1bTiQjECQU1o9zutEDDzYM28F7LQVPOLY
	 Mbgg0pKt+8+Ucjs0lGxvmFQOJ79AHmJbfLYoRIO+08sUVe6+w3qDGsSI+uBsiJ0A/P
	 tCoxr1CNBx3y1Yt6LxUCqma++oGVw5Te5LclFhro/fazR1ejMaQIeV3NJvcugSrS/X
	 T4Pw2hEMUrGxg==
Date: Fri, 21 Mar 2025 09:52:14 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::drain_all
Message-ID: <D8LUOIDJKVRW.GBPW9MJ7UF9F@proton.me>
In-Reply-To: <Z90bRpdK7qZio80g@google.com>
References: <D8LFO0LQOPQJ.30AC77E0BOH3@proton.me> <Z90bRpdK7qZio80g@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2d26f828b9b968ace93b9c2aecb0bdf4f4e880ec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 21, 2025 at 8:54 AM CET, Alice Ryhl wrote:
> On Thu, Mar 20, 2025 at 10:06:18PM +0000, Benno Lossin wrote:
>> On Thu Mar 20, 2025 at 2:52 PM CET, Alice Ryhl wrote:
>> > This is like the stdlib method drain, except that it's hard-coded to u=
se
>> > the entire vector's range. Rust Binder uses it in the range allocator =
to
>> > take ownership of everything in a vector in a case where reusing the
>> > vector is desirable.
>>=20
>> Is the reason for not implementing `drain` complexity?
>
> Yes.

I thought more about it and as long as the person implementing `drain`,
removes `drain_all`, I have no complaints. (will give my RB in reply to
the patch in hopes that the in-reply-to header is set correctly)

---
Cheers,
Benno


