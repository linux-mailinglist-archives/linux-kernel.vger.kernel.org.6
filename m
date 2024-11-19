Return-Path: <linux-kernel+bounces-414922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0716B9D2F46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96CF1F24381
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD31D1E65;
	Tue, 19 Nov 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YoPwpTV2"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0714F10F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046897; cv=none; b=TYhxCM1wozivto9sgNj8aOHgrViX2rhWKaTQNcUUw+RCzD7QCFyCj5CWEbWLu3AlLAM0Ro57eJ2YkzXLyK4+B897Ki/2IwmNw/Xnkwq6ofcQ6+nNunHHhAXF+p0cMkctPJnCzHApNefYQGlghTcB+zkqXXfB4vq/zvqrtAsI+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046897; c=relaxed/simple;
	bh=Hs8Eme1OQiztzxJTuvvPmRZGdj0gdvzB6wndxAqATAU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VKIIKCqoBg1CrJ6VmShbl9PwzC8EqSNy00hYvqVkrQ0ZW7zm1fYgvVYeyABbdZxCTMZlDElmIaCsnqVwEpbqAHu53AQAlJNrVNr4BxnTeYd01KELHK7+rMdfHTI7WNTgSUp35HuuNvR48XQ0A5WQLMcA0CPj0zHrevxFq7ZxGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YoPwpTV2; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732046885; x=1732651685; i=markus.elfring@web.de;
	bh=Hs8Eme1OQiztzxJTuvvPmRZGdj0gdvzB6wndxAqATAU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YoPwpTV2s6qaagxzNt/KoAqrdjDoFHnUiFTw6z5yuRCm1+oDRQNv88w6PKjRenvD
	 iP82d8hn8Xxf02KXFAWE+YBKXsXBl0SZ5I/njhQUykaSyK3mTaWnEH7gfKcX5/qnT
	 dn5XHL+jwd8lfSKPjcPQW+jtBDtpdPBHzidrXJjQnjt2RSey0mLYnPC38uwtIJ1jE
	 vowoQuS1QocliIGQlS0nYuM3O46S+PbCOklHtzJtN4pG0COzTBo1Cd+sZz+0vN+nW
	 Gk2wg9QGoZ1J7fdmhnglXOUGOWp+Ck9vmY9ia7JLy0xqNxTbZTp76jupG0QXgFDQD
	 F5nLQIbvZDjRwjP6Mg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8n46-1tqHvH3mQ2-012AOu; Tue, 19
 Nov 2024 21:08:05 +0100
Message-ID: <70967ed3-3983-4da4-ba68-0f91a44157f9@web.de>
Date: Tue, 19 Nov 2024 21:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?RGFuaWVsIE1hcnTDrW4gR8OzbWV6?= <dalmemail@gmail.com>,
 Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241118174519.17951-1-dalmemail@gmail.com>
Subject: Re: [PATCH] befs: Fix incorrect superblock consistency check
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241118174519.17951-1-dalmemail@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZuPDtqAZB3k5srkCRSKFu6OTs67p5v93zR9E/OxmVfzOBEx0Jh
 rrCNFuurCmGk5D9EwV2NC9gIpiF6wbcGmestw89uKvMROJR00xxQa5cdBoa50R79Kv4W22s
 zsp0+loq7dvYZEn02oMhehhMRRIQrSoApJFuJFD/YUkD/IyHAhjYrU+AhdSX1eTKYER9ZdH
 UCOUX9hhjxwawGrkXwohg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yY2NuUWa2wg=;88Y/4mzwtfzk9R7Io5ejeJLt4I/
 TQ5uMt5614yMHN1zwCW9F6UwK2PfaRWQZnX0IkOzCvW2l2+pWKkli1Nqg2gi7nfiD8lV2UcpH
 ZCRFcZxah9ZAbA5N+AGYlWK8zNB6XC8JJeoFgG4yhCdL5gxG0cjyf6iQh+oFEcove8Om+xZJa
 Wr3GGXlYivMEf2lFvuiv6YY6Rq0c8i5wuZir5dyQr2Avq3hNbcQKqvtNgTPnbBg4t6Yq9Mg6a
 grqr0MtDRVaKcZEQgi3rS+SRGwl/WRR4pDIIJpJbmo4Dyj0ChQ95T+kDjoREUfrLgBMqNA2z5
 sLkUrsD8Wp4ZfSHq7ktFnLPrDOfXH6RiRWUI48WM8i8zq0xgD5kiruQbSu9qoHR0tTZeqkB0A
 oFc8jfVx8+sSYMyfDCafWYg+1/6B3tgDty7C2LXgUJniGtSBc/m/T2ScKs2H6zG3Ag4LPsgpF
 ws3rK+tnaUpIVeU7NfMQZS3YZybhCIpuBiUigxhbjBYFllcK/KJciT2iYvCNB6cn/IgMoJe3X
 ZHcr/4Qx18wFpdzM8puRxXXChvxeMrtQtUWpkYCK9734cycrBWMgu/p2ETZyrxEx3sKGsdscE
 4oxtXKdOhtfdw653/grMicejJ3NJgyPkiuxg6aVocc+fcZumIuQDMnbyLDtd0JMDlc9jKfNLN
 MjZUWLIH1/ORDiobHPqqFevnPOxkT1WyX1K/BYcKBbRBfTyAur7jcnRiubfTBIKKrmQ4njAyA
 VNqu2S2xrx0WcDyKusZYwBG4oJUs2sSTrlXHYqVpxJkyh8tFlmsCEpOied0gbzy0Wy5HwTKgY
 X7NDBfjwvD/0qedn/IxhxhJhsypTDEJrIdwEoqmtVAU12EElJNJ7Lc4uZ5ncL1oxDeTWON3Nm
 ZyoxKoSo57jEkI477KeRw0uXRNXJ8wICNClVM+PrxQ4/2xi7lExy6RnCy

> The check assumes that blocks_per_ag records the number
> of blocks in an allocation group, but section 4.5 of
> Practical File System Design with the Be File System
> states that "The blocks_per_ag field of the superblock
=E2=80=A6

You may occasionally put more than 55 characters into text lines
for an improved change description.

Regards,
Markus

