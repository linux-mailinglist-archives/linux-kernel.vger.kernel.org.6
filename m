Return-Path: <linux-kernel+bounces-224422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F6C912231
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAF62840DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3FD175545;
	Fri, 21 Jun 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cM9kENpH"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99484171640
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965136; cv=none; b=mfMuDgANKN+5tQSuHvOVuxkKMG8O8zqIpGX1GLfRbafXfC4jfpi7PL6iynso2CgKbTg8ntlADLdkHJSHMZWBzDtgxjvnDjDnUQoUn1tWmQpb0V4dWKaC9w927ekQ6bGN6Ak8fPfJ8Y8YcdK78HYYX/TA9n37gltpVCdgWtQLslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965136; c=relaxed/simple;
	bh=v7B3FQx/L8kciW2YsYAf+HsLQNTzK8QzBbTZt/CR7T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XD6eNebp49arz5zVRN8pwzCuYtvVS29QCQKwXNt2buLmdvTm55wym024HzsXOhu+PwFm5YREV0uTkJ0KgPe61vEyG7VDfXhnt9fyaiT71kGJjVZNDB08cSDxjowB0EBM1vejJGk6kzdq7RaQtVB2dcP4mREtl084uvu9kKFB8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cM9kENpH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Gvm33rBWWy5Xb1
	ABd1blAuTcsxxZ6b8ZgLTycZKd5q4=; b=cM9kENpHFDJ/v/hMxH8kCsmyAS+YA6
	ZUJTGBx9RCL5kc2NrAUTe97jDLk26NkNiOurcluo+babDn/duT8qvwL7kTSQYNL2
	0eCXQRsHn/tImejD8g7RauR5s9Dy6PhpCSdYTRYUgcJ9KkgsF1Dxf5DH1mzHpFN6
	Ct9Q+zTCODICNfgl+xtjY088hyI4vgwc2l6q8bU6S/s3qGzJKVUE294qcnQSjaiK
	+LDfDCuXbOBnNqCDJ41/QjhHBRk3gRywAxRsB2GjDKAZvXhMN+za8iC4xaxcG0b+
	hYvwW8LH1ya+RRn3L09yDjIco8t6uP4CcFyymAxl1NfhS+hrxqqT3pUg==
Received: (qmail 1333463 invoked from network); 21 Jun 2024 12:18:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jun 2024 12:18:49 +0200
X-UD-Smtp-Session: l3s3148p1@M9XpwWMbxoYgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: drop entry for VIA SD/MMC controller
Date: Fri, 21 Jun 2024 12:18:34 +0200
Message-ID: <20240621101833.24703-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EMail addresses of both maintainers bounce. Since there have been only
cleanups for the last 10 years, let it fall back to the default MMC
entry.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf9c9221c388..5ef1e83e0fd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23645,12 +23645,6 @@ M:	Kevin Brace <kevinbrace@bracecomputerlab.com>
 S:	Maintained
 F:	drivers/net/ethernet/via/via-rhine.c
 
-VIA SD/MMC CARD CONTROLLER DRIVER
-M:	Bruce Chang <brucechang@via.com.tw>
-M:	Harald Welte <HaraldWelte@viatech.com>
-S:	Maintained
-F:	drivers/mmc/host/via-sdmmc.c
-
 VIA UNICHROME(PRO)/CHROME9 FRAMEBUFFER DRIVER
 M:	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 L:	linux-fbdev@vger.kernel.org
-- 
2.43.0


