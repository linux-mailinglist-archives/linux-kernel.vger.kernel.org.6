Return-Path: <linux-kernel+bounces-198030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D848D729A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8929D1F21BBD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F50850276;
	Sat,  1 Jun 2024 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="o+OpDDa6"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC14F8BB;
	Sat,  1 Jun 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717282511; cv=none; b=CosrY6yscPXOP+rh5XXcw7GEZy1UYtLCsFkVN/N4at+kurOIr8mCPkPjTgpgjIuUKZ6hwBw+3obXrk2AC7tbiUmxnflKnASCVN0Kx5KwhgJ+ebN1PSMy5OTujtrXIqyKlkmEWPOpF6hlC2WGsVq0texXpLahrRep/2uFOHGuNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717282511; c=relaxed/simple;
	bh=KAepm0zVeydI0pRgzEaYJ31b2FrM4Y1N1Yazuuth9OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8Dy11cx9BqK8UgdtN2cv3jPJ1FHRt72UoTMrZJQwU9HXhSydcoAuS/kTjre8eRw9T7Vetmm2zZWYLVobd+AKKzEBU2O0aQi1QcmPhTvuxbuxnuyzfybBbj+rLOPal5jrhA135EYRJpxNR7P+zUlmaXTEEB6zOKswdJDSoPzNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=o+OpDDa6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zE9JgmmMZ6U8BhzqjST5MxZKepiOun6rHIaYJ4bIKGY=; b=o+OpDDa6V4qYLJVC
	e4Lj8RsB7K+/fkfUTYprd9loTt4SjWBLUsDYUDmo6FsQ6gLw95ulAvqdt0cLsIgF3NKmOWL0rkuAN
	WXfUiZw6sW25qXbXVR5UD58vHd/bguts0aG6IuAtvsCc+nokfv+rIck+raKbb1t8H6jCstYIl0yrC
	wv7Wv6OASYEGUjWwQLE+bLli2nU/wKp8G7LYT/Y9w3XIHzDZeP/jSIRa+PY4LBnxozheqGbWszdcJ
	4GkjU+Iwrcla+2fQSkgi8ADhRrrBQAkUNjIDLPGJSwfjTP99oLYdITn1pvt6fHfU4NADvQ+W+Pbcb
	WS+nnupcsERleIsM6g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDXcs-003lZO-2V;
	Sat, 01 Jun 2024 22:55:03 +0000
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
Subject: [PATCH 2/3] ASoC: codecs: wm0010: remove unused struct 'wm0010_spi_msg'
Date: Sat,  1 Jun 2024 23:54:45 +0100
Message-ID: <20240601225446.183505-3-linux@treblig.org>
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

'wm0010_spi_msg' has been unused since the original
commit e3523e01869d ("ASoC: wm0010: Add initial wm0010 DSP driver").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 sound/soc/codecs/wm0010.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 8f862729a2ca..edd2cb185c42 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -115,14 +115,6 @@ struct wm0010_priv {
 	struct completion boot_completion;
 };
 
-struct wm0010_spi_msg {
-	struct spi_message m;
-	struct spi_transfer t;
-	u8 *tx_buf;
-	u8 *rx_buf;
-	size_t len;
-};
-
 static const struct snd_soc_dapm_widget wm0010_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("CLKIN",  SND_SOC_NOPM, 0, 0, NULL, 0),
 };
-- 
2.45.1


