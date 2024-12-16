Return-Path: <linux-kernel+bounces-448042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C29F3A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8712118894F6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496320D4F2;
	Mon, 16 Dec 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f4w6lpbC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960120CCF8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378701; cv=none; b=bxMWXj5z3XJwcr3slWOLFY+iPWaQnGl1EbWXOapvoOBEFAJTU6C9hIIjM9OqdOPwSvF1mtEenflVrbov8L2AOpJyS+/sOhvbIaYl6ob4vShUUYKc59DvjCzlTgiKZ6/gSTM0bO/svkRJWFcVpBaZ2qHjts1A7hbtNnhNEP7BbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378701; c=relaxed/simple;
	bh=W0KQp3kLhOJuY8Z4Rr+UL5TieURM0dQvz/b45ukAcyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eU5LQ2HHP974J9Fs3Wzd0kUIVxMSNj1kEpmTDriOo8rN1goHHlZS9gyrcLEJsV2TysiLWOWwHSHvObDn4ayyhfncseZrumZk06bWhdjl303yT6Iromagz81StYllvoLy2VMUfMPOw5viArxb1JkauhR6Rm5OYZ96OiToWJ3Wl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f4w6lpbC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734378698;
	bh=W0KQp3kLhOJuY8Z4Rr+UL5TieURM0dQvz/b45ukAcyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f4w6lpbCnstfXz53vnc5ntyf0J5+RtJ39qxOCaRzhpVcQewQy9qOGQF7bEBX9lA3V
	 e5Bla/3q4HDuPSx5Mx2OWdHoUA79s7Uhlbea3gQ0bcKcy3LNb/jF1reXeFSu3fa4aY
	 KQe4jmGdy5qfV4X+0URa382VURJ76Fr5LFSCRltvDzseFqyde4DZXIq5+B1S4nYnph
	 FndvyhkcMuL/CUWV/Z/UjltFtVjH69rn2oSfqQC503uYD0ESAymJxwIocFKgjUM5Qe
	 4uj+MNtjJ6yJr2up92i6X/1j36RKjSyiMY2+PFOYmxAUmxLuzsh8/IIDYlwNmYUR/9
	 RgUBHLfs27xNg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 64AC317E3804;
	Mon, 16 Dec 2024 20:51:34 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 16 Dec 2024 16:51:26 -0300
Subject: [PATCH 2/2] arm64: defconfig: Enable MediaTek DWMAC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-genio700-configs-eth-sound-v1-2-04a719035d6e@collabora.com>
References: <20241216-genio700-configs-eth-sound-v1-0-04a719035d6e@collabora.com>
In-Reply-To: <20241216-genio700-configs-eth-sound-v1-0-04a719035d6e@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Enable the config for the DWMAC MediaTek glue layer to allow usage of
the Ethernet controller present on MT8195 and MT8188 SoCs.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 95af0377ddc673be7003d7517e3990012a817cbe..188a0f3faedc62d92d0d59a397570e4c88c3f803 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -375,6 +375,7 @@ CONFIG_SMSC911X=y
 CONFIG_SNI_AVE=y
 CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
+CONFIG_DWMAC_MEDIATEK=m
 CONFIG_DWMAC_TEGRA=m
 CONFIG_TI_K3_AM65_CPSW_NUSS=y
 CONFIG_TI_ICSSG_PRUETH=m

-- 
2.47.1


