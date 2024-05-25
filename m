Return-Path: <linux-kernel+bounces-189352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFEF8CEEEB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84D51C20BD8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1347F6B;
	Sat, 25 May 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wgneB7Q/"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82395DF62;
	Sat, 25 May 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716640879; cv=none; b=dJl4stIeuBuR4sVc5t3EaC6MjtKBWSTmkm/UWYTzKSNhL6/uplW7wthp3ckP9Vb2RmYP+q2PqXnsPReHlxBAkG99mpvVCg4dQhbGDRaq7gShiPD4/LsWolw5m1ODKTkNNq6WZzD/UUQGDTJFWKg410CqKCN3w6XuTkI1och3bto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716640879; c=relaxed/simple;
	bh=7ZviCUB/6lSFNWCT4XaECeaxvcTOrRra9ubMc9FPOP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJRcaO/+b19LUfdW+F7XX912q9YOvOXbz/DbS6pJxZW8gen8bdoKnDRIVL8BVPBZ3b6aQZ59aH45Uwk9CaR+DTCS/p+kG1jvnpPIowneXvNnc4eak5C2b1jtnlygU9Z+eZ01DLBjZ9Aftl2XjioAj0dheWj3iQ8oNyGq6fHQKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wgneB7Q/; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716640862; x=1717245662; i=markus.elfring@web.de;
	bh=7ZviCUB/6lSFNWCT4XaECeaxvcTOrRra9ubMc9FPOP4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wgneB7Q/+jVmeHNdKGzQxIHu4OkyOgIjaer+RuHSun7lABKV9b92tPk8BL7OoAGD
	 gs3lhU89WmbTxA5x09HbJ9CfojMgMxAng0FxGwBd3dUzaWLO9mcjEfwYNZx/G0QKL
	 ytKsxOBiz1UcGyQ0QGcpRh26xiVew946O9xXEbS3vuB26kPyavFwCS3ysn2lr5wHm
	 RQ2GBm8zgyUPoO5l1y3WOulWZSs1emvTJXnTM5KUZ59AdM8vGM7wy0M+PIYr+btm9
	 1X7HixKKVzu/URFT++M1DFUjC4z0Pl8xmDcJUhMNNBpdz0YaS+BPhQHAJfHyKR3cz
	 AzvqNkxIcViNNNeANg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWzD3-1rzW1U49Yv-00QEPd; Sat, 25
 May 2024 14:41:02 +0200
Message-ID: <3aeb3813-9a82-4b1f-9dd6-5baad2d45f2e@web.de>
Date: Sat, 25 May 2024 14:41:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RISC-V: add Star64 board devicetree
To: Conor Dooley <conor@kernel.org>, Henry Bell <dmoo_dv@protonmail.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <IPHlm5mOKUzYfwGy0auyufx-oPkSrtQjUjiQLbtvspD69UPX9O98iB8P2mqM8ahNaerz0yUa009f4XABRniq7aj2PUp83hbRVVhhKmqT0Ss=@protonmail.com>
 <1b55aad1-1442-41a5-acc6-16baab90c021@web.de>
 <caCBlFpvjmhO9G1A1_2qHImmuoGai2NoPYonB5RCVftq4zIrSxlP8Msh9z_FX9GwQXzfSrB40dRxy1zfxZesOJENeebWQsERa03sDvArzec=@protonmail.com>
 <20240525-dumpster-bootlace-10123081a6f2@spud>
 <b52685a3-127a-4367-b11a-54ab88467dcf@web.de>
 <20240525-shirt-scratch-6708b2a4f63b@spud>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240525-shirt-scratch-6708b2a4f63b@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CxPNXD7l6EM9E57TBcClo6tiFuHrL+82ELChilSGwI5G+i6gBZ6
 /5SsVq1xUBJVOQCDKy1aYKX//RozpMRI4fznh6el42YVnrr3ZEzIloNMgvW2BWuRlmVchCE
 N28MO4QJZzdMdC5+XLEEhZPJhVeXQVOF8LPXzKS37ILeLbRMgeGTW4lPt6T/LZMklvMsRX+
 e2/QXchk8/MjP/lQ2dTDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jkgHsTc38j8=;eVO6GgRHlUgM/p7JnxdTdFAMzkE
 Rxbk08XB7XnfNSsOOWF8BNoumfxz9zwuDS2JYe7rfFV/R7zKCbEpo7galTmlwzeOTxSkVM+Gt
 Ejgp6/RVrUxAoj0/HU783BraiZ+OpA53MMcpLcPRUvpwOCyRfKlwIC07olO55pUxzbumeOswL
 Ch7fsHgvCmVxgfdcm9OYHwQ0gp5sBtTHNkS+IPEPVxrhHOJSEdCEYzLNXW9SdYMPllAnEbByN
 GytMFzm3DJCqnsOlQgEzk0lAmw6Odq1qQTyB77+R7KwM4AGswc7mY0skGIMctqmk0KiSzeyNL
 wwruCAnhMnw+vgDS9UaZlS8+uqGja8tKI11+tv4HxO32S8JDFKsdsBLcASMlr4x1TzUgWanp1
 YCwFKmbNXeDChNNNdj8UiKeX1JnEYw6NhtAVA2xqDQ9eSbHwr3zGSCx7xZ1QXQCa+DlkkI8Be
 so49rILwDUx6KyJjcKGg6nll3RMJVUg4rstg/2/2tMGf5BLbtHS4b4xZbAKye10hjESyAOp7x
 RiQmN3P8zq/HB/hvrUlO9VIJltKa9I6bggaWrvC3bqTtQsQh8xBGH/jiVcS9REOWTetADP76t
 4yVMSA2xXO6APwftKb7JwVElXjAPYZodqEfMJssRbru/PdlXsqQZRzQFBHh4xKzTWtptUGOiH
 8YgadPhbRN/KI+6zziOAXNC6nEnleAkzfAeGmEV/FOlO7QXoPNIXefKhrweyCMH0rhEhwn0nO
 tGS2cj8WWLEembz1gb7D2UVUjHKKzXYXI0zcxBzOwED+Qxpn7J48efclCcbruToh3irG5++vY
 5UE2lby9AUDj0Rp1PbmP4wm0j6ymRIkAZsJ5/pvS+WN9M=

>>> Don't worry about Markus, most maintainers (myself included) ignore hi=
s
>>> comments on patches. The commit message here is fine.
>>
>> Would such a response mean also that you are occasionally ignoring requ=
irements
>> from a referenced Linux development guideline?
>
> I do ignore it from time to time, yes. Being a stickler to the
> guidelines wastes everybody's time (just like this discussion).
> That said, the tense used in this patch is perfectly in-line with the
> guideline you reference.

Partly, yes.


> "Add Star64 board devicetree" is in the imperative

This information fits to the summary phrase.


> and the commit message body contains additional information about
> the board's configuration.

I hope that further contributors can follow the recommendation better
also for the imperative mood in changelogs.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

Regards,
Markus

