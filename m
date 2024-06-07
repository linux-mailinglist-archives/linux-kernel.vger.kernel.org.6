Return-Path: <linux-kernel+bounces-206810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472D900E10
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E0F286B02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3D155724;
	Fri,  7 Jun 2024 22:29:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264A13DDDE;
	Fri,  7 Jun 2024 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799351; cv=none; b=H0uddCk6I0lodIbPCuHQstafC7TpzgoTf/ew+AiDPoe+8uc24XYQZUL/upTzLSINbnvNWXvIVrhJ+HC2XlQYadkP4ZTzjV3gDC6B5Ud8kSVe8dc7mEQ3nUIfx7q107lbAoau5bdC6wiyvauL+9Rbv0FjpL/6VnaOdiajY/pxwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799351; c=relaxed/simple;
	bh=V3HQbZ3wuv5zYhd30+NdTvy5VMSJaBLXWQp47NLHwwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0MPruwvHGF+JvmtHR2WaUfv0mHoWy5rszUTkXsh1OhSzTFpbwbnhPTfbRAABfJBp0M13NRRT2u+uyKrJ086voWdY/O+fpA8PQQYzhkvtqJSZvtJvufm8joaJtjGadqUAtvN0mOL4hhV/Io/HoyxvzYLVwInMKgTJFYmFzi7m9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b65.versanet.de ([83.135.91.101] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sFi4u-0007Lq-Mp; Sat, 08 Jun 2024 00:28:56 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alex Bee <knaerzche@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Alex Bee <knaerzche@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
Date: Sat, 08 Jun 2024 00:28:55 +0200
Message-ID: <2004624.2IRrRt1zHL@diego>
In-Reply-To: <20240606143401.32454-4-knaerzche@gmail.com>
References:
 <20240606143401.32454-2-knaerzche@gmail.com>
 <20240606143401.32454-4-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 6. Juni 2024, 16:33:59 CEST schrieb Alex Bee:
> CLK_NR_CLKS should not be part of the binding. Let's drop it, since
> the kernel code no longer uses it either.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Just carrying over an Ack, in v2 [0] Connor provided an

Acked-by: Conor Dooley <conor.dooley@microchip.com>


[0] https://lore.kernel.org/all/20240607-dealer-vertebrae-9b22db3dc43b@spud/




