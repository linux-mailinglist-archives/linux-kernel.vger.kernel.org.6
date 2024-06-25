Return-Path: <linux-kernel+bounces-228897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A6A916861
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786291C21989
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620A6158A26;
	Tue, 25 Jun 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bLOV/bbB"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465C40BF5;
	Tue, 25 Jun 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319875; cv=none; b=ozwb94tOInC3pJ5ArpgEb1reIsdHhVqPRd8nUcHxQqMvqsuyecoDZwFQ6eKspsNwxbox48pSI/e6YlkejsmUoHM2j0X2aC8GeLsxIBiAkbaiDDObEYa4wiNpEESmpi/s/pnau/P5ZZ+Y/siZ6r/jJHm6fgQh4uGmjQUJ4l1SLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319875; c=relaxed/simple;
	bh=6loaCbYtOLI01rKUYfHa05q6R9uYmeC716yJO2XEMRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnTPXeu5wheiHWCdnYbhy0/Z5dHwuvkODsAM4Le/mOIboJFZW81Lnv2oSXWiEr8v/CVCcOVd27jbsXaSudjHyzAAQkgTxgREQ5soBlVBFOLRy7iPjmowIyvMbYI47Uh6fUAMPjPRfeGqa6ccQPWRFGlv6wuu0gWkUB8iZeBwVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bLOV/bbB; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719319827; x=1719924627; i=markus.elfring@web.de;
	bh=GP4e83RetXmJ+nltZzrhj+9THBjb5nLvKFN3CPJMaWA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bLOV/bbBaWS3wIqBQYYU/Q5fIXDY63gr6FeZGiQNjoSWuXXimje9UyfXgFj17IoJ
	 F0fVWUO2JN7zmItAYaFwAUdEWY4oCfaAMSlHbnulv8WKMBTjJf0IWVJutigIjlaRk
	 +Q/lx+lRmBHLTg7Os25TT4PyWwWQbH0xUEOTk7S6JXjLEVGOeCXgfHC/e1Vjf4Xb9
	 eiMPlcIqqCYUqhcDCeJ07Mwj/wkk0o76AJGgB97EKitpkJMaNuYPZ23byxw6+EjRL
	 695dCvhTDz5LcINg9KkpVeVq6qQesvrAd/zNX6WpwgEp5KgCqH42bSBMIjQnYAbiC
	 wgl42SnfUE97l6kRoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXVX-1sCyxN3sgt-002KoM; Tue, 25
 Jun 2024 14:50:26 +0200
Message-ID: <ff2aaf0d-5456-43d1-af52-78986b3401f9@web.de>
Date: Tue, 25 Jun 2024 14:50:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ma Ke <make24@iscas.ac.cn>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Lee Jones <lee@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Neal Liu <neal_liu@aspeedtech.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
 <2024062556-ladder-canister-1ab1@gregkh>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2024062556-ladder-canister-1ab1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FNTukBhZ3B3+L6KuC7iGVDq29cjxKUdvTe6S+6DCxRUr493OjeI
 dwv07Dl+WluHsC4py8Nurc/rjD8qeTXlJZWxhnwmLYlNt17nlv/pfEIeVUsgOiQCIADdcQt
 EtbSh42+SEXWgTkkOl96N92sqqK9pfunMONEeVBLllZIq35OFLtPhaVKw2K1PhPc6USKukk
 MKt3B0Gy2xDc88WHr6l9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:78rG0XbaWo4=;wDrWYhO2AA9czDYUVFTiVxvQhfn
 uUSuGNaMrOtcLDI0AkgykBTy7upRcIe9t6ZARxvSSrd2gf6wQb1Qwcqrc6fmAaemA9DeScFj1
 2PF881Ex0qhoTOwZN7hBwUvVwNsq9G8vvvJvqD061B3F5T5F5FAiT9dbib7di5HY2adHWewMH
 FppItD/sU5xXQfy71Ayn4PtxIyDqgOTPAHj+LNApKvNH4lKuqiBWmHBEjgbi1ciTojpyEjOjb
 oZcJivvLHuc9C3MJB7OjQ3duMCIunrsJ1l4q2qpfpNnTSeOPHXnKJupwUb6/8qXrtX6vsY34y
 YOqIRV5x9k3BpbISh7WrPycLStVSu4OszeSKD1xk1v3WS9O6KoN2t+QCrXVbJGFoDDSOjA7pl
 aktMXFxSE5bbUkteNqBPAlcR3dRAHXRAaTD2Z3RTdLnAlcyvOxxAt47rCfPPRQ0c6RslkUvDN
 Gtut4eK0T+KVuD72GkoCUfw4LVurjvcm5kHH+Z4Gv7NG+n2pIQT02IzzLW25/WVq3t70ARe1k
 FRrALs7Zzh0bvIfp1SKPlZ1Zck5Npvtyb+l5bVKS+Pi3GAcunQUnaFJSANw7VISiZ6mmcknIe
 Sv5v68GQzEDFBRKM3E4htOFBFacVRjjsvay+aHFnk/9P/yJ6VdXqdnfdAHDfdyeSyou8NZv3B
 ECdAC9ccsw0YGSM5bhAWoxskGECc2VjU9TDW2r+s0IcCTZWfzQYx7I1U6m9v7W2m/MrYMKUfX
 mhvfgeUxlHbMmh96uS4Eg9EOSLv3q22pQxqavTbGlhh9BmnXUvJ9FJfp2V6TtbGyJbLbkUaFQ
 wEOu6WgZfw5HIAL7keSgTUFk96w/cagvjrHahKlqVEols=

>>> We should verify the bound of the array to assure that host
>>> may not manipulate the index to point past endpoint array.
>>
>> Why did you not choose an imperative wording for your change descriptio=
n?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n94
>
> Markus, please stop reviewing USB patches.  This is not helpful at all,
> and causes new developers extra work for no reason at all.

How does this feedback fit to the linked information source?

Regards,
Markus

