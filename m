Return-Path: <linux-kernel+bounces-544996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF445A4E771
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D004E7A288C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52227C869;
	Tue,  4 Mar 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CqpFpRab"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86C27C865;
	Tue,  4 Mar 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106307; cv=none; b=YykGdmu65V9A/O5Y0hEReQLbxJ8Idgji3UaGNaWmk+BrH4opjpT5UPzNBCFWVjAk44nEtY4uyM2izw95OHiq9lgrl7tphPZ2+8DvQqakWX0Cr/cbTsM9AqSOQSql8kfcKJv/czwQP0F5gf1QS/eyGiJjnq1Ek2jSdfP5pLGbqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106307; c=relaxed/simple;
	bh=0NFhIHUSIXLQ1IERnVrz79OxkFLXeS/HqU9Qitji2q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rIhkXjR+V3M2/kQctT2/1T0DCyVUsrQpd/S8iewBnRdB6CAkzyziec6p3MtbcdL6s65RScCxlKmzFvRKnRd5EYPDfvd/Hi3MUb9RmLJlZ7O/2PCFCi0+2+M/odH1BNDVgnk+wLv9FTDAtJdIICA7kR/TvvpZtG9iiyg3k50DTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CqpFpRab; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF3484105F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741106305; bh=GNXSsU+nJrWFy0zOEQmbq0fVDqKBxRTGtxEH/aS4AaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CqpFpRabFcZkVlHkdXF5u0TnXe5vmPQDD5+hgy/Ut8ryHvW2EFjp8PbrVuGfAAg8f
	 JFhAOCqoHadLBKNSfX7xKNQAHQC0Il2Hqw96j2IBTwG/KAwYtI3hIBbsZsZSxk65S8
	 actAD2/JcXNLiulR8WtVK+Qu9gKQ15cR3TXAy4rWJ2rVst8/v96ZFsGzpz0JO+SKQN
	 B/LuliWECXn0y8Q/bKt50TGrUztHAvnC2T89LRRhYPRq0pXo+mgjnBOw+jKKF+13ON
	 NhHI/LMZsiyxFFxuEOY+Y2KWdyh5pKhlGSFFl0MfCHbtb6Rc6gtNAw0U1v5kddpuJZ
	 SS7Ul0z4311Mw==
Received: from localhost (unknown [73.243.92.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DF3484105F;
	Tue,  4 Mar 2025 16:38:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: gshahrouzi@gmail.com, linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs/arch/arm64: Fix spelling in amu.rst
In-Reply-To: <67bd05b5.c80a0220.205997.19df@mx.google.com>
References: <67bd05b5.c80a0220.205997.19df@mx.google.com>
Date: Tue, 04 Mar 2025 09:38:23 -0700
Message-ID: <87cyeweoow.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

gshahrouzi@gmail.com writes:

>>From 748db76c8e9f6e5906be0033dcdec9bb5749b303 Mon Sep 17 00:00:00 2001
> From: Gabriel <gshahrouzi@gmail.com>
> Date: Mon, 24 Feb 2025 18:09:26 -0500
> Subject: [PATCH] Docs/arch/arm64: Fix spelling in amu.rst
>
> Change though to through.
>
> Signed-off-by: Gabriel <gshahrouzi@gmail.com>
> ---
>  Documentation/arch/arm64/amu.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/arm64/amu.rst b/Documentation/arch/arm64/amu.rst
> index 01f2de2b0450..ac1b3f0e211d 100644
> --- a/Documentation/arch/arm64/amu.rst
> +++ b/Documentation/arch/arm64/amu.rst
> @@ -80,7 +80,7 @@ bypass the setting of AMUSERENR_EL0 to trap accesses from EL0 (userspace) to
>  EL1 (kernel). Therefore, firmware should still ensure accesses to AMU registers
>  are not trapped in EL2/EL3.
>  
> -The fixed counters of AMUv1 are accessible though the following system
> +The fixed counters of AMUv1 are accessible through the following system
>  register definitions:

Applied, thanks.

jon

