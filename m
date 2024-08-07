Return-Path: <linux-kernel+bounces-277821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E894A6F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D881C20EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800421E3CB2;
	Wed,  7 Aug 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="1JLQb4vY"
Received: from pv50p00im-ztdg10022001.me.com (pv50p00im-ztdg10022001.me.com [17.58.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A01B9B49
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030038; cv=none; b=B1481AyeQv356XNoyYZfykvnoqf2fKus6e/Df0ob2pNdgHktnl6kPMDTQAeJ1n0/OBdq5pp6jquuXF2Dcd9ZBf5PMtkMOct2/DiNcodapKUuBe6+q0weIsM28msP6lCFI1J1XI7xFpUDf2XF7i9bQsIa+gRsHE5xYrhg31vkkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030038; c=relaxed/simple;
	bh=BC5G3mC/E/fQkj8sGiyIoN+g7KJtK2B5erQLVGhnfSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WUomI9PsYEoMDsjfmzDW13xKYH61mWcjiUFMQeYf0x0maUQWnK7DZnQlJFmxXPu83T489SF44/aMJQbo6iLw83I46YkLxPhZbth6mHQh0XOq+PbQSffWqLp3scnMGT5MNJD9O3vHo+CMI3/f+3poRkYCQoastmrFLRzy0Q1SPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=1JLQb4vY; arc=none smtp.client-ip=17.58.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723030037;
	bh=5ZmxY7UmQB1fdPfCLjMzQpERdF7rKPqNFy7nvgCNoBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=1JLQb4vYd9s7r+0yPygVTj1Rg2+/VP4kPeil2NC5ykV4CSy5xVvK1FrNROJiHe7Fl
	 ogsJqeKSvyIXeLgeg5J95Tq5u+ef/hKePXA+h0Gp9ogGhRQyZrD84era0uMYryPFXU
	 Hs1l6J/TrfCkJ+I8nJj/w5Y2KgYefwy/RtSe8bI19SmV+i+yBK8EwhmcwT/bGZ+1JK
	 VHn0HdRpUTESfox4pcvCehLbv/dYIzLaSwNs2CWF2zrSRnmc2gpaDzW0fnf4zFrBDB
	 0rurPhzRSlsWyTnwYs56IWernN5528apBdXM+VbK0SwxkZHPRCyuKLnWrcU4flTzGT
	 9QyRZuDrKdTPA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 0462C3E1E0D;
	Wed,  7 Aug 2024 11:27:13 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 07 Aug 2024 19:26:49 +0800
Subject: [PATCH] arm64: defconfig: Enable UHID as module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-uhid_arm64_defconfig-v1-1-4b8de59a2d5e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPhZs2YC/x3MTQqAIBBA4avErBMmk4quEhH+jDWLLJQiCO+et
 PwW772QKDIlGKsXIt2c+AgFTV2B3XRYSbArBolS4YC9uDZ2i457pxZH3h7B8yoUmobaDo0iCSU
 9I3l+/u005/wBbDoBZGYAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: QtaAuQR9L2PABageUBrxn08X9_WARQ8u
X-Proofpoint-GUID: QtaAuQR9L2PABageUBrxn08X9_WARQ8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_08,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1011 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=648 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2408070080
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Enable UHID as module to use Bluetooth mouse and keyboard.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d32fca64996..5607cb7fa580 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1043,6 +1043,7 @@ CONFIG_SND_SOC_LPASS_TX_MACRO=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD2=m
+CONFIG_UHID=m
 CONFIG_HID_MULTITOUCH=m
 CONFIG_I2C_HID_ACPI=m
 CONFIG_I2C_HID_OF=m

---
base-commit: d4560686726f7a357922f300fc81f5964be8df04
change-id: 20240807-uhid_arm64_defconfig-40b1e360b4e2

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


