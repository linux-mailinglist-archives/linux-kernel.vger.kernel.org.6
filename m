Return-Path: <linux-kernel+bounces-262762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0B93CC68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F447282D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67D17E9;
	Fri, 26 Jul 2024 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iciomw1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4920ED8;
	Fri, 26 Jul 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956878; cv=none; b=GJUl/ofntQ4cTtLNY+nkSxBGE30uKm5kWdx2LZWgcGyo4HTz6D5+Xa/xccBGh+6VDkXA+sVNH0gd16ggjo4HIZx0480qACqFEqTxYfB0v0ISfcrchr9N1GXzrg9PLOtpal+5Nn3HNjBzKBQk5v5sd6KU+ZX8MKiPWINkchEnlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956878; c=relaxed/simple;
	bh=flPzlvlz7DN9JhwlSkJl0NM787fbfSfCMC2TYm0H5Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o9R8Jm4XRmktq7k39QGKnNuwzFwhshEpY1g/wkyTWxj3yUiLODRRGFETxNnInq081rtbBUEKsezNd/Zl95AUa77Y0oZMb4Ysaek4ZJ6Q1oY7S4EAUDmeEmypVe7LK6ZxkpYa/P2iPh3bc7Rgzrophwq/pCznSqUfr1DCibCnT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iciomw1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F187C4AF07;
	Fri, 26 Jul 2024 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721956878;
	bh=flPzlvlz7DN9JhwlSkJl0NM787fbfSfCMC2TYm0H5Dg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iciomw1gvfse2OEyXdczIQoW5EmOZtSYo+UbZI3NXHO/QaobUmUgwS4QCF6aYEnOz
	 5JhXWyRauzw5sOhYFzbIUuPvXM6tDQRYcORJALTPbsRuiI+lZwtVriJVjpUjq2XyCT
	 YqQ2QDBIhw3bsCpaqDsU/Sad1BDleKg1rGcmxPxQO5qh1TV5h5BO780eQX8IGXIp3a
	 0FS5Xx3gkuHX1ayL7BrNUtg0G30+QftNv2XAknOVgF/DAXX95GYOlqfoq4ER/uTFw+
	 GNgM+ZM90fqld4ebGoof2ZR81QgJzuzMsxC0v4TCykzk3LSXYiO3Ga+JcKJ/EQ3YIf
	 XDZ5Qn7KG46Kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B91BC3DA64;
	Fri, 26 Jul 2024 01:21:18 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Date: Fri, 26 Jul 2024 09:21:14 +0800
Subject: [PATCH] hwmon: document: fix typo in oxp-sensors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-typo-v1-1-3ca3f07f93e9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAn6omYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyMz3ZLKgnxdM0OzpCTzlCSDNDMLJaDSgqLUtMwKsDHRsbW1ADphpSF
 WAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, trivial@kernel.org, 
 Cryolitia PukNgae <Cryolitia@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=Cryolitia@gmail.com;
 h=from:subject:message-id;
 bh=RoowNEKAO63y2ZFmj969A6C2D0ZaS9bvHWQpvSGXH5I=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFHUy9wQU5Bd0FJQVQ1ZEYzTDhpb
 zdkQWNzbVlnQm1vdm9MQ1hCbk5xMU9hRFU5c3pTVlNaWGhFbmFBCkdiN3l5aXRkdkpHbVJhRkJ4
 eWVKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWnFMNkN3QUt
 DUkErWFJkeS9JcU8zU2puQi8wUlZHUElLSXd2bWZpUzJzblBHWmp1NFFyMmQrUmhDZnZ6R1ppZg
 pJbzNPS2RWZlI2M2JmQlNlVGU1SG9KR2NweDhaWlRNb3JTT1NWU2NuWXdzbkNlcy85bVhmRFNhQ
 mlWMXFVMy9hCml4TG5Tc3loaEpKL0dXUWxKZU9iOUZHNlFtd3AreU04OFRrR0JVZ1FsRlFiVjlF
 cWh3bTVubFFBckxRaUFoZTEKM2RRWjlqRnIrcW5LbnY2Nm8vcURSUjByNHVraThmR01CQnNadVZ
 NS09mMmNvVk5WaW5FZE1LR3ZuWWdtaHk1QQp3OE0rWkM4bjZLVjMrSkRFL0JERm4xbFk5L1U0Sn
 gxMFV5c1RXa1BIK3JQTWhjN0xRWXVGV0l4MkI1cWN4WTlHCkpaeXhzNGFOOHBJb0I0dUVCRjF5d
 mdLUU93ZXZUNXdOUDJlRDRnQ2VjMHJ4WCtIWAo9RU16UgotLS0tLUVORCBQR1AgTUVTU0FHRS0t
 LS0tCg==
X-Developer-Key: i=Cryolitia@gmail.com; a=openpgp;
 fpr=1C3C6547538D7152310C0EEA84DD0C0130A54DF7
X-Endpoint-Received: by B4 Relay for Cryolitia@gmail.com/default with
 auth_id=186
X-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Reply-To: Cryolitia@gmail.com

From: Cryolitia PukNgae <Cryolitia@gmail.com>

RMP -> RPM

---
Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
---
 Documentation/hwmon/oxp-sensors.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 55b1ef61625e..50618f064379 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -52,7 +52,7 @@ Sysfs entries
 The following attributes are supported:
 
 fan1_input
-  Read Only. Reads current fan RMP.
+  Read Only. Reads current fan RPM.
 
 pwm1_enable
   Read Write. Enable manual fan control. Write "1" to set to manual, write "0"

---
base-commit: 73f3c33036904bada1b9b6476a883b1a966440cc
change-id: 20240726-typo-616bb7db0f68

Best regards,
-- 
Cryolitia PukNgae <Cryolitia@gmail.com>



