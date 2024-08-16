Return-Path: <linux-kernel+bounces-290225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C443E9550F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740AC2842C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D871C37A1;
	Fri, 16 Aug 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netc.fr header.i=@netc.fr header.b="dbZPqTeH"
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F74328FF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.182.54.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833530; cv=none; b=S5jDgiOPLpZCcSYnbAiCITazeOUgohrONFtQNqOPugGPOvSU+BCJyeF9xT73qbqFRULLLCv+MQBwImbxJyI7tNMz3YXIFG/RzU16RZmejA15MdUDSZ6L+ooyXpPWVWAAoIdpqtWQIr+BaJQVI1hkYUPWL7rQsDdtu01rmQb+62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833530; c=relaxed/simple;
	bh=w2zNACUIGRSA2xy3BFISwYbfbac4NgwJSaNaM5z6h4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQbIVb/hfJ6SCSRHXYo/+hcXHfxsV0zoXSv7O3ZOHrCYHyF6WrGlMVf4u34OS29zSbVrv7TMzcKRH2RoULwBw6An3aBfjOpfz1wEVgTizw3c2g40XiWgKxPqvvdVxyi85T9+ItoWjHSc3QrmiNsxotQEyv4q6DzEPwuR0KynXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=netc.fr; spf=pass smtp.mailfrom=netc.fr; dkim=pass (1024-bit key) header.d=netc.fr header.i=@netc.fr header.b=dbZPqTeH; arc=none smtp.client-ip=213.182.54.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=netc.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netc.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=netc.fr; s=mailo;
	t=1723833510; bh=w2zNACUIGRSA2xy3BFISwYbfbac4NgwJSaNaM5z6h4Q=;
	h=X-EA-Auth:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=dbZPqTeHyWNL9zZ5ILjxdDaNj0aJg/56H1ZcdjHwaQv4RwIZDJ/rLpCIbWAkdDQK9
	 T7lYAfsgS2BWStdGbd65AzfvWV5xMc1rcvsoNptQ6eUKfxJS/IW/LpqoEat9KxJLUL
	 sd0z7ZkjVZXF0Rp9TiSelvBcEe8zFyQnslAb99ag=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Fri, 16 Aug 2024 20:38:30 +0200 (CEST)
X-EA-Auth: rFYSvjmkmKT6XOrqsjpK0F8VIEGSasceXmh6AWftftw6WYGlQHukrVVnXifgq9RxT1W3ruhPwgjP8xux6C1cAjqHKUSYRUf4VGRcbFMhcC5jKR7+JVc7kg==
From: =?UTF-8?q?Guillaume=20Lef=C3=A8vre-Crim=C3=A9?= <guillaume.lefevre.crime@netc.fr>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	guillaume.lefevre.crime@netc.fr
Subject: [PATCH] staging: rtl8723bs: add spaces arround operators
Date: Fri, 16 Aug 2024 20:37:32 +0200
Message-ID: <20240816183756.59250-1-guillaume.lefevre.crime@netc.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.
Reported by checkpath :
CHECK: spaces preferred around that '&' (ctx:VxV)

Signed-off-by: Guillaume Lefèvre-Crimé <guillaume.lefevre.crime@netc.fr>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 54 +++++++++++-----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index eb848f9bbf2c..89acb6f290cc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -38,7 +38,7 @@ Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
 	if (fakeEfuseBank == 0)
 		*Value = fakeEfuseContent[Offset];
 	else
-		*Value = fakeBTEfuseContent[fakeEfuseBank-1][Offset];
+		*Value = fakeBTEfuseContent[fakeEfuseBank - 1][Offset];
 	return true;
 }
 
@@ -50,7 +50,7 @@ Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
 	if (fakeEfuseBank == 0)
 		fakeEfuseContent[Offset] = Value;
 	else
-		fakeBTEfuseContent[fakeEfuseBank-1][Offset] = Value;
+		fakeBTEfuseContent[fakeEfuseBank - 1][Offset] = Value;
 	return true;
 }
 
@@ -206,21 +206,21 @@ u16		Address)
 	if (Address < contentLen) {/* E-fuse 512Byte */
 		/* Write E-fuse Register address bit0~7 */
 		temp = Address & 0xFF;
-		rtw_write8(Adapter, EFUSE_CTRL+1, temp);
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+2);
+		rtw_write8(Adapter, EFUSE_CTRL + 1, temp);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 2);
 		/* Write E-fuse Register address bit8~9 */
 		temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
-		rtw_write8(Adapter, EFUSE_CTRL+2, temp);
+		rtw_write8(Adapter, EFUSE_CTRL + 2, temp);
 
 		/* Write 0x30[31]= 0 */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 		temp = Bytetemp & 0x7F;
