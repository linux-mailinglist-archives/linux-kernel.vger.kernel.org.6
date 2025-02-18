Return-Path: <linux-kernel+bounces-520392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9D8A3A965
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BE417A320
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26B212FAD;
	Tue, 18 Feb 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="e6qINPAk"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B2211711;
	Tue, 18 Feb 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910425; cv=none; b=fnOUKyyX98xrVjusWTWdBexYoJ56eFvfjX/w6ffflbR+NzGmzN6Vh3rOb4/VeRfPZDnGubAgojZth0rVKGp93Hhy12SfUvCjJo4yOeVs5eQfGqzCS0pIjuhm3yA/gbQzwfOrbYJ/D+rNN2x6jPVyZvKDBiGfKNTxiJ0UHlSvfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910425; c=relaxed/simple;
	bh=jzOjyAkVY/4mgm6pA2/v3Pqid2nY8xwqgBJ5O0DNaAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fA7wXICzwiA04nDzB+Rec2mqXxG4fheKXvZG8hMUK8XoLk+jhG4muwCFUaWrm5nogDlUo84gLHXoiT3wp+jAo9Im2duYrC4S+sCcnFY8I3e+GfOXIg/eVsSQJlmdi3IKDewNZJiY1iJNb/FbxAPbLZnqG3FUY1f/kJLujMYeESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=e6qINPAk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0EF0F411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739910422; bh=BiLVC2BVbo+NoyWWvZyARvqZAhfzklVINLVC4FN0jEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e6qINPAktFtMuSG1GnjzfPnHoQmKGrmvjhwnKkM0FBiPoarY6Oj381CQ6ZE+uVT+H
	 SRberwVPonDmAwVwSL+Cj33+oRViE0MnfT9kgJHU1gKaxfzOzqT3fKQLRycu8LACzX
	 PxE6ZISBDXmtSTnuCMWe2AGCRgGdb2Kqa/xcDJ3NTKGEtNZ+4ptjSgTrTVQoM1zoBE
	 NhfkaZec9AL8o3RB8KehKf/eCv1MYAlnQ+sF8Y/dwp4on2I//f0NDCOZW1TvgM4obS
	 R/KicGOOH/h1OgLgPItqTtdg/QG2FTqMBZXV3T10rbuMKOe1OsXjMleDg7vWxZgl2m
	 AI+PgcpAfLpkQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0EF0F411AF;
	Tue, 18 Feb 2025 20:27:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <si.yanteng@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dongliang Mu
 <dzm91@hust.edu.cn>
Subject: Re: [PATCH] MAINTAINERS: add reviewer for Chinese translations
In-Reply-To: <20250217043109.3571459-1-dzm91@hust.edu.cn>
References: <20250217043109.3571459-1-dzm91@hust.edu.cn>
Date: Tue, 18 Feb 2025 13:27:01 -0700
Message-ID: <87pljfngmi.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Dongliang Mu has translated a substantial portion of kernel documentation
> into Chinese, developed scripts/checktransupdate.py utility to automate
> tracking of translated content updates, and actively reviewed patches.
>
> Thus, add Dongliang Mu as a reviewer for the translations of
> Chinese Documentation.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..ae45135deb9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5405,6 +5405,7 @@ F:	Documentation/dev-tools/checkpatch.rst
>  CHINESE DOCUMENTATION
>  M:	Alex Shi <alexs@kernel.org>
>  M:	Yanteng Si <siyanteng@loongson.cn>
> +R:	Dongliang Mu <dzm91@hust.edu.cn>
>  S:	Maintained

Applied, thanks for your review work!

jon

