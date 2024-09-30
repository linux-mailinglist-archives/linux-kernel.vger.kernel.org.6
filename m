Return-Path: <linux-kernel+bounces-344491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1A198AA60
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5B21C216D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C92193418;
	Mon, 30 Sep 2024 16:56:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F33192B73
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715364; cv=none; b=uRLN82ijuFp2PS7zb2cK4KOjzz13VZhlmbf8Uzxk53wXUXw7qRw6xaKicXSid7crCrRQs+ZVVX4N5jolhdMKsJ0/E2s6yuvOeQ59GTr8BX6wu5EVw9G2PH/SNbTUrazGTrRy2deae2+okTkEINSHUTjrtmchr6Zx/TAupXXWrSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715364; c=relaxed/simple;
	bh=FdzFe29bVnueT1SvFySU4LKKY79uu+PoKdU0aZp2hME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y9LaPLpHy81CeC2z1j+eUyIl8hXDOf9NEUJdFPcDkFVoPvXlFNXZvs3ZPuIUUYmONmI0jkhzTDQcdOjUAFN0sP6MGv1lz4SC3jRKrwXQYIFkFGMhNpEC94dncW/irXHfu/eNKGazGNp6hYr/+heRKYIdSiebVg+UqAUJoMM8Tbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJgk-0003Lj-HV; Mon, 30 Sep 2024 18:55:58 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 30 Sep 2024 18:55:56 +0200
Subject: [PATCH] reset: amlogic: Fix small whitespace issue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-reset-align-amlogic-v1-1-f64ed5c4efc1@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIABvY+mYC/x3MQQqAIBBA0avErBtQk6KuEi3EJhswDY0IwrsnL
 d/i/xcyJaYMU/NCopszx1Ah2wbsboIj5LUalFBajJ3ARJkuNJ5dQHP46NiiXbUYeiu1kgS1PBN
 t/PzXeSnlAwv2GFZlAAAA
X-Change-ID: 20240930-reset-align-amlogic-cd4076c1421e
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Fix a checkpatch --strict issue:

  CHECK: Alignment should match open parenthesis
  #48: FILE: drivers/reset/amlogic/reset-meson-common.c:48:
  +static int meson_reset_level(struct reset_controller_dev *rcdev,
  +			    unsigned long id, bool assert)

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/amlogic/reset-meson-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/amlogic/reset-meson-common.c b/drivers/reset/amlogic/reset-meson-common.c
index a7b1b250a64dbf94530d06138f4270fff8f56d7a..38a767c06fc71b6dd8a998958b20592499db3c8a 100644
--- a/drivers/reset/amlogic/reset-meson-common.c
+++ b/drivers/reset/amlogic/reset-meson-common.c
@@ -45,7 +45,7 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
 }
 
 static int meson_reset_level(struct reset_controller_dev *rcdev,
-			    unsigned long id, bool assert)
+			     unsigned long id, bool assert)
 {
 	struct meson_reset *data =
 		container_of(rcdev, struct meson_reset, rcdev);

---
base-commit: 5b93105afcdcdb94d654f253850c5432555b283e
change-id: 20240930-reset-align-amlogic-cd4076c1421e

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


