Return-Path: <linux-kernel+bounces-395454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236859BBE14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C430C1F227AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998251BFE03;
	Mon,  4 Nov 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hp0rfofy"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843A1C233E;
	Mon,  4 Nov 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748934; cv=none; b=Mkqe2HUJVM2rS5V/WpHdV2HNdfY5GicACshwyGIH2zYVyy3ldLn/Dwwu3ndz5V1ZAwolFeFPT90x+DqO52NJrh11VFPEJryG4M+Y8fcQqEpYW+7Nq6yF6R3BBUzgX/CajVo0vfvCuu0sFfR+uua7EARoJw+klifIu63qT7I6//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748934; c=relaxed/simple;
	bh=oqnScoJlKNOs6n1a8VqzsJB45+5FLITuWYoz8qJZowE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBBVpQNZQKNT8tmBLttTlHxYLusG0/u8WAZmIwkFa8izYto9Mfq8nmTzrU2riFs+7vCGMUYzpqBBFAoqANkuBc4UM1ENqxqQAlDBBRlQweCeCGFkJrjM18sCI4Z8zED23UNllGbzX+kpCXsEjmYtxYb6wJMzRhLiNr9urNepvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hp0rfofy; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3B66242C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730748931; bh=KaYJ9U77ffkdFaZA1G2eInCnl4YzCT4LVedal41j/9E=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=hp0rfofypsqA+o8JbXO4F3PvGLAUBZ2KAi8AOJvOt/NwQU74AW9EOI31qBfDboaAY
	 I+7OzwrwT1gOZlQW1acjrSnhjqbTRoHPOAAK5K4wNE+yOVy93kJwipqbNiWrs7oZ43
	 6T2eUqrZ0rsPebQzVoFdy16DNqkdffj6nCnJlgse4y2f26CEE4pMVCMInG9zblrJ5m
	 nhYx1VArveestYfDEiDjyjhSL2pBG8sp4R4dk7HJRLwj79CW9K/necH9pQKI4beOkn
	 VfmtMDqUzbYVVN3zzKsGs5+vqgvQNSiEXPn6cyVhdPxkpshT0SkigJVpDH0J0+uDRH
	 YlUylxpt4L1SQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3B66242C30;
	Mon,  4 Nov 2024 19:35:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nir Lichtman <nir@lichtman.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix incorrect paths/magic in magic
 numbers rst
In-Reply-To: <20241025135128.GA879576@lichtman.org>
References: <20241025135128.GA879576@lichtman.org>
Date: Mon, 04 Nov 2024 12:35:30 -0700
Message-ID: <871pzq94hp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nir Lichtman <nir@lichtman.org> writes:

> Fix some no longer true header/c file paths and correct the BAYCOM_MAGIC
> value to be decimal as in the source instead of incorrectly hexadecimal
>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  Documentation/staging/magic-number.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I've applied this, thanks.  I do continue to wonder about the value of
this file in general, though...

jon

