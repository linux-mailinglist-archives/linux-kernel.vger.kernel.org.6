Return-Path: <linux-kernel+bounces-513476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA323A34AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BBD17034A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93254266194;
	Thu, 13 Feb 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mHu6CIWh"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B7266181;
	Thu, 13 Feb 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464853; cv=none; b=qaGH3jN+kDdFi+up8NYi6sbx6G96nGb6TRImT7eAadpTMmoZn84MukSzVzyTnt1CjjlD4sbeqbpuUMmQQy56lgh2DvyF6cxbOntGS+/jIsV1qd8AU2aUEZz58PYD/3vraCeyMvRLEJFRMf+l6PSA/dweeMAoJTHcZIy0p5xHu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464853; c=relaxed/simple;
	bh=+NmJvozCvHqYo27+QZ99g9mKJER+YVCPI759srgIddc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deLiy6h3QeLd7SsEUAl5j0BdCn+RalHtUt+Wcclq8F2xJUAyfKX/kXTq3om/+6HbmZ6S06avP9/P+sUBHUtxB0c1LleTj7VnTI5DiGelEF5WbYnPKg9U4KWxFfLXu+mpumBYWzQvX6++pBGu3rRcQRgRbMMHQ6QohOXoQtm0Ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mHu6CIWh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B85D444097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739464850; bh=0XfX4xkUPnhb3Qg4pir8Dg6wUP9Xma+uY4HBJFMOGuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mHu6CIWhUFtFxJvqpyTvgeZSXxUegMO2ofWHiYbxqel+lpFK6TQEueZhCy9TX30ea
	 DEO0CsXG3P3Su+N03pSD4LFjKPemVO4kRAMVrFzplcIpV/0FAbhBg+Hzk4mXpalnRL
	 hKi7ZHERh1oZTIqHSeqyeK9ZgafTxadjJlxV2IC+34pmOjvMK/2cSJJCKKulrGyM9x
	 KSdUt+MqViP2eIEhgl0wSBZaHVK7Lj07MnUlnKI3lxgEEPZ+np4G4JfyZKi6UEjkV2
	 vTybn1XeZJhnoEI0j7xA2vIs8qMB3IS4oSMjOT694n8dkFIpUc4oU4qOa3SML9Y+CA
	 D7ESS8vnIYt9Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B85D444097;
	Thu, 13 Feb 2025 16:40:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] docs: Makefile: use the new script to check for bad ABI
 references
In-Reply-To: <20250211054446.1696826-1-mchehab+huawei@kernel.org>
References: <20250211054446.1696826-1-mchehab+huawei@kernel.org>
Date: Thu, 13 Feb 2025 09:40:49 -0700
Message-ID: <87o6z56bn2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The get_abi.pl script was replaced by get_abi.py. Update it at docs
> makefile.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502110736.ZGWaWsep-lkp@intel.com/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 52c6c5a3efa9..63094646df28 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -12,7 +12,7 @@ endif
>  
>  # Check for broken ABI files
>  ifeq ($(CONFIG_WARN_ABI_ERRORS),y)
> -$(shell $(srctree)/scripts/get_abi.pl validate --dir $(srctree)/Documentation/ABI)
> +$(shell $(srctree)/scripts/get_abi.py --dir $(srctree)/Documentation/ABI validate)
>  endif

Applied, thanks.

jon

