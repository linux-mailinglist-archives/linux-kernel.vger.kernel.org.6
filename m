Return-Path: <linux-kernel+bounces-207090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844EE901244
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A33A2827F8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B701791F2;
	Sat,  8 Jun 2024 15:17:27 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604EA17C68;
	Sat,  8 Jun 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717859846; cv=none; b=D0G57JzxmkbYb4DU3tzXihr0Prh9LULtSEabdPzvwcIRvPG4H8o95Ta1MQ1mo/lZkSaBYoBS1dbNOF2vJtiCI92BudYomX2CWfqIoHZqV51G+iRkLrYc2+yMUGXbBOHuGj6LD/7e6WwxbPTpEJvUP0hMzxBsJKDASRWhywPzo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717859846; c=relaxed/simple;
	bh=mzZfbhNXvd2YP2Js2RMQRMZOB+YFoEeeaoZ+25727J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6HapUaXvThcMx38Bisrf6VX5ts+o5ClU8dnyZTR0s9E+C2kVd3SNDo7YG/Ju6zkuZKkV1wU0afo5h/O82TjLMZg4ylj4IHyiY+lawkjcstzlt96LSlDdiDQ8RafJ7t3DL+MxhNkr++LQViaS4K6Oq+vDyzvmaIlVWHhxiwP23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sFxon-0000Ur-8O; Sat, 08 Jun 2024 17:17:21 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Add RK3128's sound nodes
Date: Sat,  8 Jun 2024 17:17:18 +0200
Message-Id: <171785983007.2839639.9120766327861589006.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506155103.206592-1-knaerzche@gmail.com>
References: <20240506155103.206592-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 6 May 2024 17:51:01 +0200, Alex Bee wrote:
> RK3128 has two I2S, and one S/PDIF controller. They are already supported
> by the drivers and covered by the bindings. All it needs to make use of
> them is exposing them in the SoC device tree.
> 
> Alex Bee (2):
>   ARM: dts: rockchip: Add i2s nodes for RK3128
>   ARM: dts: rockchip: Add spdif node for RK3128
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: rockchip: Add i2s nodes for RK3128
      commit: 760e49dc6cee85994f7ece74f7145887ea7b64ca
[2/2] ARM: dts: rockchip: Add spdif node for RK3128
      commit: a6b661c2a38a92b7de826f74e57596fe33fe17fa

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

