Return-Path: <linux-kernel+bounces-180665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08E78C7189
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33A91C21E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECEA21101;
	Thu, 16 May 2024 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eyN+MCwh"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C32137E;
	Thu, 16 May 2024 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715839324; cv=none; b=aZHkrrW9yXUWRQApHLM4vphwReCYlbWsfzLvfoYoUfNS4Bnad1XTF3AtliwMRMIL9TZdKlhOkGK3CHeku0hh574xUBgRfvCFFs7rQFZybLDFpuiVPRDUc6IoR+FrZeJyp1NTD4EOoQ4LtocUeH6NY3F2kBBhYEdWa7BNQwXyjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715839324; c=relaxed/simple;
	bh=8Yz8hdYO1zO5H+gdWNA7xLnI/GiTkNJbeKAXjlzwnzk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=urrdpKErgGaeIbzJbSWrP5GREKP6bu67NyCceyttMUtm8LDLUrnj5PLZwC5lVz5j+CBFY2Y8crmSK/O0aQvsJfnZcnlAM/goOSKC/3W96fMKoIwVrSipTjKsC6uSxVkZkyKqo6+c53R7zbY2DNUyt4HGVyzJtUfSzPRKKHORHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eyN+MCwh; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715839283; x=1716444083; i=markus.elfring@web.de;
	bh=Cyh+eg/yRQoUJohGczjwN4WgfqvUfMeQ6xYM9LQpmSM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eyN+MCwhadgWF7AkhcROllHdp96/idsb7fQuCeahUz4X1pcYx8Lrvrndo4lCH8WK
	 OHBGvrUzuGH6/uviHkA1Mr04siqg8WoJt2j2ZsaoNRqU2xioFOcPOHV6kjDbkEADr
	 sWaJavXhxwl8xzgjncmvIp4ATu7Hp5MNau7QNCopjcNOr6JLbzh16nBBamx8/BSCK
	 bfJCp1VR0FXIMGTWgeV7zNzIup+ta0NDhCYfWI6jDxS0InYm//VFOkZeMC2yrDzAP
	 qvcWeKhkqh8dQYUAJLUeAjLiXArfnReNpgzmdaBKjfY1SUfcS4d+0VcGsPK0Frmh7
	 Knp5DXs8IeZe257v7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3tF-1sJqdQ35Xz-000szD; Thu, 16
 May 2024 08:01:23 +0200
Message-ID: <68b2d167-6241-44af-b50a-feb4257e5a78@web.de>
Date: Thu, 16 May 2024 08:01:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sui Jingfeng <suijingfeng@loongson.cn>
References: <20240513001243.1739336-3-sui.jingfeng@linux.dev>
Subject: Re: [PATCH 2/3] drm/loongson: Introduce component framework support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240513001243.1739336-3-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TaIRuGzWCIt3tYqyHddJHcD7QI6a0iTTV8jXc9ueJegtw2j5MEg
 nYPLHiwDo6jdy3YGU8XkshijPrVdV1WsKEHB8GDRC6x03m5ur9t2DlC2JvuzOi9Q5G3LiaN
 zDmIarFJ/Y5QJ7b/edk3MEbfiKJT/+raoY8RuKmH2NzqvakVvamhPZdW705v4tOBqdS2WVd
 J/jCz453Xh2mFc4bEEeag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FVEYT3FbxY4=;tNVf7Y6TSTVEAMpSIU5NAdbOy6u
 PaQpOQ7d1Ixbm1+WQK3wUNYpulXmpRDZpsaD8ZKbKWALzgNAp6RCngttJrH/czd48VXpLiHx6
 XRMjCE4m6T658yi4i4ZXoZed/PtOFxjCqRWyZU/yVmX3bqS6JVpPTLvzvYqS/mf5FmVLUOYuE
 nVMdiqYw8pGhaPJOLp3DpUisfdqTGqLG4q+MH/WvQ/xXNlFJZolfDrLComS8aaPxFFndwbaus
 8CVJHyRWrwHZOIudo7dGmroM2D1ix/YafcyXGyhhtJz6JANqmJcq1FXhjrTMmWBRcw9d4ou3o
 OKkHXJul4zs8OIZzHjlsO0LKuhVwOISGaVZ6/8QQGime9lw9bXphgPZhjeC92vppL7f0qzEJ+
 G6LT9E3qeT/xLaY+0377Abq3l8IE6Ngl2toI7J4+x33kYqa5SpEl5rwiQRWH1gSsSUTAKkOjy
 lc/FzJiq5dJhiDKuFNr1v1THHQkE1bvc213rFnj+CjQP+/lnLFNxSelm5/2CLatf+TPuUInwX
 fu7udLsTvDbdzZ56EnLdQlVARdpt/5nmSfG+8wTl3kqdlrtrn6A8t6aklLnBKIPAlWupmbCzG
 GVLab7fs1NuwUz/0nxzvagACquiQGPScrl07NG8jzL6/mwGCGSh6reEZUMDcg25PFXiodvOOR
 w6jRZANacKFdAKacMWZyGp3n2B0JrIrGkmsXIQHevR0sjCjGO3KzVyYpzCFkQEvLn6nou2qKY
 uq0O82yz55o2m4bjww+9G/o6ZGwwQRT0GunUE9iN5ETZNg7kMxpkBw72CcFPJTOpANxWmtbBc
 al/RSSajyeUyjyB6sM3EPCcGUHFaIl68qd5hE7mAs+VZ4=

=E2=80=A6
> The idea is to devide the exterinal module dependent part =E2=80=A6

                 divide | separate the external?

Please avoid typos in such a change description.

Regards,
Markus

