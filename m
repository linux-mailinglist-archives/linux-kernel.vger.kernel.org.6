Return-Path: <linux-kernel+bounces-425622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B99DE7DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0D2B23F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068B519F487;
	Fri, 29 Nov 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VilcuBxj"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4019F419
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887648; cv=none; b=Y8IKBwlNjWQnl0qCUJBoEdwJBuvuqDxqPniAPA4623U/kV5pHsanc8hwiNQxvBBqqe9j+xAH2iQPTQj7lmAlay99xhZFRITBVCMhLNievkaOZkbKWuERGnkPs4NkNexZRW30w4SOofEZi3z1HvNBl9zSOr62FWAW5ACdSxoQZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887648; c=relaxed/simple;
	bh=ubuGP/4Pf2xhQwHiSesHilRhCNMS6HxKjdB3pjoi4EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=I7DtgEZ2Vv8bhGuUv3KoiFhb2au0eDaduZ09qErqCrkQHzy6SMeUJHipU/t7w1PXYlTK3BHewD9OIFilcTj9Gs7nuoigNX9nWY96cOaoqsma+5ZBqnzcMEQkxHxfZYppg+Al2qygruaG5L/MSA45qb3Jp7XKWvSQwWxJf7/cIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VilcuBxj; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732887619; x=1733492419; i=markus.elfring@web.de;
	bh=4aLJg9VUB9HRRVJ0YdwC4TyhT84p0PsQe/a585jAmAk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VilcuBxjyKCJ7DLw02D+LKg3lI3vQsR7w17unbjMW/4hKrRj6tkWlUGX92+9DvQZ
	 0c+EQPcKZV0e74oTUtly47T1khYXMw6/eZkI3fPtiRm7SgP5VTnAtpG98lNkFRn3g
	 f/O40EGDiu9uxkilokXfwVqsx0aM55FVrjFsW+4kqXHQMaMeJl7hV+NfnGJ70dqA0
	 t7NlOZ9UMGzDKMerkHcmH5yClD64MiU36FG+jsUXK+6ORTr8eZq3LhD1vrKTVgF9P
	 A8KqledJc8fPXB8OjDm2tj9Kv929SPa/wpC81E95PLkPP2BWsnnB4rKhXyq6vlPKX
	 7tRLXxDvLXFthO/coA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1tmU5u30rt-012ROY; Fri, 29
 Nov 2024 14:40:19 +0100
Message-ID: <39f00e80-120f-4c00-a966-53e745349e3f@web.de>
Date: Fri, 29 Nov 2024 14:40:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder capable()
 calls
To: Victor Gambier <victor.gambier@inria.fr>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, cocci@inria.fr
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
 <b30c7227-c596-4980-aa46-a75b1d429354@web.de>
 <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Content-Language: en-GB
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ihsjtGwThE3NOxosREOFxtonYZcVaZzp+KzdSy5Pukrvn2GxZi8
 nZUppE/qNkThq2JlAWUe8w1J2F6MZzU1EX47Ib2ua2NsDD/Gs2t8sY+p1TgKcTjdRDERvDY
 +QtVDkpnJyRR64cAnenpsqD5QKOGBwwF0LCF7kXX4OQpV9x6nYl4fIycyMdSfCwcHslgWla
 HMPIpzui3IQihcCnskl6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tIihcw65Yjo=;JSw3pFncyWEQ290xs99IRCzj06g
 /Fizon/FQiGGPLEifFjYb+LEjyZrvJowAo2LSf99jQrxQ0ujy84ye1OS/r83aR6TSgvx3ynbm
 FFMiXfb6QBVaK8RqVnNk8Galp9+awREnvuCXePMROhZFZFaDdZ8+7Jca52cuf5dbyhH2PpZjz
 LC54fWqk0VOcHEdAl4IJZGO0diTPtsud4ef8w42AkX0YZ90ogC5fVdhzKSMPTF/gR4ZKWTYZc
 +TMCYOyJZKJry+9joBpokJEY2B+X04NXZy/nGOhWFzohBx45iQPO93WUzG7o7ZVeEDQMrrXE6
 OEQRaQgOxm4pIhR2QMxseljRTQVsRNhITSw43OU7ERFJ3Pj6GF4phsJd8M3uWOlTaX30UP9DG
 AarRISMnHyprq5J5695NRczeZpNeWsFiXXAxyZw4mDWWkRDRNlsT+6bmrBvhFB1HF49X8/WPq
 1xowZhpeBqXzIVIlNo7aOwVLOhqgFcp19dqI7XDi4ot0gxyoD1P1TQcJ/EK4YXYngUYcTY6DU
 JAhDO1tWgycd1G31plkBUpBTCKLuCj3lGHdGLB/bTAKVXcBOD3oYCyc40Q7zZOQN7jG+3KZxw
 Nya1CRuQItM9GyfNKGvWrTGll1YTzUNQp89cORWHC9mOdfXj/NewheMyqQ7UpXg/oUhjkLsiz
 +jibDUAhNxDerndDabBl4lmY7fy1Mf0mrkfFBxdbU4abDr1zS6yIag1IdqQDpk93qcwjtVKFy
 PSUzehUO8apimIxg1b8JESO6fbrf6Ii9WvE5JIt+OhxdqshFQFhgdcWvzJffhPE7wUUsrRZ6d
 ZHN36DpWUhTJKGAptHAEiLNUf3hdTuzgbj9qrqJNRS0AyTbxnY8uOkbtrOH065+YZRe/8PN9V
 zjkIao12eC41m6T6fXef50+SMpDp+DqxAx53xWA75jdl+x2G8u32Cd+U/YnZeB9z4jhxFVQt+
 lC2BaOFy7kutBp/TcziH3TFqP0/Sbm/uG7oNHLCyXNxNqDErzWY21ShJSf5yFftFL2HIodFUY
 rqUrxAHSti+F786vQ8edXbKqE5szdzklgamgIGkagebHoddOSkn9vQ0G2Quhvwx0jDGfdcIi4
 1AVY4g4Xw=

> Feel free to ignore Markus's comments,

I wonder about such a response.


> he is not a maintainer

How does such information matter here?


>                        and as usual,
> his questions don't make a ton of sense.
How did you come to such a conclusion?

Can software development clarifications become more constructive again?

Regards,
Markus

