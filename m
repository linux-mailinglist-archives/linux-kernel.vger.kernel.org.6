Return-Path: <linux-kernel+bounces-530922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D62A43A33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36083B7A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026962661BF;
	Tue, 25 Feb 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TMBU329S"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB8205AD5;
	Tue, 25 Feb 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476654; cv=none; b=piUUSOQF/gtxOjp1tgiRrS0jzokSiPz6YzW03OBAqQZNKdPSajkrXnO31pa3vbMATvvJk3y6hLosZhW6YJ8o401ho7pbW5VrcHzm4VGZwx9kqhxWFoD4vwL+XBx7R/OSJrxTbZkI59hLJV4qrlk3aeJXOEaIgZVuhAEXqxr10vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476654; c=relaxed/simple;
	bh=lOltmn06J90I/0axpOwXLXvdQ0/mV2bzHdtnEi1ZVck=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KYVOjKu/m2cp8NSrbbcNiKwriRmN5M/pZXCrPC+bdtEmw0p30HVOVA4+wg2ZgwH2Pwm0L2Nq3jJz4d/ugeV3Jz6heocHPZk+AWtvFz7dxiqZA16oQ+Rggx37UaOjgDPQg7RZJgwO+F1T0Gnq3VlAnrc/YQQF35hziaID2RTFBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TMBU329S; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740476630; x=1741081430; i=markus.elfring@web.de;
	bh=BdBsoikDArtMACxKD42l+nB5saRhKzzF2Hz35s6CP7I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TMBU329StovrEMUWG50Upg8JF2Itah+rkWKweEeqL6p2JIodyQuQrhXUIkJ6nTQz
	 peO+8OQRqZPRGzX0n5aISpIgTAt9RPMJ9hBvAMA+Z1bmVi8hIyJTpQB+Y5kAdZrFD
	 W1e3nJ0Nw72X7nUIQFwnfledooO99hw54knKNM3oFEeIipn8fgQIBSmnCcQrSSIQZ
	 9h/GzDHYTRoRtYtmIU7Qko5EMb+Smp1GDvodcXTcZdkCA6NeHbjlke+TK/D2Rrrj8
	 qy9eBBwliWGk4lDT/ASi20IwQvyPZb6cMkJCbJ4BQqrO/A8oBTEPy4C175RF5nHcP
	 rY3k0L9k9fWM28u3Qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.36]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtsZ-1tbdDI3bRZ-000Hvk; Tue, 25
 Feb 2025 10:43:49 +0100
Message-ID: <29a06fff-1fa2-49bd-aa72-e1eff1634b84@web.de>
Date: Tue, 25 Feb 2025 10:43:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stanley Chu <yschu@nuvoton.com>, linux-i3c@lists.infradead.org,
 devicetree@vger.kernel.org, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Rob Herring <robh@kernel.org>
Cc: Stanley Chu <stanley.chuys@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Joseph Liu <KWLIU@nuvoton.com>,
 Tomer Maimon <tomer.maimon@nuvoton.com>
