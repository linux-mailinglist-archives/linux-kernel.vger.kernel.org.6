Return-Path: <linux-kernel+bounces-364634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D6999D73C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CD8B22689
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCD21CCB51;
	Mon, 14 Oct 2024 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="I4XfgSLL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355D1CC154;
	Mon, 14 Oct 2024 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933751; cv=none; b=aZpE0Oj9ZLQ1U+vLU3NNmaWj2IGi/cTgz1ayrMBjTKxCFOxEDyKnNk9W7W9++g8swPgdx2uKdU5L1HxHRiKTSv8dY9yKFlsihNYN2gdSziAg8SnN+gp9gvf5lMZ0IRv/KzT87OjoOFnU9BTklxjgWwMlHlFNrj233NuAz96964o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933751; c=relaxed/simple;
	bh=Uz25GdoBKOI7VrVOnxLarmxVsm9R2vLGXmqdlT8ztU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FpUXyUrDy6U+w8klpE8MsmIphK13+EFg4Ez16mRRqOMEusnNgX2fqMi1XxvE+/C71yWx7D+z3sg57wdD4cIRE3d/B+lH8i17gsv5UNP4pL6AxJA9S3kmF1rs8DTpdvQVtPb6YNfZ+K55QDVWW/stIMZP65t4odR93q5a0dZwGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=I4XfgSLL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4E87142BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728933749; bh=0OD7mq9D7slGeSUu09o+pF9OpII1JMTQup9OqHIXJxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I4XfgSLL1jOYOgTtemmSISayl0I43ZdyA4xtC2Nkka0678HjIX3QTWaMuJ5aJTq2/
	 SK+egBqWhqVL5DRK+uDlUV2yioAPrqKH/pF/KonV6qCEQhQvqIemfrT0KQq8G7nkul
	 gitOprxjZO0nKWjpy3mdTdzMF7UNopo7Mf2OmHUeYkKpw0rfpEWYHJUiUmnXxrsh60
	 g++2OPCqrnD2+p847V4XYM8iUrfcfuwGs4MjViKmH6ncuQR4PtKRN6MSptpr6zC5ZZ
	 VCy6nX5JGinyuqW61MEOTjIAc7YQGjRrwTKGPvvbnEb5017t/9Gr/ba6vRpQjUQe1Q
	 psJ10x3y5kaAw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4E87142BFE;
	Mon, 14 Oct 2024 19:22:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vishnu Sanal T <t.v.s10123@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: Re: [PATCH v2] fix grammar on false-sharing.rst
In-Reply-To: <20241007191253.112697-2-t.v.s10123@gmail.com>
References: <20241002100852.70982-2-t.v.s10123@gmail.com>
 <20241007191253.112697-2-t.v.s10123@gmail.com>
Date: Mon, 14 Oct 2024 13:22:28 -0600
Message-ID: <87a5f6sd57.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vishnu Sanal T <t.v.s10123@gmail.com> writes:

> Fix slight grammar mistake on kernel-hacking/false-sharing.rst
>
> Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
> ---
> Changes in v2:
>
> - revert inadverdent mistake introduced on the word "randomizes"
> ---
>  Documentation/kernel-hacking/false-sharing.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation/kernel-hacking/false-sharing.rst
> index 122b0e124656..eb0596734e55 100644
> --- a/Documentation/kernel-hacking/false-sharing.rst
> +++ b/Documentation/kernel-hacking/false-sharing.rst
> @@ -196,9 +196,9 @@ the hotspot switches to a new place.
>  
>  Miscellaneous
>  =============
> -One open issue is that kernel has an optional data structure
> +One open issue is that the kernel has an optional data structure
>  randomization mechanism, which also randomizes the situation of cache
> -line sharing of data members.
> +line sharing among data members.
>  
Applied, thanks.

jon

