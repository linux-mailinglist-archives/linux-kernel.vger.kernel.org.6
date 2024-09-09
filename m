Return-Path: <linux-kernel+bounces-321317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451A89718A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A9F2848FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26FA1B86F1;
	Mon,  9 Sep 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GTrp2e0g";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hhEj2D2V"
Received: from a7-42.smtp-out.eu-west-1.amazonses.com (a7-42.smtp-out.eu-west-1.amazonses.com [54.240.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095A1B6549;
	Mon,  9 Sep 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882605; cv=none; b=u/UmXq8ByLs78yfHAb0IC50orSB2WZsSBJCh1Lj5iAYUDaHFa1uUvX6+TSYGPeaTPlJ2e5vwWyJmUWD7n+V4NScTvmQZcuVk1GH1nMkx6emk5Oqspu7yP5e4UhjYYG9XD4LSOMKUVNvSkzfQJlQRRRihdzARxijU4PRPtgrbPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882605; c=relaxed/simple;
	bh=ygfmowPRaEjKrQQZNci9q44h/vDEG5PoM6dtbziwh3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5NTznyh9jIVtFxcM1b/+nEM36zAIKmmEDk0T0WUdbK1JXKdGoVFY9r40Ni/ab+su4KZjO0E6gAYlWLVx/26KRJvoEoPaOTMBlgJdHz6LwGq+hMHUIT9tQ1cOQb1+IxrHNhWdmOaY+55VuEwMibhVdg5fZK5izCFfE1mUQUc0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GTrp2e0g; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=hhEj2D2V; arc=none smtp.client-ip=54.240.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882602;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ygfmowPRaEjKrQQZNci9q44h/vDEG5PoM6dtbziwh3I=;
	b=GTrp2e0gqjLHTxUQ40M9ofLiLjsCG5V5qjIKNtGRuspxJa3cQwFOtKMaGQNScetP
	gnXLxS2sxHZiYK5SJ2dhJRylXGhFkFHfC8oq12ISIzrOsxokcHxyhOkVjo+1La9YRYj
	bha1EyfI4mJHF0IV6z6kRvdArsU991T1M39EsuBqXq6Bom+vxo7yRylds9B7csCq6ez
	iaOhRkrMRyDPoIfWIcHU6atA03Op3nA4FqXi2tsoLRZTU002z2b/1tbr/VjIUrvgsQV
	m+Q86NVlNZ1chRnd7VtKrnOtMwZPW2Gcqd7zM3srvrzRibnLRgSo05FQ0X/ftipNxIm
	ts7cXwcjQw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882602;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=ygfmowPRaEjKrQQZNci9q44h/vDEG5PoM6dtbziwh3I=;
	b=hhEj2D2VsAHIb5Rq7VuwsOFK5gcJiUedcUHI5/O76aWjm85mEWWuu9Yu5bDfO1yQ
	a0oyR/bV5gXOY0927dC0QepQKjI4tolG/Ax0CukQcsRbYxZ9nI4FD+3lENEK/i6Socj
	x5jgN3KgNAtcACA8B/JN4FJ2HATBHmNP0vxGXWFE=
Message-ID: <01020191d69e91bd-6b0ddb3d-ebaa-4e15-ac44-99feee5e0a07-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:50:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] ASoC: mt8365: Make non-exported functions static
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-4-7ad0bac20161@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-4-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.42

Il 07/09/24 02:53, Mark Brown ha scritto:
> The compilers warn if functions without a prototype are not static so add
> appropriate static declarations.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



