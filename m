Return-Path: <linux-kernel+bounces-213685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB39078BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF72282CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C601487DF;
	Thu, 13 Jun 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Avz9gaPj"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98E12EBE6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297495; cv=none; b=L1KFNkfei/uqvKYnOGvBXYenN1ZzpQxutfgjw6YvcQfqeSmYQEQExKelIH/o1kwaWPCN4ASoeLhuaVT6ei9mx7X0Cl/aYH/kSMiW0esAjYnl1g/z+xos9iizLaHePV3WdYgB8m39kM5VA/BoZuo+5x8tUQW6Sz4S/kApH6KMHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297495; c=relaxed/simple;
	bh=3Uv9P687Co6Bcq3L3Ugq2lwsGwOHTvKyqnIbkSW0VR8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XK6F1Q39DCjEGh871ADFh9x0EpvnXgkOzr//2Eta30+mdQ8uwW7mjwIxcTGfzqJu5qu17e1BA/M63cL/sDc+vWZl7w7qI7uYaENHCx+D9aflBrZnO5wbCO4j4Pk/Ef9NtV3YzRnIwSLvo8xdKNHeKMBmJsH/QghbZ26k7+Ff82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Avz9gaPj; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718297466; x=1718902266; i=markus.elfring@web.de;
	bh=YFkSc9CKpSbzYGObHg7hLaAew0BY2AKB2tveQbaNtko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Avz9gaPjA/Y2T47/8yA0Siun4DlzrI6JqJegC30JnDj6y1v8gGHgOhc1eLceNiA0
	 1euNryqXV9Hym03STUBFXVQNkH+yPMa+Mjs1tlRMcWNy6tpiOIU+xkstcDCm66koj
	 IYcF0Htvhjg6ThpmPzPMeDSMDKnMEGGjdMJL896jeQXhiO87DEn8cW7OpFxTuS4PZ
	 n4E7EanKgMtpi6Lt3u1lmE3GQSTu1I0E9uKYwxPzUFvIw/Y3wcdVjBAH4cH+5oCxr
	 ve7ezPwMIASVd6EU2QlP9Av1cu6wLrrZ5mho/qDSr1aLdSYieyCUnV5kZo2WqfeOm
	 Fn2ezAIJLOKjrNlKUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcll-1rv1Za45Mh-00OyyV; Thu, 13
 Jun 2024 18:51:06 +0200
Message-ID: <7daafcb7-2c80-4c2a-bf25-7202634f79f0@web.de>
Date: Thu, 13 Jun 2024 18:50:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Carlos Llamas <cmllamas@google.com>, kernel-team@android.com,
 Alice Ryhl <aliceryhl@google.com>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, Christian Brauner <brauner@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joel Fernandes <joel@joelfernandes.org>, Martijn Coenen <maco@android.com>,
 Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 John Stultz <jstultz@google.com>, Nick Chen <chenjia3@oppo.com>,
 Steven Moreland <smoreland@google.com>, Tim Murray <timmurray@google.com>
References: <20240612042535.1556708-1-cmllamas@google.com>
Subject: Re: [PATCH v5] binder: use bitmap for faster descriptor lookup
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240612042535.1556708-1-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rZTOq3c5bVF59YHL+9ew+vmZxgNyinmAaSyUpX/VJDnVFelxcNf
 mUfbLSWYvWwiDB5qnnCyZbUvWxFG70ahzq+KWDkPGBBc48KuFxwgx3d3Qj2STg+B0aVPwon
 wfwEugmlXJWLZW430aktHk+fboJ+C1wAdnnQrKT/DLwrWO1ghcKOQiG6NokPtlM0kX5APp3
 KL47bhaysyH2RxI1jHFJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ps1ZIzQZw6s=;eoLeI042XTr8v7Hvc0IRxGMCnVo
 xtnfjtg9K0X0F/viALADXrvHgybzVI4vsM+YSzyg6eig4G6Ma9Pv9PYxEBPnbpKIb4QBx9fJY
 /2N9eul0qyyHaIrjGNTko8+DBQCsBrS4njO23YoeNcG5QGXAPjvogNtzxEx1OAXdcPa9ehacf
 Fs2lkXEXv9DLquw4O5ffOnRZNXHAnOTpCpGEf5Lnrv0mTbYzvKF0Y02I2HX2gkykV1ndJHFDq
 FEtaytScecxrJ2eYiphZIYrBpu00AIWix8mb+hfNfMzQHidPgZ5FPnA45KePa0UtQYxmVhj92
 SqUJeBWYWqA4WHhkWkm3sXnsfWQUQUvsHCJE/g4kjAjWDXaMHqoBEviFZfmqfTHyuAmBdji7g
 zYgDswXZ5dfJQS5rw7U/QoSzvfYkM1u5jxj0qzgASHvUy5tl4lEeBK7yCH/QBEg08UKEps0Rz
 lWhmQRVP+tIsk339HwBOv2BMR2en/KaY35FS42H/4axv7fK3RXBeL2PqzGfQcNICPZ2IDwhrV
 Nwnqj8LIdvm1Fuy3XDq6HyW8XRzGyYJTV654HzkKFqlh1UKWkAXAsUk55fGN27IexAvLlx7Em
 YYdihkD2kcNNLbrsdHPcVRlQG67X9DMSw+/NirMtpVYPY+CPiBnSMNRsebg44SXdKljXphx91
 KDk3QnP9BJzrLqLx45Dr+nKPpxkDRJUIH2k+RRbDRVdYe7hmgSezFgWNCwbM4atvCix0Q3ueI
 SjgLd41vcxJ0rPtSrUKqCvNqbL21aST2ocDPSOZIwOmrbnWA3eowxMP14uD7owsAleKgDCLAt
 CDaGl/uthLLybqOVnHOmMc0Ia0fD4P++5xDLq4MJujPJ0=

=E2=80=A6
> +++ b/drivers/android/binder.c
=E2=80=A6
> +static void try_shrink_dmap(struct binder_proc *proc)
> +{
=E2=80=A6
> +	binder_proc_lock(proc);
> +	nbits =3D dbitmap_shrink_nbits(&proc->dmap);
> +	binder_proc_unlock(proc);
=E2=80=A6
> +	new =3D bitmap_zalloc(nbits, GFP_KERNEL);
> +	binder_proc_lock(proc);
> +	dbitmap_shrink(&proc->dmap, new, nbits);
> +	binder_proc_unlock(proc);
> +}
=E2=80=A6

Would you become interested to apply lock guards?
https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/cleanup.h#=
L124

Regards,
Markus

