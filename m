Return-Path: <linux-kernel+bounces-428312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C789E0CB4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43FC16564A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9A1DE3C1;
	Mon,  2 Dec 2024 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UIHJ/hzX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F31DB540
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169692; cv=none; b=CtJ+7yQX3Egoih6OasbHtTs018uAngjfYhIlhXg2wKBy0TOyF85wRlqZVZAo7F4XePueM1cKXZMc6c76N8hwwbqB9SEexIkjEuDajf04Y0rqyOoDl2nchyF4KKKj2Tc9UsxGh8Xf29EWk662fIV71oqBb64yYlGE/BK1XeAm+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169692; c=relaxed/simple;
	bh=AcS9h9A8rhS7zBTPZQsgnAul4AOihkxYcdRYoDEwHuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cpg8h0oQlIy6NOKwqj11NArviCOfLgq6uugWmQnLaDhZZ4lONTqHZQPZiVfTp63GekmeLWHrnh3UAaoCMpyN5TCulzVVMwjGP3z8kzD8bReIH811cWituipmlQjAmOnfvI6yi6TE5LiII4lOHeNyLTBzaMRWKXhehH5knBalsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UIHJ/hzX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733169688;
	bh=AcS9h9A8rhS7zBTPZQsgnAul4AOihkxYcdRYoDEwHuQ=;
	h=From:Date:Subject:To:Cc:From;
	b=UIHJ/hzXSA65dcl7gpECngWh6Kxj5yyQWmrKTPHhbyigJW2R9mT+dyEah/IC4mpG0
	 yeql7GWzIHHthswYeo0TVyUIfJ67/RrOycoUTy3e8gcn7BJNwcE4Ui+KesOp3/mKzs
	 dwX1lU1rrCtzykx+LSxtMCG83mwGyHecTXCbQCpxUA8NWEQpZwzTWxPAhy5r126fM7
	 ZBHS/8Vx2Y2cxpIk5wiwrLIBCZvNRFVveNKhTNrzIpSd0R+McS7QWbbZw5iMXjQgxl
	 t1go9XUkAB9rooJPyZRKk+B8awPxTZ0Qe23tbazMQuSEQ93BCWfoCBBdOmRRGfW4PG
	 9+XnlmfRYmc7w==
Received: from localhost (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D44617E37DB;
	Mon,  2 Dec 2024 21:01:28 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 02 Dec 2024 22:00:57 +0200
Subject: [PATCH] arm64: defconfig: Enable Rockchip extensions for Synopsys
 DW HDMI QP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-dw-hdmi-qp-rk-defconfig-v1-1-38757fc053d0@collabora.com>
X-B4-Tracking: v=1; b=H4sIAPgRTmcC/x2MywqAIBAAf0X23EJKD+hXooO4ay2RmUIF0b8nX
 QbmMPNA5iScYVAPJD4lyx6K6EqBW2yYGYWKg6lNowuQLlxoEzwiphWJvduDlxmJdNs3fWs6a6H
 UMbGX+z+P0/t+xW2wGGkAAAA=
X-Change-ID: 20241202-dw-hdmi-qp-rk-defconfig-dd15747526aa
To: Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Enable Rockchip specific extensions for Synopsys DesignWare HDMI
Quad-Pixel (QP) driver.  This is needed to provide HDMI output support
for the boards based on RK3588 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e6158633f07c1f3532fba62f09b31e7448..286a386496014cf6d7d03d1efaa84ef4cffd57af 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -872,6 +872,7 @@ CONFIG_ROCKCHIP_VOP2=y
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
+CONFIG_ROCKCHIP_DW_HDMI_QP=y
 CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_ROCKCHIP_LVDS=y

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-dw-hdmi-qp-rk-defconfig-dd15747526aa


