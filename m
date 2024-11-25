Return-Path: <linux-kernel+bounces-421327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E9F9D89A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3841628BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC941ADFF1;
	Mon, 25 Nov 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bo7lN66C"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFF29415;
	Mon, 25 Nov 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549780; cv=none; b=kaR6XZ1h3COGR0yoeF+3Z169ZsY3y/vEZxqh9z8n29vuA282KcXqTipASgdzR6ohHGfq6wOp0nUU6U33TGBhI7n+pH+aNniTOjpYcm0e27oSKpf9P0BOPORuwdyGi3yCV0Q60m+SzyD1hXdFC/D6tWTRl4prhodorpEATTeDj1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549780; c=relaxed/simple;
	bh=NQ1kcMmfMaIDU6OdzugdzQaHh3ZRA1tFz7NBPluEn20=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type; b=lbm+VQFDzComLpqhN9aE95JYDfJAPE5Wus9sCwupAJ3lP/m0QVJ32nRPWd0T+Nm8JvraV4bzIEXhIEZ0vC5bbXIGbFot9AJ/BYJsyIFT7RqaMbrcDjq/zUfpP8L+jseq+y+6wVFV/glIYj9J/+NqTM/ceja0ftBB/P2X2AOS4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bo7lN66C; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732549767; x=1733154567; i=wahrenst@gmx.net;
	bh=GtUesFmoMelthLsxJsdVzkl+XiMqw1KScPpqQzszf78=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bo7lN66CSKgws/PktTXiTh+wNEn0OKQSrxcb9VDYa2iGmZY+IQWb8FGPm7mz0rbl
	 f3acxkWiNItrxAFEkPrdeoeyCh7rU38mLaK55k/gRKgZY8uf4Fmz6iFkY0dHZCtsI
	 FIdHjge9RcFvPcUtEjge6o3RwG7ceP4YvsICceV/sfBKotFBQgnY22SF2oNP2r0uF
	 gWtm6B5fMoyJ0y6bjbHLcZTNqYSr2ZMsGCYcYGGCfVihHRzHiKwNzTmgiEKrOxCp9
	 zQ9shHqynQMHPUtZmMqs6i4nuFHShVyT+Hr8sAc8xSaGLcsWsCPVxWY36dFO10QrU
	 9TZkcul0u1PoEURtvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1txlrS0LU9-00alE3; Mon, 25
 Nov 2024 16:49:27 +0100
Message-ID: <6ea973d8-e625-47fd-a69a-b39c22f2ccc7@gmx.net>
Date: Mon, 25 Nov 2024 16:49:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v3 1/3] w1: ds2482: Add regulator support
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ben Gardner <bgardner@wabtec.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <20241124-ds2482-add-reg-v3-1-806df39c9454@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cBMy4ZXkpqNToMoIlRIghqiSfC0OM5CaTGtpBblxLAT4HOcLNpH
 0VPl1sm+4e641+9RBFIk21O+kXARL5xiVP1bnyWRxqKSzsJWfwVpAzOkeTHV/l3cCpb53EN
 Iv3veuyYgLyirYK4CgHaoYy15yiorrlotgNjtPgTR0m7IcgXa0syxTwY36k7QzRNhe274dI
 UKzkGYplxtRr00jfzWrAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:almMDtvQqGg=;XKGaz4zp++YqKkAE05uaTUo0EQE
 42VFQ7nlq48wF8Qy87wBmrOJT11mAxnkOq/YE+9NAoUc7pJINJBpGlXFHnyWxmNRBGg14MRNA
 6nghMncUq5/IoYUVJUY/4Wup384/O8Hj4VWXvBVDKVSpJZdT6VxDOoMevo80xichLs8+P/Suv
 Swde971yKUDmjamoXa2JhPM537BMRcaEdGSka3cKbWK/rYbSYKpOGFQYpsl1Waj8/IINlRV9A
 xDYM3qhXBmnFFD0jzRj3RPLVOkRB47kWVbmZbapju+EbYWrD7mIa6LWXj6fbN6dmB/q+wngz2
 fAlsvntXSYbG44ZXlbFhGTgIde0Cs6uPJUqD/ZgVD2iBbI2dhRCaRmJIlXHbG5K/IebVOkClC
 iq8bYgUqpna8QZMY/71WVctRmSvdzWr/BL0i6ZQ7U3REzfgXmjONvK6IfaX3DPXiUwOYt5rjf
 7uRiFn6IlmBRgUMdhelE1J9zwC9hevFPTTrIqx9yI7Rq7XTO+IUqtm562TceSAP2bYPInQYtx
 NpXMtxMCX/ZLRrBc3K7YD8IXgzwPxlEN+7kOwSuhNEhRXKzbHqNTRkjBosdcpxxdmx53u50+7
 PbhrZcXQGSYgshcIEB3fw2O6bK6Y5XsAJIzj2KP5A9dniOduk2PwykPAp+sAIjN8Ss2yNtHSl
 pEKbjvBB+vtUzMP7+hoi3xmkrW+i5IzXZwNZMfoExy/et6HVX1a2kS//MiKLVCYfsFGewJJIU
 mEZoidaQt+JcnIoKWf9nIzZ4DYPnRI91usubdQRJJf4IuigV64RQwSMVdsITt80DMJEm3GRWF
 ZmHYt0KeNLcc2DvnX4N4riBa71semT2Ntt1fJSmKAi/TRo7dxeM8aiTfyMNBpXWuhu0TBK9UB
 +u5Ft+o7X7RwbwkzjZgvybv3usD5Lax0NwwaHTdewIQJQbeYIOMU5NU8M1Yvf/UR6WuUA5Wo/
 o5XScrgOmuIAuamWf0bn/IzKqDho5COUhZE3Hu/fOEbkZ9TsWJ8upZd/mAHMgJNN5XpP7tIJX
 BYHX1RvHmZJpyN8Hm4Zrm1nYMsPU9yaEByrI8taG4XuohfmGCQBDwLSdIA3nf2PYldFWpUH3s
 wJHqYWh9r/njM1xH38gaYi39FEOfKH

Hi Kry=C5=A1tof,

> +	ret =3D devm_regulator_get_enable(&client->dev, "vcc");
> +	if (ret) {
> +		dev_err(&client->dev, "Fail to enable regulator\n");
> +		return ret;
> +	}


I'm fine with using devm_regulator_get_enable() because it doesn't break
existing DTS like imx6ull-tarragon-master, which doesn't have vcc defined.
But please use dev_err_probe() here instead and s/Fail/Failed/ in the
error message.

Best regards


