Return-Path: <linux-kernel+bounces-198031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F38D729B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71771C20AD8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A23B5674A;
	Sat,  1 Jun 2024 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jc4cgg1t"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6C537F8;
	Sat,  1 Jun 2024 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717282515; cv=none; b=e6jikervz3bGJvAhrKLuIj4NDnuhLP/YO+lOG62fukVRFGXzZoNSjqWeHPeNRPUHjywTTmJ5qvrjEfa4PqHMEj/PROtqxHaqxHZucoK0suz4kdNCfB4ftjNhjfsJYI2+DDM7j6zNG0w7ZLlnbAQjOROZI1IOFjxywSZKb5BKQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717282515; c=relaxed/simple;
	bh=ecpgpdxBFhv5hbq7XyFUS2efQdjYBNzzM28BA9baArg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZNyMWKMs7lFhr88Rfr6qnfSiDirmk7AntvwezHV4H1opiWEc15FS0g4H7n7va5C/Q0++kS9Emb3zkI7zog+mmRNY+7qG3MW2yYs/YUMEWSjy4PqSgmoX7qrzWR7EEDOBh88CfR75dIrsyYCOxMqq1gOpLYIwzcqZ5NZnjw2IA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jc4cgg1t; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=10pbVTdAGHzcOVuExmt1SQ5n+7OnChaUdx77tcWXsVM=; b=jc4cgg1tNUqf8MA8
	jp1rKBA2MQRIB1z/j01oZOifsn0h9x9Khu/pBvVYhkadqQVF85bECQ9XZQkrx8Vn4vBckl2hPTFct
	eUMbIL3AftdP1cLHBGyANPBs8d8IT8oUGI9PwIF5p9RPJf39e29Tw6pE//O1tCComp3c/h51f95X0
	iej2zrD+0o1oSA+AsxBFcaGNC4nSFT23dTn1OTUtwyWvxp2rv7MKc9IrnZvnV6bU1NaS3i0NjZQwg
	UlPdUgJd7myY6bbY9ZCCkneP4i4dIWSYh4d09m29J/VlY7kUbVFC/RJCPMQaUKFkTGUjqd2sWXdTA
	0HqX43zm3DzOzJp1lw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDXcw-003lZO-2w;
	Sat, 01 Jun 2024 22:55:07 +0000
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
Subject: [PATCH 3/3] ASoC: codecs: cx2072x: remove unused struct 'cx2072x_eq_ctrl'
Date: Sat,  1 Jun 2024 23:54:46 +0100
Message-ID: <20240601225446.183505-4-linux@treblig.org>
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

'cx2072x_eq_ctrl' has been unused since the original
commit a497a4363706 ("ASoC: Add support for Conexant CX2072X CODEC").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 sound/soc/codecs/cx2072x.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index e8e22b1a1963..8cfec8dcf839 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -63,11 +63,6 @@ static const DECLARE_TLV_DB_SCALE(adc_tlv, -7400, 100, 0);
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -7400, 100, 0);
 static const DECLARE_TLV_DB_SCALE(boost_tlv, 0, 1200, 0);
 
-struct cx2072x_eq_ctrl {
-	u8 ch;
-	u8 band;
-};
-
 static const DECLARE_TLV_DB_RANGE(hpf_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(120, 0, 0),
 	1, 63, TLV_DB_SCALE_ITEM(30, 30, 0)
-- 
2.45.1


