Return-Path: <linux-kernel+bounces-319575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8896FECD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F61C2207C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65C8BE0;
	Sat,  7 Sep 2024 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o847oYZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5C1B7E9;
	Sat,  7 Sep 2024 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670544; cv=none; b=NyfqHw5g8nEY2oKsv0HQwZkskDgj0rOOJerVRWE865XhTMoDRuhB6uEGX6lphK6SnaZCcltx4LJOdCBEGfRQSQwFVFQXrP+Bd6ifyYnrkeYeqa3f0X/ja1O3KAKaQjhDfGhUY3iP20l+cq2+x/k7iZtif/QCCVRY/gc3yvUt8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670544; c=relaxed/simple;
	bh=hVRqy/YIqXha3+LEl7UForQK+FCn9cErocX8XXm3AKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFMhGg/wB98YeHbBExSk/3qZbqn0J2YMS9N2BdyAYLyDSLBLq1QC7AQgv0HbnDXFY97LPb10MbvuAZ7fYekLRWbjw5xEejVX/j8fYs9/Z+onQNIOWq7k9Ptm6YC+YuPR6RHwzccjYqZaqeux/1Rt7omIzO3bCUzkBie03eGt3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o847oYZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF96C4CEC4;
	Sat,  7 Sep 2024 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725670543;
	bh=hVRqy/YIqXha3+LEl7UForQK+FCn9cErocX8XXm3AKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o847oYZWd7bYXkrO1HkLBhr+TlIVBzWfFXa4UWPcLjK4iCjkdMCK47gPKpQwSvn+s
	 8HwefoWa2/rlUG6GHo7nFI/dsEHqZIQ08+rFIZnhUutSmUFZeIEqnWh+l4X1oCzXsl
	 RZixxkkxRscQOlj9QX8DO9RW/ZZ6ZWbc54bQaBVpFNZEb37zqlyEZuVEmkex0oUWQO
	 XJo9AlDlLr7pbVjLMnai3Gejzu5osrGL7HuXYoh14JkR6rrKX/Mf2wlG32YvQLBJ04
	 tsEomX6ggOIdte8O8uKEvna8XYrw42biWB5xmZqTCyIyId3+Sg2NORZKl4YHzj/7TD
	 9saAWIhTgrxMA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 07 Sep 2024 01:53:28 +0100
Subject: [PATCH 3/7] ASoC: mt8365: Remove unused prototype for
 mt8365_afe_clk_group_48k()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-asoc-fix-mt8365-build-v1-3-7ad0bac20161@kernel.org>
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hVRqy/YIqXha3+LEl7UForQK+FCn9cErocX8XXm3AKo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm26R+ODYn9QHBhO3Jkdnki3jclFXaxvYiwoG+8
 QyvUQtzqjKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtukfgAKCRAk1otyXVSH
 0CmqB/9Ts6+nuGtv/dpT+wN/BSZumRSYevRraXg/+TUAeyiDK+2w1k7FPwdO3wPbLxngyt8I3fM
 gsxul/IKy+2d8AzfEw5V7jvbWpNMZGYYwi6NCKdJttHZpJOqA9Hyyrzurf1EI1RqCgteUhvKqln
 DQ+gNovUMRS3caTw+Y3SY06Pe8e9k6C5g37teJRGt1eVxZeyYOxMdhPe2LorkEJKNot9lAicimk
 x01FN96AC2gNPACvKzkI/NT8R/gs+OFqAEgqyWDXUi/mNDiihOlz1qwCpRxTqwBPKIWWtZ7Rvcf
 j48gzPDBihukvOJq59RhGjMWx6NZ8jdIwP5zvhswyP58orjg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The function is not used outside of the file it is defined and the
equivalent function for 44.1kHz is not prototyped so remove the prototype
for this function.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8365/mt8365-afe-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-common.h b/sound/soc/mediatek/mt8365/mt8365-afe-common.h
index 1fa87e54a57f..731406e15ac7 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-common.h
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-common.h
@@ -421,7 +421,6 @@ static inline u32 AutoRstThLo(unsigned int fs)
 	}
 }
 
-bool mt8365_afe_clk_group_48k(int sample_rate);
 bool mt8365_afe_rate_supported(unsigned int rate, unsigned int id);
 bool mt8365_afe_channel_supported(unsigned int channel, unsigned int id);
 

-- 
2.39.2


