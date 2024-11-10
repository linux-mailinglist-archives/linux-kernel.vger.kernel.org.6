Return-Path: <linux-kernel+bounces-403169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555749C31E2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8F6B20F39
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFDB156641;
	Sun, 10 Nov 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nAQdAjwg"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D351537C6;
	Sun, 10 Nov 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731240652; cv=none; b=JeEOA7sefXPPKScKis1Ggln1IVwR4hGrj0JJPVZ1OPd/p4dBeQT+Fi5EZMRxHTAa92lbb1mgVfNLuR0/CH5O6ChbFKaV28u9l/xpeMJSNKmElrTCDA2uueWerWJkVQeoaLH8nBPvMAd+m/68RZq0FXYlAXyhnGMmQ9kad2muWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731240652; c=relaxed/simple;
	bh=XTR/nhj5MrW+3ggTFQ749a6iLnniw2ba6f0H4nA+qfA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Me9MaHnvCnL0otiqtYfD1vj1Qp6JOnRrVMhlXoakgSFiuZGa46RzGFX3YPJffbMTpD0Z67zsK2cwtq7wIp91CwEp0kHni4zJ8lp3/GdOiSAdcNEvxV4bp5L60xO4cTZPzVZGdKIdEMz4qBzMPZ2PEOafESidDTTyUIHxrpRRUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nAQdAjwg; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731240625; x=1731845425; i=markus.elfring@web.de;
	bh=XTR/nhj5MrW+3ggTFQ749a6iLnniw2ba6f0H4nA+qfA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nAQdAjwgADWFJo5qTN9mgG2FdrguVGoYj/xwvqAfcuQW9i4WHJDNFjcD78cHmVaC
	 yIY3WmzjFZ41JAbXSHcXvEK7nJmSwG7TE9uhYOzbwVpdxMBpxlW4PLQjOQLRk+24m
	 AtSf797iZok8gnigCT2lWL6O8MNO95hGejezOlgmUa4pxe+GJalqWPXGmLkdAz4fo
	 YbI7xu4b1cMA56XnIzG3FNuNoI/iRDPIo1/P0Fl7xMX30JCfoL8kM/hcrRijT4Mkc
	 JHJSL/WwgWcSpf7r6al7B5Kw5B5V7O1C1OEJlQGP92jMS6eX0M4JygEZTK4nPSQmz
	 ChOvIvpy0LOUGOhiVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SKz-1tw8eE1Vtf-00w35Z; Sun, 10
 Nov 2024 13:10:25 +0100
Message-ID: <28f2bba7-40f0-4015-af84-d3c08c9a14c1@web.de>
Date: Sun, 10 Nov 2024 13:10:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tang Bin <tangbin@cmss.chinamobile.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-sound@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241025080026.2393-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with
 local dev variable
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241025080026.2393-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cFryH+0NX5oq80c/QNEmOxjeC51hOP9U2wT+P96GpQKaFgokGkG
 7Wf4Mn8YFwyLHHvCbMMy7JcZy5ok+8spkddeOF/7In/eQzmAe6ZLdtEX7AObfjUs7k48cJQ
 bOq79U5aJKSnzi3foN5ca5TGCXTnYYYP0k8wUbidQsVqnSc1M2E+ehKnocTiasfpdMF5C+6
 jGyK9d1+5Xa0gJAFHiGuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ix+3Vngnm6w=;p5QE56Xzwca5K5BFHiuaLGJAO7e
 auLYxV4OV05Pw5RnzItnmtcO2ieqKwINlj2b7mgshnGe9v4h666f4G3PXQqhbfWO1gRZxzxXP
 G2o0xQEphxeYmpPNS9GcDQwG89SlGCCWZqeY15vwpzDg8aXkMD627qJt/pq78A/hFnvU8VbLJ
 uLnReYZtDslBjIcVTHC/d0h4H9DE81xMwOvl0HtOuIlM7KnabVQ2rabX/Z6CpQgprA2DoJDgm
 6UTisdG/AABwXS2pUv999C+jRLRRNMrY5XlrSt4LHnTo0SuwZaSmSxwNkEt9DVHlTVKa0kEJG
 Qj8uADrUnMEzKQvx8In0aTIJ7U8DPhBiSTqOL9qrKKvLlK0LVzltBz72KQ0IjUID+jkMY5eKx
 zuyMRDOca7cWeWhU8KPn7wAESWXGMai7IJGoMjFk5ii848OglElYfNamS4xzybeqbQGGRUYu6
 vxqauGbXI6yxyqiRkjU2xJif5KsbeUep1V0hSHU/8CzKVsEV9SyzikeaRe5TYxLMqpSR8PRM2
 d/3drYn8kg+G65WOE159FhvXYEDBBR4Bz0mK4ATVwS3JNj4LM4vHyhqcnDBXF+9ATbe+pWli8
 /pIblUEdqbL06nKzC4h0Gv2BKrMtpFnpNP9i7qS0jD96nxHcLwSH57Xu0iP3QBfF7e173NrSo
 bRp/Z6SMpvHpi8s/qiTfJUIr2/GNT2k9KBrMIfIxrUVPcCKGEmXyd4FGFdT6A8Z8+h+CvkXvu
 RKIpvVM+P2aMza0wS1zeq+oA2N++LyuFapUbaXM9g5lcaSNOji7/DoB0PGTUUbK0oI9HXh2ti
 AY1/w/8YCyi+PHKY2Md0odpg==

> Simplify the function mt8192_afe_pcm_dev_probe() by
> using local 'dev' instead of '&pdev->dev'.

You may occasionally put more than 51 characters into text lines
for an improved change description.

Regards,
Markus

