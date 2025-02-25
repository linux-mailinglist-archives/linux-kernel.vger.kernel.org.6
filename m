Return-Path: <linux-kernel+bounces-531666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79166A44368
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A1B861761
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0626E62A;
	Tue, 25 Feb 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SZSM4FTn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9EF269B01;
	Tue, 25 Feb 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494516; cv=none; b=K4F5O1ohHaEDG19MEFfLQKh5ogftiZQ8+vfbAL5Q/FbQgQEYVpgTmPyOjWsXaVo7KlZafNyaJpAQmxCMulnnDsQKtxsEbLTbTxtTRbHTnw5LNcz8djeOAkg6xVxOGgvArMyCHDbPeDWnUdXMo944ElTSl+oxI5Zha5/46kRE0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494516; c=relaxed/simple;
	bh=OsoerhI9WsLOOMY2Rdt3PJVqOYEEm1V/Bo7XmSxoDl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptvQJ2MQMT/X2k+SYfN0yAUfhBhEkk6POpCq2Ot6pTweNjBRuRxRkDjuR1T1GVjrKlnGNr+fvlcjD2UusJgLKOybGbZgxRQMbWPAXOC1ypEOWw8ej7hF+i+L+ouEO6WV/Br9J0wcSZhxKz/39PJcy+zB42c0pZEFDeI5+kh2Hmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SZSM4FTn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494512;
	bh=OsoerhI9WsLOOMY2Rdt3PJVqOYEEm1V/Bo7XmSxoDl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZSM4FTn4mzwb8jnHbzHxD27ZuvtKTfJeoWas36wv0trYGAcQQry6OLoR3ukrKvTz
	 C35YVDkqeqzBQeTKdVD6uVQgbLBx0nF8klvV5quXrPp+07K/bUAeh/IMzZNBovkgIy
	 0zBYXGivfbiPPAQH3Hm199kjEhIgXtYbzI9hyk9crZQ5KgnqtKgueXQm+5ipi+uSad
	 Snbjv1nYHLoExx0pJ5hSxShigQZrNG1Ob8zmAK1bibWfKUX4ArK8meWksdjmZdvfk3
	 akgSlERNrscerfXhy6KqRntqwCc93FX1NG3i7N/ivcuqgX2Mdc/aEymKpjMF6wKrYg
	 aiMd9Zq1V0gQA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E99D717E0E91;
	Tue, 25 Feb 2025 15:41:51 +0100 (CET)
Message-ID: <c25f36c1-04ab-4681-89c9-6dea7cd26ea4@collabora.com>
Date: Tue, 25 Feb 2025 15:41:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 DMIC backend to dai-link
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
 <20250225-genio700-dmic-v2-7-3076f5b50ef7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-genio700-dmic-v2-7-3076f5b50ef7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/02/25 15:33, Nícolas F. R. A. Prado ha scritto:
> MT8188 platforms also have DMIC DAIs, which were previously undescribed.
> Add DMIC_BE as a possible backend for the dai-link property.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



