Return-Path: <linux-kernel+bounces-265175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965CD93ED97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E728107B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA984D3F;
	Mon, 29 Jul 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eR7DwdKV"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64B84A2F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235276; cv=none; b=HdtTsRa5rYi5oxRuhNf5d0ioS/XJfuzQak1a4quEsT1u2FrEP5IuoQY/2gUq4cZoWTI5hYt4fpQ6nklVSGL9RJ8p1WVO8W3Y+CUITti2Ch7I3+5WZ+mu4C3QG2VuhpY2uVDblpSJ6dJ78ZjOG5Mp4iehbHpOaZPfb/R5XWRkt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235276; c=relaxed/simple;
	bh=FKiZLIIW/Rjgk8YYHrGHydi/ayOuoY02w8vk/Q+iTRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpaEl8fPakVgVotkjsTZlg8P2Xy2OWzJOAI0EOg/n/kpUg4H4/S3cfLFXxdkex9ZrzZHkA8NxwkBHXhq8rziqs5NdVqTxDBHq3fK+/PwEPOlGAlsPdJJyTAlSP8gX4UB74Uv6hHIIin3uHQi2vtIB+xUNrm9jzshR2mQCx6TnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eR7DwdKV; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722235248; x=1722840048; i=markus.elfring@web.de;
	bh=FKiZLIIW/Rjgk8YYHrGHydi/ayOuoY02w8vk/Q+iTRI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eR7DwdKV1Ki7Ix/TNESgSd8z07S7aVyP6Sl2TZWY5SQJcLwt1p52fRMtAOQQm4uf
	 0KyCDhkaFSH4rppBCEOBA5ABCKue0b3zW7x5/1lDdehxJQ/fo/BjUO86J63SkNWAb
	 TdN7mnDpHhlIJrRgYA7Vp8Z5tJmKysR3z/9xIhrt4yJ/Xc9ULigKhDt3y4racg4+H
	 GdNcLNtRaey51B8c7nDfvC6+PtH2WzzT1ByRmT1JVSunyaa4/zksKIU0Ny0SW1J9/
	 MOH5APZRnJnFCF522PPUI2oVdQlySplrW1TZsB6hxMxRe4C6fH9eyevXvC7iyzjHs
	 koe3qPtRZGdul8IOdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoNV4-1rx0ER3VM0-00p3Z4; Mon, 29
 Jul 2024 08:40:47 +0200
Message-ID: <6dbe975a-59eb-4d4b-9fea-b930fa44e4ec@web.de>
Date: Mon, 29 Jul 2024 08:40:46 +0200
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
X-Provags-ID: V03:K1:eH8QhXFrNUvKJHFFt4DSSg2TJPzXihfBGfxhTUawe9AS/vs1ZQS
 3JR2FAAYsMFu98nrykhrIhcYV4+J7qe9Ikk/Dbwx592stgB7GeugBxET1sB3YtleBX6oKlo
 yg/X4u+tD2L5XoItJFdPUvZYtxfYXvcVwwXyxiKMamp+5nik+IwdkSiBNcKn5JD0+8w5O+a
 ASdsnuHnC6TySNX1AynKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EXKv7Y05wlU=;8qHZtcsi9/jxerfd/oQY7TiHg4s
 TIB5YXfpSNGR19gDBXOLIBw0RsCdTwXVp//s11N3HhfD1dGbIrCWXLTxNjkTR8knKycmFZPFc
 jl82Zj6TDZ33ygVQ7zHLlFRJhS0hrZ6pp8l8+jjWOvMtv0l8OqOXcyhg98SziJdmUafZThxrG
 CiI5gk7esfvq+Fho6vvG8pXbBqdws5F0i1OZau7VL4sF653NNIwG0F8wwH18vclfqYgC+K8n1
 Mh9Ak6ETh8gTLjGjE4lVzJLsUtfrGgFNQDgFXZnQDpqRArCIIC5TohqVnWGLVshgCByNg5pq4
 r+G7iJDtMkBg3B6Mb6m/TXzFA0BoUbzL3Nb99uC+ENVr3Oh/BngWzqfRNjcy64lYCMDoekRKE
 T2E7jojyJMz+No4FDwd0LuOIfJTCWQ7SxL/xCBFiYOnEtVyP0TwOIh+BsDGijRQt6X30RnkL3
 4DkBPmtTNx5Hw4537LlJMFxfWCm7iGzDBwS39ivv3gvZqrziLrtGFdqBhKkX55Pc1nkSJ6Blm
 Z8aX9v+gj20k5k6BrnN9rEPMIimFv5VybvNyXgBw+rEfGV+EX56QPncTbP/S7rpMhRSJGuJkM
 LY32x9sCYRxP4ZMLdyNYFPQ5a0pJ6Hov18NdvZhPtAizkCvLGAZsTiRqC273XDQ5DEYVkc+mK
 n3IjU2U9PsGVj5DmejnYOPY3mWy7SsVUuEJxUqgJ/Q43zSx+8nQtUouauE4AxScBkbozo3RdN
 yNbl2lPZMbZxA39l9VcOdPl3cpJWDPHte813Ul91eT7zo5wuIen4llQlJZnpC5v9qWDyAX9Ms
 8DXG/BOadu2k4vRupwDMpNnw==

=E2=80=A6
> +++ b/drivers/gpu/drm/loongson/loongson_drv.h
> @@ -0,0 +1,108 @@
=E2=80=A6
> +#ifndef __LOONGSON_DRV_H__
> +#define __LOONGSON_DRV_H__
=E2=80=A6

I suggest to omit leading underscores from such identifiers.
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus

