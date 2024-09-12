Return-Path: <linux-kernel+bounces-326294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF78976615
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA15FB2224C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75DC19F11F;
	Thu, 12 Sep 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Bw/rSeVg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C2184558;
	Thu, 12 Sep 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134913; cv=none; b=Y7eR1fL5n8XZyOZ8teBTiubJ+JqYTeAmKGBKJsoANOFxU8yuKPemHiHFK16pKDfMV3SLRqoBbDKzJwzhMVo2NuY4tku9rKUrlBxRoqsl/umKwnbd8Ptj61E6iLD1+u1y5YHc7PxW2D7z3WrAK6gnR5vOLzNd/MUAzxCOs2C4tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134913; c=relaxed/simple;
	bh=ak0oM6R+aQCqIdmgcyfTd+zaQr3ycIgnJT5Jwb25V3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ayz1s7bdq2J0jHlXB1YGewi+dBCQHi8s2rp98AE87W2lAEltX9i5g88FRgGsZLwTp0ZGZc2SC2XFp4rw7pLeKuXvBHWMVa3UJtNg/ima0xEmbjjshiWSu9DH0WBhmPf1Qcn6WV2LNfrWC7Er0Y5u+hWjP5hrqG6jnz6q7aVufCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Bw/rSeVg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726134911; x=1757670911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ak0oM6R+aQCqIdmgcyfTd+zaQr3ycIgnJT5Jwb25V3E=;
  b=Bw/rSeVg4FseKxC1JOcViq2rbRgfJ+wgTZMAXiPykNzu5hQnBEg+iBnC
   B25/qHAOVbERORX/n/eBNrtxuof797RaI4Um2FfHlh57SNMmqI1xHcRWe
   fj2w/ptZLezD8A39mCKXbA7Xr1tiJjz5FhMYaubKh+RZ5LZES56lhkaIu
   cs4bff9BdhNnzybAWZzESWguGY9TLpED5gcyMK60wEcfEHf10vrnZmrqb
   1/ICX9fMgeTp3vlbteoZNM08Bx1U8mXxXthyzh1OwQHWMUJ4A6Ds+bule
   jG2xpYRQ2b63BIvcKyGVwDj1YHVjA5ryHIcG7TS6yhJWUz7KqbZF2xzb7
   w==;
X-CSE-ConnectionGUID: T/B5t8f4R/WLMPbvf6HuCg==
X-CSE-MsgGUID: PI/UPcP3QuiZ0PEyxZoDhw==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="34843216"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 02:55:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 12 Sep 2024 02:54:44 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 12 Sep 2024 02:54:41 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>
CC: <alexandre.belloni@bootlin.com>, <alsa-devel@alsa-project.org>,
	<andrei.simion@microchip.com>, <broonie@kernel.org>,
	<codrin.ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <nicolas.ferre@microchip.com>,
	<perex@perex.cz>, <tiwai@suse.com>
Subject: Re: [PATCH 3/3] ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls
Date: Thu, 12 Sep 2024 12:53:38 +0300
Message-ID: <20240912095337.41507-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ae7a3386-5e11-4d9b-84a5-8e6a79c91c52@tuxon.dev>
References: <ae7a3386-5e11-4d9b-84a5-8e6a79c91c52@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

>>  struct mchp_pdmc {
>>  	struct mic_map channel_mic_map[MCHP_PDMC_MAX_CHANNELS];
>> +	spinlock_t busy_lock;		/* lock protecting busy */
>>  	struct device *dev;
>>  	struct snd_dmaengine_dai_dma_data addr;
>>  	struct regmap *regmap;
>> @@ -124,6 +126,7 @@ struct mchp_pdmc {
>>  	int mic_no;
>>  	int sinc_order;
>>  	bool audio_filter_en;
>> +	u8 busy:1;

> Can the spinlock and busy flag be replaced by an atomic variable?

I will use atomic_t variable with atomic_set and atomic_read.
I will do a test and send V2.

>>  };
>>
>>  static const char *const mchp_pdmc_sinc_filter_order_text[] = {
>> @@ -167,10 +170,19 @@ static int mchp_pdmc_sinc_order_put(struct snd_kcontrol *kcontrol,
>>  		return -EINVAL;
>>
>>  	val = snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
>> -	if (val == dd->sinc_order)
>> +
>> +	spin_lock(&dd->busy_lock);
>> +	if (dd->busy) {
>> +		spin_unlock((&dd->busy_lock));

> You can remove () around (&dd->busy_lock). Valid for the rest of occurrences.

OK. Got it!

>> +		return -EBUSY;
>> +	}
>> +	if (val == dd->sinc_order) {
>> +		spin_unlock((&dd->busy_lock));
>>  		return 0;
>> +	}
>>
>>  	dd->sinc_order = val;
>> +	spin_unlock((&dd->busy_lock));
>>
>>  	return 1;
>>  }


