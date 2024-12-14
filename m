Return-Path: <linux-kernel+bounces-445985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2579F1E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B791657D4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB1D18C900;
	Sat, 14 Dec 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Z/kOiL9v"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB346FC3;
	Sat, 14 Dec 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734173954; cv=none; b=a7YDOS0bBzuOre9UFokEpfeS4PTCfnGLV8vzwvZsow5bmaLIkijZo8QXBxwaZ2HBszv+bbvshSbbbIadiLrJIPNevPKCM9vCi97HJP80uN66/3+ag7CW5lggK0n8kRWPyPNYlPT4+dS0XErXZ00XwxDNYGw78iAgRCc+SPtL3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734173954; c=relaxed/simple;
	bh=Fc+Lga2kQfa2YAlyz+vyYBKOGMxD36mkXbUX58pDbVM=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=rL3JxzkcnoQEtEj+GbEWOt4j+BLOOaJZGnR6NSpO5oPm07OMEirq+G5hIjV+RypyzzY9DCiNjfeGNUjgi5mOnDOdCQJHkhWIpLqY6v7Euq7+D5d5JXOh0Nbt0JN7PCl7pqbf4s7ayTLHeHfhESqfz9zhgHBI5RfEUuJsasY9/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Z/kOiL9v; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id MPqRtIIgS9R0DMPqRtEvE3; Sat, 14 Dec 2024 11:58:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734173880;
	bh=GTL9bVXcbcNLOf+AXiFXrUqoNsGjOwxtvB4CnPvP7/M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Z/kOiL9vFy9kKFyycch6jgd3EyGewsfDt814DGCxzPVRMnQzjt5CrDglgkNDhlN3v
	 cj9MF9R9uW3PRZwJ/uRLm/LJ7QwZFd3DIaBpSomIdKHCNSR7kpTFM7IOxQBwYJoEXB
	 Q/yAb/ujFrVU6f6G8oKeIFZbKlTo0qSRjr4TIB16q9Cxw3Mwm4wad/HleYXJMrMQ+T
	 sztjgxrGDkpzyt1TVwh7Jnn0mAj1Jkiw5dkD0OUw7FDnVcWMo61kGU0x161cEPqL/a
	 QEm/uPMC5Q+2OTj/UbBwvZJ9TwoshS4fYESMTq0f9ALBQcMjW3M7m/HCtulLoDNQac
	 wUBmZiNjOnFQA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 14 Dec 2024 11:58:00 +0100
X-ME-IP: 90.11.132.44
Message-ID: <689b1095-0dfe-4204-843d-5a7c23213aad@wanadoo.fr>
Date: Sat, 14 Dec 2024 11:57:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] regulator: pf9453: add PMIC PF9453 support
References: <20241213-pf9453-v3-0-5587c1693155@nxp.com>
 <20241213-pf9453-v3-2-5587c1693155@nxp.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
In-Reply-To: <20241213-pf9453-v3-2-5587c1693155@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 13/12/2024 à 21:46, Frank Li a écrit :
> From: Joy Zou <joy.zou-3arQi8VN3Tc@public.gmane.org>
> 
> Support new PMIC PF9453, which is totally difference with PCA9450. So
> create new file for it.
> 
> The PF9453 is a single chip Power Management IC (PMIC) specifically
> designed for i.MX 91 processor. It provides power supply solutions for IoT
> (Internet of Things), smart appliance, and portable applications where size
> and efficiency are critical. The device provides four high efficiency
> step-down regulators, three LDOs, one 400 mA load switch and 32.768 kHz
> crystal oscillator driver.

...

> +/* PF9453_REG_BUCK2_CTRL bits */
> +#define BUCK2_RAMP_MASK			GENMASK(7, 4)

This was 0xC0 in previous patch, so GENMASK(7, 6) if I'm correct.
Which one is the good one?

(the datasheet I've found does not give any details, so I can't check)

> +#define BUCK2_RAMP_25MV			0x0
> +#define BUCK2_RAMP_12P5MV		0x1
> +#define BUCK2_RAMP_6P25MV		0x2
> +#define BUCK2_RAMP_3P125MV		0x3

...

> +/* PF9453_REG_LDO2_VOLT bits */
> +#define LDO2_EN_MASK			GENMASK(1, 0)
> +#define LDO2OUT_MASK			GENMASK(6, 0)
> +
> +/* PF9453_REG_LDOSNVS_VOLT bits */
> +#define LDOSNVS_EN_MASK			0x1

GENMASK(0, 0) to be consistent?

> +#define LDOSNVSCFG1_MASK		GENMASK(6, 0)
> +
> +/* PF9453_REG_IRQ bits */
> +#define IRQ_RSVD			0x80
> +#define IRQ_RSTB			0x40
> +#define IRQ_ONKEY			0x20
> +#define IRQ_RESETKEY			0x10
> +#define IRQ_VR_FLT1			0x08
> +#define IRQ_LOWVSYS			0x04
> +#define IRQ_THERM_100			0x02
> +#define IRQ_THERM_80			0x01
> +
> +/* PF9453_REG_RESET_CTRL bits */
> +#define WDOG_B_CFG_MASK			GENMASK(7, 4)

This was 0xC0 in previous patch, so GENMASK(7, 6) if I'm correct.
Which one is the good one?

> +#define WDOG_B_CFG_NONE			0x00
> +#define WDOG_B_CFG_WARM			0x40
> +#define WDOG_B_CFG_COLD			0x80

...

CJ

