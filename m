Return-Path: <linux-kernel+bounces-553459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10989A589F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8393A8069
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDAE14A0BC;
	Mon, 10 Mar 2025 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="DAplPc40";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="iYBjSq0/"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB7BE6C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570110; cv=none; b=CO6Y6ndrmB6UwtL/0qOJ7uXv1fXPUR9SN3zG7cNUODi2GyL9KCjGzevVVHxt2eWFeOw4wQ0/YTRCE4LciOVbaOnIrV2ACxxXn3Z2BJgiChScXOOFaWTZdqeLCyNJbDguMll7xmBknOXi/bTNGagi99OX7jmLR6Ec6Z/00tAN2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570110; c=relaxed/simple;
	bh=jxcp/I6qRoVojrFqHPEejhsnoYO+OFk/768yTckJ3WY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l1WhWv2jiSIEkg06Y2yQ4ZuGGF4dtSzAidMRgzWS9b3/8zd3Ly/Gwz/ApQrWP0D86dU25zcrT3j1krsepI2dnQw/i1bprnVeWjW+9Y58LelTkLOEeu0b8cON2zOldDqFEyT4e+3x6qI1xHq6DG0dakXkKda6qRfnS4EaOEF3E1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=DAplPc40; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=iYBjSq0/; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1741569706;
	bh=jxcp/I6qRoVojrFqHPEejhsnoYO+OFk/768yTckJ3WY=;
	h=From:Date:Subject:To:Cc:From;
	b=DAplPc40YuYE2ugSiaMFi1i/E9wsKj1YrYF/uAip+36rGjuJB5gvHSkQyDb/fbGZt
	 GDip7IjYpb/h/SwW3ou8d/cjASYyEci5ilgG4TR9j1Y94Ljy5Sd3DU2d/lwi9n27MC
	 2agQAs4wIZiotTIMoYSpyf/DyjNt/PquN17TqhNMEuNfOxInjbsGP5ewYP+larusKW
	 KlBIa7uu3K+t7BmHrX1zduvQmfVOtG+9NSum6UWF/mQw5Zj1j3/qEnfAzoEmhgdwfJ
	 0j3aOw/qPV4uEDZjT/tNZU3RUwAjPCUndvwiSRp4iTjW/7gDMbwPA4j1MywXrqk7Yb
	 7zbJK2X7oub6Q==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 32B70687
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:21:46 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=iYBjSq0/;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 078AF4CC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:21:45 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2254e500a73so16486165ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1741569704; x=1742174504; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhiAMviavNTKHdOoETHF5AIQD1QwdQW7edH3CF15XWA=;
        b=iYBjSq0/nsCKSo6O2S6GCIZkvPVYq/TSedX+xcFEWoryqLDbDdkii3TPIPdlINLR0i
         950Y95JmKCmGMTmChhSPSVY/sUpsM7PcZ7obfRSt9VRtJXLVCsZHKSC7bywVnOIKSUxA
         lh6QJmeTVVLB+KfSIu/v3nUWKj9kWjRYWbswXqmYFhKhsaJSWqkGtJwlQzHu8RFkhW/U
         7R7aUL1KXh1P1kW+LdtXJtiGBvaO0+BElV+PkQ1+5Mqt3INzw1KfsJjruCuOkDMi+7bM
         StByvvf5FMWNRGJmY7USZWlaIILSstmAKXd4t50tV8xoj6Gehj2tyhRV8EVHVxhyMskJ
         ad2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741569704; x=1742174504;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhiAMviavNTKHdOoETHF5AIQD1QwdQW7edH3CF15XWA=;
        b=jtWA+6yiDukkhWOUYFMyG9pZ4oba1RJhGyr/Vkf9z11V6ArwPlRd6DT7id9TWWPMi3
         5C6/oliwg5f2TGVywgFlaRtaxj/hAEZHtE9LJlh4B6ZHGVMY1wz/bSPgwlqJ6m5KLRxT
         UEe/XFQE2YCDe7cNQjrQzIA/E+seCopdCPy+geulszi0pnieWrmoNVYeRrAKpQB/BN9G
         yRDUCNRw+y6SkSjlPYDeGm7eMlc5aZ3CVKDomZqxoIo15uO/ZZ9XTOEV30yQmFf4qsOI
         Fq/zHwNSWvGmI4QMk0+FYMFaS7GEa1YRv3tVHlwGEUGtkUardsHs57SVszTAaGkg9WCc
         JuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtRw/pS1v0Cmm/HQd/VUedutKQSolcPo93qJu6OLUc527lOHLNswQfyhRi8wkt90If/x8yHXpgG/lHDO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85qzW+uYS8gdJQ3nMW+sxPutwj4T6Z34lUh8G5Mf747O4UawD
	FnZ/wTYKI3isFyIgiHg89IOKoE0bUt0AufNwGcMJExSfKQAF5QG8ekUKqjrd6QpmPW790XVEdBI
	unYIjeCyerZO4m9DRASkFhGSpeUWFkAIY646tDbt6/IYbtx1AjbWU6wPZxYtzmVA=
X-Gm-Gg: ASbGncssqgXx4QdGTB1C15l6/ebCZm99GqQ5GpqHlkcL11mapIHlaWMZiOJD4ENX69y
	Jbm3cT2Dk/ut9Mnmj9Shv13rJ6VtM1LjmFlHtaHnXhKG5Llhdz4quxf1s8CBTImhAhwLI6yF3dU
	bQro7OVjPxsf1JLwJ+KNDBjOpJz6ufuFTfqD+SVr+DI9KVgKfLbRDPxOWF+lT9FcHAZI7StvwES
	HiN3eL0HG15RAbh7obubKSB/4ZkPNY9D8mcAzxOxl/iQ8bgCKmtAwTzbBQV2h6L5xx1qBzPtqG3
	Q4GTEfEpEPbPRfwemLA2jcQRaygvazmknAINLyvIGVWkE6LYDy5kT6e5d5JHixA9dRJ5EBRGRmE
	=
