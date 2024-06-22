Return-Path: <linux-kernel+bounces-225755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B189134D9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CE1F238A6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0FE16F906;
	Sat, 22 Jun 2024 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sCABwqPg"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC0B2566;
	Sat, 22 Jun 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719070235; cv=none; b=MWCRru9JEF/rjbl5zCgpvJPrV5aZcExNT8x/zdWTz87W78FcjqwYCEMwEZRiv1UwL0xLY03sc8Q19qMyLa54PCHxLUWqdb1syzu3H+1A++xIUuIQsn/8/F1g6SZQz5LtqVX3uTbPry0SdFzDhT8uqW7DcdbCOZO78p+FLe5yngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719070235; c=relaxed/simple;
	bh=X2AszDmnHh7iISJmQW1shchTaZiTz3ToGFcEGM0xMhc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=C5fdyBAexB64Vdpbb1PoPjmXvvEd+vZIROJKjmFHtH9LDIj68+/TP+Gr4TDcotXq46AOdxGCve5k3cPev/5Rojhu27OffQN6/jOz21PiiZdNACkvg9Y/lYT8pugkzbt6SDLJ4Bd3vBK1P4a2ARPmC1h09JtOHn4Sq5OK/zU0BsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sCABwqPg; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719070218; x=1719675018; i=markus.elfring@web.de;
	bh=WDcb3PwjlGhqzc9X8abkD3G1wxfR7OKdxIH664e5EB0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sCABwqPgDuBBvplF0JxOoKl/KPyBm/IGFjyUi6NbcfL5PwQl16VZYeo9ioXS8hzM
	 bEssaSpFNqpAF5S4Hc2aYkQpAe3okmZdxmKU+Z/x6+EYvgIubt7AaOqi5DrQQpHh/
	 8/G3/7l9xT3n5ctia5D4a0K8C4PKgCjIpc5uU/HWAWlwqHOMHauzmdlz7ojW6oK7q
	 HeUa/9YIXUe+R+O1E53Nxe4D0GA9zHeIZEUqHy0gjD2rRQl4fl9raE32QC7Jqpbcf
	 BzpraJ/1kXFv94VH5MF97xbhbjvMYfF3lJLbySZVApVQLrxLTgg7Dkd0twHHQcjRs
	 xNOlefW6UwdeEiklnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpTxm-1shySM1p40-00aL1W; Sat, 22
 Jun 2024 17:30:18 +0200
Message-ID: <4c28e897-0f44-4927-a4e7-762fce28ae63@web.de>
Date: Sat, 22 Jun 2024 17:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, linux-usb@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240622142308.1929531-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] usb: gadget: r8a66597-udc: validate endpoint index for
 r8a66597 udc
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240622142308.1929531-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iOasHZkHe4S/i6kd3HsazMDgIgx3R1abyjeMctSE5yYhccfMURt
 akqnKkqHLTa83/XUfwWydwps+rL2DjqBqB6od2xXaShz1CC3OF9PD+HEof25m7T87MocjOd
 J+TtKXjyOBl+C9mvADzbaMfbNS83lg8F/eP+0gIsQTfF9W+6d4HYHxbLwdHCMAtxfxT6HiA
 3Kacx3DVS3Eqvx2UKmpNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/LQ8t5mdaUs=;S6OmDHQRpCxKd4iDuGC8tso0pSW
 ksqa9cCNR/B9+HFXO/+nrjqsmZ6KrmKrXI6u/hpZlKLBzJXymWRYOVMhmK2vZTnueNfV47ENg
 qwUIOqOREyrwtDZ9sASwCKRDP6F3BRTKS5fsRO7m5mvjQV5elllVGij4CypWRBA5hrg1you6m
 zcYvDaZY7vZw6fPxZdRhEVpA1044TO90rRQaDegm50BhA2zIzeglM2Jf+TtdCUfI2CMY5YCY3
 jOtiUTCnWjMV8YqdVWLomB5tcFY765HryE26HFUjT4n35JsrZCbO0o5/mg1+jRgmLbCFB68ly
 BkCSP8qeaT+3bYuhA84MRf4A/zoVmuvr2Z98BipNf0zZhWoZ/XRfubtVgKwDomVUzAZxp5Lpn
 5ZNUVNpAQx9wAXk0xb731bAUjyg4Ga6ZyHkqviIki3OkdE2MBbAYTjxLHv5aOs7bg3ao9LEzE
 tDKJm17oZNBPsgnXvVLHNfknxT24d+xgrFnY+bBCQdfdW2LDRIit/9C9h32chPPhlAfH1ao0F
 ez5s1eVE508BGUePPAnYFJAz35w3lgg2CPetaxt+AtwirxEXJlUSlyDRBUBtFrazOq9Rbmw/5
 b744zwXZRVCR9p8G3iq9lYADgVXuAtrnz9ry+AqTAXjhCn5Iby8PT3KIUvQQvTVIZPFkVWeCM
 jIyG/mDFqW4ain424ejm7BF7WeeXoEkgMz3VZ9bQUmRQLmS3V8kc2F1bESZobmqIhQIfJsUrp
 J4XKKUE3J4z6qTotoSZlu5ilVaAci1yvbBBrXHmoPUCnX6bG0vjLYk9Z4TjVhJQMvmtJOxhD7
 /7a4TvBdWKgQdz8j0scYTTOxDb7EgljmMuuJKg7gVJhJc=

> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.

* Can an imperative wording be more desirable for such a change descriptio=
n?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n94

* Will any tags (like =E2=80=9CFixes=E2=80=9D) become relevant here?

Regards,
Markus

