Return-Path: <linux-kernel+bounces-173054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFD8BFAD6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BDC2862CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345A7D08F;
	Wed,  8 May 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QyeQ2Eo7"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB022089;
	Wed,  8 May 2024 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163808; cv=none; b=FTb/oWJCrAJiyw1Ln0/3txz+64JRxESJjfohRawZ4ExVF+cmJIJAfhj8VzT6bpLiar4dLMerxBciVoozAfNGOgQosWwaKE0G9zwDBr0oMDdVXzD1Xf7ntkMabSlNAz8cSpZF6wn3KUSzc+PSLspUVKPAXiLeOet3XvF1YH1XgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163808; c=relaxed/simple;
	bh=9u8e8s1R/YF6MXMjCBn6+TrL3a/2KyHI6/+JT09yEu0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LClugt0OTII95daBYfEcOeOfmjnexnUFJY/Gc2wiWkDqnQCbV8aBSaszIRjNK+AibvaUup18o4DswXehyFdAdATUxhPKzIz+6yH86+MP76qNyh9jXId+BNMqZETXC4hHRHtplsoTT37O9sZt/cpgT/RAK2ItRjYpznk2Ja3kE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QyeQ2Eo7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715163773; x=1715768573; i=markus.elfring@web.de;
	bh=9u8e8s1R/YF6MXMjCBn6+TrL3a/2KyHI6/+JT09yEu0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QyeQ2Eo7XFGASiZJxlq49RshFXFLs1Uw0vy/nCme8V6lxX18Bqkld/3LPql71Re6
	 JZQ82wg8O1Yj6uFop4cn4iaIxxKZTOMoXpQ49+c9L9JZdYw7aRpahBwEtoxW9Q8fo
	 2hZpNU5sCY7wRYg6j/N+S90E2xWCkBfCeUFhiBpsXmg+6PHDPKKFVv8Hn4k9Mv6Tc
	 A58CiPhnDq8o7vxMjRvJxStMPhnLJhAYzJmoe67bwX+qZWBWAB0Mc0GaVEwOpoYbE
	 TJIMLIuqjEMvt4CQ7rSZfM22M+QYs7BnyrshVsxRN8shHPjua+n/DAXFEQ0CNYAxG
	 C1CF9DNxzyIR1OuuZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjMO-1runbd23HI-00CIR6; Wed, 08
 May 2024 12:22:53 +0200
Message-ID: <662d3052-d0ab-4034-84d3-fff4f985875b@web.de>
Date: Wed, 8 May 2024 12:22:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240508070611.4153602-3-jonas@kwiboo.se>
Subject: Re: [PATCH v5 2/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240508070611.4153602-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FsK33dhQ+/BU0M0PjUpaQsMlcz5Garq5LIVOLVXlfoMnIbJyiOA
 WdEBFvyV6/bHKxib005lnuAyGPBx3RXAWxWLhOPJh0w9C8ZdOXl83uBPKinOrLh+BwiRmd+
 LlEMmnsS3AdrkHS1aZtUQXt4FP67Y9CoRKdDYf4ulGMDRfoC8+OoqEBNtNX10p//ECYnOJk
 lACFPbs1zkNDkR7Xui+7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sGs5kl6ytS8=;F4gMryC1X7nOoBR1b4G2CyVhvfp
 Tz1ybSjP4qqM8ZdG9HYzf7KlITPTQlcLCohaYkvskhcCnuia2MJFKy7bNQKvT0SjGEI+Afe9v
 wzv/H/bP1HWK04bEGyyi/iLf0N0REPPzfLcWx245ssTL9CrXV+eHmf1Is+rRLNU/CBSevl7dK
 9bAs97mEJl0k8yoX4XcV+a3IcxCDfL7UFO6pxGenU3YNDTGA87NeCSRshClF4bdBujrKRkMt4
 vFChGYBUqySsgdYleGWza+sbEuN9FXHC7WI3F7gZsgIj46Hv5I6UkNVwCbsit2WPZ+xDRXpCO
 M0NkDjjfEDnFAQtgFRRXBnNiz/nupPMmbA5aigUWhSOqV1fFRttUPPpgTi3Khv5Cl7c0uz4W6
 d2LpSfrvJvtN1psw4r0PcaAdnhxOMggtulyhJNfHfgCSRZUi7BkrIKQ2NoCa2/y1g736Mqb0J
 CkZPYwJtjthyyUm2sviIyNeypINZO3OXcspNJjrPZn//pdnUiZZaa7HhZWSvXo56OYnEg8YyI
 xVV6/OYIpv5va9WUadwuZMjFf0fCFw1B2KjES4kQiqCSIGyy3TQY7uLEDg9fc/WqEIF7U9F7z
 E3ujhvlK69Y5veMpK3I/N2nqIfxnvBnV9boUPdCXDeGoPa8tRI0eGLlG2KfanJT0XmwNDkyHg
 p3Pz9ecTH5ba+Ve4I1kjKBkUGzU7rjlu5hyly31AkSGc9i/Ran9wAjNuHoWjcaUsUaHMFvLh6
 xgKPsPAigFmcRUOLsCqQ5YkStl6i1qC1U8Bzd2tTOhvB1IURe+kVcyKHBhqpfUwNqdqZnJVDM
 68BsW15+pivFnjiAEoSQJqY3oBTi29N/zQnx3WocHPx9c=

=E2=80=A6
> This adds initial support for =E2=80=A6

Please convert this change description to an imperative wording.

Regards,
Markus

