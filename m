Return-Path: <linux-kernel+bounces-267461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE29411C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E991C231F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B5119F464;
	Tue, 30 Jul 2024 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qNLrnyDz"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15C1991DB;
	Tue, 30 Jul 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342340; cv=none; b=RuBOHNbYZIKtlKK4u8poWIEYKrEYzGTERZEmgToas4YnBgz4ra+KxfbOd8cZWmkJU7kZSJzAvL0iMeziC5sBfBTCxtPC1200EFxcQIDJDmq/jB44NuHSD3AjLLWSXWtZFwC2QfMinfN/kTCiN6QVsl9PbcmYWxZVfOROy6t9GKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342340; c=relaxed/simple;
	bh=qdDMP7323l8v6fO21UUWMEocD4966D9stt8FVHJsOUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIn2a4OdkzCFPoDM41log4Y5ACVkkTtDXTFaYnhkRXIMujBkP5mjTiicuJUuaV/b7922WmPOwV2+wlYNAT2vQR77EC+ymR7Gij7evi0i5kNIdyrrxjRH+CmPPFDSKqcxfBLIp7/GX0ompjdpmYpJRFXUJFUM73H5Dlq1LAc20LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qNLrnyDz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722342331; x=1722947131; i=w_armin@gmx.de;
	bh=bussN/ItGE7hyQ7qjLYxNnxcmLOLpXWhjXARu85qVog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qNLrnyDzulH4CN/hF55v0aev87OBUJlDIB4Mq0TtdVEikhUwFJZCNDKezANHEN5h
	 yocU7fNnNpgT+O/qSEV772TTfV9rEPEr/Mc0fr6W2V2BqiZ85gJ83SERuX7aaiHL9
	 3wqquhMbxMIYF45hu2295RCfkhmjVqu1IB9Cd75g+3PDR/D6TUch/yVobIZLCktEZ
	 n0JJh9yI22zZVkJIRopZ3pN5SRrUHiACedgmXrTEscqPoyjBxuF5Y6e7e1uZ0L+P1
	 FWzP/yT0Ed+wBHvs8z/Z1zrH0p6Xwr2ocidAgq84PO7sWiNoNkhgmc4YsufkKCohm
	 CCWBu34iQc/qa6esag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1sTHj51A4a-008mNj; Tue, 30
 Jul 2024 14:25:31 +0200
Message-ID: <87bfdaa2-5b94-46b1-bbf7-d81245c7d658@gmx.de>
Date: Tue, 30 Jul 2024 14:25:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v2] wmi: Fix spelling mistakes
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>, corbet@lwn.net
Cc: platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240729223649.135639-1-luis.hernandez093@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240729223649.135639-1-luis.hernandez093@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IzHrU+9R1FGoUahWzPtYbZQXRyIJcVLmyBbTiP1Yaq7sqhyYw8H
 mjRD+L06aLbz1IS5TkiNQrAMULuXVxHdNjh325hYz2S1f6TXQxQ8dSrdmh7to+DdfhyJ8p0
 pPj1Q+Ou+zhWoA+JJaWq6cnbBPgUranxWiUiSd+N+55ch27wSSR4EmgESjw2JYSm3o8dP+A
 FhJ1LwnjH3COSlRDHHVgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9fq1H++DdOI=;MB0Yui693RYl/p+ccc3bWftwDLn
 V/x7jTl+n4AUDQMUlvWauiJfOduFRrtN4av8a8FI38fbnHV46IDfUXGhR00gXkuXqOkDTnhFR
 r0pzwr5FPpO8vWbsQgPHUnplHCMgNBb4Bxn8NAlsJ2LeNpDOdydazcd3plcu7Xmid+EMcuUaP
 /3XPE8SvlOskKJj8kC5JK2FzyRXTXm+TSmfnxrEY3xXDEPw3IHtZZa4mTkLg+eb7GF5LmvDAq
 3/o7sUY8nKHkl4Pszsmgjsfhe1Ofn0Ohth61xgRcaHDUJmjTAsNMLfrXMLRfmQhHyf6PozVK9
 U1RXBGszSjkNAtCPBlfqJD2FF9q+8msBPhNNKfe/sD6EELGTWq0mu8ASXPrMUq1NXSEJK5zNQ
 a2ElU27+Nk9dw+s+K2zn/O6QPT3cj0UduHGNRdW8JZLsH6/EnGSlVtMqyT7SNBN5R/O0ybia9
 wH/B0PwhQM+zRAVOmm0mjA44It0qK9UxPZLr5wrl7mefii3U91P05qRS4BZJIe3P5irQbXhYm
 pU35/5EK+TnltquPD8/9tle3+IjdJE/ez/zOp61Pe3q8tcYCLuwotvVbwB9786t5KXTzycGjh
 ChWBTGehNfHi79KZ9DX/L6SHyYTxUB/kDaptcQd1JrQ/Rn03hqbp52chTdnYzchaq8Uz+JVbK
 Y7ExgW0y4uphd+1SCiBVeYV7oUoMg6ghsJR9z9PrtNWKI1GH4XSKvDSouMRE8kFKqZTxxVFA5
 J+WvkXWAROt3y8dlpnPpTXaQvTLEOi3ufSo/LXgUOQGSdpFCClziflMc6mC/CDYhF5jIt/G65
 SjfvpV7ctWz5RN591bb/M2jg==

Am 30.07.24 um 00:36 schrieb Luis Felipe Hernandez:

> There were a few instances of typos that could lead to confusion
> when reading. The following words have been corrected:
> Binay -> Binary
> singe -> single
> chaged -> changed

Hi,

please change the title to "platform/x86: msi-wmi-platform: Fix spelling m=
istakes".
With that being addressed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
>   Documentation/wmi/devices/msi-wmi-platform.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/wmi/devices/msi-wmi-platform.rst b/Documentat=
ion/wmi/devices/msi-wmi-platform.rst
> index 29b1b2e6d42c..31a136942892 100644
> --- a/Documentation/wmi/devices/msi-wmi-platform.rst
> +++ b/Documentation/wmi/devices/msi-wmi-platform.rst
> @@ -130,12 +130,12 @@ data using the `bmfdec <https://github.com/pali/bm=
fdec>`_ utility:
>
>   Due to a peculiarity in how Windows handles the ``CreateByteField()`` =
ACPI operator (errors only
>   happen when a invalid byte field is ultimately accessed), all methods =
require a 32 byte input
> -buffer, even if the Binay MOF says otherwise.
> +buffer, even if the Binary MOF says otherwise.
>
>   The input buffer contains a single byte to select the subfeature to be=
 accessed and 31 bytes of
>   input data, the meaning of which depends on the subfeature being acces=
sed.
>
> -The output buffer contains a singe byte which signals success or failur=
e (``0x00`` on failure)
> +The output buffer contains a single byte which signals success or failu=
re (``0x00`` on failure)
>   and 31 bytes of output data, the meaning if which depends on the subfe=
ature being accessed.
>
>   WMI method Get_EC()
> @@ -147,7 +147,7 @@ data contains a flag byte and a 28 byte controller f=
irmware version string.
>   The first 4 bits of the flag byte contain the minor version of the emb=
edded controller interface,
>   with the next 2 bits containing the major version of the embedded cont=
roller interface.
>
> -The 7th bit signals if the embedded controller page chaged (exact meani=
ng is unknown), and the
> +The 7th bit signals if the embedded controller page changed (exact mean=
ing is unknown), and the
>   last bit signals if the platform is a Tigerlake platform.
>
>   The MSI software seems to only use this interface when the last bit is=
 set.

