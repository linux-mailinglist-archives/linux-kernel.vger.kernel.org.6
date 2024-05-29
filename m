Return-Path: <linux-kernel+bounces-194541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42528D3DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18441C22AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24063184110;
	Wed, 29 May 2024 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ft7jqA4u"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA62184116;
	Wed, 29 May 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005199; cv=none; b=Nvna3AG/UP+BYylewUYMZtyv0onLqj6OfkxX5wQ6k+QG9/VtA3hI1tjeaTaNsYzu9BkozGs4OTZ6b6Y6I2i/iZOUSABxXlCtMbTfCE4rK5RWiu8FlE1vUKQHwSAbCJdF0+urcNnY6V7NLRu4SzHz+l4yXov3esfI6Vw+qL6ETlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005199; c=relaxed/simple;
	bh=jkF3u8/AuZIBDsWcnV5XdyenW/U7OcyO/DZWN9o8A8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PneHmjK3+VrTCeFtsVVRPh2eA6Pm2IrDU4/4oxxfwIxd4z+xRIGf4/AyG45xOKopnKLR2wtRqxF9Mlu5poGYZQSIWxQsvczY3ebOg58tFXXAplVGSEIIsLcFjedObRVZHbrd3NZE8zTapPSrvtGkKhnpxAhU30dmRDvRhOBuPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ft7jqA4u; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=MMBzAN9cUHS7zocL5pZCi4CE7c+vOf+EsFuR6Ia2ACs=; b=ft7jqA4u6pWXtMB7
	kVZvxha61Kw+Y2uCnVRRlt7hDioL2g0oK55z5EF5bT4IkpIc0kP9oK6GyWxMCDY7YkcCfO4ttysTC
	JexgMXMz2DvT9LSdJPHXhg45lxDoe+cuQ0uR4UO5IJOE3Ry5dfpps++yJeFfIWyX+Byv2CM1ZSvE0
	PCQrCdHMeoaeQDZrQIS90beBqrgoazvg7wwaXlwiNr/3GvZ6ulCo/0onbonDuA/rTP3EMiFFfEaid
	Ryq8gI2YxhiRtNHoTKMO+7Y2Md0W/8fHk6xph3roJNrW8EjgHsolbyRq2WznhROvdfjjHC2W3LwYn
	8vFPnTiLkkyzBVbyxQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCNU6-003F0r-1H;
	Wed, 29 May 2024 17:53:10 +0000
From: linux@treblig.org
To: rafael@kernel.org,
	rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] thermal: int3403: remove unused struct 'int3403_performance_state'
Date: Wed, 29 May 2024 18:53:09 +0100
Message-ID: <20240529175309.83294-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'int3403_performance_state' has never been used since the original
commit 4384b8fe162d ("Thermal: introduce int3403 thermal driver").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../thermal/intel/int340x_thermal/int3403_thermal.c   | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 86901f9f54d8..c094a422ded3 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -25,17 +25,6 @@ struct int3403_sensor {
 	struct int34x_thermal_zone *int340x_zone;
 };
 
-struct int3403_performance_state {
-	u64 performance;
-	u64 power;
-	u64 latency;
-	u64 linear;
-	u64 control;
-	u64 raw_performace;
-	char *raw_unit;
-	int reserved;
-};
-
 struct int3403_cdev {
 	struct thermal_cooling_device *cdev;
 	unsigned long max_state;
-- 
2.45.1


