Return-Path: <linux-kernel+bounces-319579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B496FED1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EBA1F22B91
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D128E57D;
	Sat,  7 Sep 2024 00:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayJETFy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604FE571;
	Sat,  7 Sep 2024 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670555; cv=none; b=m6jelp0DNwv6j5IdUHKdSNBUodAsUJXn4b3tyMVPHbfJbG6y3dkpmnfQoJuHJYD6gQvUbUj01ak9aACWpZKMoHYmy7jmdIJ10YuFpiKODWP++AcAqq88DMz+rSzqSq8+sclabKpuI/yRzCclgZdt8iCc5OG+gDI4uWBgK0Gk+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670555; c=relaxed/simple;
	bh=nA9ahGD8KCtvlvbDt4nJtzFF7vCKqQHJVd+rW53TmJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iyc9nfYBKW9UWQIQfVUexOsMbKotetrrJyDCgrdVmMOXaT+Wedn04GHWB7orD0/4yJjy4BFfRzujf3U5ju+zymaA/CIc3150QRgMNNzqQmQDL3XtgjgSrBtS/SS2FdV3h88kYDXgLfaHqf3sEsH1DGVGrQ7v2wbAvI3RlHg9IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayJETFy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B490DC4CEC8;
	Sat,  7 Sep 2024 00:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725670555;
	bh=nA9ahGD8KCtvlvbDt4nJtzFF7vCKqQHJVd+rW53TmJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ayJETFy3oR0dj/YVoAdbPdMdTaPXt6OFwEabnelgP6jdlmYvD+r+YwAYAdwA3hSZt
	 /MpGtMM01zhUI+Gj3+EzGiK9jY7sn8ZkYoLak0Ulbg/sGIwpOu2fMMNYU6A+3lnDFl
	 nkUOiLty2yVVtpzuPzMsghsZ2qv0na0DXO4lPxk8+dEriNjEifPuY2NMkbAEBlpg3W
	 0bZWK0CsUAVlb9ONCFoU/AaKQhGL1jmXaKkFnzu3dnazKI0tBJy3ouW7idfxi0BKtm
	 APvXwXL9TJ+jS/2uhjEIIt5d/MGowtuGlzfK1LDP6xSuPOrn4CF2tRHFBuQKI9KqFe
	 IpHPqjOje0hHA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 07 Sep 2024 01:53:32 +0100
Subject: [PATCH 7/7] ASoC: mt8365: Allow build coverage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-asoc-fix-mt8365-build-v1-7-7ad0bac20161@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=745; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nA9ahGD8KCtvlvbDt4nJtzFF7vCKqQHJVd+rW53TmJw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm26SBashc9R8SRaPNLmRiHb9uf0L6Kfilp2Crr
 xwJesp/DgKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtukgQAKCRAk1otyXVSH
 0HNBCACC6/FARXYPWFGoDdvKChOmPaXipGUS4ZUgMv2zgpiLMUk3Rmjoh92TZAho+u88uJQZU0l
 DdMQMkr7n/GhGSDZ8nvNOsXOe6HJgCXIUrYg289RDlfTTDCd01DIjX6L8gmvQ/apVEBsYWwlSRW
 VXLE0ROKZgbFD+IdJL29AI5vcrDum/WYhG9AopQI2H0aIF0+t26jgOB90mm0qbpKOC2ioWRtbeT
 WDK8Ew8uTY1qF5AVL6HuVt7HgYEQOUzRu9w0yr/O/HA8u9tiGbxRz7UR2y7VRXDp+sskceBZctV
 Rm0Y0JFiCbcO4Qf8vsW6q1xRG5dEGu01CjVUPZb8nLBFTKJT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There is no build time dependency on anything specific to ARCH_MEDIATEK so
enable COMPILE_TEST builds.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index e6f7a5a49794..3033e2d3fe16 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -301,7 +301,7 @@ config SND_SOC_MT8195_MT6359
 
 config SND_SOC_MT8365
 	tristate "ASoC support for MediaTek MT8365 chip"
-	depends on ARCH_MEDIATEK
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select SND_SOC_MEDIATEK
 	help
 	  This adds ASoC platform driver support for MediaTek MT8365 chip

-- 
2.39.2


