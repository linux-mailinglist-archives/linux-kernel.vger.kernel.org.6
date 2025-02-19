Return-Path: <linux-kernel+bounces-521071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDC8A3B38A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FB1188FC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156B61C5F30;
	Wed, 19 Feb 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvrZMDgj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD21ADC99;
	Wed, 19 Feb 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953203; cv=none; b=HBgemYJ78wkIyP4i247KXArfPmtZNbPdMvTTWtTsfeJvk/ZjhJjsJpCBotNgaxThjchXy5o8b39mpfzcsix3Nl5B7s7Tx+lnpewSjz5j9xEsuGLRJ4zH7Qr7Y6Sn/OT58NMWdwdpVdHxeOlsAmldMUAnMKQrZJaV1lHk+V/VU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953203; c=relaxed/simple;
	bh=f9iAeR1IOQP8kmg5+b4WgQh9Utss7fF0baQU25zQRh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qrzm0JVPeqeeKVpu7mdkxSQrX6MKZLptoYCyaAbsHnk4q2VIQ5InV5Lt+wNrK07impT8svAErEGrGWKUqP3zh3C1l/EkN7d7Dvx0NLX+q6CIj4vi07oK7DOC3joB8+NFzkb703RtuQmeYQ1L0uCqiHy7uh74ctZrMU9rUWhkpvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvrZMDgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B645C4CED1;
	Wed, 19 Feb 2025 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953202;
	bh=f9iAeR1IOQP8kmg5+b4WgQh9Utss7fF0baQU25zQRh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvrZMDgjSl0CSSQCGL3t0GjL5zUupEtWr9dK6c23NVo/rvVZCUVL30qNdCqASRZa7
	 aE1WBn3Y4r9MWNRoufWG+X/u9Sh/F7jhuLG7B2jCFwAUoWTB99hXiHJWxAasKgIjef
	 ka30iRBL9WlsjV0NjiuA1sZQCrJvTZU5K3Y9YOX4Fk2aQbP69eBAy3wJpcmCdoo61B
	 xtGds4u6BQ5A5cvTVXkvQ4UwDTGxgv20yilzkbOUAnMWg5h3SRBiPoe1f1JGZA7W+W
	 CtMf7LPQNKV309/0Ifr7hzZGx2atLRAuilBn/VNVER91PRi+FvAeNZpQjgC0c7GI8F
	 ZeDx+f09/wUdw==
Date: Wed, 19 Feb 2025 09:19:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrei Simion <andrei.simion@microchip.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: dt-bindings: atmel-at91sam9g20ek: convert to
 json-schema
Message-ID: <20250219-strange-quizzical-peacock-eb077b@krzk-bin>
References: <20250219-sound-atmel-at91sam9g20ek-v3-1-d7c082af4e14@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219-sound-atmel-at91sam9g20ek-v3-1-d7c082af4e14@microchip.com>

On Wed, Feb 19, 2025 at 11:22:27AM +0530, Balakrishnan Sambath wrote:
> Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
> based json-schema.Change file name to match json-scheme naming.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
> Changes in v3:
> - Add recommended minItems and maxItems.
> - Fix commit subject and a typo in example.
> - Link to v2: https://lore.kernel.org/r/20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


