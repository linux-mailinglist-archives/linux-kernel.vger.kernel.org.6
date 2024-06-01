Return-Path: <linux-kernel+bounces-198029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748728D7299
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A02B1F21657
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915443AB4;
	Sat,  1 Jun 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BVJQbnfu"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0B2E419;
	Sat,  1 Jun 2024 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717282506; cv=none; b=nIBZGAB8AP1BQlLtdl8Jxfhepod0EyHnLIIPjdmHLTnJpYngpNBdBdzJdQ4Ym9lPHLZ7soqGAYc44i5vn5aQXPxYnOxp9BL095t5d9l/I3UDJGMUrX7/zPGKELVk7q0vBVZ5X5gqzCBkdh1AA9M+8zt1ZQ10vrsjZCyVgCjjWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717282506; c=relaxed/simple;
	bh=QNSY4tvFcnrlWXrOTixpAfH09s2dQhFqt9qlP90Pgn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQ0p2ZJz9unUpHVYvj+8qYNjlpdg/rhMtX9PVnw8+xnuUJ77K7iNdRecMtCUBpIJbwaRQsBsvgs4BsoKH8fBdU1EStLyAQXJml+lZoSnHcndksC/QvEjthRu/gx9SxaKur3/VvMOmeStW1moPUC6hqrROxG4MjY/qYgOc42MEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BVJQbnfu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=nRcJIf+1327Ly+8LDkevCngx/XaoRpszZ7qr61eLFfc=; b=BVJQbnfuGe4AuHf6
	DISGYwh+D3iB6Qa86StIXGTcZz9+C6KZ5ByH6m59t9S0hHGldBISDeRItuLzRsJnZ4oUSeR75pfK3
	FQhOGYosMfk6zKa5kg0V/s9+FISubLFU9krYl4M1roZS+DzCnWSM0E4x+qPoNDjavoPZMmxhrPDXu
	jHcru5r6J3A8RU6y7FSh6cfV0l5YU0dwT1mHlxnMkKDpP/NgTYSAL29VJmYedBNoj+/XkcZHfUMcs
	hndVPpO82Kx4PH+Cwpiv1JCEgkdHY7qa3rdgSOSUIgzX0m2VM80I0Nc4WZBJK4r57Fe320RWRQ0wE
	2V92mpyopI+RXvwMmg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDXcn-003lZO-1h;
	Sat, 01 Jun 2024 22:54:58 +0000
From: linux@treblig.org
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] ASoC: codecs: lpass-rx-macro: remove unused struct 'rx_macro_reg_mask_val'
Date: Sat,  1 Jun 2024 23:54:44 +0100
Message-ID: <20240601225446.183505-2-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601225446.183505-1-linux@treblig.org>
References: <20240601225446.183505-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'rx_macro_reg_mask_val' is unused since the original
commit af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for
lpass rx macro").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index f35187d69cac..dfb7e4c69683 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -463,12 +463,6 @@ static const struct comp_coeff_val comp_coeff_table[HPH_MODE_MAX][COMP_MAX_COEFF
 	},
 };
 
-struct rx_macro_reg_mask_val {
-	u16 reg;
-	u8 mask;
-	u8 val;
-};
-
 enum {
 	INTERP_HPHL,
 	INTERP_HPHR,
-- 
2.45.1


