Return-Path: <linux-kernel+bounces-334636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BA97D9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7578E2823A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CBF184543;
	Fri, 20 Sep 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="L++UoExS"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195CE14F98
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860988; cv=none; b=FvT6hOKVdBLmdnBUGE+fNj2XDcAojVp+AQRci6X7dSuq7Z/ki0Qd0dvxJ0wp6cYNfJDGsFJJr7ZaEKaDnsCivOks2Va0A0Ow3SHju4AAKrqhrasg+1m22Y1u2NWRuFN2HsN6DlK9+reF0w67VlnMkOOUh2LLXwSgOcubcqDIUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860988; c=relaxed/simple;
	bh=2ZbALmhC8fX4fHPsJCAlysl4Jr6F1MGYZRq6c1VZa30=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0FAos/6ow8j3dmhj/mQlDYEwhRNsxff7UySSi8hyY6gVAilUFfKedVPku7ohY86DUDu72hUVZom+qDn2knp4sf+rZ1Qdo0+qOOH20QwLpGJiNUFfyecYRo6NZcNcnl5QxQmfFq2THnsglEJ45zNxrjUuiJ0qRbEwvFBjzLbhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=L++UoExS; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726860985; x=1727120185;
	bh=nfKnzlGWcwkXSNpRuWNcXocA9IW8poU5gYJng2B05R0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L++UoExSRkTKmmfWtByI/7rw6GoJS5eaPWruHeIRMky/FXIGZp5W6LKI1Riz/Sht+
	 R5HPE3ZTnpeoq21uOOD88fhO0AjyktEJjiSulroz+MDibrKePFMYv6SwfmyaAyGKGb
	 gNXX9KW/kX52Ly3om/voj7BNy2q0XP5SjYCMM9G3Jx4OMhgy2vnPKlnDmS3uHVvy3l
	 hQsHHFKHCqlU68/BJzd1SjfMlePyXXTOqAuYif1GoOavk+s233aApudPImmOl0cA+E
	 ryMRiioiFvYe+o1uLyV65lMkrw4TwhytdmX4C1tM9PA9xSj0tNulIOIgpbnMk577EJ
	 Uoi9HHBWJBytA==
Date: Fri, 20 Sep 2024 19:36:20 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 1/6] staging: rtl8192e: r8190P_rtl8256.c: Fix alignment to open parentheses
Message-ID: <20240920193356.32156-2-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 8094afcc5c1aac72bd9e5944c302608a037ea4c8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch aligns the code to open parentheses to improve readability.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/s=
taging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 7061f1cf4d3a..d909f5c4fd21 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -101,12 +101,9 @@ bool rtl92e_config_rf(struct net_device *dev)
 =09=09RF3_Final_Value =3D 0;
 =09=09while (RF3_Final_Value !=3D RegValueToBeCheck &&
 =09=09       RetryTimes !=3D 0) {
-=09=09=09ret =3D rtl92e_config_rf_path(dev,
-=09=09=09=09=09=09(enum rf90_radio_path)eRFPath);
-=09=09=09RF3_Final_Value =3D rtl92e_get_rf_reg(dev,
-=09=09=09=09=09=09(enum rf90_radio_path)eRFPath,
-=09=09=09=09=09=09RegOffSetToBeCheck,
-=09=09=09=09=09=09bMask12Bits);
+=09=09=09ret =3D rtl92e_config_rf_path(dev, (enum rf90_radio_path)eRFPath)=
;
+=09=09=09RF3_Final_Value =3D rtl92e_get_rf_reg(dev, (enum rf90_radio_path)=
eRFPath,
+=09=09=09=09=09=09=09    RegOffSetToBeCheck, bMask12Bits);
 =09=09=09RetryTimes--;
 =09=09}
=20
--=20
2.34.1



