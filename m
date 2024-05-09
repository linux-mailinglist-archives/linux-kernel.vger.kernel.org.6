Return-Path: <linux-kernel+bounces-174335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9358C0D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79DE1F256BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937FB14A4EF;
	Thu,  9 May 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aRvGTQiF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED1BE68;
	Thu,  9 May 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246008; cv=none; b=iozlwACnv+LMmN4ywOej83swLOg4srH0u4CGPJ9pNtU+XUGgKnP1Iw0s9Sj3ROhF1T8wUxIq0cxN5/HhkLKZ3jhWttiK7V4exbnmMZiF9zvPySC0ABqK+B8yT/rkgNSAB7KO2c4XhwygujiqWMmLEa5+sYOjNYzzW5armsU+XiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246008; c=relaxed/simple;
	bh=NKeC3HSPrcO8YGQah7jVicYXn1UrXm0HIq2+GZU4qb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bl2KB0EGrkC9ZjVFBzr125nT2EZ0meuhQze3+eKIx6GAf4Pg+GnuLxVxskyl9eP6a5GmeMJxjfDSmxh8j6t8REEnos5L966oC9iCxz5OrGILncZPRB8IyfQ20lgtCd3b3f6NzMGptxXiDPDye3n0ly7Fc7z4Tsg6z9gTGW20j0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aRvGTQiF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715245999;
	bh=NKeC3HSPrcO8YGQah7jVicYXn1UrXm0HIq2+GZU4qb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aRvGTQiF85dxBDSN9fPkXOnIxpElVdaX7KpVKTj40xDidst6eL2eqnswdPhgJUiFi
	 PNHR0gTmZBcx31tDijXxnLOSw7ShYMkm9O3lueWNdiBa42INll3QIiVMVa+pbslzcj
	 lp3jANfu7BxQkq9jikVQu/8ihHTpPRRmK7Knk5vdP+dwkgS+OdCYp4QMbvK4F37N1M
	 YCuQXPG8fYfibrlQv8v+Xd436g7BncoUBCmFLit4wT+dp+AyFxs+rxkagPyXKblmn8
	 /aRagpfQ1G41xvOQF7+IRZMhna8WD2FqCG0y1kozJb/mMKjCwgHcVAAI6J41g7HV6J
	 Cd51XjsIAPtKA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2B0C33780894;
	Thu,  9 May 2024 09:13:19 +0000 (UTC)
Message-ID: <f0548f88-fe81-4c07-9583-ef1a1c5ae519@collabora.com>
Date: Thu, 9 May 2024 11:13:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8192: fix register configuration for
 tdm
To: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240509-8192-tdm-v1-1-530b54645763@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240509-8192-tdm-v1-1-530b54645763@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/05/24 09:31, Hsin-Te Yuan ha scritto:
> For DSP_A, data is a BCK cycle behind LRCK trigger edge. For DSP_B, this
> delay doesn't exist. Fix the delay configuration to match the standard.
> 
> Fixes: 52fcd65414abfc ("ASoC: mediatek: mt8192: support tdm in platform driver")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


