Return-Path: <linux-kernel+bounces-431601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0750E9E40A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41F3B61278
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55420E014;
	Wed,  4 Dec 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnTVeGA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B6C20C485;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328394; cv=none; b=GTDm1O6/IS/wSXXabEZO2IttJiUMAg+3QWRbpr2LVbm3mKTh/yZcB2ILEYXr+gRkgBJkG1Eu2WaWmc8Vmu7Xc/V2kIz5LIqlC8ibXUs8i34gM399Zuj4aKgvb0yWI7D0e1SCDUA1zt+1D0BVRCGji1jWM08gOPLDWVu2DdSoXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328394; c=relaxed/simple;
	bh=9TaGX6HffgIlLj9EAnKA1F6OunD1In0MqPvuPOMdWXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLh+DVTwrY7scoI11zIYiM4ae5aI4ZG6lDoZnw/YoUWVlrtCMRsXleXtzh6qDAxrwrPztJP4qUJoDnQJZgNagpuXDRyUq0w8xv4JOozAwbqjK3NEKadjK/eGFRFIZQsrxLRjOdqFRp0gVDHyhX7lo5GL+7FlOvYifG9b/QpD0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnTVeGA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A7C0C4CEE6;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733328394;
	bh=9TaGX6HffgIlLj9EAnKA1F6OunD1In0MqPvuPOMdWXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AnTVeGA0A6liJtCNIb9Hf3VZOUxRJvBYCS5i9F9Ndy3tUPgliLORfJf+jRtDSq84+
	 vt0HezbZJH7g7gBZxdU1r7ad+x+IyTG5wJ/OV+4pin2MikG/cx1kB49cDwVquqIZq6
	 mO3obxNWSx9M7rfk1LC+s9QZivgHOwnCgA9aKrvKOCLW2mdCZnoluZc02NfKMROonm
	 PHv/U5LUtkowAC+lQNoyS810kz/fKf1JQvkype6jSnEU9u6M+5T9A6HWs9mJ7n2Ezj
	 u5xiA1IWbZPdySbDNmzkBSoCHRBVSkwuwfv3bL9vv9+WTMUF5tPPWMYNanaxCo50G6
	 CO7PsGA/mSBCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE10E7716D;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
From: Nikolaos Pasaloukos via B4 Relay <devnull+nikolaos.pasaloukos.blaize.com@kernel.org>
Date: Wed, 04 Dec 2024 16:05:28 +0000
Subject: [PATCH v5 5/6] arm64: defconfig: Enable Blaize BLZP1600 platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-blaize-blzp1600_init_board_support-v5-5-b642bcc49307@blaize.com>
References: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
In-Reply-To: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733328392; l=754;
 i=nikolaos.pasaloukos@blaize.com; s=20241111; h=from:subject:message-id;
 bh=p64eXXaIQjoPOizS0+i1yI0HfKEd6m8yRHyu9K+W+GE=;
 b=xiq+hGJ+bcWw9onTf2uX5rlzKc+E1DAv8+JHh2rcSL/LF3Oc1dtqsHetuoJ932y4rTYThe8Fn
 rIPtAh8dlLZB3H2WKbc3Znaeet/Fc4TWBTSF3E21T/UXhTtbp5us5MH
X-Developer-Key: i=nikolaos.pasaloukos@blaize.com; a=ed25519;
 pk=gGEjGCXdSuvCJPIiu0p0UeiPcW5LC710Z6KGN/dzo3g=
X-Endpoint-Received: by B4 Relay for
 nikolaos.pasaloukos@blaize.com/20241111 with auth_id=274
X-Original-From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reply-To: nikolaos.pasaloukos@blaize.com

From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>

Enable ARCH_BLAIZE to support the BLZP1600 SoC and the CB2
development board.

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b295c4569f34773394ffe6eda778e9..4921669f89ae0a89e0c1489a2a4359be9698e5a2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -44,6 +44,7 @@ CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
+CONFIG_ARCH_BLAIZE=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_SPARX5=y
 CONFIG_ARCH_K3=y

-- 
2.43.0



