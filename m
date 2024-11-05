Return-Path: <linux-kernel+bounces-396710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18219BD112
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618AA1F2399B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30114E2D8;
	Tue,  5 Nov 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="YpneG5bJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C3824BD;
	Tue,  5 Nov 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821958; cv=none; b=UB8X/XZZqfzQ9W8KVWDMngL6K8Wc7jWwaPIHeKSp2MuFm8PhqfGtXvPRo+PGzedRNlBVAKHen1XuLApmzD9v/p70hSoU98JmFFh5vyrezJr84YvUZVd9oo5kBsgpC7kcTANFJylx8vwGOS8I6ymkKF/lV9MUSvUrlFUmsgvRyPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821958; c=relaxed/simple;
	bh=A5wkn2g7ewXyxsGccABxzYa/pZrTsi476qh1bxTr+0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXTsNrkhkmCr7Ow2MZwFyXJdCGd8NyAu7rISH2Td81V8bfbnXDZSbHeGdR/octQz2iAjIkKn2Zl7eSncdreFPw7AnVwIGawAbjWdTdlcwko1r6Bu03M2eCmW6y0WJV0u4HwqA1pkTzhWkbaubFv85MUrR5LN9h4iozI0L/TBLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=YpneG5bJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730821928; x=1731426728; i=wahrenst@gmx.net;
	bh=w6BRqx3A6quV1vsoZcGcoTn++xiCKrR1U7u2eV5qVyc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YpneG5bJGnvLKmGToYXDgbt38gkeGGpnqWqhwoKiW1BeNfoCbt8f+6JG6M91H4h8
	 25XIcg1MkxEbSvLsy0cGPwbcz2Lz4gqT2iM9RwmVwU7gG+yC7rVCVM6zcd3Tjt2CY
	 wai51zIy6iMvP28wVyEOv1klz1PQe1lkb5MVo+8Pu/09HoEC7Cg1svAFakJzuJnAq
	 BYEJwE6kbxuBsHMBMAE7cIVuvSPa9KOO+74tSyg5+MYxnMNpeWf8ufKMTKZieSbLs
	 8Cp5sClw5qPUqvVkWoNJGgUEPaELVXemxDVUWCZPLkhe7HBurLCTQeLhgDv0qlson
	 utqYcKbAIfieZjqCeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5eX-1tROAf0k6P-00VvAM; Tue, 05
 Nov 2024 16:52:08 +0100
Message-ID: <283bbd2c-0997-43d6-bc24-08bf2cb2412b@gmx.net>
Date: Tue, 5 Nov 2024 16:52:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>,
 Stefan Eichenberger <eichest@gmail.com>
Cc: Shawn Guo <shawnguo2@yeah.net>, Russell King <linux@armlinux.org.uk>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 imx <imx@lists.linux.dev>, linux-kernel <linux-kernel@vger.kernel.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
References: <20241030122128.115000-1-eichest@gmail.com>
 <ZyXTFhEm9UCBii2c@dragon> <ZyY41nJY9ghwe-Y4@eichest-laptop>
 <065268d6-84eb-4247-b834-40a9ff32c1f4@gmx.net>
 <ZyiAMpjmXuVMi5FX@eichest-laptop>
 <787b45a1-9f8d-493d-8930-e1c8d396c818@gmx.net>
 <Zyj0VsTJ2qDHiss2@eichest-laptop>
 <1044800423.57572.1730815098440.JavaMail.zimbra@savoirfairelinux.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <1044800423.57572.1730815098440.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0e9SmOcFNlaLT3rD7fmlk1piqiI0xf9twOaT6BfM28EqKj0nVcR
 o4F+e9wg1F9KMTPgwieP7dUOCU4Afe313a882FpkfRtSLwwH97GTo6nJ7e+XCUMOcAuwPBa
 o97vj3JRErBEF9dJMLCTGatCaOU/5oF/PKr2QJBh5HWfnQ0/iYxakx/Z12r8PHFlkZ6ilPs
 xBLxMJ2xlnMEMtCNfm02g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5y+4KYOBIe0=;7F6uroMgDxRYDS9DjneTwuHj82n
 6LD5t5muKL4oKm6lGgRVa+fz4MtGFqeZFq4B7cXclDheY6Pvd6yF70NB6PQXN8jcJo1IFMWDz
 dED7W7xAE3/xAjck8Osso+Xdd1Cgwk4D7ndkPPM0sQPGwRMYKhvNfYFc4Z7HQ08ixeFakYBJy
 hhEZfU0yo55E9cBkPz3xGV2FyUXfpTpUYmtHjrGZWOZN7KiB+mNkqIiGeIbMK+5TXk6GnRuzj
 8s1y+etj/xCoSTV0Q1sVOUdbT7Rz7jcw1AOCV1pndH+xfDsqWC2k297J5MI3awV36zb2Y1hd0
 5pLIffIyB0xyQkU/Qt+XRitQWNVyr0cqRWg07xb7W/YYH4u1ctjSkSJ1H6c+HBvrj5zTiOlkP
 OMnpQhcfBbJGwqBS9jMJAcWip2OjCFe0tV5Mr1eksMsFjOe4eqA11GKocDObm11kWkDdY0jyI
 io8qELe8gpKroPEzx0e37QilYl43nBsmTIvhdTRySRRCSaTXPXAuj2fAak1gKkciRXrl3p5UT
 TdDoPGpDiA45KrGkE6Tl/qHhxQfx+zJ09rCMp59+RC/C01kEbt1qJ26gcjd5jcHYLh1fIE8gs
 vdVbuemIOp16XsX9YvzurNKM9bDKmjdsU9Ekwbf5HOly5QnQTat6dPIsaAD9bMBHJAG9FTLmG
 kqjQpF1LQ86mCx7/14NggNKP9N+evecjFk183kBgBUvcjpusL2hyFp83Y2Kf4CtqV0Mt1V38/
 7W+buQ6a4qTmx5Ce9Zg+xovDJHwhTkAuKccIw/Y1kikbsmpYnbGoHkBiWV6TCcnfDybegMM/R
 VFqY+owNYAk+d8AO8QzpW8ug==

