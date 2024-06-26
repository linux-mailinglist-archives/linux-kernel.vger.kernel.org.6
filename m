Return-Path: <linux-kernel+bounces-230343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506C917B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669031C2165B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52D16A395;
	Wed, 26 Jun 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UtBMb89y"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B398160796;
	Wed, 26 Jun 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392210; cv=none; b=b1AIGXK7WeAd/jpFGnIi3sB3ImMNQFkt6AIxn91nMPw02plotc2emDTILNZxH5KDB8Jv5cgzEVx0t10EdDjXZIQy0iJww0rli4/jGguiFOO3ywdKRFTc7ZB6dMrKEzsX78CToO1184cixYt08ViR6Wb8g77RMm09Crrf3AspkMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392210; c=relaxed/simple;
	bh=dqN7RMr1ENoXwQSJOuRDf7RcOZcpC3x1Eq9p6j1DL3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb5VKWigkWhSBdt58GPrmxWFLtfAeju+1l+qXCXDOa2Ru8w0dzkry8FQzdbEL3BJGVsJC+W8cE0K2rgGBXLbtLoMo7jVQk/gkZ1YCZnH3LszOGSOdmH4tZa+rx65v80yew0W38WntruM7XtwzRdJyYElyhMvHCGhfulI/N0wzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UtBMb89y; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719392168; x=1719996968; i=markus.elfring@web.de;
	bh=uHpBbe5Y1ciXIOpkMuiiWV5X9R8Qj10UQWwEFWd/0kc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UtBMb89yxkN/4fE8WTQmaHr1dsRFCz7YlpxKHXzi2hhw87EZD0QXvHczGoC8zK4C
	 bxs46Sx5ME/30TY1yXnx+GcDfBczARqfuq9n0tEbyeP9bjUuzSyhlkqA+zgxyNmKV
	 hfINLFpKAcaA9arKRjXzuoHhFVd/JQQSjDbjFcy+QPxTNAGV6Tr+jSWK+01Vl8q5y
	 aBGGij92NgG7FWoSlpwutJHawlqIr5hv621j6s5SmNC3b2Y0UzRWajL3kB50o2/W9
	 j8bvh+dtxuN9TdbbNO6WhvKysawYc2TMuBeMnhba9RKQg99wja4JwPGFwQxAg9XCk
	 2A2DwGsVEei87pFdYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODiN-1rxqFd2O8P-00V3Tx; Wed, 26
 Jun 2024 10:56:08 +0200
Message-ID: <95612a56-63ee-4ba8-beaa-4b773ccca5e8@web.de>
Date: Wed, 26 Jun 2024 10:55:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] usb: Patch review processes?
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Ma Ke <make24@iscas.ac.cn>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Julia Lawall <julia.lawall@inria.fr>, Neal Liu <neal_liu@aspeedtech.com>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
 <2024062556-ladder-canister-1ab1@gregkh>
 <ff2aaf0d-5456-43d1-af52-78986b3401f9@web.de>
 <2024062532-strep-president-44d7@gregkh>
 <5fa430f5-3e18-4c20-93d4-6733afd6bdcf@web.de>
 <2024062553-koala-granddad-50f1@gregkh>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2024062553-koala-granddad-50f1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:01Zgw4SpZxal5aX+cdD8nOTCspwL5KOnoabCgPJR2tnzNKav2ey
 kY81u5ra8MXgMOxtiZZXjPFI8MKtKPtnTNvanxr3aMrubDK53O5Q6lSYjFBWX1oD6o/QsQ/
 ftgq9FJV0X2wtZ5m2KTV2zcl4yJrdgwpm4E1Enl7Cdz0yfBdQO2N2lhvZFHzDtIdhINqskr
 POn2J1dxCNUh+sBbgoPPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gfrLLhDtPD0=;UlbLOaeVxgTqqoy5hNUBJ8gBGCp
 vnSvPRqj7AtVm2SCQt8tVy4oNIw3HPJfJdNp6DTZsXaQCyDzJHJtJkHrl4lNR2YrTg2gHLJaj
 VBjz2dCD8QXbthggUT1rffygNJm8L6SsgL7eBQkJ1OXI2IJfJ9vP39oJHNQZB+B7yO+KzSPuD
 70Jd4fp/wP+9Sw5zHI3Eb2ZNo28MXO+BTRQVXz2qoUCEsmBVXq75RSCMCHCNgRGQtpOqA+cb3
 XaMn69X30IdlbPA3JaCUb/2Wa4XVNFKaAi6yJytX6XjRH4gZlZVMTmw1QQnx5D2v8vbBl0RLb
 +IAiqXDSTXHNoOPDS/kjEfHvziRfKdJETXzkfla/K43mRNADraVPhMoU7EFql/KJ4ceuB7W0K
 Wob7idlraKRvfThiNUA6s0vfh8kttP3KcfuGWDpcgUbtds1RY+8L8VXYKuNd0DXG6ycHBv6CM
 yWag7wrDclPLugGnlfkAcpm4LhvkyyEHqtEFpEkrwf0Dpg3OFX1SBuiomX2Ig3HdMjlgKzGlm
 dLWTn7jO1BQMq34P8fqTfKxXKkpbELQxqZcgSGCVq5c11n6jW1JKYeapPN14783isi4ldaW89
 xJ616XTleXAi0PBWoJVEvJYWmLtan7rz9MVNSSEuZpukcjjrsC09riSDH/W8L6dz9h9OFR8rz
 CuqVYp8bnvdrqSMvL3mNI+4DHfZgqsRc6KtYKm8YVhsbZOXztXzgk7cFl7apeGr0EjfN7t/NH
 sVZ0X49TPfZuHqnxoasaTFvlXG5QHrV/X4YIDTpNG4oWME+B1a1WQ/m42mp9okc4jdDXK+Zxw
 CTCNxvLaXxOY5R335wGi0XnPLfkCLULuEZW7YkSp8IqV0=

>> You indicated concerns according to patch review processes,
>> didn't you?
>>
>> See also:
>> * Patch submission notes
>>   https://elixir.bootlin.com/linux/v6.10-rc5/source/Documentation/proce=
ss/maintainer-tip.rst#L100
>
> This is not the tip tree.

Would you eventually like to support the creation and maintenance of a doc=
ument
like =E2=80=9CDocumentation/process/maintainer-usb.rst=E2=80=9D?

Regards,
Markus