References: <20250224083908.1880383-6-yschu@nuvoton.com>
Subject: Re: [PATCH v4 5/5] i3c: master: svc: Fix npcm845 DAA process
 corruption
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250224083908.1880383-6-yschu@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8K+PHopHu9xkXX4CIxgvLNYgOtnWctxbev8mDHHsVe/2m2wIAuf
 tsD3AH0DKjTv7WxU14zgyXvcEt1U4Br1mE7dMWQcFhHbe6L6j4P9FGNDTg5oiqg0RheHj6p
 ymw79Kx1pB0nnXywb51I+rYRMM5vQX69adKr5VPO8k4aqRhm4tjNxQXlykUc6NcQhDjXpYG
 LMrn5nQoAEjDU2SNa+lSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bdZrR1bd6TI=;fnuK2XjYVMC+xafW5uRXPx8boiN
 BvfHdCbWJ+1K7ad2spgBy16diKewrEly9+LTzuejA6tGut5kP5u3OF1PbJWdzk9iGSKey6CAc
 GUdre2Wm1aPwtYlsLIwBavgXI15b0cIS9tN0utbLdJ/1Fo4gkWDo8SMNAlyjtNY4NCPLeKgZg
 rSOGHj20hteykfF7SkXGzXF673MLYaAcUHoEro9QoAzZzGUgFo/jWth2clYExVE8bG8UBhqpu
 XwTsCwG5wR9WrTZuxpzCljNoMqW0r5A2XZE2ibCdjd/JKAv0EnZFcsHnM8EaDuZ33e2LzsMuW
 KvJQwXGdJoS/opSo/AsPLfnMQ1MPSAmGnBMToKE8vc2xajgOb9K5k2QSk4dgABD96renVpjau
 gyCmScL0mfUirhZXyXupzIAiUQoUmSsl9h1Y+PS3h+CuUzVXUWl6Ay2BAqf1w3TBkjgGdCSj6
 WjyyMBauXPXn5aZcuRuIXc98d7+Cj7Q8pOk/uOkOgRaxgCdNzWBcx2XIFwZSlsr+8DXPi4M2v
 jovYonmxV78G0Iki9zny+M2Eep3UI1Ed0D5GDJj8jsQrkzL/bttHFvSAIY+w9tTunDCpTu6C4
 98meicmiqdXYb0EO2D3FzZRDXBdQpkzik3XhJTbDlD7MuJUfrTFksyJ6b9e4XqR/g6EeIXa9k
 L8XkfinlaTdvUq59AkPQEuDzwlcUT++Wjt6EQGUhv69uqCguyHjWFfRQU5CXGRKkiaFV5gYbT
 5f8va6uWjinaqtNfsn8GhBJ7TscqlMQaHOmhf3usvMzPI3JVJBp3OfPHjJd6iq9K7Ov8x2iIm
 mUW36raehf3SGpET2/Ju7xYqgPLLWghPfN5oQCDlnHUnZ5J+RPhMQ+OJ4iH2eOIrZzpA+9ymm
 MDS2A1pf76c62JQmSTYH4DOd1XS8a+6YNxDe29qf1olJKF6Usp4KWufw1q3RYsmjFudKeP8NR
 87SrrSIO+rQeLonx35CHENqzpLltwNFYM8OkddQd29JQ5BXWfk7MBL4SS+2XLVOqDBZTqIdOT
 5emUfzYEeeQtisCCI2a0iSJH6tGyzZX/XR8OTa4ObajHuBieDhIol3xNSz3PJy0exoipyQGk0
 HonwbW2lUtbgg4wLHg5fUqwoEj6jXGLN37RNKt0gwCApj+XuGPDrvSp7Q0snJ7AD5+14Y7Zcj
 aXK8nb9+g5Hokb57WGMTlIUgH/nXEdniqUFIMMapcNPSXHZPwm0A5TXgJ+qbIdTZMmMEZrBJq
 ay1iZ05VnstqwR2FC1ZUobssEEdHdXCUOjJW4iV2JSahdL+4jyE3ZfyWD5w8oN6VOCM0SR2Em
 VRWaPjNVxEyWu77QrsOjZWlwsChDyMM75QzHgg6q85xR7DqKhY0MTSJlN1pp9qr0692tvk1jZ
 V2LMCc4GzQVBvxDYPvzbloBLdhhqUf9t3Bk04+urjPLMt44cUpvKZmaHOWl4sTbSsvPSrqja9
 cycxEtgkmSEQdpS9vRZgbocW3sS4=

=E2=80=A6
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1162,7 +1162,16 @@ static int svc_i3c_master_do_daa(struct i3c_maste=
r_controller *m)
>  	}
>
>  	spin_lock_irqsave(&master->xferqueue.lock, flags);
=E2=80=A6
>  	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
>
>  	svc_i3c_master_clear_merrwarn(master);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock_irqsave)(&master->xferqueue.lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/spinlock.h=
#L572

Regards,
Markus

