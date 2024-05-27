Return-Path: <linux-kernel+bounces-191496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3628D1053
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08880B21E42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE581167D98;
	Mon, 27 May 2024 22:42:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ECB13FFC;
	Mon, 27 May 2024 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849749; cv=none; b=Dc+u+414iQiYexTkigQht41nxizUKU6f1MLNUekHx6X/KIMl8M7wS18j29d2gCRDKZsj8lGuNY1Amf0gSoc6upnQM2oxdJgB2AaPoUUXuesLILULMSdMAv4uQi+sgJX6ix1OqGFrJnzsc4T8PJB9XjaCX6qve5SfRf7RcSTG70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849749; c=relaxed/simple;
	bh=9oVBIegLmVNuS26BY/YHHtHrR6ycL2Y2OsU7tLbHygA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byMTIouwpXOcYgFpe26Uf7I8ZtMVN3IxWd5UDh9/AVjK892v3PjELhW9h5CT/YjRIFnjq7SRjKX3l9ZKFSRMJCudY4FS0KTaqD/Htq7PG0VkmDKjH3PyxuYw+anhsf9jV/IM6wPMlN2X0ppKPTl6pWxAhgQMLrxPxfG+88Gwcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193d.versanet.de ([94.134.25.61] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBj2q-0005Os-U1; Tue, 28 May 2024 00:42:20 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 00/13] rockchip: Fixes and improvements for ROCK Pi S
Date: Tue, 28 May 2024 00:42:16 +0200
Message-Id: <171684956152.1783037.15483261423757153532.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521211029.1236094-1-jonas@kwiboo.se>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 21:10:03 +0000, Jonas Karlman wrote:
> This series include fixes for DT schema validation, fixes and improve
> support for onboard features of the Radxa ROCK Pi S board.
> 
> Patch 1-2 fixes DT schema validation of ethernet and audio codec.
> 
> Patch 3 fixes use of onboard SD NAND and eMMC.
> 
> [...]

Applied, thanks!

[02/13] arm64: dts: rockchip: rk3308: Fix codec@ff560000 reset-names
        commit: cb1622df6a28e3eac34a8b95feba2dd2dc6cd887
[03/13] arm64: dts: rockchip: rk3308-rock-pi-s: Fix SD NAND and eMMC init
        commit: 1fb98c855ccd7bc7f50c7a9626fbb8440454760b
[04/13] arm64: dts: rockchip: rk3308-rock-pi-s: Add sdmmc related properties
        commit: fc0daeccc384233eadfa9d5ddbd00159653c6bdc
[05/13] arm64: dts: rockchip: rk3308-rock-pi-s: Add pinctrl for UART0
        commit: 7affb86ef62581e3475ce3e0a7640da1f2ee29f8
[06/13] arm64: dts: rockchip: rk3308-rock-pi-s: Rename LED related pinctrl nodes
        commit: d2a52f678883fe4bc00bca89366b1ba504750abf
[07/13] arm64: dts: rockchip: rk3308-rock-pi-s: Add mdio and ethernet-phy nodes
        commit: 4b64ed510ed946a4e4ca6d51d6512bf5361f6a04
[08/13] arm64: dts: rockchip: Add OTP device node for RK3308
        commit: 36d3bbc8cdbef2f83391f7708888265ac4c37a99
[09/13] dt-bindings: power: rockchip: Document RK3308 IO voltage domains
        commit: 579e5b476307797b3a1260bec544dbbabcce1de5
[10/13] soc: rockchip: io-domain: Add RK3308 IO voltage domains
        commit: 0536fa6e6fa3e48f4ca11855b586c277be524fbe
[11/13] arm64: dts: rockchip: Add RK3308 IO voltage domains
        commit: d1829ba469d5743734e37d59fece73e3668ab084
[12/13] arm64: dts: rockchip: rk3308-rock-pi-s: Enable the io-domains node
        commit: 100b3bdee6035192f6d4a1847970fe004bb505fb
[13/13] arm64: dts: rockchip: rk3308-rock-pi-s: Update WIFi/BT related nodes
        commit: 12c3ec878cbe3709782e85b88124abecc3bb8617

I've split this up slightly.
Some patches for 6.10 as fixes, and the rest for 6.11 .
Edited patch7 (for 6.11) to apply without patch6 (6.10)
That disappears during a merge of those branches.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