Am 05.11.24 um 14:58 schrieb Elinor Montmasson:
> Hi Stefan,
>
> On Monday, 4 November, 2024 17:20:38, Stefan Eichenberger wrote:
>> Hi Stefan,
>>
>> On Mon, Nov 04, 2024 at 12:39:40PM +0100, Stefan Wahren wrote:
>>> Hi Stefan,
>>>
>>> Am 04.11.24 um 09:05 schrieb Stefan Eichenberger:
>>>> Hi Stefan,
>>>>
>>>> On Sat, Nov 02, 2024 at 04:35:19PM +0100, Stefan Wahren wrote:
>>>>> Hi Stefan,
>>>>>
>>>>> Am 02.11.24 um 15:36 schrieb Stefan Eichenberger:
>>>>>> Hi Shawn,
>>>>>>
>>>>>> On Sat, Nov 02, 2024 at 03:21:58PM +0800, Shawn Guo wrote:
>>>>>>> On Wed, Oct 30, 2024 at 01:21:12PM +0100, Stefan Eichenberger wrote:
>>>>>>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>>>>>>
>>>>>>>> Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio. This
>>>>>>>> change will fix commit d469b771afe1 ("ARM: dts: imx6: update spdif sound
>>>>>>>> card node properties") which moves away from the old "spdif-controller"
>>>>>>>> property to the new "audio-codec" property.
>>>>>>>>
>>>>>>>> Fixes: d469b771afe1 ("ARM: dts: imx6: update spdif sound card node properties")
>>>>>>> It doesn't look a fix to me.
>>>>>> I agree somehow, it was just that before the referenced commit our test
>>>>>> succeeds with the imx_v6_v7_defconfig and after that we get the
>>>>>> following error:
>>>>>> [   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-card:
>>>>>> snd_soc_register_card failed
>>>>> this error should have been in the commit message including the
>>>>> information which platform/board is affected.
>>>> Okay, I will add this information to the next version. We see this error
>>>> on an Apalis iMX6 which has in my variant an NXP i.MX6Q SoC.
>>>>
>>>>>> So maybe it is not a fix in the sense of a bug, but it fixes the error
>>>>>> message. However, I'm also fine with removing the Fixes tag.
>>>>> But this patch doesn't look like the real approach.
>>>>>
>>>>> Could you please clarify the impact of the regression?
>>>> So the problem is that before commit d469b771afe1 ("ARM: dts: imx6:
>>>> update spdif sound card node properties") the audio driver was
>>>> using an implementation of linux,spdif-dit and linux,spdif-dir which was
>>>> directly inside the fsl,imx-audio-spdif compatible driver. Now with the
>>>> referenced commit the idea is to use the more generic linux,spdif-dir
>>>> and linux,spdif-dit compatible drivers. That's why this driver must be
>>>> enabled in the kernel configuration.
>>>>
>>>>> Is it just this error message and audio works fine or is audio also broken?
>>>> It is not just the error message, audio is not working because the
>>>> driver deferes and because it is not enabled it will never succeed to
>>>> load. I don't know if this is called a regression, because the driver is
>>>> there it is just not enabled in the imx6_v7_defconfig. I thought because
>>>> a lot of the i.MX6 based board use the generic driver, it makes sense to
>>>> enable it in the imx_v6_v7_defconfig.
>>> okay, thanks for the clarification. From my understanding
>>> imx6_v7_defconfig is just an example config for testing. All possible
>>> users of these boards might have their own configs and stumble across
>>> the same issue. So I thought it would be better to add the dependency in
>>> the Kconfig of the FSL audio driver.
>>>
>>> I'm not that audio driver expert and don't know how the dependency
>>> handling between the FSL audio driver and the required codecs like
>>> SND_SOC_SPDIF. So it's possible that I'm completely wrong here and your
>>> approach is the best we can do.
>> That might be a good point. I don't know how this is usually handled.
>> @Shawn and @Elinor, do you think this could be an approach to make
>> SND_SOC_FSL_ASOC_CARD select SND_SOC_SPDIF? It already seems to do this
>> for SND_SOC_WM8994 and SND_SOC_FSL_SPDIF.
> SND_SOC_FSL_ASOC_CARD will compile the machine driver fsl-asoc-card,
> SND_SOC_FSL_SPDIF the CPU DAI driver fsl_spdif for the SPDIF
> and SND_SOC_SPDIF the codec drivers spdif-rx and spdif-tx.
>
> In my commit series I made SND_SOC_FSL_ASOC_CARD select SND_SOC_FSL_SPDIF
> because the old machine driver previously compiled with SND_SOC_IMX_SPDIF
> selected SND_SOC_FSL_SPDIF.
> But because fsl-asoc-card is a generic driver, it could be used on a system
> that doesn't have an SPDIF device, and therefore should not require
> SND_SOC_SPDIF nor SND_SOC_FSL_SPDIF.
> So maybe it is not a good idea to automatically select SND_SOC_FSL_SPDIF or SND_SOC_SPDIF.
>
> On the other hand, if every imx6 or imx7 boards have an SPDIF device, then
> I suppose SND_SOC_SPDIF can be put in imx_v6_v7_defconfig.
Okay, I'm fine with the original approach.
>
> Regards,
> Elinor
>


