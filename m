Return-Path: <linux-kernel+bounces-330578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F9597A055
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671111F20631
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF2155CB3;
	Mon, 16 Sep 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HMushXji"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2941509B3;
	Mon, 16 Sep 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486454; cv=none; b=K2Tidaw2bX0XaRsXuJnHhVb7wBwAbHj1HqlEPd2UiCxv9u0iRuhAErOyKJ2g+UYzI7Rl1w1qmn+4hLJr0DRHdrkOrN3mGpXl7bKnKLBFsAgfgDLBtcoM6nAfrNAwA0lCyr5O4n4FHRGUm2SgmxsjadfZ2PNCKpzvwcb8ixtGDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486454; c=relaxed/simple;
	bh=04M62AnevvKOpl+yrEWkhUipAMKBwSj5m1kfSIBHe7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grbU77yu8nVdYN4vZxFaI4JqaDVYBcUnnJIApe5dsS8/C6J83uKOr+BiJJDuaXx7ovUd7J5E4Oh6Bj+J62xJV0u18YRi8PqRC/h65FMuBmk+3RnX2V7bAhHnIsy69c4MKov+Dof/gnTDCqbmarf1AvRBCU9KXoMDOqOh07DiIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HMushXji; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726486453; x=1758022453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=04M62AnevvKOpl+yrEWkhUipAMKBwSj5m1kfSIBHe7E=;
  b=HMushXjitH3FzxCc8QzM5BhBRohMOGr1x3af4g5e3bGB372WbBoHEAUr
   znbB1wTcJd4o38YFcec4DGx8ITzb0uO+7HJCg3in63UrL7Cihayh7KeIW
   vBWfN8cfas7B9z9942230W2TlySkjkwZo+ERgCyvSqnjHIADRbYpiJq56
   eI5z9oIeEytt0inmNPPEN0EaqD8rSIHHvGeBjakSASKuUVnEgQWFQx0x3
   oLXHe82C4/IoDnqwfT5YbTOe+DJVgvGuxLjGu4IEOfXDenz0ylLTCLxER
   jY2oZAWSqFgffo4RSbOF7nwOmm9Smbh/CBN4Ex3f3i4LJ/kVZomltw7dh
   A==;
X-CSE-ConnectionGUID: Onkqnjp3T4uu7VkYLySsmg==
X-CSE-MsgGUID: DF5Odg+jTkKSP28grZCI6g==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="32447859"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 04:34:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 04:34:05 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 04:34:03 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <andrei.simion@microchip.com>,
	<broonie@kernel.org>, <claudiu.beznea@tuxon.dev>,
	<codrin.ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <nicolas.ferre@microchip.com>,
	<perex@perex.cz>, <tiwai@suse.com>
Subject: Re: [PATCH 2/2] ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due to single channel limitation
Date: Mon, 16 Sep 2024 14:32:05 +0300
Message-ID: <20240916113203.17871-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916100006f2db7b06@mail.local>
References: <20240916100006f2db7b06@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On 16.09.2024 12:59, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 16/09/2024 11:52:15+0300, Andrei Simion wrote:
>> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>>
>> Drop S24_LE format because it is not supported if more than 2 channels
>> (of TDM slots) are used. This limitation makes it impractical for use cases
>> requiring more than 2 TDM slots, leading to potential issues in
>> multi-channel configurations.
>>
>> [andrei.simion@microchip.com: Reword the commit title and the commit
>> message.]
>>
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
>> ---
>>  sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
>> index 7047f17fe7a8..475e7579c64c 100644
>> --- a/sound/soc/atmel/atmel_ssc_dai.c
>> +++ b/sound/soc/atmel/atmel_ssc_dai.c
>> @@ -822,7 +822,7 @@ static int atmel_ssc_resume(struct snd_soc_component *component)
>>  }
>>
>>  #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
>> -                       SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>> +                        SNDRV_PCM_FMTBIT_S32_LE)
>
> I believe this requires a comment. Else someone may add it back later
> on.
>

It is unclear to me. Would it be good to send v2 with this update?

>>
>>  static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
>>       .startup        = atmel_ssc_startup,
>> --
>> 2.34.1
>>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Best regards,
Andrei Simion

