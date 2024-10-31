Return-Path: <linux-kernel+bounces-390386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EBC9B792E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2B1F258E7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34CC199FC2;
	Thu, 31 Oct 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QUPUarGH"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C40199937;
	Thu, 31 Oct 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372258; cv=none; b=RSomPuSpzh2ZFEMcoNKjAxS7hi1jZOU9PrLmTMzH9xlKbGeSPw22guzCgNCf70nWl1tygzRsTrEVoDVndDGeFU2BUkmCtPXATuI5F5joPwpK8onhlnnA/1kKx941uEvQkhHj9LC+vZeADY8NkkfuwIQQAwW9u7+Kd+8UEdY31pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372258; c=relaxed/simple;
	bh=hSnSmBA3JsThBFuUZF2dy8IVRStDG33LaamTUDCv2ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJqFDGnfK3/T3ABOw6/EM4bkXb/WjPn28szvQlWXeV/t8Sd3y6HkPU/Yzd+LvuYcRIxaw77vi64LfDZX3Z7VbUmFPWmxGJGJTPABtX9KixIcdgkUZJd9FB/ydqnhz5i0TV4oHM7kNc53LW1adUm7L+RQSiJ5lHGodsjPpE87ZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QUPUarGH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730372242; x=1730977042; i=wahrenst@gmx.net;
	bh=Oe43Kh4B9XdXa2/L1UGOstz1oF9OEnFJnRe/vKUWKos=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QUPUarGHgVFTVsiLY13LnTToitIe2pgfpZ4MVz6awnTutfJav4grv9hdFzlhkLI7
	 6KUlCNiwhH2hMx2Tf6SvfpgI29DRdCBZ/8NGLPgBGo9Q7Voyww8k0n28ljp3q4GSh
	 UD3NRPa6r9g5nc1TBoFeOX1Aamn9r0U0SHT5nHOcPxSe+PFoW+OjyDElpdhY7Enc+
	 wWQtX+3e4uj3KrmAbfC8MJVf82HRvxAmUUhcZ8tkE8uExS8r3SPVyHJb3KOrWJGRf
	 vhaNJvSSLZXNqzdibnZQOdiGSMuzmUJcqpkr9VjR4+dq4kGHwolwYrs+jk6x4q8/h
	 W1TPjpMMhy+sYAhZHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1tXnPT3BEj-00b0fY; Thu, 31
 Oct 2024 11:57:22 +0100
Message-ID: <0cb1e74f-1163-4a80-8c62-9c7b0a0584f9@gmx.net>
Date: Thu, 31 Oct 2024 11:57:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/4] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241022133040.686562-1-lukma@denx.de>
 <20241022133040.686562-4-lukma@denx.de> <20241031094236.17ed927d@wsk>
 <806770fc-3830-4e89-a3ee-487b662685ed@gmx.net> <20241031113425.1e3d1da5@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241031113425.1e3d1da5@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ueq9WGiK3ZelpdLiptJjxXUfOP7Gd+Bcvs9yr/VNBq6j/n/wyhW
 x1d4gEzBdNf3tkwbHyCvbWI3H1NPx/+plxVFWb6RkqsLFDpHvv7PZq2eRhBeP+1kQcYjbRK
 joQDLID2XsBhsOlRA6hDiPcakKic59Fp3cOq4Vi8PoqYBEFQnU99U9aV2yK3X/nzAd2rA7D
 h2uYGjAtBBAdAs8XnWDXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iMKkQEY8APg=;lkIqyhmfxxDZI8/qbIw/RDKfkak
 7KBbBqxD+sNYzxnIiFVC3XmZQ77p2KO2aMm4p47FW9dcWNnGow/0QrJfPK9Fbd5Gen12HKcv4
 lwX94A7pWBsK466ZvRlCInjRaF3ra7muYBcfXxbqM5lgDZQ3NCER38Eh3Ngb7Tyo4LBRg/WPf
 bzDnS+d1dZxlovad6bLx7man/UYZUsEwsbQ1xOH0hwTvLPG+fMkkkwFQWEr0m3IHfHMqZAcVX
 Kj/Wv0PsuB3yEkxgd7NRGKa7avZYHsBY0ccxg7pb2o+mPK7phdxo+sjrbCEvEqMB8LuCSfIWo
 uzj0QmaGDeGE0SDFp1VZAGWre4D/SXzFFINI8f4nn8OBw8hTVioE2UklkkAQjY5yET/XLh1QS
 2wkk+wdkd5uu3++QBfePWrNuuV3pu0F+V6yfpHXuA4SD6QnDQN+AS2bCB/54BundiVhKv+oeb
 d9RwFbrrqUTZvqdBGSrkCxedZtKKV9JBpM1PiDVyUCdHP0fK3wmi+bumP+hMrYK5esHE+lJSR
 k4LRB2/C7ynQRVYrBflUBE6opSeDaAm92GL5/HjMIyk6mn6pBFzpYLooJG9ytRKGt4RflTMB9
 uSgyo8+4/BnqIhOq/eCFV4lT2LOFRqhpYXodEXl1P6zSWtlLHdAqlpGhVLatnIU9sa9B3TMJA
 ean4aO/Hhb8LEfPqBV2LJOddi3Wcs/Dsn5N/HnTJ5Fq2Th9jQUhQsWd/MlIhPR0sVzGzzT7D4
 12nGXGczhuiKUY8D91BVV61W0q9iArRyTx7JL+76da6H2zjmF66sYtZEFb0M+abKdZRXPgFnC
 jMUPCYq1aJp0FkVpdoILlqwA==

