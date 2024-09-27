Return-Path: <linux-kernel+bounces-341617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8098827D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDA5B228E6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A471891D2;
	Fri, 27 Sep 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dJykBayB"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE371BBBED;
	Fri, 27 Sep 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433065; cv=none; b=mKskoYa+m9tLqsMzlvE7lYIEPC4cCMGfViKrmTPHv7NKakR/IuIcqylnYqkWmPyehlB47ZTJxVQ8IcajWaFMS6jdRerdUzYm+lFhFV5tPkGEfNBsFJrggKrB7SmWT+V+kiycwhUxYDPQiWZSwnyt9ugGp9jQJLd9kOKERiFrTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433065; c=relaxed/simple;
	bh=YPZKp9WocsSeoEXdLKHKzk1hZ4WRNHhTwompXzvVqVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9PKZ89enX3IIEuioY3myz891lO7iVkwcJotx/ImkzgNKmIamwqhUgu8Nz7XQVfDZnTy67tOIDj8AN+OWvSxjmYVRYYO/lVocWHz6sQVTt+fSMBEfv1L0ZfLgJHGIXKJoK4d5+uYGeXXpnFUQTRaErgCURFrcspww/cYE1U+uxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dJykBayB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 95935d507cbb11ef8b96093e013ec31c-20240927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=h/LHB3ZMIqikyE3aOw6Fje4NJlQOFH8RU3i7QXhs1LQ=;
	b=dJykBayBELalyMMTTdLm7zNKyVO2NUlQqhmPQ9jbS5T7Q40RwRp6LtEa5Kz7y+lVog8baOfUbSgKxrhGT4Dt7HPDhHXE55R/JD4/6x6BES9LON6/7ZdLsM0Lo9fpZqKu7uWHBSwWvGjGdG+dKBNKCXKaRFcII+ZXRQMfAcgIWsk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:1eefb1e0-c1ff-4fa6-8b28-7756e98dc744,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:3c38aa9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 95935d507cbb11ef8b96093e013ec31c-20240927
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 279153103; Fri, 27 Sep 2024 18:30:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Sep 2024 18:30:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Sep 2024 18:30:56 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v2 5/6] soc: mediatek: mediatek-regulator-coupler: Support mt8188
Date: Fri, 27 Sep 2024 18:30:04 +0800
Message-ID: <20240927103005.17605-6-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240927103005.17605-1-pablo.sun@mediatek.com>
References: <20240927103005.17605-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.054600-8.000000
X-TMASE-MatchedRID: msJaThnkmNZayfMsaQo1Yu0yyL51qL/RoA9Le8XJpbpcKZwALwMGs5cF
	n+/+Esg7Ev0kmovGJccBtjkcfRMmqUfr6WG4Th9ayATMS/tDL5h9LQinZ4QefOYQ3zcXToXr+gt
	Hj7OwNO2OhzOa6g8KrQK0HCTribQWTnu6+Q9g++1ayR4tFJT475kkMxBaxnVVvPWAcMDQBWtqVT
	6JmZ7BwDqjXUZtJJR/TCQXVISdQxKZ5ahCeX/umsGQYFMiVRG5ehcPPz6UzEWlb5ogMngNpHOTE
	n5IiRSOady5RJQR05c=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.054600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3CB527BD4A245732867C341859077F95F8FB5A44F287851BAF02C0D236C39F702000:8
X-MTK: N

The Mali GPU in mt8188 also requires coupled power supplies,
that is, the "vsram" voltage should follow the "vgpu" voltage.
Therefore add the compatible to enable this coupling behavior.

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 drivers/soc/mediatek/mtk-regulator-coupler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/mediatek/mtk-regulator-coupler.c
index ad2ed42aa697..0b6a2884145e 100644
--- a/drivers/soc/mediatek/mtk-regulator-coupler.c
+++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
@@ -147,6 +147,7 @@ static int mediatek_regulator_coupler_init(void)
 {
 	if (!of_machine_is_compatible("mediatek,mt8183") &&
 	    !of_machine_is_compatible("mediatek,mt8186") &&
+	    !of_machine_is_compatible("mediatek,mt8188") &&
 	    !of_machine_is_compatible("mediatek,mt8192"))
 		return 0;
 
-- 
2.45.2


