Return-Path: <linux-kernel+bounces-243112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BB9291CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D500B1C211A5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 08:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA246B91;
	Sat,  6 Jul 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rBHnu9EL"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC381CAA1;
	Sat,  6 Jul 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254076; cv=none; b=E+PFrwF+npGbyKpC3u8hokzh5ZmT4yHpfSYr/539evlm80XkhydoMkSu/nYcKA07mRkJuZIgqJkcG4cZm832jzKRk7JPGMXcVYgPbGrdyA4KMT7hRvi9ARF04iJj6V/AgFxeSxZ93fUzvxvbSfIaGkcchkUAUZQKyZoUkjrrcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254076; c=relaxed/simple;
	bh=EjHeaYK2lnlH/aBaBonNUcb+1o8ishy8edVJ2Dtl4YM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YEBZPU2PORXJx7xE/vq5FLvBhVnJwYP4xQLxz1gmD/4+mMfXhM71HHbK/lDyh0ATz7oC3AmaKGD/GGZ8mj90oljeFfcx9Unq6zGCzzJaeOPQQISiZGG73MNXkX/UDWE5SQ9xa8PxgEA3Vgw7xBAQxAbAjIaN8lGsR1FK1EeVoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rBHnu9EL; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720254059; x=1720858859; i=markus.elfring@web.de;
	bh=afApj3YSZ72YjMYkr6dhqIbPRpKKBwBEycFGRfMGKew=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rBHnu9ELc0Zp6QzdiZ3GzhBzdaCwys8+4UPMQRP4gPQWNiUca4+VPo3MlVE+7JMw
	 1KT5cpHiumcxpNJHN+KZ2z9ekzsUDMEax4I59gFYM3rdpcIHltxgs54gEJD+Dxjp0
	 cZIFP5tzBQ6mcavd0HEF91+nnAm9Iln5Z6f99WweIctnHSk/Ow9y3LgxFQVQHh3CK
	 a/qCBJwJ2koiWbCibImmTOQgfL9zJRW7UccAVMea0Ji6kcXaiR0jH4ZmQCE2EqINx
	 iYor/FFIzmd7289gyXgtfVO8LREw6ksmseDWrYtfGMpXZOpl8ltsZ8L3EZWjyd//g
	 nvFMehniVAqxa3xkRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1sQYcy44fa-00BMyI; Sat, 06
 Jul 2024 10:20:59 +0200
Message-ID: <c88eb0bc-b86a-4077-b5ee-09d46a3074e3@web.de>
Date: Sat, 6 Jul 2024 10:20:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick Terrell <terrelln@fb.com>
References: <20240706045641.631961-2-senozhatsky@chromium.org>
Subject: Re: [PATCH v5 01/23] lib: zstd: export API needed for dictionary
 support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240706045641.631961-2-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xrOf52OENPzB+Ci0nFX9hGxOSVLPOJGRqivp5JAzBzPfQXYvr+U
 LdpEc9W6NneLF57ebyBqzLRHNOAJ+f+XrnYT0am4pX8maSUeXIYoEKA/SdmWq0shgwZc5Gd
 9hCuMu5UtNGwH9d/Wy5LNHeVXaAI+GKPF/vA2crhOmLprl5OqBDggfUWUnUybC9cMfHvzJE
 90XNuNc4V4Hs/33C/IYyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k+zZ8mjY9X4=;Ts042HU7h5cuIEesrYVFolPFtfB
 s2kxgfjps7FjoTT+1ansowdx0atkUZ9W6ByHlg2b99GmNWfMt3d1SF8doA7cIDJTKg9q4UBQu
 Pl4QQye3M2wD5pibPGNMAqx6plGG/a7XAzc3ErHR/OZXy4+l//KayyFYDUKd/J6J6tpjbTcE7
 9SQNh+Er0M+DkPhpnbf316c+al3QLHW2i4HIMZCItWZN1S6lQSuSbk1Pu2FdNuZ8k2hPvBjJR
 udWVzFsV7tjE/m3S44VmM3TipUQ7CWGNiBatYqj64wmtI3dpyo8cSE4h5pKI8APhonUeEQVob
 DMtfC7hIxYj6p/e+AndmaAkhoEYuMUntePvUnt3Xa2fzsyTGGYBHJ3Q2SwWA7idtlXgz4+AV1
 I7SVvWFkClE0CcRY4qIqkIaH3s96bg4zSsnt5iLp8KHxQ3F+3++GjHFMa9oikHDEG8kRPvuy/
 in6qmKvMIdYulnHaCR1NeN8V/pW9Sj/RzXJpMCPWCMQpsfgbCSF/fCUDX95k4jOD8VFA2OSf6
 CE/qc0H2Z/V8iUKhQLL2vmepNPBUhStOz9br+X9019LPkJev7nkjloZxDWPngwaANYSmYp4Jp
 7QfIu28VhFURYG+OAcDaNBMfO9tuBKkxjxwfaLLnBPNmzedfe+lgef2D5wuYCT/jPNp8Zwf94
 cKFBgpxSORJs/KWdc7CaXdRYJ7Zdp2WKmKUQaE/MDmykerJ2UzJleqqwNFiA54q6d4USaWJ0J
 QPF+Loz6a4HbSzWzjFX3YJVGPKvXXlYCNIlnSgxy/2DZnaEPBJrBVMBDyJPDtnSmAXV2hf00l
 W4mEIWUsltbY7tl57OjO25+N7RopDe9jn1ex3ZMgwkIF0=

> We need to export a number of API functions that enable
> advanced zstd usage - C/D dictionaries, dictionaries
> sharing between contexts, etc.

* Please adjust the word wrapping.
  You may occasionally put more than 55 characters into text lines here.

* Under which circumstances would you care more for remaining patch review concerns
  also according to better change descriptions (or changelogs)?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc6#n94


Regards,
Markus

