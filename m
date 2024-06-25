Return-Path: <linux-kernel+bounces-228513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3B916114
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A42B211A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE069148312;
	Tue, 25 Jun 2024 08:26:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD11474A0;
	Tue, 25 Jun 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303964; cv=none; b=i+QwRJyOwmOnNKBtvEKk9I+G+iRzF0K59/bw9X2NDFrNgqzpUkd0RYY0aRqZw53dWvCZQmh+WrUXD/oAWYV9UUND+7PjCIE7Lg6nKDAqIp5IUfIVMqlI1MozD3F4PjxVP7GfnYlWXat8WoeAIQCTPFx8cnIDixEFPs85H+Ddrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303964; c=relaxed/simple;
	bh=IhF2vnbDM/lviRIVJxRhDDGl2xUCWqfNOeEkZeozmJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coxf8XUbyi9KRa/1s/ykOy/4nhtHOYT8YGOvmmMQ3fivsy+wqNAJ2Hp9ckTV6R6M1jj+F0rHu8YB6Y3iWrmhJz5RwIIGJQX3FmjMw8i4/IxDApwVr0iKhudnZ0rl+mVP+wm2BxspG/gZ5GDpxDgFQytcnwDtBH/ErYGmu+idbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sM1Ug-0003AJ-5E; Tue, 25 Jun 2024 10:25:38 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Jacobe Zang <jacobe.zang@wesion.com>
Cc: Nick Xie <nick@khadas.com>,
 "efectn@protonmail.com" <efectn@protonmail.com>,
 "jagan@edgeble.ai" <jagan@edgeble.ai>,
 "dsimic@manjaro.org" <dsimic@manjaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] arm64: dts: rockchip: Add USB-C to Khadas Edge 2
Date: Tue, 25 Jun 2024 10:25:37 +0200
Message-ID: <2403789.9XhxPE3A7Q@diego>
In-Reply-To:
 <TYZPR03MB700141F5448D61A000D588AB80D52@TYZPR03MB7001.apcprd03.prod.outlook.com>
References:
 <20240624083236.1401673-1-jacobe.zang@wesion.com>
 <6d8f80a0-d67a-416e-b395-7a33b539682e@kernel.org>
 <TYZPR03MB700141F5448D61A000D588AB80D52@TYZPR03MB7001.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 25. Juni 2024, 09:53:45 CEST schrieb Jacobe Zang:
> > Was it disabled anywhere?
> 
> This patch aims to enable the DRD function of Type-C port. So need to enable in DTS.

> +       usbc0: usb-typec@22 {
> +               compatible = "fcs,fusb302";
> +               reg = <0x22>;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <RK_PB5 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&usbc0_int>;
> +               vbus-supply = <&vbus5v0_typec>;
> +               status = "okay";

what Krzysztof means, is that the default for status is "okay". So for a
node you just added, you don't need a separate status="okay"

This is only needed if the node is added in a base dtsi (like soc
peripherals) which are then enabled on a per-board basis as needed.

So please just drop the status property from you fusb302 node.


Heiko



