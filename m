Return-Path: <linux-kernel+bounces-523987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CA8A3DDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D499B7AC3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70051FDE08;
	Thu, 20 Feb 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DwHMrhft"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8626FB9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063766; cv=none; b=eFHk0kUk6vFun9hjOk272g6NR2MUvPU7sERUPrmzwlgVkBUHQjBx+Dau4mLN7o15nTotTjhWtv1yjQe45GFEIRi+/B08381dbt6QSZSslJVH2i0Awnc2ge2QiTbIKPT7YsbIUe9vE8hB8U2WQbpItJTcfUi23gSJnAMwk2OuCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063766; c=relaxed/simple;
	bh=rck6B72os/DWioFHMOmH67JN8LqxpYdTERiLlS+nlTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fkhNF8s3EBnBoqMZroVETISX/PUy7h+jk1VZUcjfd4kHcqSxBFZeQhoiWf4Ftym9lV5JUTVw+oF88zlKDj7IBA0XByR8x/+9m7d5VhRY0anrZAABMDVuMtIsLng7ZrlFkvnX+I1FFsCtFM+NyhPy0lj+MC47KYko54T/uCkzh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DwHMrhft; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740063756;
	bh=rck6B72os/DWioFHMOmH67JN8LqxpYdTERiLlS+nlTw=;
	h=From:Date:Subject:To:Cc:From;
	b=DwHMrhftva+2vJ3zQamsc79qDX+CINE6HLPpu75s0Z8Zr7NRsl26Qw7l35PPVaxBG
	 1yKXd+e5cHoKyNtKoRK0wLG+FAUqto69/oYX3nAtxKTm9lwg6/Mvl6qDjBsnOF/i4+
	 KAsNZEKYuxQuom0f1ixxiQBCnOzbxmVKJtFJ8En+v14m9KcePBgdvU5r3HAWxHOwtj
	 /mbSZo1XMf31/MpidFckD/z5LJSlTvZkrarx5PhqU3iPMitZaovj6V73unDHhTNkTz
	 X/EwrWwv+Y8o4L+HPhPAH4QqtNRasaKRnirN9HJD/BRYwijzoI/mi36nu7WZMnq3I2
	 IuObWD5cgelbw==
Received: from yukiji.home (lfbn-tou-1-1147-231.w90-76.abo.wanadoo.fr [90.76.208.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE1D617E1557;
	Thu, 20 Feb 2025 16:02:35 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 20 Feb 2025 16:02:09 +0100
Subject: [PATCH] soc: mediatek: mtk-socinfo: Add extra entry for
 MT8395AV/ZA Genio 1200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mtk-socinfo-genio-1200-evk-v1-1-a683ad028bc5@collabora.com>
X-B4-Tracking: v=1; b=H4sIAPBDt2cC/zWNQQqDMBAAvxL23IVkobX4leJBk9UukqRNogji3
 xsqHmcOMztkTsIZWrVD4lWyxFDB3BTYdx8mRnGVgTTdNZFGX2bM0UoYI04cJKIhrZHXGRtDw8M
 9yVljoAY+iUfZ/vFXd3Li71If5ZQw9JnRRu+ltCrwVvD6QHccPx8glG2dAAAA
X-Change-ID: 20250220-mtk-socinfo-genio-1200-evk-712b6d82dc11
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740063755; l=1266;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=rck6B72os/DWioFHMOmH67JN8LqxpYdTERiLlS+nlTw=;
 b=utlvnCOJj4zzso5Z1dtj4zu9mvNrVqF9Y9tC6p7GZPke22xBquuAUlGIEX64Egw4QHjvotDls
 QV9FKciTZt+BrkX9eRTaSRNb9HAbgk9j8XmwsYUtVtvbyPFpkEaen42
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The Mediatek Genio 1200 EVK P1V2 board has a different socinfo match
for MT8395 SoC (commercial name Genio 1200), so add it the driver.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/soc/mediatek/mtk-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index a15d8f854cefa90883377b47bbc16a7072ee21cd..fbaf82a6e14c31d447f7725c82b306ff055e1c7d 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -59,6 +59,7 @@ static struct socinfo_data socinfo_data_table[] = {
 	MTK_SOCINFO_ENTRY("MT8370", "MT8370AV/AZA", "Genio 510", 0x83700000, 0x00000081),
 	MTK_SOCINFO_ENTRY("MT8390", "MT8390AV/AZA", "Genio 700", 0x83900000, 0x00000080),
 	MTK_SOCINFO_ENTRY("MT8395", "MT8395AV/ZA", "Genio 1200", 0x83950100, CELL_NOT_USED),
+	MTK_SOCINFO_ENTRY("MT8395", "MT8395AV/ZA", "Genio 1200", 0x83950800, CELL_NOT_USED),
 };
 
 static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socinfop)

---
base-commit: 964b0ceed00032fa0fa841fd61e5f315880a2d36
change-id: 20250220-mtk-socinfo-genio-1200-evk-712b6d82dc11

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


