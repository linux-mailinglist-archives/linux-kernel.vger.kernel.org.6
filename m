Return-Path: <linux-kernel+bounces-433708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2199E5C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A444D1887856
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE50238759;
	Thu,  5 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LJFRpxOh"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BDE224AFB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417014; cv=none; b=nz7wyHPzFdtNviUKBh0wlWA/QL4rT5IpyghTBaWPxVhlDPPD88RVzjF74XhWnMqN0NiSld/nkiS9OI68HHmAqvlMmH0RT9ItOGnQqr3CriaZCwgkUHdzBQi3BMBZnwfn/sevFxTZmssxw8cz09GOjWM3YIIJ46oJsr9tZTXKCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417014; c=relaxed/simple;
	bh=AqQc5KyVBR3UCuZaACzhcUMOhUf+nWE6X6C1Uv6SlD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=THjBb0jMZRqWynLUdWH8C6Hi2hbROYEHVHym5fUdSfwT8FxShlU+eWdU/O6hYOECdB8RgMPPr0eAQ9Ak+HJXjL+N6UDkqWzFgEE/4/uXgR9tZnyCt+yTXwGCeXWgSmtLLAhmoF/UV91R5J69XvBMHol9+iBzf3kjCIUVjEBhoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LJFRpxOh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733417007;
	bh=AqQc5KyVBR3UCuZaACzhcUMOhUf+nWE6X6C1Uv6SlD8=;
	h=From:Date:Subject:To:Cc:From;
	b=LJFRpxOhrLTGqA3wuMsK7WdS3/2+a8PO2D+A+BEzFFInn4GhBiXPKvLfnKWo9m8cB
	 Y743jtPGUpE0X6/5HAknxsQYaZejLe9TZ7OgLwonO+OV2Bwya5vVjNcBhY2mXKzyID
	 Fi1n4PEUd71UhpHfv75TTL9oGSTXB/YCC3wY93Rk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 17:43:27 +0100
Subject: [PATCH] MAINTAINERS: add include/linux/sysfs.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-sysfs-maintainers-v1-1-53694b690d67@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAC7YUWcC/x2MQQqAIBAAvyJ7TlCpqL4SHSzX2kMWbkQh/j3pM
 Ic5zCRgjIQMg0gQ8SamIxTRlYBls2FFSa44GGVqbVQj+WXPcrcUrgJGls4r7DvbzlpbKN0Z0dP
 zP8cp5w+fGB/0YwAAAA==
X-Change-ID: 20241205-sysfs-maintainers-df0e98a6b11a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733417007; l=768;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AqQc5KyVBR3UCuZaACzhcUMOhUf+nWE6X6C1Uv6SlD8=;
 b=Ip2cNESpWGf5dtKc4SyJ2/inayGMGiTVKCq+KpA8tDTJGAf44gdTlcE9Uh00uQ+Q4Ofepuq1R
 inZo/mwpUPGA5UgLEl5PYZ2gR5GNO1tXGdg+kbvml+6/K1tI1w+uECF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

include/linux/sysfs.h is maintained as part of
"DRIVER CORE, KOBJECT, DEBUGFS AND SYSFS.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b13d8bbe6bf133ba7b36aa24c2b5e0..59e60ce945f1d95a17b9b64bccdbc8eb1330952a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7029,6 +7029,7 @@ F:	include/linux/debugfs.h
 F:	include/linux/fwnode.h
 F:	include/linux/kobj*
 F:	include/linux/property.h
+F:	include/linux/sysfs.h
 F:	lib/kobj*
 F:	rust/kernel/device.rs
 

---
base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
change-id: 20241205-sysfs-maintainers-df0e98a6b11a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


