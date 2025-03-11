Return-Path: <linux-kernel+bounces-556948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8EA5D149
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F51D7A6E94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AA264F81;
	Tue, 11 Mar 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hamOIRcr"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042D26462C;
	Tue, 11 Mar 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726782; cv=none; b=dUTzu3gufqZghOBBa3ZwfrFo1KJQq/f88iEuQSvawozFx3N/JJNbDn+df8tokOX2Ks9LZ9tagQLjSKmoC2sPw8oZ0yb1E66uADWaB9Eko8uiHws9A0eg29wIHQYLcgUFrWOnxtE4VndeQP+UYHWvfdfFa5Xvi5qJ8aTXkySeA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726782; c=relaxed/simple;
	bh=ZTLoy04AcxE0+RsFhYHFuRWDBsjVehCNjOKy+T6WHiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8UhpGTv6biWptqqq/6xvBqCZrAgxIjlmEq4aqkT3hnrWUxm/+XnflZbPIzBeQGwatiFuRZA5FaX2TfiTk63n48oCBCLcHoAQlmS91YnNdrgBge7vhZr+NiUEbZNtlb/YcmS68XmsdpTo5QpuFbvLfIju4tfvQEO16FcVipdN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hamOIRcr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741726771; x=1742331571; i=w_armin@gmx.de;
	bh=aS72S4iQimxR1qs1rymCfzNqiC6Wx8HofYRqfoLxjcw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hamOIRcrIrpNXaCDBsn2Lw3wV5Vhh9hyP+AeleaujF/2kuliVrrrSniqY6SLWj7p
	 zgJ84nhQOe9Ggnpihudj0EYdmzAeG2UnoXH9Rojqan7YzeA4y7+wB6qh7QnNpPKSy
	 PqVn7iaZaX7sc2G1kIG3aC9B006Qy7Pya4ntINw/DoAEpNG4KD/bnM02zjFeCHHeY
	 BwDvA33l22sfohsyzHLYxZx+HQEcRrrqWt50Uc9MJbUL3JSkqQqTUOLKDH46mOt5h
	 f9nEjrRtCHmRRDNIjAZRBz0r317A99ZTmmSQlXvHMnz6aHzADkWBi3z7MA2fzSjvQ
	 vbO+sOxbVPyoTrqpvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1tjtVB1quA-00X7qW; Tue, 11
 Mar 2025 21:59:31 +0100
