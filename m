Return-Path: <linux-kernel+bounces-321315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A009718A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9923C1C224B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C72E1B78ED;
	Mon,  9 Sep 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A9DkJsXe";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="XcbUgz4W"
Received: from a7-42.smtp-out.eu-west-1.amazonses.com (a7-42.smtp-out.eu-west-1.amazonses.com [54.240.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE935172BCE;
	Mon,  9 Sep 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882603; cv=none; b=G2Tiqdo7G5XrsA5zbfcBP9ea6Zl+RVD6jqfScOxog7lFfNTV8L9V6jHfFrsxaXUpQ5igLyQVBvlygUNt35hKU6vx4s5TbHpg1uETULcKbVX3Lx2KRDf1Cr7ApfyuS8KA8wB6DDFD8wbOto6VBTcfWw5PapJeD55m825SjqOtyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882603; c=relaxed/simple;
	bh=Ds/iFWKEadcyezEOhzSp7/w1QfqVAzd+958xE/zYiKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1BbLJbeeyKnBYX0Y3oj9BK0kwoMEK4fqlzZnqCA6+jF3Zoy1Ub3CjOrGy4cpHR+7HzyGGWmmEmwbrBHhKiEHeyi3RMYXgXoeVrBV5inrxVQM41d9yaO8brveVGAE3k0zQUABJrKzAsYB1pTjWR7BARvug1rHEGCxig4lc8Rk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A9DkJsXe; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=XcbUgz4W; arc=none smtp.client-ip=54.240.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882600;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ds/iFWKEadcyezEOhzSp7/w1QfqVAzd+958xE/zYiKs=;
	b=A9DkJsXecUzSXKSBfPyuCspayk0urKCgg9VXRtiLU4nbwS3y/1hejKEMytcmt+Rn
	F7GYKYFmaFy/37rUzPvG8KDGn3bRbbHGhjGTkCO4oZyUKSjOXBz3FSFbxRG/jclbTnM
	iNQjeGtND6IPTw7WcJNRdGpC4THBI0jyh8YDqLcRrBGwA1J1dk+EP0dxP5fXMlH3XBi
	m/EFdHzmWAzZ/RlNgtWljbF2B8Cq5y/vdLiyHiSg5NkgHcNrzAbVmGTEEz4b0FxACTU
	qPNdsTK+EmaFy029VkwC9KGrvUJywoEVF+ZkEatxRoSYe3aGm2QDqyPjSnoa+TT9HaJ
	DuP2qb0gOA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882600;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=Ds/iFWKEadcyezEOhzSp7/w1QfqVAzd+958xE/zYiKs=;
	b=XcbUgz4WOi+t2Og+VHeGt4G07LzJvsDKUBGKfCIH7nCtG+sk6s0JvvZK/Sn9m+cC
	Tx1+oXsiyc7ccIOOOWnnK/tdZrt2qIRJfWDl70zFn7h7/wx2oDa5vKRRXl2YzIrKFld
	DkruMCWvJXvFPHpTzeKh+/ojGd8jfoWVzr6pdWLI=
Message-ID: <01020191d69e8a97-8bce7a3d-8327-4aac-b280-7856aa17f31b-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:50:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] ASoC: mt8365: Remove unused DMIC IIR coefficient
 configuration
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-6-7ad0bac20161@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-6-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.42

Il 07/09/24 02:53, Mark Brown ha scritto:
> Nothing ever calls mt8365_dai_load_dmic_iirc_coeff_table() so the compiler
> warns about an unused static function. While it seems likely that something
> should be calling the function I don't know what and this is breaking
> -Werror builds like allmodconfig so let's just remove it. It can be added
> again along with the user.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



