Return-Path: <linux-kernel+bounces-270906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD79446DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54172B23B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF816F0F9;
	Thu,  1 Aug 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="J7fKc0c1"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176116F0DF;
	Thu,  1 Aug 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501836; cv=none; b=mGvQtHE7oR8jRP0mKiqsL1usiSHkhxN2eTRMAtep3hwlVplSscA67kQ6JbHfWDDZIN5u9KvOORZfedMrbnptTRuIKXLeE+czigBvA4CJKtftzlwwez2MlsihGz0GpENyjsCWWrlDUun5KxqY7Eo7iVnPt2LGlb1RM6X6Wl8NUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501836; c=relaxed/simple;
	bh=K2kM8YggRi5Dtsgagwq/vp99bFX2KUuSkK+dDgQtJEg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lRXNjVPY8jfuJ9vnk9tvgl7MJGi/DINqZueRTCGo/KCBTK1td0bEm6v9wIG2awY+ke1T7Au2hvKuetxkGG12md+HyD+IP9gRFWsy6RIhf8ZAymE7J4t5SHFSGO7mkitDnb4V+9Ks/axIkws0Zj6QLwSqQCMGfW1EEio85DzG+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=J7fKc0c1; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722501802; x=1723106602; i=markus.elfring@web.de;
	bh=CQp3GKwVPbSykTP1zO1E1wRNFejm6ihvP+iQi9limaM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J7fKc0c165phl0NfgymzO04iOO+zavIWFdmwr7oNBRip71JHICSurGLINPl7a0lg
	 FedQAG+MJ7PIfzPB1265zKsKQasIZAxrosDl5f3H3WDwyWIrpVscmyrTJlhJSjMWM
	 VdJVwbA8T3lB9IrPgjALLSGD3jiZOumZVR/Fux8DIk1s+tJIt/Xm3rsAEHTeMkG8k
	 tjp7rKiAT8hfjscp1eZaFoSyMSqwTbMKrOzbvquSFsPp4Wri5IyWeRJGi6uhC0wJr
	 /LGg28O8HRqkW6bZG+XZFvR2JrBC9Fr+3BcdiV6ozg2rLQYrPqR4+7a0hwuIOprhH
	 mp2JVvA9Fl40tJqm0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLARS-1sqQ3c0u9q-00OTWR; Thu, 01
 Aug 2024 10:43:22 +0200
Message-ID: <73180782-0f78-4e49-9528-172c5d8c43f6@web.de>
Date: Thu, 1 Aug 2024 10:42:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: James Chiang <cpchiang1@nuvoton.com>, Stanley Chu <yschu@nuvoton.com>,
 linux-i3c@lists.infradead.org, openbmc@lists.ozlabs.org,
 devicetree@vger.kernel.org, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joseph Liu <kwliu@nuvoton.com>,
 Tomer Maimon <tomer.maimon@nuvoton.com>
References: <20240801071946.43266-3-yschu@nuvoton.com>
Subject: Re: [PATCH 2/2] i3c: master: Add Nuvoton npcm845 i3c master driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240801071946.43266-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YbpryX/+DRSBcSU8+6mi9njm2dNI/wHtDq3ZO/tUM/dvgTqvWv7
 PRIO2b/RloTIK74+SjBlfZz4U3GEwueyDeLwrICYZNSCc42UmxVmQd0xQPk3IYR8VNpe0Cr
 iHVEm36QTzZBriqrHSbT9p/1a1egGIgCzVJ+HQt3VdO3qt2C3MqyEcmgKi59AEfXZ+UJrGt
 ql6EWwXjyQ62IVoZwMjmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/Sr9o8//E8w=;uGeDbtd1xbAFlu9rnBCLtRel+wp
 XL5r4wiHiSVelWPKHGWGTjOMlNaH9VRKaSpF7BAaewRf0W2x82TiB05V5y5QPe5eLpNKVNjDZ
 DveFTS13C4xsmO6WoNipCzuGVTdrrjN+oiXV4v5KSJs17XAWLmxl0/Mk53TLAEfrp1+hYqaxE
 4Y5Jy3m6khdiCGlFte1a9xJpWullQZHqXq4LfuKZ2MJwji3TySCXc9uL/Zixd1QUjpggCBtp8
 NRp68MpYSY1b7ClJNeNQAfSWvYyrX17VUDQP1u1jsiWKtaQQN4T0ErSf/2J2PFqtz3F7c16nP
 pVx11+VlGJ22K0hxWELmsS5QwEISdpI2+RS+MT98GQr+m2UQIrrT8rL+1vZaKTXq403J1RNt5
 h3XHd5RvGYOYzJ3zrlWikQg+ddC/SzgIoVUsC8Z77180TOGfXU3YcwlzH5/6cJn//toyC9rLe
 1GWdsuQgftw982zlbCm7qEoC5tAT1m0hkU5YBtEVLyetzTbHNMHoHSTIVS5LobjoIwYrFog6G
 ryTa8GTHC3rhm6UXDfdkVrNRSN1U1EPdCreP3xfqdxHKe8ORhhiWGKe+5s4J+Vqqbkas43rH7
 a7hbP3olzKGLO3FlF8ffbClo9Noe9D3nm3T1X7Y7v9GWQLur6ZKOpK3ZtyyQvMi7Uh10fJCam
 M06R0f+b/jR/joq7PC+GArLtYCdfSgE1dRUL+uC9QQKATcPGriFINf47qraE/srrfL61hYm5y
 VE/Roo0SdTGPy9dvvWt+cxwPvlcKzlITZhxxUpCiSxnFvXdak/q5BhsW09LeB8p9k8TxvMROH
 8BSMcvIKpTBBDpY7WBt5OjWg==

=E2=80=A6
> +++ b/drivers/i3c/master/npcm845-i3c-master.c
> @@ -0,0 +1,2364 @@
=E2=80=A6
> +static int npcm_i3c_master_do_daa(struct i3c_master_controller *m)
> +{
=E2=80=A6
> +	int ret, i;
> +
> +	mutex_lock(&master->lock);
> +	spin_lock_irqsave(&master->req_lock, flags);
=E2=80=A6
> +	npcm_i3c_master_set_sda_skew(master, 0);
> +	spin_unlock_irqrestore(&master->req_lock, flags);
> +	mutex_unlock(&master->lock);
=E2=80=A6

Under which circumstances would you become interested to apply statements
like the following?

* guard(mutex)(&master->lock);
  https://elixir.bootlin.com/linux/v6.11-rc1/source/include/linux/mutex.h#=
L196

* guard(spinlock_irqsave)(&master->req_lock);
  https://elixir.bootlin.com/linux/v6.11-rc1/source/include/linux/spinlock=
.h#L572

Regards,
Markus

