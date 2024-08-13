Return-Path: <linux-kernel+bounces-284246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2B594FED7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296101F2435A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CBAA29;
	Tue, 13 Aug 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tebG8Yjf"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725A61FDA;
	Tue, 13 Aug 2024 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534471; cv=none; b=MGrBco3VX6JS+/XkivLLKL4NRJlJzx2rg0Ne95h7JcGaorTnd3zM1yvQ7D/e0L4ZRyr7euLaWsDFDRjRyLzxYh92GYmkCbNQg4+F9lCBiEafzgDthPDWKRwdEKS1yYoD/M2031K4UuRpBnuuVNmZDmtEbw2lTRCUs9ZAGKec4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534471; c=relaxed/simple;
	bh=mU38cC/LNwgzPmTxkcy7GpXw8inn9Lq9sOxBxqRIzGg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hEWB++bh0c0OPnSKD/KPWF+vFIvtnT9S+KJBayD9dMSsHtCaV2qqeDErRj8NHicDolEwIRIeJo+gR/y0i0kiw48+1e2istyIASF3OJToYgVX4UW1bDAyshNx9fyIBH+hlfsWF82xW9luIRNi19Pp5an7+qj+jN0gUeElKz99PeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tebG8Yjf; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723534431; x=1724139231; i=markus.elfring@web.de;
	bh=mU38cC/LNwgzPmTxkcy7GpXw8inn9Lq9sOxBxqRIzGg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tebG8Yjftsbl3IF0TEFclqSqrb2UEraeT45CmxN6iRDtIan/tesDmlY0ypVX9H8O
	 e/VXPtLo0gGUvvklh3xJJ5nH4BemydyVfA7D2mA+30CpjczQPOxDS4x4I2nSe5U5E
	 BUh2SoKMsv+tWbvhGRTM0ixwCHh8r9aX82JMY7EOwCBJa13vt8IILY3FrfeAvuRgB
	 Io7AxlucJ27nT35u6xAKnT7J9XMxZoMRtG9H1/3p3LUXTx5orH4b6Z05I27CEuWoV
	 2KSGC2OCoVpjIRikArEvQM2kO/7ZdbzqpXCqUa30LEH8fdNw/QEdSdVQppA5Lok5O
	 rbBRADEk4ckAd0jTKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYu1C-1siIGd2PTM-00XyiM; Tue, 13
 Aug 2024 09:33:51 +0200
Message-ID: <fb45abbe-6cd7-430f-a828-bcf8667a87f7@web.de>
Date: Tue, 13 Aug 2024 09:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Basavaraj Hiregoudar <Basavaraj.Hiregoudar@amd.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/8] ASoC: SOF: amd: Fix for incorrect acp error satus
 register offset
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QXjrDwQD05SSALKfEGxtJqBs/HinYxwdtF6/Ipy0yvvNpHL8MU/
 OdEarN41T+2waA1pWjJgs9oRbQ2lBt1rHH848rr2nxOjCjGJTVyTJuxcHqDew/UhbVt83Xz
 yDRxO0giqTxP4HfRQD58gp4tL/KPfFulVqNlztpjOUTdF+nvrMl4j3FNocmySH/lM6NIS8S
 ck/1thdaJ0wzkrVzLP3Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wfBjWxf42kE=;dwBdLLCOghN1zXaw0AYkTP79JET
 6I89tFsZazzv/E32KxErl2JLPCbVJYu5CQoMwx9pEahjypZapg+eWdDJJAN5Rr0YoQod84uSL
 uBMD58o6gdKtlE5SuZC9M+5OQMdgfYpXOdhw1XbJAdheXBs39hCUUL/E45sSfXC31jvmSFf0Y
 wVXLMCYgcndSea0oC7DU00qedHMTXg99wQSSlkZHIU9TkOZ3AbS0s8AZRYKA0DFQoTbFGUNgT
 SbM+S5kMdpAo0xRnfRADCaxxGwQ4LTuiWO8aqdSTf0sFxB8BICx35kSCAVwn6EU/PQ2jDbmgy
 zxgu5wziQpXfB19ZlWCE3gmC0T6tt4Y7+2Lc7UzLTnSYbUwW0mvMMLsTI7KHl1V5Xhnd9ZF4b
 UboqLulsMuumlgxOIGRTPXAfk65KzSAdvz70/210TaE/8BfQ9TIk8D9XqPOtkZkLNnLvnmy7N
 H8Mi5nK8s9FsD5qeDmzD2Q6r0Ye8er99FgXBuWclqAH4F6x8i9kAtaXMASk2CmfUZP+mg0G1/
 +fcHTBhQecy8y27LehxwnKFPG8BNgx1gh7sYtWMu2jRHadaH6hZwdT32teM0WmiCDIjcKAMAF
 YeNFvgLFnItBTMQUPo3uZsuB1NFKWVpmH//BPc6N+x5mbxq7Xfzp5mAS6gO1mGsOQmgvHWAbG
 TfEsDMId42VGX4NhT7Y0mCG/EZYSVE4zOa++ECnx/sediocyJCcuM6ne9gmnvS3VkIeDZWtld
 Ai/rGwWtR33KJYUKBYeA0WqZuO2JcD9KsrtRTTW1UuqDqMTOCbb0lE87Nb96jLmc8+TzdgjBC
 D2I7MlKhFCe/SAZ+xlvyFfUg==

> Adding 'dsp_intr_base' to ACP error status register offset in irq handle=
r
=E2=80=A6

Please avoid typos in the summary phrase.

Regards,
Markus

