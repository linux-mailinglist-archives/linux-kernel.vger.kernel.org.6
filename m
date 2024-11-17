Return-Path: <linux-kernel+bounces-412246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CB9D05DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678F8282322
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750021DBB11;
	Sun, 17 Nov 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=gerhard_pircher@gmx.net header.b="jzUqmkTk"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FD18054
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875771; cv=none; b=Oscx5KHvnjmDa0Z6GsskM/4/Xt1Ctl/nYz5rx2vUSc7BS26Rqydjhp3hU1d7/Uo2EF88kQyYiQoX2/GG3akPbUUN/qVVYqxHOgUARp5a7nAdKDpkKB3N8Uqpd2MVH9sf4he92ADz7vqUWZUQr2H5Oaq4g/fMKaS++Ysx32+WbmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875771; c=relaxed/simple;
	bh=wBbUFxuRpefUDoTWDdR4oG541pCxAjV12MOKKMSPMLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6CU6Wa9rL7A9VyTHAqsG1eVqof6xpdrorJ236Gzi8IM4bl7BqAzjFoJiV78GL0TWz5E1veFNDKO+tVWafwQfpMDOPSDM7B9gln1x4DbpE9nqPOc9YokAPKwFGLk0RUbk1OIdGkDhz0NrBHKvmKeXvFkzPk6oOk4eKi9TA4Xh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=gerhard_pircher@gmx.net header.b=jzUqmkTk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731875762; x=1732480562; i=gerhard_pircher@gmx.net;
	bh=wBbUFxuRpefUDoTWDdR4oG541pCxAjV12MOKKMSPMLg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jzUqmkTk+e4csRGVRQ5iB51OwQI2Bgq4UHPOT4LC6X3iAl6K4BRJEQ602E1+lmht
	 qsVr8imBNT2BXGf5xnkEwSVCrE4q9VVAkHxWwGTPDi+4NLCjN8OfUEduzjyYh9lvm
	 VxPzkQ9f9IrMZgor0RW3vBLmBsdiEPiJoYG4I1T9qOvEbDZUVb6CLP/DMET5KiVU+
	 8Yi4xVNMg4jWzTWuPA9pS9DIr2e53xe0lXWmlZSTcsXDo7axj7SrpJNZJgSA15Cws
	 Rrc/d/HYxdOqOcBR0bVE5afBkkmwv9pgBTKFWWmSLV+mjYB1Ht6eekFrBW/cuwFjM
	 iZHOQ32I75Vuy7RnhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.24.73] ([45.95.211.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1tuawb0FJD-012bDQ; Sun, 17
 Nov 2024 21:36:02 +0100
Message-ID: <7e8a2788-f0ab-4d98-b26c-114e04558fb3@gmx.net>
Date: Sun, 17 Nov 2024 21:36:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org, arnd@arndb.de
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Content-Language: de-AT, en-US
From: Gerhard Pircher <gerhard_pircher@gmx.net>
Autocrypt: addr=gerhard_pircher@gmx.net; keydata=
 xjMEZgsLXBYJKwYBBAHaRw8BAQdAFQBjng5ejD4ROI9G+eNIrECAOKsI0dEqMh4uW/vHjfrN
 KUdlcmhhcmQgUGlyY2hlciA8Z2VyaGFyZF9waXJjaGVyQGdteC5uZXQ+wpkEExYIAEECGwMF
 CRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQRvJ2HWg8s/bjPDPanyPTewbNK3vQUC
 ZgsLtAIZAQAKCRDyPTewbNK3vVErAQCnjZo9vq/Z+bcO5xA4NTIEjFNWGX5ezKIdycZwh083
 dQD9HyN3IE0xKU78rBok4lgimReA0zIoXIB2cWoi9cCjWgfOOARmCwtcEgorBgEEAZdVAQUB
 AQdAw8jGfsYGYHfXSiHhEk8zkKAFbkAodKiSLAqp/YxKMkcDAQgHwn4EGBYIACYWIQRvJ2HW
 g8s/bjPDPanyPTewbNK3vQUCZgsLXAIbDAUJEswDAAAKCRDyPTewbNK3ver4AQCkOqp9UwZO
 HAk+IuqBcdIf9qxFT5U00N9QCFMSiJtFEwEAyEpRNkXaPu2VroSiuZFBtQPd9uwS7QzdyR+w
 NTurFwY=
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IIKJU9JoBpa6kQg3YVBs1CsTZpTHWzfg+ZLwzYhCZvdRNURyHKx
 hS7h4Bxu2npIFKzWRQ4+p/9lWWHeVBCwZSKm4BEOw8/KQDa0PCN3j4+gp0NyjlZ4UQ87oP6
 ompBnAyJgm2Vb8HZOPsTTKgD+phDsBZMqKDgnhCvBUr7YD2e5UrZweEh9ttURvR/ktSppGs
 JImmgr25Iw/vvDIqA7zTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GZrdb5MdC7Y=;MgX5JXk1AHLGyU6DCS8jDyEBOP3
 WxrUB3KYKVy3twShH3QtaunZkFyWaZQrp+yAA6BZy+ip70QfVJN3Br549MtQhcb4sxpPLfJLz
 4vLpwv0DsoJg/+I1I7lnNelCzI/cqeSfp7fABKtSo+eukIyeN1ndfDO1b2lEAAiCmz8rCv7ls
 mbfj7cbSIyvQwrvVdo/PsN58cU7QUxzvPWoRsGjHAirZyJavQQt+p0/Ef2ND3fYcfIvbjz7rX
 0s/xMQvmxMN4L1ep540Vwx1WEFpKsmq5cPBjKKZrMJqQupBmMUj0D6zYfBPCQYT5BcQGaDowq
 +mBej2CVumVApyddeq1+jGOT2UQGgvtLIhuaB8ldb7bnWeG9ff2oHCMzLmYqx0NZg4BFoJ8Kn
 0gWHILc4C0NmPJFyrgjJq3OjJIVrtZtwFcBs5nN0S/L8LNHLbhyevUik7QvynM7jHGpqBuztw
 xjQrSSM8FqYupGYGjimew+WlF00WLXg58PvL/e/f3uPbPZ2toofnvQax1Sfm6eY6FmTJpw13B
 jDGUyiMnh1vsgLdhK0jQ8hs+Xe3um8cA9FGjbouCAvRvKCKMFUcHlWLRgyok3qwDnXgG3Pvlk
 aHyqfS1wn3oupml0YjsEl8khwufW8XwmN8wu9/YWHyTDclLSQyeqJJ8ROf6q2l3QQgadYji9A
 sazzBqnnrHQKYl9e+H0tgfXyF39xGuwxDlHzrAlJmgW4UctEIus8wAb4lQ8SS7kSwxDbKAxAz
 UeMSQPl/Es2Hng/DadmyyiXKrwUM0HsdZ0nA6yyyZPbVhjsGFMr2j8GJRBGeEGJCn6LYknimu
 ld3sJ5rGhBqW5SeMdYga/asvqXIO4hG4mi7SqsFJ5LYXWjOZONeWngD1kfk5A2DejwKEXbbjX
 aO05UG6ISzK4A+jEcCJ6DnXKEcflHg+xVgteh3s/wFoOd/DK5F58LmVyd

Am 14.11.24 um 14:11 schrieb Michael Ellerman:
> CHRP (Common Hardware Reference Platform) was a standard developed by
> IBM & Apple for PowerPC-based systems.
>
> The standard was used in the development of some machines but never
> gained wide spread adoption.
>
> The Linux CHRP code only supports a handful of machines, all 32-bit, eg.
> IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possibly
> some from Motorola? No Apple machines should be affected.
>
> All of those mentioned above are over or nearing 20 years old, and seem
> to have no active users.
Pegasos2 users still exist, but admittedly they mainly use MorphOS and
AmigaOS4 on these machines.

br,
Gerhard

