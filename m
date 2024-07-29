Return-Path: <linux-kernel+bounces-265285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A8293EEF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736691C21B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062C12C530;
	Mon, 29 Jul 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kjv8p/go"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DB12BF25
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239346; cv=none; b=Sz70vXDFI+n46VoutIQI6qDIRDruP2/Ypm1jUeHX72q8e3E5g2TCpjD1AphSSSR/jI4UHfivrTZdLNqxZ0zFQKHFgTXR0gUsgNqhGP1rtfxaJHw4PeXiYJu/2UITp09BUZpJ59J7rqzSHkv7X6LgTyBNqiQXIgrz1D0Ja5dLDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239346; c=relaxed/simple;
	bh=8qXbmALWzs5SYl+OmeX+etAL3BW7qWgUyyLGnkXZ4C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2hFrvDijo+bb0ogY/R7Qz3Fz107r9VoKFo25d2xNvZX6VqYH2BYcuC8FTkAaIi9tNPLsMssm5CEpy5cSK7knViRJIqcYibAOXbeMvYFJ/p7QchgVj1mPvNLnnp0EcuoyRDehfR85zkZ6nJZHOzYAkW7FUbn0yn6TMb4EOFVQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kjv8p/go; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722239327; x=1722844127; i=markus.elfring@web.de;
	bh=3dLNP6ha5L8O6bnFV3P1s/tNTDR77O8ngc2Z3LIdL5M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kjv8p/goYjNyWD65H5F25SISxM9y/D49LA4z5+CY0fcTPOWoPHFfgid+uLTnFtzN
	 QrTRds5FdYF3Hv0ANHjJfZY52GSrVomdjTr8SuHMrAY+WAWgV7huEGQX7geY270/8
	 f0gffgqJsOheq0ObrTUa528+jeaI09h8zHtzsrYbDomNQB0yzppcAi7jPzm6pwOa0
	 NvMo11vNgf75qczkPY3B3UUbhq8WfbHl+lufwRSnpy2ubgm0Yhp2GlHgbSiHQCv/G
	 79YznWq84XDlqHZCdfdpAo0nqlcbV6JxLeDHgTh/wVES5T7I42KFvO3vM+cmz+SaC
	 tnfxtZ43ZEcwwFOBXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1sBuiz3REw-0153pK; Mon, 29
 Jul 2024 09:48:47 +0200
Message-ID: <439e8600-91ef-4c48-8d5d-f02a497718c4@web.de>
Date: Mon, 29 Jul 2024 09:48:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/loongson: Add dummy gpu driver as a
 subcomponent
To: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240728152858.346211-1-sui.jingfeng@linux.dev>
 <20240728152858.346211-3-sui.jingfeng@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240728152858.346211-3-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DwFf8raUcUPakBgYkEZ+Z0vYtFpYB9XQZqXPfzuXX9SQlG0bSwj
 B/ay3HNglCy9UCqpGRbZz29AeJT5NcnhwlyTGUMUDUx2ZkxZ/P4yfbCApSz+3c9PMN3oymI
 A01YRd4EhsZ3hRsQVEcb5qFGCcRNNvPvxDGUMuctioORxXk5rDdBsKhldMN7sFF3Fb50fqi
 3CHQPG70gH2yS93s/W1Yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k8BcT9I67pU=;hgr4dPf7d473opHP9W3cu+dMEq4
 DjiIkqCSYVI6xTaYBbntODw2f4NxoqEBhl2xFaqg8XvZ/4ldW0vdbXLZxmzhg4AgJ8a3sN7Mm
 HlwgDxOi9c+uIMLXKDq0sd08t9QeE/4kB8MMDco5J//JWpRukBIkrW6UdRAolu5Ic/snxkCSD
 abwhIfFHwqUqOYkSYQ5S7ujMnnxWQ/oQudtBRUbWxLW3N/DB1tSav7U30SnxNx+IDVdsFoqOu
 Vfmznw02ZmdsY7D+EMWZrlzyiU1Lf4a0hQ3uSKyV7gidaw0XVLmIwe843bKO0kJaC/Is5SvAZ
 ww/Trww2NYJ1VJgErNcbcKFcFp/1JnENn97k7v8TixNBIGo75VPMDetD1GQdm6JDTZYyi1dgl
 Mfpv+4g7Un13jZIDHcs86y/1EPFDHDFAktQZWhdtVQCOlvLrTh6eYkHWhsfPe3kRX/hzo+d+8
 psJ58/iq17ZcS4bRjLcv4YmKU2uz/iZefER8phA1Gbu9W5sMZWSNWIOWJhgTb+qiEIXc52NaF
 kox/KA8YldML/plCLLQ7BpwFH9psNzmJlDMKDtadV4fZHw3Teyn5YLDRw7AJsNb1DTYZiD3LS
 297O2guBLwGtIreaIAjpBm+FSTD9Y0GTd9icZBLVou4Gy1Jck64tfvgsAPmtXLNjGr+lE2tAf
 QzxbkCXPOU95QuO0VZO9keW8UFh01yujj1ctbU1eZJj1VdSt4N7AJCbQ7m5yifeS705/ODFs7
 V8mOMVJyFLPzDgF9QRwUvoa+H7Rxj7wERnJZCjy2l7vRJRTCB8IJIj06yefTcr+f+P8CwfcTE
 53JPTCwBSXmmY5V7kz/ENQew==

=E2=80=A6
> +++ b/drivers/gpu/drm/loongson/Makefile
> @@ -17,6 +17,9 @@ loongson-y :=3D \
>  	lsdc_probe.o \
>  	lsdc_ttm.o
>
> +loongson-y +=3D \
> +	loonggpu_pci_drv.o
> +
>  loongson-y +=3D loongson_device.o \
=E2=80=A6

Why do you propose to adjust the macro contents multiple times here?
(Can it be sufficient to specify the desired file dependencies directly?)

Regards,
Markus

