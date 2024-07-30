Return-Path: <linux-kernel+bounces-267145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D1940D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7051F2492C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3450194C7B;
	Tue, 30 Jul 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CbWJN3ji"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5606194AF2;
	Tue, 30 Jul 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331558; cv=none; b=A7RP2aaT/+CR8tDIbdBw96amHQEesnfAAYjQs2KAItxh4zxPIjlqCs1/ReiASVDidbnLo84Ud+A1rZY3NiJBVxzLBfqn83OSgDLjof/wBeDk6JWVvjq+JL5tO7seKVOiONb48k5Y6KzjZFQgKMxnJRbiT898sld9e3gxsDybI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331558; c=relaxed/simple;
	bh=B8pPZpptIq748GFBsju+USRBJIgQXhm6PsH1p3yF93A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Qwa1vq2BV5B2RMb60HACV48ScqQ/q9buvL745YF/A/1PbS1acircsZBrkn6GEatwav7qZB3IMrVoM4uMI1K1vfq8gdLQ7bO0zm3wmhRiCdJWKjzGw+QmvdL3FYnTe5vwEgiiqHiTe0LV+C9pWyULs8GrhH24SJcyvxuGhx0m0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CbWJN3ji; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722331528; x=1722936328; i=markus.elfring@web.de;
	bh=UuXPUKpAxDUJSU7l9ijEWWWr13YM4cXuW3gjBPRNm0A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CbWJN3jib0JHsUqML0cfbUsCpoVIXwrEAp4um1p1ZXrQnbPsLAdzmjtLCjzHoGyA
	 RX4lCwa8DEKaSIDXORdG9MVXZKZJ7Pfd8rxaECmwt43AFpQ63umvVIt0yGgohBVYu
	 PYmD1PIAjlQwaSNHXCTPYQYQFZKObRKggSzYG1y09BjVkXydAl2PqNHUUDUnKuHzS
	 LjinVc9VJqK909fcj/tjFcBgBB2ZCCHfjVdzO7n918mHdOuUd0no2WgOsN862Y7r3
	 pGTY5S/Wg3Z1Ekwr+igGsHwVkEtOagg2IohZh+b9Rz4yjE1LM3YStZkEm2zOwLGQS
	 /ZwJpKonFm/8KlDDCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzmv-1sqfV30ZZx-00W9SH; Tue, 30
 Jul 2024 11:25:28 +0200
Message-ID: <7ed0f4dc-9865-4139-bd88-7ca270b9a466@web.de>
Date: Tue, 30 Jul 2024 11:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Herve Codina <herve.codina@bootlin.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Mark Brown <broonie@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240729142107.104574-15-herve.codina@bootlin.com>
Subject: Re: [PATCH 14/36] soc: fsl: cpm1: tsa: Add support for QUICC Engine
 (QE) implementation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240729142107.104574-15-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Enr+kaZULtHao8xj1MEf/uKFDf7xcXnvnwHaPuDxNtdiZHuvaY1
 faTKq0TSqBUp5PnbVfJHtSKkWkSvb14oZqqMrmafdm9no2GWN+cFWhjHN15JJxYtMz9Y+u+
 rlbcI5vrBr9iXxgxveDoHTs1RKZ9xgqvf3m/bg2joG0pnQwCi/b1i14gAI/SZySsyF82FFS
 2x8gGxTr1kypTc+y1/2nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m0k7Pq+00cY=;zaWDnDXkBAX0V6Qm/QR6xTJQWOt
 lAzDsi9PqBK3FR60RDK/jWhujt8nktX2uQqP+P1rZpIjM6bcrcbu7XF4jxeK7o5Dt223usX35
 BBqN7NnPy3zRkbJ9sSQHLljufz3JvkdfSn112I6X0ooGDqUSYtQl9PTh6KkkFhWiUOETGeFgW
 XIZ5qSKnxOU76/JX5GRyBBVCvQGWTRPzbjJ66wkoKI4p8mGV26r2lJ3Q/8JLKvO0KUIg+EM12
 uUeYj+q40/yNl2shqnpXHYqjZttEdqgsi7MFjoP0YJMcrqCVAgGLZtPdtQOeXMj8ak/5ejWRd
 ylynbfeCMHWELfdbyuewGClmsxHONIG0Esg1PAX4WOtCuX5bh42F0wREKEXMe5E287j822sHu
 5i5XVkYFSbw9BGJkwDEb9GJaklRvCTM5JbRjCdiiH2QwW62Q0Ak9jalIolsECfVWMMQVqC01z
 Vcpolul3yrBMxSt7jqfO0jFdU+UBgZCIZ4L0NU5qfDtFvgJYGFasD4zivPogv1ONbg+qjTXPf
 7UtYgTmnkEm86b7xm0BjmK72gKSCdUYlZxM3ThVuKcsYLn6mn7s5T1jyTEcXsVDZK5lCS7oM0
 Sbx20VAB2q99Vx5shGWmbnNcbOIhaaefhqvszRRfSCy9FMxLTy6cZ1mkMFM4L+QlA7ghXjRdX
 +aGhCK0qr99HW+SvCxyFearKhmz5L16uGS53BatAUNTk4M05+aUJgjwvZHzKHQFRmAcuc0dLz
 E52BPCsWSgYAbpm4Dvr+4xqEgos82xxwSC/EsjogHDCNv26J98AWK8HRD8YwoHvSnpAC8v54f
 N2mHin7mhcn4fXhNJ1jmq+Bg==

=E2=80=A6
> +++ b/drivers/soc/fsl/qe/tsa.c
=E2=80=A6
> +static int tsa_qe_serial_connect(struct tsa_serial *tsa_serial, bool co=
nnect)
> +{
=E2=80=A6
> +	spin_lock_irqsave(&tsa->lock, flags);
> +	ret =3D ucc_set_qe_mux_tsa(ucc_num, connect);
> +	spin_unlock_irqrestore(&tsa->lock, flags);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock_irqsave)(&tsa->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.11-rc1/source/include/linux/spinlock.h=
#L572

Regards,
Markus

