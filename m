Return-Path: <linux-kernel+bounces-346941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1698CB41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236691F24908
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627DD433C8;
	Wed,  2 Oct 2024 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H3J20J/m"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FEA3FB30;
	Wed,  2 Oct 2024 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835733; cv=none; b=XsdfVlPkOlyXHKUitK9QYupVILgkVuQEMNHxzXosLq4SFcEgqJa8MggWhPHusJHTjlUS0umPhk6KV2pzceMHXviCceTNqrxXTrk48qnQmlOCXTaVtlB//xl+7b25gWaQgKjKFmoFZUTktASVJ1n4iqkJ7BL0he1tayVw8rzETiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835733; c=relaxed/simple;
	bh=VqtVrQsHwesxv3hmrZ8mQZzK5TVTWF6zGF7sdoZybDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQqYnddR27wyK5TcNjOGY2IJhuevIdeamqJHoxFMYBlN1dTkMYHiIdr9fujp8eOS649NHkln3mTQDk6J9hv1uB5A7LisLno8ZGNXzJvQOHrI7Khx71SPbfAA7eUwoeN8/bUornpTvAHz9A6aqYfpdpL6uwPZ2/YztqVn9fIO/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H3J20J/m; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1cffe0a4806511ef8b96093e013ec31c-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uXDTZKQhfk21UUd3VE8Tq7H+6jBjm8HTj+j3cutpv7Q=;
	b=H3J20J/m3SGUv9XwyaT0eaeqpO9P/Z87recyAt8sgCYfAdTRHRu25FHNVSJ2NZFJQ06iD6NZZVw33D4ZNicwmp29OYABxk64uTLAzeGSRM5OQXAkZebSWiCCd3a5nmeJmVECWhjCxd3BMTPPVFY09sjFeY5gBK6NxSpJx6/k9JM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:95f7403a-10c7-4cf8-bbbe-a842361168a5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:3295a6ed-33c7-4396-bf34-2026ee4f15f5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1cffe0a4806511ef8b96093e013ec31c-20241002
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1925705061; Wed, 02 Oct 2024 10:22:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 10:22:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 10:22:02 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v3 5/6] soc: mediatek: mediatek-regulator-coupler: Support mt8188
Date: Wed, 2 Oct 2024 10:21:37 +0800
Message-ID: <20241002022138.29241-6-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241002022138.29241-1-pablo.sun@mediatek.com>
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

The Mali GPU in mt8188 also requires coupled power supplies,
that is, the "vsram" voltage should follow the "vgpu" voltage.
Therefore add the compatible to enable this coupling behavior.

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


