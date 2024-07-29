Return-Path: <linux-kernel+bounces-265262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D2293EE9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F78228261D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98C12BEBB;
	Mon, 29 Jul 2024 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RBPm5t71"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE12F46
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238685; cv=none; b=lKfxFCPJrdw11SrALhhE3feS+0qV+1Xv1OAgyoXUPGbqEpExrRUIBSncSDxGXTu/b8hYNo3cHqWvEmhpWKlAV2LoA8CpBjeKbcHKF3rJ4Z3k55AItWL3UHviQnMQQ+we+N4W807/wm0UFyfK4Hv2XjqTOsfKSntdfVsyDN2K2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238685; c=relaxed/simple;
	bh=RW7csqoWilsK1WhZ75VStOARcpj2a82rVOOY0DGzebM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkfhyHt+zf40qoxCaobGMNxUYiuooYnBqHcsjWhUjqKJXiew4ao+6FURGx56u7i8S5XiXHcW/AqO9h7+a0WWoE6WA0yDK+Akr2s6Rzpdgceiib9+2/jPAwrrfJlQewZHecieZ3MtSRhuh77xt905aN/6l292x+TYsi1I1WMD99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RBPm5t71; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722238673; x=1722843473; i=markus.elfring@web.de;
	bh=0CPFbrdSom84C5+RvbVnCnfxjIQGcRT/sOcVP5UzK38=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RBPm5t71frrmy7MgIHRSRUOhB/6++qR/uBCb4No0JoPVWZy970gPOgVvKUcHkPgn
	 EWMDYX3jLyX1VbKYJ2Qhn0mOiBeOk6TOLffuDyho/sFGjwI3isS2l988kyT5Q0oto
	 I6IrnTE9jWfWtgEEQTqosZsfYd2iy4sdv2MfAqEAo9KXPih2GG2Z5h4Ytt6t6yx1z
	 oK2swIK+wbVFMN7EgepHU3PrL/doCpaZLa1xoXnc7byRLUPG05HIo8fHnSNIqXvdW
	 62xCh4ubvm/Shhz5Ps6ieZjnCf9FCUKdrdyqic2/B6EI7tPsFoWg0os6LbXOqzZxx
	 DXZ69HTLni/eMA/dEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1sSsuT2SSC-00G413; Mon, 29
 Jul 2024 09:37:53 +0200
Message-ID: <ce9b1d27-75a6-4505-b17c-773b51c173d0@web.de>
Date: Mon, 29 Jul 2024 09:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/loongson: Introduce component framework
 support
To: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240728152858.346211-1-sui.jingfeng@linux.dev>
 <20240728152858.346211-2-sui.jingfeng@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240728152858.346211-2-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cachk3OfMSi6UNiFkC8paaYPD3qjgGBDzL8VOhC2QXWG1z2oFzI
 pyci5a30NJa7h/V/rIK7uqt8UqXitAiKnc9rsL+b+wWFWICcYUJOgcr0SCPh6dBPmVpmfas
 dxnr34pvPctNXm1gHfUjjRsniuc22o1JcVmCL7bF3aQIQj5k35YWGHc1XnqHnza8q1quBF3
 GaNlgImDaw7PgfNgcNVuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uL55tRs2TFc=;kA8Vr46z/bsfDkWUIaEmCe9FF6y
 9jZ6W4QLXZLVFAlyGdUX+Nu799jsFJynVaPOeaYdPU6keqABSAhL+5Tg9uS/4bqmVjAsiehN1
 ytITkAIUqCw2mdQPEOXiV0omPa6r18McBmkXuIBMazavWhVpQZwKsYEE5U3Fl22p997D8n4pL
 4swv+uthA3R0oTW/7CoDP3gmk08XmrxyFsNYvadl0K4oBtqbt5zxIyCZPaZ4WKqpe/eQlu4px
 MThWwCIiWek0ds5sAfp6dz4PCdU1jXEciDO2lLG/FrKEWA7QUCTweW3EkvfhkhjD2oOerFzNC
 Xn3uDpkUKeHTNUmTGGoIrCKeDZWxuBtYev3gLqQVrKyQNy73p+vpRn9OsqsnrvIBYd5c9kRRq
 3Reh4blpgwoUXMG/RWXNX/HBPsKIWveXNHMuQq2rOeRCSZeuxlfcrpQnnmBaLHaBCTeXIAP/+
 e79O7rl72nte1eQDFJPFzbUpryGPl9pgJ8rzFIWng3UkHw/G58CFC3mXGlAKjoMrt8U5bZSVr
 qYf9qHGKpFlSPIAaZ3RVfv39nspw4uys7s1uTtBHoOWX2IqnMYEVyzHPn1XN70DX1yOk2DIeS
 c+hvtXIjJYPpvnFC0jyyptTjs95jVgXwRYzbvtgQcsaZlF/UvX7yj8mScqhbhB1tEMqweubMv
 pCL0bqKAy6qfH1Z1qOGT5U7JeHxNOZ2bh4Fn8cHs1zmI+8z8Y6LaEzIS1mKj0w6iS9lUkzhi2
 vGvOegr9z1fzLzLhmhfuvhXAZgA2qbuVZZpJaAaADTwHUHP4TLhYHDh812LTGAIQzmmYGMrGA
 VuZJPOi0iOZ1zIMQvCWKvrMA==

=E2=80=A6
> +++ b/drivers/gpu/drm/loongson/loongson_drv.c
> @@ -0,0 +1,298 @@
=E2=80=A6
> +static int loongson_drm_driver_probe(struct platform_device *pdev)
> +{
=E2=80=A6
> +	dev_info(&pdev->dev, "probed\n");
=E2=80=A6
> +}
=E2=80=A6

Do you find such information really relevant?

Regards,
Markus

