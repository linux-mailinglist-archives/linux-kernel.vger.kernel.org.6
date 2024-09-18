Return-Path: <linux-kernel+bounces-332472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030497BA36
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5536D1C21000
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6167178CE8;
	Wed, 18 Sep 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bSj9lUF4"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC31304BA;
	Wed, 18 Sep 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652373; cv=none; b=q7RTLC5mKpqIDV79KRPxJs7cT+IsA7H4avexHPLTdzeH3dQWzNg2TEvGICQtHqcfpxlbb517DxghVlCSSem7lkWCEcURzdzlQdqEpf3ZThNgv5rMxiqomcqRzeZPxN1T8Sd5BATh6qlM8Mj4sGHnUzAs/b01xMMrcFtBe1KpsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652373; c=relaxed/simple;
	bh=gRsj4YrkwdhMx1zvHLlAX+RXJ2gkdco/wH3IXTlwkK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9RqlBEna0cb2fqSg35HPBTqTKdWakWwJWsEhCCcrYCh9UsBIIxKDjfaFDduSaIBaSKVMro1WP7mzyq8E6t6lJK3sxtLQC8O+0N9b7BlqwxRBwhbLujnVeS4t8QJnc7poVoN2vST2IYjxG40dg/GfgTU68ogZybXj85x1QbsDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bSj9lUF4; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726652341; x=1727257141; i=markus.elfring@web.de;
	bh=ryEsDHPLtBndKjOllvUbBdBogtS9EuS9iEH04QnZOw4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bSj9lUF4AoSwexF9Mvpvb70mSt3BsmDf2w+sAdmHsr/1ocF2pWPPjdOjlEtKSUy7
	 IDEtDXylMk5ARaBcKx06bcduLcYmwLsTxb22zFI5d/kfWHMg5sXHlhV6mOL5gE1tx
	 RW1r071EMSQwoDBaS91QucrqP90Dt2khRzTVzYkZRoIUnsUTYOXTVWIAuwOZd8ppV
	 c+DhDTIFj1wVTWlHDh0U4dbrGnDk01A1EboEozX1iRdOv0UccLH891X5lPEW6tkDa
	 O5doYTNHR7Q6hJmuDgvChCevQKJ0Xrvx1TYEMV5G5dHtE21ogUNzA4RwLXJW35Cn3
	 fdWcCYozEha67V6L4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLAVa-1sYm4F1Nj8-00XN26; Wed, 18
 Sep 2024 11:39:01 +0200
Message-ID: <4eef2944-9ce7-4126-bf09-3e4afcc52dbf@web.de>
Date: Wed, 18 Sep 2024 11:38:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/query: Refactor copy_to_user() usage in four
 functions
To: Jani Nikula <jani.nikula@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 Francois Dugast <francois.dugast@intel.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Nirmoy Das <nirmoy.das@intel.com>,
 Philippe Lecluse <philippe.lecluse@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <d1f1eb7f-1de7-4d73-a7d0-00cc1eac3d5d@web.de>
 <87plp1b989.fsf@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87plp1b989.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tP4z8gat/ogxMxUw7ZhKbdxBkZUFAX10K7GLmI6NQYyBVdXQIgu
 NgktDNeUEyrDSWL5lhqYOoCycQMUF8a2S4pHH3p2DlqisSC/XxwhGSJjkddtZSeaIr7CE6Z
 UDoMcJDsoUx8oPQwmHZL/nGPjNFbK7smbtCMLOHydAzRjwugJIY1igTzHOG/8dVK4Pt3Vs3
 zv6ugvY4WUClBiyJtzwwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8akf+dFK2/0=;giGbhwRF45vuMwQLyirVIC9BFIa
 5N/ELhOQde0TLBo+l1dQPKoqJAy/SYbZKKK6Q06wM8Fa39DNv4/HeatJv/R9EWNUsCZnmOHdf
 eoMUeif8Z0OxUTXT/Hs6cnU9wBwtTSowLBdgztZN7spkJzFG2JOYMC5ohlC0WRBJJRPq6tuXy
 VuFR4IDnFCfVnT5vbj1EH9w9uR9HH2NDdfO2s6kbHaofYwaLoBxvNhKneJOhKqzZV8M0Fqhcl
 qnKr18Hc6jlSMvBw0aKYKG7e7Ag5uE7PdEiFqL9l/6v4bV7NvRqpTQa5z1mFUO9pjE/kg9Zn0
 g+sikyeljAnSurIx7PZmKq69gwpSQNuMOqdokNl4aC/UMqTT2ijri7PPnJN5xmkrl7N+etAQ5
 gMpv5w0OSHOfNIYpzLLvtzRGDnWZBD3lBNNaDJ/HAGXpKxUVNzMevj2pVgCtn68A7JpCuDw4g
 /9P8Wa3PEpTD1dwDJhOJusvuwUkruTAdg6evlfoUSnJqcdPqPyaYITESv4ZaIOT9f/mbpQO8Z
 s3CS2xVJox2dVBX138RwOgwZYrtoxR66NDJaXd0EuyFG+u5vWBw6gK1AXh27ADC9/CAs/1gzM
 vjpgUzZWwiAUnG5FlAwRuNxCixtzEqh6LnuiDZeJ8ym3DP1VS/aMFRYmik6iJwsoviuQgq7QM
 uCvQo6dlZUmLUCO5o2zjXZCefmuXJRnrpzfBhPwABm5N8aG1e86RtccftXBUpyoEc0D3kUpTP
 iT7+01tezJyDqV0OgGTxX1U7UkPVRPID/HPVtIzZEc2AE7670Fqf7NA42eDjTTqEQaNGG0KY1
 zWy2UNDBMhL/l7/krjj8pY9A==

>> Assign return values from copy_to_user() calls to additional local vari=
ables
>> so that four kfree() calls and return statements can be omitted accordi=
ngly.
=E2=80=A6
>> +++ b/drivers/gpu/drm/xe/xe_query.c
>> @@ -220,13 +220,11 @@ static int query_engines(struct xe_device *xe,
>>
>>  	engines->num_engines =3D i;
>>
>> -	if (copy_to_user(query_ptr, engines, size)) {
>> +	{
>
> Please don't leave blocks like this behind when you remove the if.
=E2=80=A6
>> +		unsigned long ctu =3D copy_to_user(query_ptr, engines, size);
>>  		kfree(engines);
>> -		return -EFAULT;
>> +		return ctu ? -EFAULT : 0;
>>  	}
>> -	kfree(engines);
>> -
>> -	return 0;
>>  }
=E2=80=A6

Would you tolerate the shown variable definition without the proposed
compound statement?

Regards,
Markus

