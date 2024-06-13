Return-Path: <linux-kernel+bounces-212775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39056906625
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72441F21D50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844A13CFB3;
	Thu, 13 Jun 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="ee9gToqd"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60113C9C9;
	Thu, 13 Jun 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265915; cv=none; b=kLUb3XWic4f4Va893UTW0IdzWK2WI/hT3dhPwZhbq+LQF28jJkm+foh/3UMXI3sRX0GSvX+Ad0Own9igXm2yos9rzqTKptBrbfJQr4CRGK2j+PcvDLWjTB/XtsgBoIRTgaUVnmhgfGMKAEmzQLOshfwrEW177ttjEFdgJbjER+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265915; c=relaxed/simple;
	bh=S8VcF/L2K/w7wsP6obeStA3rZgZWLCfwav/f2zcpirI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T5LtAzsB6o+ox1f3xsQY8JMOSexg/SWbLBrtm2T15JmpxVQhctTZ4pfAxXyXm3fhP/Ej5z/x/9zxA0q7w+mcm5jxjQju7cQm2Vx4BQPpsgzy32hCqWcXmmCVzSYwFQMtWYNLsvdasuXBhZ7uAxcPkDimuEh9ZB9Ic2drrIIz2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=ee9gToqd; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B77AFF6DC;
	Thu, 13 Jun 2024 11:04:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1718265900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=0x6Lf8u26vaxcMPY+X+v/MAprWib4Z0FqDNje+Z8SZY=;
	b=ee9gToqdWu7qYI3kUArtkDHNcCLOAtf2AOGZ+oYMK9gL+dgFBGWeHMjDcibj3ppEquiOFT
	OpQKnCT2qExvZ1Imm33tSHJEYtOaWQ/f7VhlfUupxXuihFPPQTbo6tJjUax0K+L80oYkPw
	T03UZsPy4jjAefvZBJcm/gg7cy797P9Ggqs6fJ7kiDM6RNMA61uQmG54zQuoYbRzWZWwFj
	sf2Xyq0yCu6oKm+9QBnbDzu+xfah2yJrNBDGczRnb9Wj8jWey369/nfQFOeXVUuW+yAI8/
	k3r5npg01UNeMN1dWZI34dKD0g2sTd8yaEzGCgUgIdBG8B/KsFF03LM81DW9Kg==
Message-ID: <e3a8cd0f-7bf2-42e0-9b41-9665686ee4ce@lexina.in>
Date: Thu, 13 Jun 2024 11:04:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] arm64: meson: add support for JetHome JetHub D2
From: Viacheslav <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org
References: <20240607145148.2246990-1-adeep@lexina.in>
Content-Language: en-US, ru-RU
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20240607145148.2246990-1-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

This series can be skipped, I will send a updated version.

07/06/2024 17.50, Viacheslav Bocharov wrote:
> Add support for new controller.
> JetHome Jethub D2 (j200) is a home automation controller with the following
> features:
>    - DIN Rail Mounting
>    - Amlogic S905X3 (ARM Cortex-A55) quad-core
>    - micro-HDMI video out
>    - 4GB LPDDR4
>    - 32GB eMMC flash
>    - 1 x USB 2.0
>    - 1 x 10/100/1000Mbps ethernet
>    - two module slots for radio/wire interface cards
>    - 2 x gpio LEDS
>    - 1 x 1-Wire
>    - 1 x RS-485
>    - 3 x dry contact digital GPIO inputs
>    - 2 x relay GPIO outputs
>    - DC 9-36V power source with battery UPS on board option
> 
> Viacheslav Bocharov (2):
>    dt-bindings: arm: amlogic: add binding for JetHome JetHub D2
>    arm64: dts: meson-axg: add support for JetHome JetHub D2 (j200)
> 
>   .../devicetree/bindings/arm/amlogic.yaml      |   1 +
>   arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>   .../amlogic/meson-sm1-jethome-jethub-j200.dts | 614 ++++++++++++++++++
>   3 files changed, 616 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dts
> 
> 
> base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58

