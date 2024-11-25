Return-Path: <linux-kernel+bounces-421621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B89F9D8DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0983B291E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FD81B87DC;
	Mon, 25 Nov 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KtABL/cf"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA41891AA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732568475; cv=none; b=XcbcR9L9CgKviLCa9AKxqX1rEesxV7trWGXhAiKAvcUFp6eGUeAIi4s5doVvqXR2Bzz7bsvKmEgmz+aufBiS8EsYCzffPbmp8eOa4I9k6XGO0inGqtYGOEHIYc/EOfr08IyHQyT3r68jlGm3GQhzsv0OEfMpgqaRAvmXvj8I+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732568475; c=relaxed/simple;
	bh=GYvUBA5BjOM+/7xzBWjPyBEWFX8Ybkxg6Stza896lRE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YGe2JwYkkGBI0C7B+e4iA+cTtzpwJgIvNOuJsAqLLZ1+9nfC2Mt+qRFF2hU6nlCbbk/a+PMIYFg3rNDKHgIZOPdeTLGRPZJ9hBQvjEyXkEkN1GGZu7bwNc0HJkH0Rl4TNEoZU7y1yV6NRIDJ/CUYkCZgbjEhBUbe+brs6d3E+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KtABL/cf; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732568454; x=1733173254; i=markus.elfring@web.de;
	bh=U1KGd7lC3wJAzmLbFHY8H15nM6NX0O5/QyJiQ5y6yLo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KtABL/cfULr7kGWkD3bSywLenyYXbpSGRhCM5+xUxCHwtN1DvKAq1qaIBw5kl9vm
	 K3GwCNK80wCS7+Twjuy/WGWjToF/7Paj9O1nb4qarK7yCcroKFy5IzraxzMuQcxPC
	 +OkW2DfsgE0bosiQ4+JrEDpnDvAz3zqhpRuQ39H1InoF7r+WEq6WrHaPcvETdyorq
	 YqWJ4IPBz1mCfvy37kF9mdQlCE3XX7Zygao1BRtaC9ajyql36/SnF5Phzzq87whuu
	 bexsLXXQ0T/DI6bpxiP9byEfjFm8up0JoNrQZqSwVR9HyK3W7bhhyt2QYZsqvug0v
	 qDZU6FrqL1jqPEgzeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRYf-1syq4P0khX-00IIcn; Mon, 25
 Nov 2024 21:54:26 +0100
Message-ID: <cbcf177e-198d-4bee-8e8e-c6766b15f661@web.de>
Date: Mon, 25 Nov 2024 21:54:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Kunbo <zhangkunbo@huawei.com>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Liao Chang <liaochang1@huawei.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Jianhua <chris.zjh@huawei.com>
References: <20241125123547.3307117-1-zhangkunbo@huawei.com>
Subject: Re: [PATCH] x86: fix missing declartion of io_apic_irqs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125123547.3307117-1-zhangkunbo@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LV7ne4uKnomkw/+52B6aUZupRq6LyRah52Y87j9fcdQkJxTZKLe
 M9ex+BJ5vDqZ7DCik30QNYLVRRkSE/B5TL6GXsmFobnYwH2D+RPaYeArwa3iiQ9wDWmHUTc
 JJ1VQDmBM9C/OiFI6E+iydJGmrvMt+vRNd+nV9W+RYPbuv2MCJxu/83kBnXEQkDgGNUKsxW
 k8HmjOKhImtrEBkj0/M3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xaIcDup+BtA=;u2QzvhXSNZ+tUdulwImB3oNuD+1
 iVp6ZFZ8lnCb56gRTopGUnsd5ycCRcwL6waEZBah6RyTeGOKLqC2dGgA0CLyULchpPQnI91od
 YonofsJ/C5mwjtKLf6iZo3sfddF2kSYGsi/FvDCfYP1TfYkFGrLs63mi4b52crtoIB4okUqBN
 urs4bfiU623O4LYQwQuNoZuUQPdkuNCNS59szsEB1uf/lSITUaZJkDBUqyKhzhLwvXDy6Fbti
 IfaGYKgY14nUbzFadPPIhKlQLBb+y/mGaiK6Yr7lXZT5mLb5y8bih2EozbzDc1C66YOl1jhrU
 Vjive6TTOaKvp9tf9KgXcRVfF5SmMraBrnnoucd9VbHRXKOcRgItQmOdIJ2Hd20Xg9wQLvhxo
 crVbjWMMi4yTW/CPrV/mkmo4c9YgLX1qZ4/Pfl5QmM+n919OOC6j+JpU3/3gMjn28Fn/iicI1
 wA+KEJEyjLEx+doTKJRTjFiHwAMn7Bm6gVzHIt+Ti/KEidm3oiaOhJYt9seV57wmFT25FJPSQ
 tdsBM0z8tWeKnn6lGqOD+8AYN0AOk8j9dKyRxjr2sTncDjPxKLqAwGUex+vK9uKwHTRcW7lmg
 F6V9sASkT7wEqtU27ljCsnE8H5CR6vwqk20T11Nnwe4D9WKMhbQkwU/NUf8PkVjuHBFTiOnGe
 v5tlI74A3XAT6v7gZusRGudGAbWAq7G+h17u8LJqmVtOzkxFdlXxASKfUJRRcBscfgmAc3DWc
 j0j+UF52sX8VSopePlQiAMtjm8P3sPkwBI6YxfNF2h+oANNPmn2YmXnDr+g5bYwexuOsawyqS
 GES29+r792YXB3mmT/2H+Dpcjwl4QEXQpHm2MjbQRy+ofcxtepVYcc6Hg4eodPC7idppnWnax
 SsYsI1NXnVSe21ATm2g6ByBvwr1BXZ0Qe5YWAV9ckMkcq/PrIeR7xG2mS

> arch/x86/kernel/i8259.c should include arch/x86/include/asm/io_apic.h
>  for declaration of io_apic_irqs. This fix the sparse warning:
=E2=80=A6

Please avoid a typo in the summary phrase accordingly.


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12#n94

Regards,
Markus

