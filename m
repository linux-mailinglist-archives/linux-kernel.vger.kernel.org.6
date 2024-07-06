Return-Path: <linux-kernel+bounces-243292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E58C929417
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AAA282CED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A92A139584;
	Sat,  6 Jul 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="e/oqVuvq"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69B29CA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720276923; cv=none; b=k7kbUbRM8Iwlj6uiRvPcEYVmte+s2v2J5EeIsUHg58ieU2rvhrWN0at3y5MfergdQXRPPrnZBARZOzsjFAhH8BWXIHAAJSFt7RTDpc/LAnZIsmYqwXnBMqNvYtvQ/UnOG8WE2HY+VhhVV0WV1eQH7MBD5e3TM+c55gvAh+rizkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720276923; c=relaxed/simple;
	bh=0NWOUSsB3uif636gQkfhs1/AhAJ9qh1pPIcVwkAs668=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eu2TGujXQRpoK9d8o2HkBGZQih5lEeuwnKAtpwQlYhh0lBb2c0qpbS0pycwIZcOH8HXMVukjEzLKEqXab8a1Tqdc8jjfUWWF6IN4B6ejkFaucw4NZHIlq3qTRzVWuMMBFeC759R9SocLs1C/eBZWGtJCHwBzWcuOWupYK9/akSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=e/oqVuvq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=uOJePxJp1PxgWJ
	736MVVoBjceFE66llaKX9HPIB52Bc=; b=e/oqVuvqwcxBHqAv1QV0kQsbDkj1KV
	v6YBEBW8IxTWft8S0qMlOn2YFpl0wzk6wdrI/FiMFD+YCkbs3QQo/3xy2rQNvcv8
	sc83oXCm0kKtTz6VHlGFJ6z2luzNIoJCyRA0WvEXwCCZapoKeJBZd1AJiULP9g1V
	LlQvOpmw8SOqgx1q2wUuj8ADsfmQ+7N/PbfMAA8J7ceqkR4YlGdilMLWpQ4D+F51
	7ZctD2tysRpLLTlq9j0fNSOADje5yN/fAYTpLOyfIO3CcGhJ0C+IGGL2LyU64quU
	rDlH7zL0TDI4NwDyXtoS4EAsvo7uTLg3NS1wyNiz9KHnBbyJhF/D7dkg==
Received: (qmail 3850048 invoked from network); 6 Jul 2024 16:41:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 16:41:57 +0200
X-UD-Smtp-Session: l3s3148p1@lduVLpUckNhQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: delete entry for Conghui Chen
Date: Sat,  6 Jul 2024 16:41:50 +0200
Message-ID: <20240706144150.2668-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The email address bounced. I couldn't find a newer one in recent git
history, so delete this email entry.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68e3ef05facf..55bf8ba02386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23842,7 +23842,6 @@ S:	Maintained
 F:	drivers/vhost/scsi.c
 
 VIRTIO I2C DRIVER
-M:	Conghui Chen <conghui.chen@intel.com>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 L:	linux-i2c@vger.kernel.org
 L:	virtualization@lists.linux.dev
-- 
2.43.0


