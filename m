Return-Path: <linux-kernel+bounces-249807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E00C92F01B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7000C1C21340
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8A719E82B;
	Thu, 11 Jul 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1V3cvcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41412E1CA;
	Thu, 11 Jul 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728320; cv=none; b=jcSBzQcJs3HBQVdLu2MThVOvTYxOFcVvMcsuy3ZDBlqLsNb6UQQq8fjca23Rb6SDIrntRmMIrthGPNOdfDWH1puaIO9ikaB2rfQvxPd5vSbf0y4Y2pvRUmb1b3p04TVqOlHiVKCPC4nr/yg42YjLFhZuZG+WbCO+adn6cVBNTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728320; c=relaxed/simple;
	bh=JjEoJkt+b5z6Xv4gD7fs2fVQqPxXzgl+biYuXu2KiNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfQ21OvHMUaJjvUVMTRnXjQ2KGh0jI/VQJKMoU+RiqDl8YT2V7tR8CQYQHgoQ0w+aNyKY1H+Tgc/B2yB/yqKNB0WbWOdF8guqpYxKEh0iSp+l/esKpGnmUIWO9zTEgswdwb17vXNQGgPzuboiXLCSNb27aEVdwg/wEJ9jAGfZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1V3cvcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467A3C116B1;
	Thu, 11 Jul 2024 20:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720728319;
	bh=JjEoJkt+b5z6Xv4gD7fs2fVQqPxXzgl+biYuXu2KiNM=;
	h=From:To:Cc:Subject:Date:From;
	b=o1V3cvcfZCzOMP2MXrJTHjZ528JS1hcPktGAKlNYlZqKFUSoHGNDXWtCrQYA7va7W
	 oHuGUaISZASFZ2YrvK92bFHR88zKNXyOc+xwMkBOBh6vU/dMbjX+gdoTByn+y8NiGs
	 SM9MmlKdYMcx1pC4q/0hgtvD+xJJqaMkAAiMUVl+L8ufaZjznu4XQvIL0mYxLPvgRu
	 J35aIXKssQN8iT0EUSTmFBL977uvfo3SKaDpHb6PraTDUk0CbHJZXfaZk3jXeY/jPj
	 MpHQzhYR/e6MUmPTAemX/paBoi3fIaYFDAbT1nTfvGPHFIGwqTGiic/fbeV5aLEuA2
	 ZNEDhkGxWsagA==
From: Eric Biggers <ebiggers@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docs: driver-model: platform: update the definition of platform_driver
Date: Thu, 11 Jul 2024 13:04:21 -0700
Message-ID: <20240711200421.11428-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Update the documented struct platform_driver to match the code.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/driver-api/driver-model/platform.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/driver-model/platform.rst b/Documentation/driver-api/driver-model/platform.rst
index 1fe5c6c6199c..7beb8a9648c5 100644
--- a/Documentation/driver-api/driver-model/platform.rst
+++ b/Documentation/driver-api/driver-model/platform.rst
@@ -39,17 +39,18 @@ discovery/enumeration is handled outside the drivers, and drivers
 provide probe() and remove() methods.  They support power management
 and shutdown notifications using the standard conventions::
 
   struct platform_driver {
 	int (*probe)(struct platform_device *);
-	int (*remove)(struct platform_device *);
+	void (*remove)(struct platform_device *);
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
-	int (*suspend_late)(struct platform_device *, pm_message_t state);
-	int (*resume_early)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
+	const struct platform_device_id *id_table;
+	bool prevent_deferred_probe;
+	bool driver_managed_dma;
   };
 
 Note that probe() should in general verify that the specified device hardware
 actually exists; sometimes platform setup code can't be sure.  The probing
 can use device resources, including clocks, and device platform_data.
-- 
2.45.2


