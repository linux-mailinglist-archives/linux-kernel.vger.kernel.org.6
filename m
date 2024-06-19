Return-Path: <linux-kernel+bounces-220655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EAE90E4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF5F2844BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89F77F08;
	Wed, 19 Jun 2024 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EcbHUndJ"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578ED182DB;
	Wed, 19 Jun 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783785; cv=none; b=DkG4V5tVaaG8yocLpVsK1RcXJWv7icdOaX+ewX7zcgAx8Kr6dwsBBSD0HnT5Txp4Yv4xf349WcVGWOe0z4l/t3j5As3NQdEN9qyqw+MSgDeJqeJmqJEnS3D9g43bQ+EK7SvQPYjfwxEK0p7zlI28GkqdXhZEIjB8Qv5gn/yJAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783785; c=relaxed/simple;
	bh=MIeBYTYwehE4mdC07eH09+hgOUyMJEAzbyr59ive7Do=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YseB37bRDcSLMbt9lJyajzNTMLWus0hm6VlgnbDgi6DeF0R593hh8K9usO/kzDTGQhMD7m3+wl1kiqhwTnLCNKNBfjMlz+AdkqGcslJVylJC0RwG3v1JqjHhrCpUR2BQtIKIOkZvnYZHj5lU7JMZRbR/kYAQb8pPp0rh9OCYfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EcbHUndJ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718783745; x=1719388545; i=markus.elfring@web.de;
	bh=H6XR+KaJmJJXfpLLFejnJYIpvpaAVwGzb2OH+w8nOPE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EcbHUndJ4aAdvM/a+7VLFlmCGR3jEhqvXiPaZ7YlwZPB2+wP6lkheRdGkLVxEJtx
	 tI2QKk59BttXf57K+VgTceAiqymatUIMuqEgcwoXFilLoNi5wASnc42bhtlpVDqss
	 emMnjd75MklQfNfGEf0winFX6zGuc5NpHe6oUBaFe6W/7LfRgjVf2ztRRtI4hpb+v
	 U1M7rhEBInU6OGcXh+eE6tBTly0JeYeZB7xlJfYfSzHK5h5ajhHM3N443zJS7kvRU
	 nazlSHxi4WwYbNurWynsSiK+SwSKHD4oL0NzjrPxVm+pg3qTs64qmf9Yqv0lPpxcH
	 EVxUphULPDQjtkiGxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62uQ-1sQPo90PN2-00qu2k; Wed, 19
 Jun 2024 09:55:45 +0200
Message-ID: <e916a445-f7bd-4213-ac66-cf39f6c5001b@web.de>
Date: Wed, 19 Jun 2024 09:55:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jie Gan <quic_jiegan@quicinc.com>, coresight@lists.linaro.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Rob Herring <robh@kernel.org>,
 Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jinlong Mao <quic_jinlmao@quicinc.com>, Song Chai
 <quic_songchai@quicinc.com>, Tao Zhang <quic_taozha@quicinc.com>,
 Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>, quic_liuxin@quicinc.com,
 quic_sijiwu@quicinc.com, quic_xinlon@quicinc.com, quic_xueqnie@quicinc.com,
 quic_yanzl@quicinc.com, quic_yijiyang@quicinc.com, quic_yuanjiey@quicinc.com
References: <20240618072726.3767974-3-quic_jiegan@quicinc.com>
Subject: Re: [PATCH 2/3] coresight: Add coresight slave register driver to
 support data filter function in sysfs mode
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240618072726.3767974-3-quic_jiegan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a/SZS1DY+oZZXGn4gEUYqrx4lxfFFXvkMLFAROQHi13/Xbu2KfU
 xO0q7wzNAxTkpSIPUONQX3gNWJ7IurTIjsFZKUnwQ4B8Nm+RW5tLC5f0sP6vhzLsUyO4xQy
 CNsyo9Sascxa9W0fmXmtPnwjJXsh3ZEGi/8dUKth2JrmTd5YvOZxCxBDdaEjmUP6fe3nuN1
 iS9P4Pz4Dz1n7rI1qLVKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aIh9ZjNPP3I=;7KBwd39YmURPEMZKHTMVfa3Miuf
 ToC5Sz0ObZGAWZqSAM+SwJXIZPkZ40qbS5tygrWgajN62xN8rG8EfkwZuArzvq2n04MCtXs45
 kRQHzIIAJ7fvMSXVzkcZje360tc3hVrUu3mSlmwOSXVAuwsHDIJbFCwA1REfkPye3VC0MeeJE
 5jgbw3t1QtlNPmikAPJSt9qxNRFGO/jy7bSeIZvJI+Sgfqqsfgl4/DfhkNxcdJiN8isDfZeCi
 rkx+NzJ3vzt758VM2Z20EqzckiPuppSsV4Gn3/0Z2Dbp9sQnrVAsFrU7Z9fG1kNRtQ4M3guHR
 6fX6rVIj6vA+YLxLba4PFfA36TkGBNuReQF2NPc+Z9goP10vi/ZUQjwYOqY3OncAEpGfKZvhI
 NeAwH5bPVGp/7Oe/UHe18gJXx5bfl1QRrKTsKO1rdQd4gTEZZR04oBoRvYUDpSFqBGBvsRtRa
 fsgxhNXGkpN/kHydt20tJrStvgCPCejeuMW0DO2jloW65Btn1ZpD4ckL4Dx2vczWGgAKHDwab
 NM6kwAtioww/PYHT7LWffM8pd9El56HuYPktj8351by8SfnmWnZ4h9T+yAe0TGAb8ckP+wlEe
 iuwNTIZnVgG9yYYBvgnb9yG2KAYd5xlL8N6YeCkd7IM5HRxmpdQ47VZfbkO0iZauzsDn1rFLW
 3KjZih1ppa6nnh2O1rF+GRXddn0sjS/9NqsTgM6XkFPiJy7/lOt8P2+WHzd+B6Ur2ryBzMqfh
 y1mLPGv2ul7GRqAJVlqTuLYEOtyyD7u/WX4ycF84TG+N8bCaJN+p0Qm9qW5fVHYekQYKOYiZ7
 cTgZEj6+CXqEIn/QU/1XArPcid4LCwdhv7881hB5xG7kFf6XisKlczP7SeWjbW62Pv

=E2=80=A6
> +++ b/drivers/hwtracing/coresight/coresight-csr.c
> @@ -0,0 +1,315 @@
=E2=80=A6
> +static int __csr_set_etr_traceid(struct coresight_device *csdev,
> +			uint32_t atid_offset, uint32_t traceid,
> +			bool enable)
> +{
=E2=80=A6
> +	spin_lock_irqsave(&drvdata->spin_lock, flags);
> +	CS_UNLOCK(drvdata->base);
=E2=80=A6
> +	CS_LOCK(drvdata->base);
> +	spin_unlock_irqrestore(&drvdata->spin_lock, flags);
> +	return 0;
> +}
=E2=80=A6

Would you become interested to apply a statement like =E2=80=9Cguard(spinl=
ock_irqsave)(&drvdata->spin_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/spinlock.h=
#L574

Regards,
Markus