X-Received: by 2002:a17:903:41c3:b0:220:e9ac:e746 with SMTP id d9443c01a7336-22428c049fdmr204603255ad.53.1741569703999;
        Sun, 09 Mar 2025 18:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQqkpr0NSHHa6VrwkkUEh0/PFpr5MlZHcBta7OOIN7lH6y2dABiyFXHjv0xMS7H2ahRBN2yg==
X-Received: by 2002:a17:903:41c3:b0:220:e9ac:e746 with SMTP id d9443c01a7336-22428c049fdmr204602905ad.53.1741569703668;
        Sun, 09 Mar 2025 18:21:43 -0700 (PDT)
Received: from localhost (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91e66sm65375475ad.202.2025.03.09.18.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Mar 2025 18:21:43 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Mon, 10 Mar 2025 10:21:32 +0900
Subject: [PATCH] phy: freescale: fsl-samsung-hdmi: return closest rate
 instead LUT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-8ulp_hdmi-v1-1-a2f231e31987@atmark-techno.com>
X-B4-Tracking: v=1; b=H4sIAJs+zmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MDXYvSnIL4jJTcTN00i5TUxGQDCzNDw1QloPqCotS0zAqwWdGxtbU
 AhJP88lsAAAA=
X-Change-ID: 20250310-8ulp_hdmi-f8deac08611e
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Lucas Stach <l.stach@pengutronix.de>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Makoto Sato <makoto.sato@atmark-techno.com>, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2114;
 i=dominique.martinet@atmark-techno.com; h=from:subject:message-id;
 bh=+BkAbmxwkkZRS2paZjf0xa+4nJdGfyFk5BqqRZG7pzs=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBnzj6l3RdsRbF+c/GvCGKDXJwbHib3terbsEXgN
 byeN8msZO2JAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCZ84+pQAKCRDyimB/1oxx
 B2UtD/9R1iVRZmgD5Tb+gMvQ/nDGlLcskD5UK/yduZOjTZRZwMPFZ2RvtScAE8iOGBxNzt6//D2
 E9RwEFhIBQvI3C47DsVW34luv9LLoqeaK/eC+RgGMGpqv+HmaD8TxMCGlnmfkOTNV5OF3xMWZ+4
 T1C7TPRaS5+Rh6xvJxNs400cfCmC3+nZOgZbBoQHzpxoh21i4lsoWwyTV7i2r8wK+K7NwgplaIY
 sP3OeuzF3usSHZ3n7xlFtkMzqt8t48qCxGXlFwytqGGMYb1FN7xQxIOjyn27I+8f+y5FEHORjk2
 8JtZMExcQjhOtQbeLw8M1cxOB0RO9RyuIfb7DB4CX6FFGdt6EENAKyANP9ks+32aM0urj46evWl
 zknWqqMY6X6FqqHFWtnUvgIBM8mUVKe4i6JfWHHZyBgVuRnrgZCdce05AImVjhtq87OCpt14ft3
 27opVCEaK1gIG8ZthbRKHz1hEaiemkCopL6sCLLSep+C8Q0iOFQJ/n5DgLDJ7qZQAAewsRw7xL3
 czdcXE40y6nqbhYvcQYRMkjvBbUYgtqlE+Of28u2uJu6yGmC7izQIdhIeudrm+IYeHWWzNO7rwr
 1rqxmTFU85n2rRpPT7tIBMJT0AhPYIESm7zQRXfNkOfEs27U0pro2iQGf66cj7owLEJVv/CbXRn
 F1F8n8dtZpKjeBg==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp;
 fpr=2815288B303FADC6BD2F7896F28A607FD68C7107

From: Makoto Sato <makoto.sato@atmark-techno.com>

If the requested rate is not an exact match of the integer divider
phy_clk_round_rate() would return the look up table value,
but phy_clk_set_rate() can still use the integer divider if it results
in a frequency that is closer than the look up table.

In particular, not returning the actually used value here made the hdmi
bridge driver reject a frequency that has an integer divider rate
within 0.5% of the target:
for 83.5mHz, the integer divider generates 83.2mHz (-0.36%), but the
next LUT value (82.5mHz) is 1.2% off which incorrectly rejects modes
requiring this frequency.

This commit updates phy_clk_round_rate() to use the same logic as the
set operation.

Signed-off-by: Makoto Sato <makoto.sato@atmark-techno.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
We're finally using this rewrite in our (outdated) tree and noticed the
"best" mode missing on one of our picky displays.
It all looks good with this fix, thanks again!
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index e4c0a82d16d9ef0f64ebf9e505b8620423cdc416..91c4d27a31f48fc49f1e8417d7089f5519b8a0a2 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -557,8 +557,9 @@ static long phy_clk_round_rate(struct clk_hw *hw,
 	if (int_div_clk == rate)
 		return int_div_clk;
 
-	/* If neither rate is an exact match, use the value from the LUT */
-	return fract_div_phy->pixclk;
+	/* If neither rate is an exact match, use the closest value */
+	return fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
+						     fract_div_phy->pixclk);
 }
 
 static int phy_use_fract_div(struct fsl_samsung_hdmi_phy *phy, const struct phy_config *fract_div_phy)

---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250310-8ulp_hdmi-f8deac08611e

Best regards,
-- 
Dominique Martinet <dominique.martinet@atmark-techno.com>



