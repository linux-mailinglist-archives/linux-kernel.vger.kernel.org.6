Return-Path: <linux-kernel+bounces-562925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87CA634BF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 09:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F39170772
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B619AA56;
	Sun, 16 Mar 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kFF1x8+K"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3F11185;
	Sun, 16 Mar 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742115093; cv=none; b=mKXV51gmoTK8aVQ5Jy9WGZAhVOF73WLaZThdQ7SpgJD45qw5gggl9WRr8NlwBIxS88HkQs2KbVFGD8C+H3GLvfcIxSeGpP/qUC2tRZbJfL7C3ZzFFkLUnzX+39k30+D9HpKr14d6mQ7kaeVe4eXvyeekfHTXWj5mAgr3hZnc9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742115093; c=relaxed/simple;
	bh=vAff0aee3rul/N7q848YKkFuTPRfb8ln1tKjMsKXO74=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aMs6dEcr/y0AfPF2Bbav2SFf61yKT33YTneAo1EH5YomQAHamIw3BDNOIu7zMKKLUiu8ufaO8btn7nC+t3cULxi7wiYjlkvaLbaN49e03teHR5OWLw1ueiDHb547MmH8QUseZhLcTLIbE8ntlpICKbrQ2KCR/y6jWRVxsEKXNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kFF1x8+K; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742115052; x=1742719852; i=markus.elfring@web.de;
	bh=vAff0aee3rul/N7q848YKkFuTPRfb8ln1tKjMsKXO74=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kFF1x8+K7f1TIYXk0J+TiVaWSoeXR/8crYCPBZT7nQqSx+9n/KRHGSaflWlhV3SL
	 rF0raJ2ppRNwHcmqeoJXyh/GP1iyajQfaWxBN0nRBgpsySmexLFXUG2yU4iGVfwmc
	 hwo8kVkskaKkZ4GzOj72GjBlLK+lrT1fTg2ebchAPk0OpOQ4m/UJq3zX0B3apz7Lo
	 pza84namq0tJ5k/hKW0c+1w9YoMMqhN9r913vl38cJ84eoL7YnQiJTvCle73jfXM3
	 oI5sDjFOUZGWg/R+X5A5V3cwQomhe89YjU3rpgrB6rZD2yE893yyMXmItS0c7qH9r
	 y3/22mPeosHnm9NYyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.60]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrLN-1tXW870xxT-00MepM; Sun, 16
 Mar 2025 09:50:52 +0100
Message-ID: <aa403b90-5479-4beb-92f5-d8f33773b923@web.de>
Date: Sun, 16 Mar 2025 09:50:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Gleixner <tglx@linutronix.de>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew@lunn.ch>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Gregory Clement <gregory.clement@bootlin.com>, Guo Ren <guoren@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jiri Slaby <jirislaby@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Samuel Holland <samuel@sholland.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Talel Shenhar <talel@amazon.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
References: <20250313142404.896902416@linutronix.de>
Subject: Re: [patch 0/7] genirq/generic_chip: Convert locking to guards
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250313142404.896902416@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xy3Yson5TdObRf0N/SURy+6vxAvi28ZaIz75v4YI+eFy9jMgCnf
 Nzzrrbxs9TbdI8aNEkVBN0pm/+AjvKzYWB35d3jBTmQCen2t/NcOLq74GfuHRBR5kInFWYF
 /BY7ks2CCn5+dNXw9Lxc1g42YDcW3mTycO4d+sHuwHv0GjKRzUd/gz9q6ar+IY/nlbPY+ia
 TH3mSFg1etUtX5E8SV8VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:51w44oArk1o=;k+F4f3IFOUW1k/lwqjQc2MCr+q5
 A7JWSZqr9NWA3sEmtLYW67m4maYYgRRtB7g/jcYBfDm7ATQJ0eeR387AIrXQZ3yzW7c0oYfkL
 lJ2bEKewl0Cs3JCXcS6PvkORhnIt0dYXnBdyeZigCCy3GLDnqtHp/dQG1leoyTeq0nQrKogdc
 WZUlAwux3ZMVD9rNRPNDaO+MmczK0ZQZFOysIWd6Vzd/MlmOUtP7WY6I+qoV1U0DACjEjyhEE
 4kiC/3vVW80/iszCy2hnCXoGuh9v4aTPaa627iFeOMd0fz8KNoTlIOd5tOCrSvW0QMlTFoJ+p
 FpVfzq9gqDUKxhFQ3p5HHdGDaeQf5OODQcFC/84lxCVA1KlzNDhyb6N4mWvJQ3QJ43zYqQb3/
 8E+SsMWc/yWB6XrhXLqjvAGy6SdjD7zYXqZJ8I0D0Us6V+YIVsIo+srYTz18+m59zQW2jSsIa
 1iHC+MCEYo9+FyM+C1al50f4JqH+BOg/kuJQnilpoNZ+S8Wc0J1Gxb65YDAswG9u3S7Z+YEay
 MA20Roj3WrvPdHC/HcRGi221ctojkkC/Tix8geBr7mfHN7KA0RowqLyPtaSl5abuvNtzzTYjH
 +brQRKH/BwcRWoqaOpiFDCnkHJ9XB9n+CpSsJSjWvYVDWxAYfacmz42XHL9vvxZa8x6Trmvgv
 iwR+u/5g/AdrCQwXgCetoftuB/gAC3I2qY0BtDqwxebA6aliwipsu/qLn+GKLdmH0xBwLs4hE
 +QkNlZkbNlLcGBbxZCjx0UWx13lMpIrDUx/L6eiSWDuei1vUhP0gpLnS6ecML5n+5IBJLj12L
 yymOc3QXUwmnzQJvdReDmBhcc/ucOtl8NPzkDQZdn0yh3netXZ/2//9OwMH9+1YCMWK85ECUO
 MV8At6h0JQYzIKRwyY21aVa9lqCQuHUc+2ASib2DxOQg58/VTImbYAqahEK6HU0a7Ve44Alyy
 bM7iyP2oT2XwfxJCgKMOJ4IktJ3L5cdCzI/8n1eB9je5LvLDJFSWLI+Tf6Ic/hQhnr8NlB+7b
 Zu4FYw5vjdGCr73mj8h7eQKBCyvAMZn5aWWryYFVrGvGZXTjNLrCd6jpYJL15TqcVy8Xtmxe+
 ZPKKoRL97+bdWl2LRcEECsyGreOtln9dFvpcF4M/n4ZP8WgahtAszgWsM4PWdjkbQ8yRtO4dW
 CyhAIJPXmbXN2nsgltIqTlDJ7z8LmGD8uBKHws6/EXGw3xMlm5MP6Hteq22+AXcOoTKO8Ytao
 KTkaZRtTJQT+ysvHSKLi6xwueOIjLblW5nmkAkg76NulgrG+dS/MpB6vURfOSj//XRGHOtFK9
 T0XBTi5HwFwesqkrthpC253M+vKLSwL6Z2y95OIE8qTlbD+I2R4SOMBPTNMrkp5ebYjFAZcy8
 P1RPI3UAMfmvn5nzPN47C6Q9xdWGvPTTyoj8zYJ0zv+Fa+bNZYfLjnhuQ9/OTxlEGjE/ooQ50
 xtRwWaun4IFJ3FNJUZLFHpiiKYZTOVrJuxRlg9mkxQuwi8/Bp

> The following series converts the generic chip locking to lock guards,
> which reduces code size and improves readability.
>
> The conversion was largely done with Coccinelle.

Would you like to share any more from your evolving collection of scripts
for the semantic patch language?

Regards,
Markus

