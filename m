Return-Path: <linux-kernel+bounces-265240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF0293EE49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87711B22E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426585931;
	Mon, 29 Jul 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ka4UEiRb"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA26F2F8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237359; cv=none; b=BZgB4S+ADjT1/uKBlWuhrfRcCzQ6+/l6wN+XlfES7NiYMjNN/riR91JUfanwjxwiT9m8mHZm8VLkdDULQxPHpZotZoTnt1W25DvX1Cx3bykJ0i7fNcI69torzmdx8LYiZYS5kknbbvSJ4pBnQNdqwEmh5o9GleYDDDoH0M9LCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237359; c=relaxed/simple;
	bh=yQ8u9i62JQjoC7Fsck57aZDny1kjksb5yvyx2ZNAfeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxLbto8MpzMOEfwP/doNv3wTfmoQ+En62poM8Zoey868mPKIU7OevhH04zlnamLus4KtKitYiKmhqDM7A3eKjMnoKenHAHvvcTkxj91I4iE3yom+1C8uK5mujyZ2QUReYa5d/bF81XMtZ9upwo4u44Frywpn63mA9L9adaqwKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ka4UEiRb; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722237328; x=1722842128; i=markus.elfring@web.de;
	bh=duZpOgGavgIfcJxJxGDjjsBaYUoNsCLxi9ySKX3D78w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ka4UEiRbjSKQLNop9RMXU5Kce4LrTG4VppUU9xvJnlswYP7OJiMGCPrXFUF8La7Y
	 k7MTT0ZOwaOG4qDmrTyqhqLB87/i0dcXYx/iJBvuLvrczHFKWDADjKtc4sS2J/fbZ
	 e/tgLVzkt59YLyEi7jYDz0IsoeS2C+7nWGmN1Vz42jPdF1HUn5oz9ImAYjRURq6yX
	 00aOXhrh3YXO920fCihqqM6KBQtZhp5Q5QnqZg+QO0ackwob/AJ5+occC9JKeu++V
	 szZ3VVYeNJ4W/NVH2WUgs4RFM1TnDrPWyi/oeUSMexXCLwD9wZOaz/lpGr80EHa8k
	 meiTPI0dlUXb6ZgF4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28SB-1saGPh2mgj-0022Gv; Mon, 29
 Jul 2024 09:15:28 +0200
Message-ID: <139afaab-343e-4cb4-83b7-2695129d27b1@web.de>
Date: Mon, 29 Jul 2024 09:15:27 +0200
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
X-Provags-ID: V03:K1:l0i/D/twx0/4yQ+jxA/4dRn8I7iyk9vkP4mvHIOx1amytFbIiqs
 NQ8/BQNnqTivPoQBDdBQjrSTwj8wX1BeiYYOyHZbCeRXMFh+f8BLs2vT5A3Bg64L8egyFL9
 WnFiOYF7rTWYsGrLfuJBVu+4tebW1KNfwyOzldQ7l6r5EWa1i8GcQ3XtglaN8Y8fRyn8miS
 vMSGeJXs+oRBWLAcmbmZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kq7j6WJqdN0=;Kr1+OCJOzj6C8z5RW2OxVuo57M0
 HYQQaYI2tUE4hxBCgwltXreqLPepPkY6jGJTcISe386X+gBoApzNOm/JTuqc+9vrIRtx1Wlum
 Nhp1ibF6OTRpWwE/PwBwR60hcHH2wF9QWMoJkBI0vJAvHLm6WOgRC034W8j92143ZIQy5g2+E
 0N9qY25O7/P5JIfY/yUetuGYHGM//mIsOVhhlgitu+FMEq9r7NBd7RHjlS/55xi6QJLmR+jUU
 Afiv8oBcu8FBOkoD3GwkCx5IFU2A/nP5zBvOReOnLqaxve+xMe3nLu3NakpHzdrxkNTtKWj7S
 WlLnhgrFXP0NGbh1cpSASm2N6Mf7VDLQfaQOcAMNmFPTehYUT5dh3rHRIQmux4TmRlwmo2B16
 YcoZ2ub9GIdG+fMYfKIWSTrhVdf9E7tCCqs3bEvJM5wAcn7I1B7JaoF237j27EeJk5uKhOmcB
 F/bKblgtBdNmaekzqO6PDpI+bGBjWm4icaAUKH2y7waKr7cXGoWbsdaJ5v+0cgimPbO/q3tNB
 8RdY+Ng5mcs7ck5vn6NynxkdHBp+MfsiQYXE/ohLMaetis6BayjyHGfS3AqcMx3rtCdo7+aJB
 Sqr9job+SMviRGN+vTZBN5MR/RokWkrwrjgPgqC8HHl0zgJH3oHWXNUKm3q7Y73rSPz0J0fCT
 B8EEbk0M9K2pgF4S3VIbfWnEpEXWHtcA68+rCOhjoaRmyu9lo3GDauVnwBy98zdTbuwvQ5MPK
 96KUUQLdfk5JEaYG3wkgCvtgyzTSW2yopXabiiFDBO48mR3FiyMWTN24I2zDP/rzWwb7J1ReG
 cbRAsiEuKfrKIoen1LoiCbig==

=E2=80=A6
> the driver is loaded, drm/loongson driver still need to wait all of

                                                  needs to wait on =E2=80=
=A6?


=E2=80=A6
> design. Therefore, add a dummy driver for the GPU, =E2=80=A6
Is there a need to reconsider the categorisation and usability description=
s
another bit for such a software component?

Regards,
Markus

