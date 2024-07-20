Return-Path: <linux-kernel+bounces-257867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF69937FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1990D1F21D29
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2652836A;
	Sat, 20 Jul 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pyt5pvMJ"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836EC22F14
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721462774; cv=none; b=tn0jTCeJ0LTLn/SdDlilKDiiYU13BOGErDboCM1fskCYuHJDdvsRsWNlflcpmUzy13pPMV3I/t/u1PsB0doaTg06yreI5LGBo0pPD4eQwVB6lDYwJ9SbQBoIIE6AJux22wjgZreEkAYRhJKceIyBrctZwUdXpAQNrVEzvU9PbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721462774; c=relaxed/simple;
	bh=PHVSl/wshCNA9Yqywyo0gnla7YSzfoEEf4udZoPcDCM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RJORxjcgc7UrTv/n6qkzrf9N4ySEC7JDQRaGtNuILFsMLDfWS6vcqkqMyTTVa0iVKvwGUNwMphEUmAPU62o2/8+izU1MKuvYYmeoPJvnCvGPzx+USULEpBbSoLV5K3v2C1pTcKM5563ISoYfZc8gQcmeTBmlyJBfNn0rGz7gBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pyt5pvMJ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721462759; x=1722067559; i=markus.elfring@web.de;
	bh=J2t61GWW3REmuis12f1LLVLCFhXcXognXwQFM1bnBwo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pyt5pvMJRTCMuUKVWUSV/4gAq9BQ9UzappHUjzh0NuaVbKRF/LpQTujSpqGBoysp
	 buS9phH+qdZ4LnIfkn06z8y3/8PVA3G3SuAqZ1Cq5AXIPKSuN88fWd5BGTdw+GRxM
	 0XzGW9bqYaWkfRH1WIn0Ug/Q8Kit1rjV27+IVi2bLWJz9MpILX2QL9PtWZDL+UuwM
	 p6fW2SLtjYlZSUzZHvzU+zdQqJokQ9CXLnqxwhgSuQ4/JJVpZ66ZosW53rsySQs58
	 dOM47ND350xFNtkehiRjeB7OeIFZ+ruFnxUAaRuJH4tJkU+hx1fXit9gUwltAejD0
	 Zgi3NqCzX25W0dldow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmqC-1sa0Vl050Y-00FVi0; Sat, 20
 Jul 2024 10:05:59 +0200
Message-ID: <f9100627-ada0-4d78-8b98-15d6aef64d9a@web.de>
Date: Sat, 20 Jul 2024 10:05:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: George Yang <George.Yang@amd.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Min Ma <min.ma@amd.com>, Narendra Gutta
 <VenkataNarendraKumar.Gutta@amd.com>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20240719175128.2257677-3-lizhi.hou@amd.com>
Subject: Re: [PATCH 02/10] accel/amdxdna: Support hardware mailbox
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240719175128.2257677-3-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:57w+CsTSOckOVyVlPWbbo/hHQqSD4779xgQm/wtX026ldaAtQHa
 p+5z0cgDngoSWBXCiH+8UbYObfT/HS+9slm3t+Uuxz/jPd3OozKpVI8Z//ZFbw1xeiYw5yD
 t13pWIwlbDDsJyrMPGm90u0Z8fnRHOO7lsDTmJ3SCN73zDzkZOYE8v1M3bcP84ElFDo9TjJ
 IaXEzxZMDfQkrJPOjFQUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KJTEVVoI8C8=;O7kiy57ni35JuLZLXdN4Y7sRIyo
 bSetC+tCsvX/9Ceqb3mj2UTlQSek9e6Gmlr3KFgEJ3Psc6lziyw4CiC1CLPG8UuHF0Y7kXs8f
 fIWYeRuYkEo5DpjKXRuyK2oYU7ub0+oD2zvpFIabTJYU1VrCxYu13qN9x5xwTiHOampYO4f9b
 spnZ9bovEHPzqxs1v44Txwm7AloOm8XXdTlCh0gVBM+dhGb6bx3MpEMG6vX1PXiA/22eRijq8
 yJY3tm5O6bGEiGuHKOszIgoacoE2JNDyCQaPwMEvjG2/OJacoGq9LrCBJJmnQEGfPMBfWIvMn
 Q4O+z9dl86T3iiJokjFhAioCnCgzqn9G6Et/CNlu8sam28vDo8fM7H4OKCjY/PFzJjHw4ZL1e
 ZYRtvCh2VrDbg5csPNj3I1CXjFK1x1IU2ESWBIa/hbnmf9GU8i4MmfJlO+tmtrKnTCvCycnoB
 DP055aIJtF3OosXkMH3ybT0HnvUt6FOFmWZFa2ku9wcdt7hY+3czmgY4ewT3y+9MA52uTNQ0u
 mjL+U7u39MrIgGJrJNQkM86NO7r4hwxWWm0aY1CW4jWrDmDNMAXRIIL5oIj9CHN3pyW0hCSPg
 46Y80IsRI86xM/obGhFW5pUszraPnAehykBUMNtbDFnbQyMAwDHiVMHi2asjHoM7LNx+6EZm9
 +IsQzy4BbVFeZFp7754eoVacvd+QFFw3D2MxyKPmBHbl7i8VIjd3m7UTdBwozPhHbAvg7s0Wn
 UG4B9YYJWO5p7YT9pbo7T5zlqEAq4YebGTMLYTORamKh2d4WpoenEB14RqDCKA7b7k6bLXTOQ
 4RxdP9ujtXBIMyroFrBIm2Zg==

=E2=80=A6
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -0,0 +1,582 @@
=E2=80=A6
> +int xdna_mailbox_send_msg(struct mailbox_channel *mb_chann,
> +			  const struct xdna_mailbox_msg *msg, u64 tx_timeout)
> +{
> +	struct xdna_msg_header *header;
> +	struct mailbox_msg *mb_msg;

I propose to take another software design option better into account
also according to the application of scope-based resource management.

* You may reduce the scopes of such local variables.

* Would you like to use the attribute =E2=80=9C__free(kfree)=E2=80=9D acco=
rdingly?
  https://elixir.bootlin.com/linux/v6.10/source/include/linux/slab.h#L282

=E2=80=A6
> +	mb_msg =3D kzalloc(sizeof(*mb_msg) + pkg_size, GFP_KERNEL);
=E2=80=A6


Regards,
Markus