Message-ID: <f5d3ef28-7321-4bb1-955a-8f9b53b13c2a@gmx.de>
Date: Tue, 11 Mar 2025 21:59:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: In-kernel parser for the BMOF format used by WMI-ACPI
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "linux@weissschuh.net" <linux@weissschuh.net>,
 Kurt Borja <kuurtb@gmail.com>, akpm@linux-foundation.org, mcgrof@kernel.org,
 russ.weight@linux.dev, dakr@kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <a18f2f93-c8ee-47af-9446-97e3714fc275@gmx.de>
 <20250311201357.tyldll7j2eogmryw@pali>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250311201357.tyldll7j2eogmryw@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0pYFNu1p7yxC3XdWznunZDkjog3VrEkGNcPel/jOl9RP+W1NbYB
 U2CdiqUThGFnPy1Zk4pPyYrkiwHRp1WmeGPakhlWX3V1D+OTCiQwA+z+WhCACGNkVTEhGUi
 EYUUERFH2c94hsFY2fCT+HjUqh4LkQ8cPHI7DEqFMv2OoUpGgTKowNmHbbAfoesJB+oSEYa
 nFQBnzipO9rwe/HEpahmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i+9CkMzfrT8=;3nlfRByhenhspUBgbL57BVxNuwJ
 pGdVBlA6rloXqb8OhsWPNaC3uZmF5vBSi8ZqvcEBgwjGA6LKIw1w6U9hHMP7C4uW4NFp5u6iH
 uioLg4iv3YXfKNTvmDsOQl9w+Qws72xL8G0pZwjTJZtNY/Gvcndd/GVXM+0vhGFZ4LJaReN5P
 NhfCxIlFYEunr7Vmb/7cclYfOfJOo19jhjGbtAcjeC2lEmVeZ2m2Lo6ZJmq93bNss63DhmGxz
 NsOvyKYfTbz3JJw6u6eWhlZ3MqbhXjWInPW27JIMv4/pwy37ejJW4Ogb2qLj/72gbTSOxlulN
 e1L5uDbCERDIrBP3biBjiVtdWh0g6MI/jlBEiTpy5mZYEz2Y1Effw/yDuqvnwEBZ/AK7aDjVc
 BSmNcU8rsI2gwYacqusEB7JN9iRjsgGawX07vMyMoS8yTTkhY6fJUZMdGM6WimVAClQEyQzON
 g5BuUFA/DLn4SFGe9BAxQ36rF99Avk4CZea+T+/TBFh3F9xNdD8oKoN56z/pohdznAlLe+dAp
 1KQhbJLjxHayIRS02VAq9vCHn03lvS+aAorpi3u6GBHTd2PRdQE12W4hLjV9jQ2ANNGuWyTE7
 miihOsCDxqWpjs61lbAIqwhu1UoxRWljNTIFLjyHt3UTn1fqBcZ8rBqH2XTzV+F22PgKD5cIH
 2PkwUKtswroJ4mJvGRkR8X62dnUn/EpJfH8LgpyrpR04oAM58AWtqP5KPFpMKXms9F5/w6Avo
 yJ+UMYalUc/3+eXiS0bl5lU+9OobscgDGrlJyjY5HGjjhu2JUmp0tROPXwzkdvsajmZyryFaP
 afvq9xjYPdiLRsdPbGLy0YlIWXUGq5A7SjZWok3Pkim1FtAbtMIP2rnf6BRDuyYZYzZwsYml0
 scbHcqpO1srMHSXd37UJIRuM/8OHPWwp5xZxRlLm/iLH4KwMhTZZRnORhpXd2IHapWxF+KBzn
 IU+Uca02tzVCf3lffyIZvmiXDfzKZNiaqLDWk42kDQAi5rLPiNyI5WJZijxY0TouCBTUZ4vzE
 NfJg8byJ+sEuFgAJrL0x0FVZNnCpBwPk8yw9zxbnWJAf9MG6aEC5PKFdFxWDqv3rqyAMqmuPt
 tWTldcSFa931hpwUBQrBP15syPUgOqQm/7N7AMMkdArNtkpb1unEBZD75GyUtXNlN4ABe4vCZ
 fCXslYMigeAJkvaOcxisPUZmx1v59eeS9N//Ptyn9xHOg0W8wtKYrUnXvgcbBE3MvaZagk+nR
 XG3DIpw6IBVpENROTsi+b1smVI7GOlgQljSBwDEW5U0B1sR6S1BIrpDqkhnkf2KijPA9Lsum2
 vBqEdLOqAQhFU/mw2ZtmCQxgw9hI1gXI4pEAT1Hqhw+LwGx/V5FaskED2vXeDwl9vG64nP0BG
 bES08KO/CBn59tY33Rvk2GxUs0ZNVP/GMUPdIHZmKkLjnoCoc398nHGzUX

Am 11.03.25 um 21:13 schrieb Pali Roh=C3=A1r:

> On Tuesday 11 March 2025 21:06:16 Armin Wolf wrote:
>>   - Is there any way to check whether the Doublespace compression algor=
ithm is still encumbered by patents?
> Linux kernel 2.2 or 2.4 had full read/write support for doublespace
> compression algorithm in mainline kernel and it was connected with fat
> driver. IIRC it was dropped for kernel 2.6 because nobody ported that
> vfat code to new fs API and hence doublespace in-kernel compression
> algorithm was not needed/used anymore. But I do not remember details.
>
> So IMHO it should not be a problem to reintroduce same code into kernel
> again if there is a new need for it.
>
> And in my project I reused the doublespace compression code from old
> Linux kernel.

AFAIK only the CVF code used by the dmsdos driver was inside the mainline =
kernel,
but not the dmsdos driver itself.

Thanks,
Armin Wolf


