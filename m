Return-Path: <linux-kernel+bounces-284668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEF9503D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B21281894
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEBD1991D8;
	Tue, 13 Aug 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="f7OWM8Of"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46EE1990BB;
	Tue, 13 Aug 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549000; cv=none; b=agMYt1d6mdwnpnztPiPNANXwrr/h1gzq6VFi3hU+/Tpd+cVx59IXxJJyAt/r08SjC+bGW+ANTTNoz+V0WqFDqm0Hwdw5B+d9sZ1QTUgN6mHV+hV8aOQrWZfv5JVIAOZ4Ii2+mmQfuA2rKi89nUHFFVPbmAXHHAZ9FUrabjdhmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549000; c=relaxed/simple;
	bh=m0IRIH3EcHV+TrlopED/cgfzuE9mKP8Dk1cqfwP22DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbFFyBI+JG+13+WLylCTiLjnoO9iBMBWjc9DmmAzMewRuH/fNdYR944JfsOxSJFMYCI2AHLZlBGBbj/I5zlHX2JFtei90eyCv9tecyT9a48PIhshaUNOGmQGL3+zY9//W8WUYXJDu5no6EpnaCH0jFo9k8qrc5nwI9dYHCGD32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=f7OWM8Of; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723548958; x=1724153758; i=markus.elfring@web.de;
	bh=7ipYMxPYpOpnW1gNYkqI1PmfHkw0HS0KWT1PkmtvSwo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f7OWM8Of+xF6FVyJpYuyCeMxI/59mdOFOzAIm920XKpojmgLqVyhhPXdNruVkjCM
	 czoreeYUNWtPfMTScgjOC7IPYCpBPgMucDOekzE1c6rQeMV4I6XoGmCp1fA4XkaMb
	 CasImxN2ZNbJBBfKL48/EmISnKFfvEYFuy35k16rlE20sLzAuPBzL7ipfqbAbdtK4
	 yJ0ABWOKh1UbL1YTPgkwUaQYmK04aZVW4DSoMbEq2OBD0j36MOjagExn+r8Iq/TZH
	 zJSndhrzttT67QvpWIFTjaxzsgf201H5/mS5Je+iYJAlfaEpedFPOeSw2v/jIAeDe
	 9+n8wyZHrHDX1rGYOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1sQgfe0hZA-00GRu0; Tue, 13
 Aug 2024 13:35:58 +0200
Message-ID: <ac7efdcd-cc79-4984-8b36-50898243afa5@web.de>
Date: Tue, 13 Aug 2024 13:35:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] ASoC: SOF: amd: move iram-dram fence register
 programming sequence
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Basavaraj Hiregoudar <Basavaraj.Hiregoudar@amd.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
References: <20240813105944.3126903-1-Vijendar.Mukunda@amd.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240813105944.3126903-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:szcAT5i8Xj0bcGbc849dlKmiLBUMBuWPDXT4XBTxmCtSxx/JcGM
 28ppT0+5oNUnrvkidj84Gy1Z41vVjn9s9QxjU+uL4m4B1OKpyJT/yECkIV0Oc6m7lyQ9gVW
 +iu9AGuUD6MOJdPeJ4bgWxzpXCt31CQ0u2/u9wayD5mckgWnnwqFTi2lfa25P4zKzJ00O5u
 a1J5UaAJJS9Dl7VjeQG0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l/qmwRXuIKA=;fd1eSuvXq/XoLU2WIflqWfTlHop
 +qFsCVvb3Ug0rgCmpuEYpNl69wRLghI7eqG3tEZVPUmxafWEL41MNMpO6rzSUVRnsH2oZGNov
 U5vuZuVqVc4tlvN5lnQmMDK2O/9FiQP3A9dpcFwETiRgea6feKH/SSCD9Oaa7VNMQYsmzOw/w
 U0Bji2Z+gXD5iN65YJqJufbPHKDkBn9MfwIZpWpg5ddh2yL8IfIrC9hnECCoLUwwzFX3guIbj
 aHM7dxAYl7MV9NvXUBf3ayUfv2llox0hGZbZ+J1qdOwto1hJac9oktVRpSawsCeTyGDVwFvQV
 40CEdXirF/ecyn+olP/e4mHkegGdSKP8HO+Cg/LgiGDyPpvDXyhZB6imBgpxsvXxEIhcRDBI6
 JDqpKLb871i5gm/FOeV+IUIG4b7TPbRJZ31eglPGCKVsyk6h1BoWIAJwLRTw37XM3qg5/2sdJ
 RUTTpFZjpxG8E0ZicSuObzKCMHnPaCvX3J0+aKfARdtTgCm96mJhN8MmCfO/GWaa3Wcz5/Ezt
 ZjPZ3wnf0HzK7/yauizTYXOsZ/wu96xy1TNm2KzKJ4dGdBOHANdnDUOROeMhxXb2QytBqotrK
 Peyi4D80uRENXhAFeitGHbZK7W0AHh0IVvzudmPiRLrYZiTEhdAt5+QD9F+Mosj3Y+DVFYJNl
 gLqcV4A2lNKHKHeesmBagkg0+hIEKz01aRH21yPgmT+oyYBJpS3NOb/zD9qh/r8BRQ2UZcs+e
 XffgE0GTuf9905UeVWAVktvbyiSLmKnwUZfpEW2ywhUVuhC9xa8WQvbNlkmKP8dBMWLcZcuAN
 7vfkAk9kJazY/FmSus+XVuYA==

> The existing code modifies IRAM and DRAM size after sha dma start =E2=80=
=A6

                                                      SHA DMA?


=E2=80=A6
> sha dma failure =E2=80=A6

  SHA DMA?


> IRAM size. To fix this issue, Move the iram-dram fence register sequence


             Thus move the IRAM-DRAM =E2=80=A6?


How do you think about to offer cover letters for patch series?

Regards,
Markus

