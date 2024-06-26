Return-Path: <linux-kernel+bounces-231638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ABF919B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7571C2125D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E1F194132;
	Wed, 26 Jun 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fRxNVEby"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8577F6;
	Wed, 26 Jun 2024 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443742; cv=none; b=X2zHg1aA+xA0iqez/ER3np9sYOFCGVYslK2CEVehuTtM2YLmzuC13NOQuVv5lE6o1OkmqHZkr6+iZAouwGioaDiLiGaJWzZOOnQcZwGivUaz0lyh1GCUxrJTz8feueg21y7NaJcXkixdmRXaXqr7m1Xi7V80tIet2WcvIti9LQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443742; c=relaxed/simple;
	bh=MeYtBXq4jNLpLj1royw8057y9hesKiTXlLlEes7jKHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDbbl83Lz+4U7cNs/eR3VETdIeF3ptHTjDpKnMKnJXg2H8u22M4xlnDY7sO4MoTqYvscr6XfM+RIw6uImcBUWRBzF3XGu9O8cxOC2FcmEnRol8LPsbrcaQ9Qt9ocuRl2zSzptdwpF21Y8BBIWh3IlyEQoLW8Fq/hSzfV3pLTf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fRxNVEby; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 437B845E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719443740; bh=VsjPZzVeiHMrFmQONi+lLDnto4ojRhdn7ct9qzMPAuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fRxNVEbyweC8hX6yGlD/fauSAHjDY+rwc/oCa/Qwl0t1VN9iz2wsp9FMCgIAmGNJr
	 q6JrdioLNa8+5s46noniOaZuFYGEoXPT60Tx5HI5AotofnsDbhXLuXA8lIz0SBRafU
	 k3mGZ21DWn9WDBfNDIk479v3bBcTkSnQXr1yCJ8ikJ9G7PqyMubOU7qWWdUjNBIszr
	 IjZTNawoDryhtPAreRHOX+1J8cCvmm6EF/p/CsOc7bvbuqQM4yiWFtAZSc41ZduOa9
	 sxFDK+S2vU07p+RNiT4pDC3fPa0bhJhdWPcnlfLo3a4UII05gfdQfiZVj+m2KVDDRq
	 ibGE7wewkb7ng==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 437B845E2B;
	Wed, 26 Jun 2024 23:15:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Chih-Wei Chien <idoleat@taiker.tw>
Cc: pstanner@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih-Wei Chien <idoleat@taiker.tw>
Subject: Re: [PATCH] docs: genericirq.rst: remove extra parenthesis in
 function definition
In-Reply-To: <20240619160057.128208-1-idoleat@taiker.tw>
References: <20240619160057.128208-1-idoleat@taiker.tw>
Date: Wed, 26 Jun 2024 17:15:39 -0600
Message-ID: <87a5j7fg84.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chih-Wei Chien <idoleat@taiker.tw> writes:

> In the paragraph titled "Default flow implementations", the helper
> function definition (simplified excerpt) for
>
>   noop(struct irq_data *data)
>
> had an extraneous closing parenthesis. This commit removes the
> unnecessary parenthesis, correcting the function definition.
>
> Signed-off-by: Chih-Wei Chien <idoleat@taiker.tw>
> ---
>  Documentation/core-api/genericirq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
> index 4a460639ab1c..582bde9bf5a9 100644
> --- a/Documentation/core-api/genericirq.rst
> +++ b/Documentation/core-api/genericirq.rst
> @@ -210,7 +210,7 @@ implemented (simplified excerpt)::
>          }
>      }
>  
> -    noop(struct irq_data *data))
> +    noop(struct irq_data *data)
>      {

Applied, thanks.

jon

