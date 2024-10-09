Return-Path: <linux-kernel+bounces-357067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CE996B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDA01F27D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D319DF44;
	Wed,  9 Oct 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lEaGy5bf"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB218E038;
	Wed,  9 Oct 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478633; cv=none; b=JHUvJ/KTOs/feMopWQ6wGmuptPRDkC4PHRGfG5BiSIWEpifMe2Ll0f6knJwMxksXvgxLwYWcmEPAEwtKKO3zJvplEy82/mkysEixnoW3qbm8bhKLZaGty+U2T/21uVyPczOTUiUnOVsvhkECOeDJByG96y+01w97hIMzRMMZQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478633; c=relaxed/simple;
	bh=dfSsJmvi1riRuCTm0iyJOozKRQ+2udiRucQ+l0nnSuE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OIBjqJi4huzw2TfRA/mZ0yAYM0Fww7FwDP5y46GQzxy2JL2xZQsL6tSNQfIsBO9n73xANzId7byyLGdl5xrgT9sI3OunkeQHTX6TIqgzu3LLrVjedI2y+SmvCkuxHQ8i7zMlQ8lafGa7Cys6446dGRNzdJs/HnVNks1PYjxkC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lEaGy5bf; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728478589; x=1729083389; i=markus.elfring@web.de;
	bh=12KnPFDUcHIAcww2+I8DcbudLGNI7zh4KnfAgouCgWo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lEaGy5bfWxQswVAdhsDpDFkkTIqJmEzFyphANNLMR99hGQtrGL/+rEGlQd/7Qbzw
	 fNEilCw/jJrohMNMY/HHRNDoObod6goOPC8iCuQpEWv0cSOYAKPU5UHI1GWNLReOb
	 O9PfaeRWKbDMVK+rHpmXexd6QSVkbe/qazG46GBpFfI+OPhsAZQJJf4pyxQrVELV+
	 pGgLriBBvn7lyAewdfkYl7pkVCVJdwRzMfJ0j5PvrwZCd0oQbjsWJ9vf/mhWvQhB5
	 BzQ+1fjT2wJJGPsoldWR5xZwCEjz8Qj45kOOZy9+LyposQn+ZiIO1uHaFLTjGJlVE
	 C+rY2F5q4bdoMT77ZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jWK-1tzEjB1B3E-012VnT; Wed, 09
 Oct 2024 14:56:29 +0200
Message-ID: <f972f6bf-fd76-45c7-9812-3adfb49264a0@web.de>
Date: Wed, 9 Oct 2024 14:56:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kevin Chen <kevin_chen@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241009115813.2908803-2-kevin_chen@aspeedtech.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241009115813.2908803-2-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QPSId2FJjr8d/zGGwvi81dsHFZUVZrokECT2AEGipMXrJZRxCIP
 bh3fhkQnkfTo042vGl7scsgu4wmtzSpeMZTTvFZhdT2a3fY4Z0LXQILqu+YjcZ+vyhEwB4E
 NyZvcpSOs4PrkbI+7V7jHrmCKsEQc4AIPB+vld+JUCtC3m8u25GlaNbeiI+B6vH6UmnroGw
 qjP3A2mTy4yHv/i/8XmJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MlHg9LH74c4=;p7TF+U+OKTfvFWA5a7gk23ZDyeR
 2+1U3vUasDEAR3q/+qpuNYUbHl5LhBayl3vU/15fV6c7ysSWWOxOyN9vlqcB/4Ojw/W+ccf9O
 0RecdolgzKkbpmJgCWl8OyStzBkWV5MAIS901CIHgIYQzeTnonVXxVJjrVzb2vQysqW1TIy9a
 q7pO4lOxW5JJ0FiihNrfWPTECEPbLQdTlCuKAv6281QxJxsC82X06sJ1ABWEncBujjF9pRIxw
 LR4tQcGMdV72pQKluwc1MJ0jselMonPN+7+G/z3l5gw4q4wdRcFsN3ZRldGWwOvKu90ciPuvN
 WTAMY6sXIZTHz3FLFBDoSG34xrzj08xP/ft9WpHyKcm88FL1HStldSyPUSOuntbC2kMEkcMkt
 P+xYkKX470kVJJUpLwcwzVRULuBQy/e5JFYWLKC3GBZmWWVHYS3IOcYWy1Be40Qsnq7sDPkfU
 48jzvfeScAd88Hyb11t6h16Dtm8B39tkKs51M/SrGbQnOWgL7JR+ZKJ3NoZ283tLLuE6uj9+u
 cojdxFYEgdSDYO/taVjovqF3nhqNSmf5Jz7uZtGp/Dw1zitm+JjQ1dag+8URqKr3nXSLmKTac
 sLq20YRbaJsdo7nKiAVox27kwG1/0C8EM2PMlP/a3+B6Be4/60yO2G7mgqZyjALSd4EurARbh
 bCqt7VM0vI/4//uCfyhhrK4vm3xOpj3p/vATYkey320ZprrV8u89zSCxWbZvI+rlIPRdyVOwE
 NFUUDyx7HLejwMEA460uT5BC1GIo4lUQnJndHSyJpRC7pRoWf/GcPHGf5KDcFdWmnFeYO4vwk
 OxFXE12YxJWviBvqijPEf4iw==

> The ASPEED AST27XX interrupt controller(INTC) contain second level and
=E2=80=A6
                                                contains?

=E2=80=A6
in INTC1 asserted. There are 6 GIC interrupt number(#192~#197) used in
=E2=80=A6
                                             numbers?


Regards,
Markus