-		rtw_write8(Adapter, EFUSE_CTRL+3, temp);
+		rtw_write8(Adapter, EFUSE_CTRL + 3, temp);
 
 		/* Wait Write-ready (0x30[31]= 1) */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 		while (!(Bytetemp & 0x80)) {
-			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 			k++;
 			if (k == 1000)
 				break;
@@ -253,16 +253,16 @@ bool		bPseudoTest)
 
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
-	rtw_write8(padapter, EFUSE_CTRL+1, (u8)(addr&0xff));
-	rtw_write8(padapter, EFUSE_CTRL+2, ((u8)((addr>>8) & 0x03)) |
-	(rtw_read8(padapter, EFUSE_CTRL+2)&0xFC));
+	rtw_write8(padapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
+	rtw_write8(padapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
+	(rtw_read8(padapter, EFUSE_CTRL + 2) & 0xFC));
 
 	/* rtw_write8(padapter, EFUSE_CTRL+3,  0x72); read cmd */
 	/* Write bit 32 0 */
-	readbyte = rtw_read8(padapter, EFUSE_CTRL+3);
-	rtw_write8(padapter, EFUSE_CTRL+3, (readbyte & 0x7f));
+	readbyte = rtw_read8(padapter, EFUSE_CTRL + 3);
+	rtw_write8(padapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
 
-	while (!(0x80 & rtw_read8(padapter, EFUSE_CTRL+3)) && (tmpidx < 1000)) {
+	while (!(0x80 & rtw_read8(padapter, EFUSE_CTRL + 3)) && (tmpidx < 1000)) {
 		mdelay(1);
 		tmpidx++;
 	}
@@ -293,9 +293,9 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 
 
 	efuseValue = rtw_read32(padapter, EFUSE_CTRL);
-	efuseValue |= (BIT21|BIT31);
+	efuseValue |= (BIT21 | BIT31);
 	efuseValue &= ~(0x3FFFF);
-	efuseValue |= ((addr<<8 | data) & 0x3FFFF);
+	efuseValue |= ((addr << 8 | data) & 0x3FFFF);
 
 
 	/*  <20130227, Kordan> 8192E MP chip A-cut had better not set 0x34[11] until B-Cut. */
@@ -304,9 +304,9 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
 	/* PHY_SetMacReg(padapter, 0x34, BIT11, 1); */
 	rtw_write16(padapter, 0x34, rtw_read16(padapter, 0x34) | (BIT11));
-	rtw_write32(padapter, EFUSE_CTRL, 0x90600000|((addr<<8 | data)));
+	rtw_write32(padapter, EFUSE_CTRL, 0x90600000 | ((addr << 8 | data)));
 
-	while ((0x80 &  rtw_read8(padapter, EFUSE_CTRL+3)) && (tmpidx < 100)) {
+	while ((0x80 &  rtw_read8(padapter, EFUSE_CTRL + 3)) && (tmpidx < 100)) {
 		mdelay(1);
 		tmpidx++;
 	}
@@ -365,19 +365,19 @@ efuse_WordEnableDataRead(u8 word_en,
 						u8 *sourdata,
 						u8 *targetdata)
 {
-	if (!(word_en&BIT(0))) {
+	if (!(word_en & BIT(0))) {
 		targetdata[0] = sourdata[0];
 		targetdata[1] = sourdata[1];
 	}
-	if (!(word_en&BIT(1))) {
+	if (!(word_en & BIT(1))) {
 		targetdata[2] = sourdata[2];
 		targetdata[3] = sourdata[3];
 	}
-	if (!(word_en&BIT(2))) {
+	if (!(word_en & BIT(2))) {
 		targetdata[4] = sourdata[4];
 		targetdata[5] = sourdata[5];
 	}
-	if (!(word_en&BIT(3))) {
+	if (!(word_en & BIT(3))) {
 		targetdata[6] = sourdata[6];
 		targetdata[7] = sourdata[7];
 	}
@@ -463,7 +463,7 @@ static void efuse_ShadowRead2Byte(struct adapter *padapter, u16 Offset, u16 *Val
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
 	*Value = pEEPROM->efuse_eeprom_data[Offset];
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+1]<<8;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
 
 }	/*  EFUSE_ShadowRead2Byte */
 
@@ -473,9 +473,9 @@ static void efuse_ShadowRead4Byte(struct adapter *padapter, u16 Offset, u32 *Val
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
 	*Value = pEEPROM->efuse_eeprom_data[Offset];
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+1]<<8;
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+2]<<16;
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+3]<<24;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 2] << 16;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 3] << 24;
 
 }	/*  efuse_ShadowRead4Byte */
 
-- 
2.46.0




