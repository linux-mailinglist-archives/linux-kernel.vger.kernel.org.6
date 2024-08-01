Return-Path: <linux-kernel+bounces-270944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 523D794476F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080261F2189C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED5D16EBF7;
	Thu,  1 Aug 2024 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iZp9GoyW"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B935481DD;
	Thu,  1 Aug 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503209; cv=none; b=aDh9798BqlPzSXJ9FQih/Uw/pAcnVADUep0RuUFKf4IWKvrwkvsW1tKOL0AQkulqsxPQ6gEHm2oc7Hf7fsPyiYL5cA8MVCUFFdKuXDkwCuLwp5YXZTbWx5TNk/9GRUF3KE00vZ0dlgY1WZItjZbND+rOSMeW/H16JnkU9cdnKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503209; c=relaxed/simple;
	bh=9eAeiRz1Uoe7RhsN2YxOUZbv1JD239rzy7icMS+vujw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Nq7lmF7VPLlIAEfPd4+ULkkbd4UhtN5nhDL2bK/dXHt39oPpgTFZJE33+kwvw3kin5IH0w5IjHjzVL47dIGg49+HbysHliMgh2AutqsUjlae9QsFxyBrcN8fRn0BQvdJMsqV+L6wDE8rDcRbykHmcPpuDjZdcJFt05kmMz4VmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iZp9GoyW; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722503182; x=1723107982; i=markus.elfring@web.de;
	bh=H1qeNadCSH/lJd7w//ysMiO5jE1nOgWC2onDSyEJdJ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iZp9GoyWT3jJtox6YIvkeZ1DRU6J9TbSmM73lTebtLTdpBoMJrQo6V2xAkdkC0lp
	 jGjXkPqLBDN222/MnLyD2bxaZhs5ofwD5g70dUjGJ/dOOOIGp7pmZ/PGej/zF1sTF
	 TYd903/VjN5GYBjfNqK5kY0GlkLabuEFuVDEh8O1rDhOgIYjqEjfb6MU3kyqUqlzq
	 hXn1MuNx/4WUf2t6tsJzwULBgdT3Jv7kTT2OVKR5p6uJZ6/M3pOPm2xZTf9C/HwDv
	 2jWeSiskEU0YZN9mdaLBzxhDvsdwpUNWLydBcvkCxU00QRLEk4Ccy95ko6ruupGlH
	 a1Dan+w66fu+ehx1vA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCEB-1sLTif1wax-00tFVo; Thu, 01
 Aug 2024 11:06:22 +0200
Message-ID: <910f96b4-509d-445e-8749-ee4240849b0b@web.de>
Date: Thu, 1 Aug 2024 11:06:21 +0200
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
X-Provags-ID: V03:K1:cv1GejkDpGglUQJHRpjeZ/Lyh4VjytkKH29sJnL6xwtkrklUbmg
 rz34ZyrkbnO71Fl+Ryg6xj/j/CKo+YKc8nB9JsbQlBwP+xGN3Ni10jJHaORjHx9radPbJE3
 9yf1hqqs+QxzxvJV+I3HLqxY7RoFLDlYr8n4dF+JxhyiIIdxc5yYI2bAO3NeLFMMC3pjZYZ
 RDu5WYRToRIFl4QDeyIhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XCX5bElp9yc=;llUWJOUHi/eBMuE2SjC8YPKvOAI
 WakZfsGMV5d/3NetHrU7cmtG0BIrzsJ7aOKs66jQTvfpZQXBv7CUlunPMSNRhGASBh0QqqQFj
 wr+wMubfeRkfhr8WwxGf63huYT70qJsY3q3Tm9elbu35fYBheSu8mE9FJUn103vBdJsD3zCLc
 /TKh5YkYhUtKl0eHhhtDcweQNdf+qMCoQ466OX6WFDhm537HODpgEYX6jV8z7gbc2h1GJzgLz
 UTlF5B4B+Y4BYMkifZ86y709STwUAmxl+ueoIZsaSTa4q7ePeZMbAGJBa4VoZLF1wXFJwhO7n
 HgO8nLd8y6wQJ36b+6CGVxnag4MdN7VUhwAQD4JSHRlpzdkP78WQAFTazpIHa2JZxpJAy6mO1
 qXlax29sjw639DPdPbU8DjhtA8ZNu359/DMML8Rif90+19+LSAtkkg0spxynahhPDAKsojSAb
 KE0LDaGtCT3UuDxO/hG4dgm93m7bUfxPLtU1/wGMEGUMqqVFVuLt6hhjuYmHiscyu0JDLkq6S
 DWipx7R1fkmrNXQ6MW878YuFNOrGcW4CwD5Gjz/Nag5Vm0gyB/vBnca+50emg8ghxlMUVoKw8
 d6YzgP99C/2le87Upi2dfwll3itVTE/VL3Hcci007cz8aSu7KJWlnRaOgvxyCrClCv+EJy2Ff
 Zw5Jn/IsNks4Yq5+NlOuRcQ8VGLJCkOeXEwS0oWyc9k0KBH2fp+kLx5zibDbwfQRHloKBl26Y
 QvN4gX97lsNeDjI47iw61zcrfiU2hgshAJfqhON5m14GtYxboNQBURoCRzCWHPampdIz2qC/t
 mfuD94XnjXMy2pGDoTeWnrdQ==

=E2=80=A6
> +++ b/drivers/i3c/master/npcm845-i3c-master.c
> @@ -0,0 +1,2364 @@
=E2=80=A6
> +static int npcm_i3c_master_probe(struct platform_device *pdev)
> +{
=E2=80=A6
> +	return 0;
> +
> +	debugfs_remove_recursive(master->debugfs);
> +
> +err_disable_clks:
=E2=80=A6

Please avoid non-reachable code here.

Regards,
Markus

