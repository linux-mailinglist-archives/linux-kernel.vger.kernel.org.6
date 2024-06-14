Return-Path: <linux-kernel+bounces-214516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8C09085DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD6528B155
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D391862BA;
	Fri, 14 Jun 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Vdwrf4hU"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531FE1836CD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352775; cv=none; b=CMIjI2Surd4rFxIiSijVCmhh09TWRuFLt+hbVdSjmMQIBJAVuwb2fQ5hzK2WyU3su5wT95r3MJfJ6Vw6MQVkAwBy3zop+qKISTVq8yL5mOGn060GQE3y+4+BbedQHCo0TlBAsb9rfk+41tdsrjdJh5Swg6SojMYTTzner2hUYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352775; c=relaxed/simple;
	bh=tLa3YjKzTjbALrEqcR62zhXe0F7RUglCnTOQTHelM9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2tiV6hhT3ZkPO0pOnt0vc4DfARtzZYeo2xYeSbDkBLItDrSEMa86UVHwjPmxOlr9dMht6j6oOFFHxevr0/vRxnACBVYt35x7KN30Yb+zeKgcF4EvwtnwvHJjLtAuTNVYxso3ia/EMcFD+uYcr2SX2XriYTJv/LKfu0QJwd88JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Vdwrf4hU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=k1; bh=ns0TUqgMIMc2G1ba8motoRRT6bt
	z+ty/Oyg8gP8SWmY=; b=Vdwrf4hUr1b2PQDAjBWcFH3KuJqYXDZLc3hkMPaxSkx
	scwyfv91PRPF44bhZXdieA7XWJqXJOvyl9UPamOg9oyRMatjlp65mcotuemR0+p1
	XmbpCXxT6fjRkwpuE7wLH14MqRpkF0UGhnplmxkIPT1n6GLSJBFHM2FRDtexQImu
	iZMw6T+jb9jj4ujDR0YjA5rNmJ1qegp1HLtqMmo39BliSPHSyc1ladt5Kd04Lw0R
	6ak/6gRz2drvGMICconvQHgnX4OfmBCsFudYyBMYFRuN4PvgTgLby5tSi3rVzwhn
	SUn1Hz78V2Ir5jZly1wDdvENjqB/StAulE0JzGKJr2w==
Received: (qmail 1438126 invoked from network); 14 Jun 2024 10:12:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jun 2024 10:12:49 +0200
X-UD-Smtp-Session: l3s3148p1@cn1jLtUaCoIgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 2/6] docs: i2c: summary: update I2C specification link
Date: Fri, 14 Jun 2024 10:12:40 +0200
Message-ID: <20240614081239.7128-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614081239.7128-8-wsa+renesas@sang-engineering.com>
References: <20240614081239.7128-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Luckily, the specs are directly downloadable again, so update the link.
Also update its title to the original name "I²C".

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 Documentation/i2c/summary.rst | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
index 28ff80a2302b..e3ab1d414014 100644
--- a/Documentation/i2c/summary.rst
+++ b/Documentation/i2c/summary.rst
@@ -11,11 +11,9 @@ systems. Some systems use variants that don't meet branding requirements,
 and so are not advertised as being I2C but come under different names,
 e.g. TWI (Two Wire Interface), IIC.
 
-The latest official I2C specification is the `"I2C-bus specification and user
-manual" (UM10204) <https://www.nxp.com/webapp/Download?colCode=UM10204>`_
-published by NXP Semiconductors. However, you need to log-in to the site to
-access the PDF. An older version of the specification (revision 6) is archived
-`here <https://web.archive.org/web/20210813122132/https://www.nxp.com/docs/en/user-guide/UM10204.pdf>`_.
+The latest official I2C specification is the `"I²C-bus specification and user
+manual" (UM10204) <https://www.nxp.com/docs/en/user-guide/UM10204.pdf>`_
+published by NXP Semiconductors, version 7 as of this writing.
 
 SMBus (System Management Bus) is based on the I2C protocol, and is mostly
 a subset of I2C protocols and signaling. Many I2C devices will work on an
-- 
2.43.0


