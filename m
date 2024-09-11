Return-Path: <linux-kernel+bounces-324780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA69750C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2602028292E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAD5186E54;
	Wed, 11 Sep 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O/5MQImS";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YBUKxoYh"
Received: from a7-31.smtp-out.eu-west-1.amazonses.com (a7-31.smtp-out.eu-west-1.amazonses.com [54.240.7.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8B154BE4;
	Wed, 11 Sep 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054084; cv=none; b=Z2eL42KhhTR6xd1adlSIeXqgA2h4KTe9Gym2S4OwLFXZ3MuFs8yqMptPl04I38K5dqMi1r1iFkMizAHrTqGOpbCD+HQEe2L8ub1QaLNBcxrfdk8mBpVbcqIonzp1p+5NcbapWK1lOgpRV+gpW9kA5K/iERDzoXAg7ylEyxUWdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054084; c=relaxed/simple;
	bh=PJUg0yAblESI6yzCqdB6thUEmYVWoz0i/ywFnkD3qEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qH2GoNXbAgaTOcEoRzfb5jIPKLy6O2U0Lc5OotNE8rjXWe0IPT2dYH9jbOyc7QqwInxfJObX/+LRvb0QZ+5Vm3+QFJJ1cfEmuMPz6RkcmgeUYbWyZxrUhmiunc8noaVwfpdhrXv1j3jplwOPctUvCdKrt70OpPI2mutf4kEiSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O/5MQImS; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=YBUKxoYh; arc=none smtp.client-ip=54.240.7.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726054081;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PJUg0yAblESI6yzCqdB6thUEmYVWoz0i/ywFnkD3qEU=;
	b=O/5MQImSbnQm5ykvI0kZX28YhgmTUuBRK3h+0fslxOtdaCOtmRFD3RmyIMMUav8E
	DUIXz+Dtv5RgCHuxb9+pL0w5bqUFBTU5x7xXUemWsdNv6h1ca+o3d37cALlkR9lDdgZ
	sLkO/CgcPgVxW4JhO/ssw1WpUaNKye3Pud/gTDgybw6ReI5tgdApgPdzZtnEg7/HO+H
	Aa+tE6MraB69T9YBeBmH5VQDkMXh5MVujpMHQ8JJdqa9wDNz0+J4yreF8Dwzq5krd/Y
	k4tbCzCBjmLK+cO+1SCObfasxutY8F/h68Edrb9FYxkfVTi8cB04LRY1N+tRxpPr2iq
	MlPoQiOb7g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726054081;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=PJUg0yAblESI6yzCqdB6thUEmYVWoz0i/ywFnkD3qEU=;
	b=YBUKxoYhmvtj7KNU2moum/kL5o/yErrcNd7pxfXfp2X823aqyBZdrE6MrhI6b1Em
	pDY024TrWdg8WCRb9lf9TwMQu66XOob773u2bbwrX/7+7FxzY5Q3YqimWz+t56+Th3X
	27JAVh7nhIvlfsPv/sjQ9D0U4NZhjukB1M5ufm6I=
Message-ID: <01020191e0d72122-0c833bde-7096-4a90-b81d-84945a57b9aa-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 11:28:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8365: check validity before usage of
 i2s_data
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240911111317.4072349-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911111317.4072349-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.31

Il 11/09/24 13:13, Muhammad Usama Anjum ha scritto:
> There may be a case where i2s_data may not get initialized by the for
> loop which will cause the kernel crash. Initialize the i2s_data to NULL
> and abort execute if it isn't found.
> 
> Fixes: 402bbb13a195 ("ASoC: mediatek: mt8365: Add I2S DAI support")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



