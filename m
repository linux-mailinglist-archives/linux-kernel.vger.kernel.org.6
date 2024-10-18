Return-Path: <linux-kernel+bounces-370858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F509A32F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA01F21D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3403A1509AF;
	Fri, 18 Oct 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IX4xvaGu"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D31E493;
	Fri, 18 Oct 2024 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218996; cv=none; b=b9Gvz/Hq9c88QUd2L8oP7E+RiOTKr4AaY1T0MwLIvtYR4N10/t9TV/sD6S3KKLthBA/J4kuuRQhoZTdHGp5TFld1mhk/6srCtQT6aiIyoEvE6VmZ+iXDc/rj+VXwCNUDX9FtibiXQ9dZMsReRZoS+YkVRcO3fZwoGKe0hB3jRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218996; c=relaxed/simple;
	bh=o4Kvfn12XX9NrpP6BrQaJS81tIY3gNv+op7HG9DmURI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsp7+WyA8wnQfHgWurNhABMwgp0riH0qumaECNMIMdEeGJmyZ9RqZ2Fgo9Y/HwxtCaEgKawiSr+Kdp522AURDHUFCzEN3a+3cMJe7dkKlWe+r+/mgN+E43GilW9a8xLKakjeozWB+f5GewvhhzAFwNxOkGh8Q3nA5+Zc1lbClw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IX4xvaGu; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729218910;
	bh=BjRaaSai2G2iHtrp/+Culq3SNsWU3WArJjBOYoHBSfA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IX4xvaGu7g/6jfZcs1EY9tu5DIZ47ZVliB2UejRZmwxKmGbo1zj+oGWT5EzUSQ/Yx
	 KllTkMqvsv6XJL8ZthTjJaou/H1yguX6OwGDMjCHNHElceeDkas1OWTVn9lN6TW/CB
	 GwkHTfhq9+icQIhKxq2zQaDsIYE/GdK6XOUduwSc=
X-QQ-mid: bizesmtpsz12t1729218826t6acsk
X-QQ-Originating-IP: XOMl48OX9mOYQrkXy+on8GCDlffWlqK1JaGusn6AxQg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Oct 2024 10:33:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5756514911803189014
From: WangYuli <wangyuli@uniontech.com>
To: robh@kernel.org,
	saravanak@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	horms@kernel.org
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	philippe.schenker@toradex.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] arm64: dts: colibri-imx8x: Fix typo "rewritting"
Date: Fri, 18 Oct 2024 10:33:40 +0800
Message-ID: <45F06B5D4CA9F444+20241018023340.47617-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MAN6sKHDZ5xSlIm/IoCzRDR8U8XHQDZ53um0gdNanQ4xQMWm2wR+Rl9j
	ewnN/Ls69vbkp8T3Tt3/SFUW8YepSH0bTsomlRHO9m2UHzySfxy5XsL+ghtiXKOwGW1+tBl
	sJXNUCQfdwjyM5BmrmhsbtwAqMmbgAjIaUe39i8cSIkCmjAsidMl1LsO4qGmwghwGZyiI5F
	nDUdX6YQpxc/SCloYSPU61kAppA08ECkswYWXX3JEBtqJAc+54S7tw+vTO2kidFjd42sBZm
	cX/Qx7g5u6Zc3OZblLt0PKYAW2zahTuwiBr0tC9rvAT3iawiuXhnL3X2Vq+jn6zuWdKhWwW
	CxZnBW0ShN6a/aeC4YUUmpb8RO1bCRWiglWrmcK22QNvLGrmenDhVKizV98pWwCtHXW/f74
	irgwcrdltFmnaw4CbUMcb5/IBWLVwCqkj++LGn2d+vQkT/Mj4cijqCmK7C+lWEg+rRulZ5U
	jiOLXcJfCgAG/4ZLO7OriQhv7LN/TEuCz8Gg51YZq0RnFesurxRn7ssAImfjPbGlkNgtl/i
	QkpgH6bWX6gYROOTqlcpXaGIujMsqkoVTuTmjrqQOzptosqJzg/4Qv6E2f2HxtVrPLIdilL
	fFluBuWO0hXWpErk7XVV+gGDYQOv/1LsCE1B8q65+OvD0TtARnV4vvXneS87E5OvAGRLA0j
	/5FyXAXYLORnQYcjnEOqeGOq7O2+A5mtga/Gblm6zviJp2lDkxsbQbzSPQYsR2OlVA2H9uY
	xw9cjbTiOJhxsjQ9r3RD4WBiLIfgjyDStKtzZyws4KwFnZ1ptihF2KyhSlXyYDtMyfS5QwM
	LngLst8qcUw21+CQ0EtVm9u9KYlj/jru2ruUPjw0sZYn4sIC7hJWLe5lZxCGHU8BwyjrlZj
	Tmnt3vfGeogCb2Kmo3QJYW+0ouqAASOYG/NHW7q1BpnkeZpYqY2Kdm5O8nmU181tzKmaf38
	G4Q2n0dMhgAxtPzgmR6Kddsd/811pBzDF3CiBdxkYswvsvwxU/1z+PrHqdC+oC2HP04Q=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'rewritting' in comments which
should be 'rewriting'.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index edba5b582414..425ab37c01ea 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -698,7 +698,7 @@ pinctrl_hog2: hog2grp {
 
 	/*
 	 * This pin is used in the SCFW as a UART. Using it from
-	 * Linux would require rewritting the SCFW board file.
+	 * Linux would require rewriting the SCFW board file.
 	 */
 	pinctrl_hog_scfw: hogscfwgrp {
 		fsl,pins = <IMX8QXP_SCU_GPIO0_00_LSIO_GPIO2_IO03		0x20>;		/* SODIMM 144 */
-- 
2.45.2


