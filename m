Return-Path: <linux-kernel+bounces-390324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E519B786D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2CA28664E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A41990BD;
	Thu, 31 Oct 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="CzSwJbhb"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6D12C478;
	Thu, 31 Oct 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369448; cv=none; b=Ll+aN1rnntzSPk9HTmAIHn8zgbECR25QdzdHn8/NA8f75LFmtl9QLFJIwA6f9dZ7I5sPha/RqlaUz89tLm285mSwCrLxknKvS3ITL1RkAXe3wWHOQwFZZDvzKh6Kr4SF0P3T5PMK6rTwpJpuWj04/0OggKQTfdt17axOWgDsp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369448; c=relaxed/simple;
	bh=e9qljVv/v/70A9Mysdnq2rQ1mH8s1pckMtTYq3j3VGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GntXmNg1QlgAowEceiWa4Qu7degODiID5mB2c1ZcgTY4yFEpkIlkXeNANUE19U546xdmOQ2oBSCOUm9Grauv/gWAFmmRkP8v4DMjLRQzieePpNT4xGfukZrSTJhF5josoA9hBjdU8qaK/vMwTvUscKjgQ6nyNLU+q+mv5veQFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=CzSwJbhb; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730369434; x=1730974234; i=wahrenst@gmx.net;
	bh=z0oImfNfVmZoteRNxCIZNWQOK53yZgiZtROA1arGm3w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CzSwJbhbUJVO20CApIMrpcKE+PAzhIB0VMvp00EMi9no73XVyfqh8tyjiSr09cEY
	 1OZ1+LNz6hBUHC/PH6HIH2RJg6SRQR3IjACJif51wW9PwXZQcfSfqRrqy656qRU+R
	 cIC49AYpC/Z5dOy/Mr5vxI5JlsJ+k4DI0ttgR+dCI3Ofkvq5p3LKuhm/oMdzpw8AK
	 1Cw0C9jVFHrmxQtYEboteN2ANCVS2UynZTRXzdHpzjqdy6CXhn8N5co9wu5DWnKxw
	 v1esURQMjBomI+tXpSzeK3iruAB8olqF5QBXw3UkP4eJdCa6XLRK/FD42xKT8QbVh
	 o2tHv4j+EHHgR2wHyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1t8vdm3cMx-00H934; Thu, 31
 Oct 2024 11:10:33 +0100
Message-ID: <806770fc-3830-4e89-a3ee-487b662685ed@gmx.net>
Date: Thu, 31 Oct 2024 11:10:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/4] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241022133040.686562-1-lukma@denx.de>
 <20241022133040.686562-4-lukma@denx.de> <20241031094236.17ed927d@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241031094236.17ed927d@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/JF7aP6oveKYqWVpv51ETs6jF1SqwpNJgJey5jBS3GprKpxoAGB
 QZzUMikSxTkmXRw3seBIAnG+JtwvRUxDJ9JjnZ4c+j5U8UlvLCiLsYMrxKm/bIWKh7lu5e3
 kIl/+pvWqbJA8X/LRvoP7YduRU56bKSGIjoS63y+ZaPCRnBcQgxrQdbpCGyszzqdHqf7J4g
 RdYYL187aU2HHUTr9jYQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vb4YxoBPEBI=;zNksRCNWuHDaCAZKbxrTCxStcmi
 BbuU6kfayn4Och4nccHxZGRwdJtwpIYC5dSXcXAveTIxMiVi2IzcUXKHbk0KL+UIHVXZTHOIk
 OhUBbl6/AsP9ze0M8FubZYcGdYYeQGc+6BFibzdDkRcf9HJ0G3K1d6cPDd4U0HPSUeGMTNJXz
 53E4YAUCGp5TzuMPCiogEhso1uxG9gfIFSB0gN9oKokLYT2j6Fq1WbGUZ1a5X4FEBdEbkHPmt
 peeE+aa/Kk95EqE4lryFtmqL8nB81C/D2VPJc3OTwKEKlck6m4d+ZIvjdBVSusKugd1V4Hm4Z
 4sweQpyC7Nu4/tihjXCNJX5vQCxij8c2rh4s9DjGzATulSbjoSDWf+iOQc81AcHcNb/1LuDz8
 SCnPAxv319VvsMRjGCoa45JeHAx9G2uVe8/usLeylpSDdN1FBNzMjEweGqxzj8jJQbQJfp/7O
 05dNCuimZK63H6wFjUdY75zzdzLifcXVMeWtjAp6ypNp7TuSYhZe4xGGpY62X7qe1ezefKk9k
 GmTAAjY5SiAob1SSsPP8+39NmNCCHTQF0DN7UlpNamil5AJyOrDTWcog0Qms82jEpTuoH487Y
 cNq7tFue/qGFfp3Z7idDaXOwq9mRilSbUnDI4av1i3hmE6wIPlujTuzuAaxMbsM2ulXRa26k9
 Z/fA/OJQ2pnp5Dk/WT261jVTAVpdaRYsYB9Clsw4BdIJ3/zTu0c+isa0Ck6Tf4LCaqP6uT9Dy
 iar2qAwprClDvv4Jv4YIefVx/j363WBZporn4GuwoFZ/YwEV4W3i9PRP/IkLs5n48QsGyrW3E
 /tb1m6VshS4C9dniZAwPeoYw==

Am 31.10.24 um 09:42 schrieb Lukasz Majewski:
> Dear Community,
>
>> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
>> some extend similar to already upstreamed XEA devices, hence are
>> using common imx28-lwe.dtsi file.
>>
>> New, imx28-btt3.dtsi has been added to embrace common DTS
>> properties for different HW revisions for this device.
>>
>> As a result - changes introduced in imx28-btt3-[012].dts are
>> minimal.
>>
>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>
>> ---
>> Changes for v2:
>> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match current
>>    linux kernel naming convention
>> - Remove 'wlf,wm8974' from compatible for codec@1a
>>
>> Changes for v3:
>> - Keep alphabethical order for Makefile entries
>>
>> Changes for v4:
>> - Change compatible for btt3 board (to 'lwn,imx28-btt3')
>>
>> Changes for v5:
>> - Combine patch, which adds btt3-[012] with one adding board entry to
>>    fsl.yaml
>>
>> Changes for v6:
>> - Make the patch series for adding entry in fsl.yaml and btt3
>>
>> Changes for v7:
>> - Use "panel" property as suggested by the community
>> - Use panel-timing to specify the display parameters
>> - Update subject line with correct tags
>>
>> Changes for v8:
>> - Use GPIO_ACTIVE_HIGH instead of '0'
>> - Add the comment regarding mac address specification
>> - Remove superfluous comment
>> - Change wifi-en-pin node name
>>
>> Changes for v9:
>> - Remove not used 'pm-ignore-notify'
>> - Add display names for 'panel-dpi' compatible to avoid Schema
>> warnings
>>
>> Changes for v10:
>> - Drop new line with panel-timing definitions
>> - Add new lines with 'sound' node
>> - Change 'codec' to 'audio-codec'
>> - Change order of properties for saif1 node
> Are there any more comments regarding this patch?
Sorry, i wasn't aware that you are waiting for reviews after Rob's request.

