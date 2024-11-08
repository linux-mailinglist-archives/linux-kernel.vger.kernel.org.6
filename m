Return-Path: <linux-kernel+bounces-401737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 697119C1E89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDFB1F2182C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9371F1319;
	Fri,  8 Nov 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JyHI0Kv9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CHvPSIXd"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55741F76A1;
	Fri,  8 Nov 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073822; cv=none; b=kfty/X8xaOI3yPSGqulLKgBWxS5SMdPkx7r37P5xLfsp5JP3SzgNWMJRuU5A9YiJI6gdZW+Tk7ZO6RzId7+GJ/NqQWnrKW7yeSRmIyefGFgEuPsKZIcbC/PPvPrgvRlMH4+xztL4t+QVdCSuBgEzmO90vc3idc9KkROnzbnXsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073822; c=relaxed/simple;
	bh=TMa0wJKMpEP3WaxVuer4rn8P/ed73jLZRY9xj/JF0Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cl8giLT6FQe2kRU/p6DFOO6lkRjOC6BabKf4n7kDtSDBpO/6JCMRkla7wp+8YS+RWfYuR+GVVg03YG5hp/DRtSq22xHmqVVoLBXUmbN1fAo3iv/G2qxfXS23hHX4lqx21T4hgn/YfEvaWO2w+Fkw+epvUV4t1mKdgUeKrm0jy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JyHI0Kv9; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CHvPSIXd reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731073820; x=1762609820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bm+b8lS1YuE0pHFzyn7pTVq208oic1NcidTGM3qudeI=;
  b=JyHI0Kv9JK73Y02A4wrxxcG9CAJzpCCoxGTOCDYug6rMeOV+H9DV0vPw
   GDfuDSxgrM5Y+k1yIbIHqbUBX9GDEo+Cnrv7jYS/zNFskOz0lU0Tb4RM3
   0sP3+4pc2XfLNkef3klJujf4CSUiCfAj1kmNZQU1GaujT8ujO8EGnxVLE
   FbNLVUwNGpf7eYEGuMai0lU5kPO2ToMMvTkRN6pmNqYiYH/4RvdKAzQju
   623eJak4C2hn2SnExfePUpkBAjAkU3TTtA/0stK6jTyIWPnsh0LsJOU6I
   kSVCYqY9Hi34QDbPluGTNSTxXWVQb+HFru+k0RSD1Kka0Tdv9zXKnYZdA
   Q==;
X-CSE-ConnectionGUID: QfpBNxdrRm2QT6CN6AVLAA==
X-CSE-MsgGUID: xSks1VbqTKueiERFL+35Eg==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39936937"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 14:50:19 +0100
X-CheckPoint: {672E171B-12-1E10F2A5-CC0651E5}
X-MAIL-CPID: 21C40C5C7855FCB289C7E0CFE8DC1B20_4
X-Control-Analysis: str=0001.0A682F18.672E171B.006D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2439B1655C7;
	Fri,  8 Nov 2024 14:50:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731073814; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bm+b8lS1YuE0pHFzyn7pTVq208oic1NcidTGM3qudeI=;
	b=CHvPSIXd6yPKILCsPovot29FuRkCuxO4s7NqYeDbZC0jkl1CqemKWVcDQ6IP02VXvxSmxT
	8Lxlzb0lQEqs3pUcaTyILEaWPeJ2NfPNrOi7NrYnJg4calqyheuL7Y2mfKGhf1V6gqoopj
	ATl3BPanNquXydECDzhPVgoDvlvjxHp70OcflpXwu5mx+qT7LDUq0qJX0tjAb2KmGN7KZo
	iJ45LPrt/ZEc7F+f5HZ+RyWNTRqv+x91TBuz7kgi1MQifgNYcXoRKsf+LnElz2EFTc2QwT
	E+cAN4jIxvHmKe+5gUokd2f7dJ00cYtD1CZzH2Ue0ug/hs6oJJs6HR5PI50W/Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] ARM: imx_v6_v7_defconfig: enable JC42 for TQMa7x
Date: Fri,  8 Nov 2024 14:49:26 +0100
Message-Id: <20241108134926.1324626-9-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

TQMa7x uses an JC42 compatible temperature sensor. Enable the
corresponding driver.


Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0beecdde55f58..5bd07f8dc031c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -230,6 +230,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_JC42=m
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_PWM_FAN=y
 CONFIG_SENSORS_SY7636A=y
-- 
2.34.1


