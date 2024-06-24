Return-Path: <linux-kernel+bounces-227572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105691535A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C831F20CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274219E7DE;
	Mon, 24 Jun 2024 16:20:31 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261A19D8BB;
	Mon, 24 Jun 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246031; cv=none; b=Z6c+m8mkIFHRji9KMlRp8kTXnUk6GYTaVvsekkIeH0lvH8TJYpSfR9vHGKtv74F3YzEJsRHSgqJYKNV9hS/4SdD0/3bvybA+rajGFtkG8a9g8lcxrlVppFySmeiDEt/fhEu+KV9JfW4Ki5z+6fg2IZEw+q3vqnmT5DcWso2rLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246031; c=relaxed/simple;
	bh=RKCRIRXniq1aPuUFeyToJ5cqXZib9LZUEvgH2O0YBUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3z8+jxRRkGJshebTyDcG0jOFZwwKVfdZUWOZoYcxV1ZlhP+9sbezHQCkzxdBUVh5dSFStjGWm/9kEE62Vj1F9uoV1efEF47jIh7mw8oHfzLAw3YtcngJgcnxyS+2r4Ith1NpuABzsZGPEGxxNXYCB9InsrqPS08f7UCaZd6+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sLmQc-0001wn-KC; Mon, 24 Jun 2024 18:20:26 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
	Trevor Woerner <twoerner@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: add gpio-line-names to radxa-zero-3
Date: Mon, 24 Jun 2024 18:20:21 +0200
Message-Id: <171924573799.612064.9218736887561595244.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620013301.33653-1-twoerner@gmail.com>
References: <20240620013301.33653-1-twoerner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 19 Jun 2024 21:32:49 -0400, Trevor Woerner wrote:
> Add names to the pins of the general-purpose expansion header as given
> in the Radxa documentation[1] following the conventions in the kernel[2]
> to make it easier for users to correlate pins with functions when using
> utilities such as 'gpioinfo'.
> 
> [1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface
> [2] https://www.kernel.org/doc/Documentation/devicetree/bindings/gpio/gpio.txt
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add gpio-line-names to radxa-zero-3
      commit: f7c742cbe664ebdedc075945e75443683d1175f7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