Hi Lukasz,

Am 31.10.24 um 11:34 schrieb Lukasz Majewski:
> Hi Stefan,
>
>> Am 31.10.24 um 09:42 schrieb Lukasz Majewski:
>>> Dear Community,
>>>
>>>> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
>>>> some extend similar to already upstreamed XEA devices, hence are
>>>> using common imx28-lwe.dtsi file.
>>>>
>>>> New, imx28-btt3.dtsi has been added to embrace common DTS
>>>> properties for different HW revisions for this device.
>>>>
>>>> As a result - changes introduced in imx28-btt3-[012].dts are
>>>> minimal.
>>>>
>>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>>>
>>>> ---
>>>> Changes for v2:
>>>> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match
>>>> current linux kernel naming convention
>>>> - Remove 'wlf,wm8974' from compatible for codec@1a
>>>>
>>>> Changes for v3:
>>>> - Keep alphabethical order for Makefile entries
>>>>
>>>> Changes for v4:
>>>> - Change compatible for btt3 board (to 'lwn,imx28-btt3')
>>>>
>>>> Changes for v5:
>>>> - Combine patch, which adds btt3-[012] with one adding board entry
>>>> to fsl.yaml
>>>>
>>>> Changes for v6:
>>>> - Make the patch series for adding entry in fsl.yaml and btt3
>>>>
>>>> Changes for v7:
>>>> - Use "panel" property as suggested by the community
>>>> - Use panel-timing to specify the display parameters
>>>> - Update subject line with correct tags
>>>>
>>>> Changes for v8:
>>>> - Use GPIO_ACTIVE_HIGH instead of '0'
>>>> - Add the comment regarding mac address specification
>>>> - Remove superfluous comment
>>>> - Change wifi-en-pin node name
>>>>
>>>> Changes for v9:
>>>> - Remove not used 'pm-ignore-notify'
>>>> - Add display names for 'panel-dpi' compatible to avoid Schema
>>>> warnings
>>>>
>>>> Changes for v10:
>>>> - Drop new line with panel-timing definitions
>>>> - Add new lines with 'sound' node
>>>> - Change 'codec' to 'audio-codec'
>>>> - Change order of properties for saif1 node
>>> Are there any more comments regarding this patch?
>> Sorry, i wasn't aware that you are waiting for reviews after Rob's
>> request.
> I did not received any mail from Rob's automated DTS test script, so
> this is a good thing :-).
I meant his comment to patch 2 V10. This patch "depends" on the binding.
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de


