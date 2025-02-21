Return-Path: <linux-kernel+bounces-526601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A0AA400D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26E3701886
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C497253B4A;
	Fri, 21 Feb 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NJvtB1xA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53A253331;
	Fri, 21 Feb 2025 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169636; cv=none; b=UQrC9nctpcNVrCIIGhHXhZsP1mpJTO2CKTAX0j4lVX/z955OxE3dsWpyB5rs22hyedr52nP4U83GVnRfDkNDzTiA0uF9wL3PhewtfvfT2W3UckSR4Zkyo0woUQFDJvYHwF6HEuPrZCXC1kFXs4GMEMxBBIm6tpQZCcEyLKgQZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169636; c=relaxed/simple;
	bh=G9sBsbihoRoug8ktuGmiPPuSMt1GV5sJ2n/cm5yV8w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T8QwvYBNPfnbnZ4dpwe8O9eLFVMm9bGH44sJUH8u3Ex6SrO33tXn20KE7S6DOhenZK6n8gAU6K22QwwF9EwcHcqsraKK2w8yPtt/z4C9ga7DM9UR9yEc+pPeOIbf2f65p4CBSG2Kj74/uMkn6zWMLTayOs658i+HHoKp3G7lw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NJvtB1xA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9A8F2404E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740169634; bh=7FZq7x2DsL0p96wxMf+OEK477FKs2JfWM383YceucfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NJvtB1xA9yQtQY+9YtMplhmskbAAnABIW9xmxngyr9xMOv52Y3YTIIxzHDnwybo0T
	 Qf7gvauZ6AcDIjBpwz6aJHYpJmDZGb3hZ6ko8ZjdTJJKAYmptTB3lkGn1lgekacc8N
	 fmKqV9JCjg0D9Bj0TdW4d2smxjQePWwr8mtiL8VS2Vvgo7uiMhh/PhRGP5W9EOIH9B
	 PkN++/E1t0GQYX5mswFzvK7lkw7eHxC2BGudfiNer4cgOotU7Ddqa57rtvfYFUXurj
	 H2qQ212/AoDOFntv4q2p2/+BmGBIUvywzNtIwSY7kQXQpXsNtm7QBGdJgxWH+zaSFI
	 YdoxaOCwbF5Xw==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9A8F2404E4;
	Fri, 21 Feb 2025 20:27:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Suchit Karunakaran
 <suchitkarunakaran@gmail.com>
Subject: Re: [PATCH] docs: scheduler: fix spelling in sched-bwc documentation
In-Reply-To: <20250219112254.28691-1-suchitkarunakaran@gmail.com>
References: <20250219112254.28691-1-suchitkarunakaran@gmail.com>
Date: Fri, 21 Feb 2025 13:27:13 -0700
Message-ID: <87eczrgi1q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Suchit Karunakaran <suchitkarunakaran@gmail.com> writes:

> Fix spelling of "interference" in the CFS bandwidth control documentation. 
> The word was misspelled as "interferenece".
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  Documentation/scheduler/sched-bwc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
> index 41ed2ceafc92..e881a945c188 100644
> --- a/Documentation/scheduler/sched-bwc.rst
> +++ b/Documentation/scheduler/sched-bwc.rst
> @@ -59,7 +59,7 @@ At the same time, we can say that the worst case deadline miss, will be
>  \Sum e_i; that is, there is a bounded tardiness (under the assumption
>  that x+e is indeed WCET).
>  
> -The interferenece when using burst is valued by the possibilities for
> +The interference when using burst is valued by the possibilities for
>  missing the deadline and the average WCET. Test results showed that when

Applied, thanks.

jon

