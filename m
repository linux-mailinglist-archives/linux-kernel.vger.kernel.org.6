Return-Path: <linux-kernel+bounces-224067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADE9911CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A231F22EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1D816D4F5;
	Fri, 21 Jun 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="e5da2N5a"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041F4CE13
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955028; cv=none; b=he4J1j1JQMYzb43S8pBvtb87R9Ov+EacK3J4Pb2zNNVjrUo88jHsgeJHt1EiQzNixx7xouY/lvlC3bjl75FJOYs7IRUWEMgXOCwt/LlUDQ2DBECKSlhHRC45usrH/UExAGDumYdOBMy7VOfbNlvw84pYOcWDzPBEY9HjTL6YbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955028; c=relaxed/simple;
	bh=tLa3YjKzTjbALrEqcR62zhXe0F7RUglCnTOQTHelM9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS3mT306nPkKMC2LfH6rG5p0dbK8fzP0Qc1jWBKK38OPzppa9PmX5zi5UyRNZfmsInGHVdAxrm5g8qdFP0IG2LxK6GAtEwYYTa/KkATOS8/cz6NsgKRJ+/S/AnevjlEXwP7l0pVtAsjp7fcUw9JTQ3/KyjGxX+OpSUaJ7iZzb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=e5da2N5a; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=k1; bh=ns0TUqgMIMc2G1ba8motoRRT6bt
	z+ty/Oyg8gP8SWmY=; b=e5da2N5atOPx9sU3HnbguoDU4x5iKVRPkVDDDEpkwqK
	HiHr5/qo1NyhMdC7ZFGP1l4nyBrQ4Bl8zceH3ze4/zsaZLtJVZExLd0OcKPeZLY7
	ABAEm0iSVfhE88OP5WB1ZwBuRf+oG70iJXj0zGbcnJi3TarvrlKV6NA6K3U50yK9
	4zvR7Pkeidg7aGuAVEjMBakop8ISfFjQvXEaiT74LRrS1H98474Nha97hU09ZR2x
	uVR0zx1iKUWMbcwIB3vkFs0MtW7+aIyEgW8AVnYujhaCAie9kkos9Ok7U8stIymt
	4Gf0KWZqSXZZObSm/cYDI4KdqqgREOOsCnMuPzMv1xQ==
Received: (qmail 1279065 invoked from network); 21 Jun 2024 09:30:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jun 2024 09:30:24 +0200
X-UD-Smtp-Session: l3s3148p1@ZFyXZ2Eb0sMgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v4 2/6] docs: i2c: summary: update I2C specification link
Date: Fri, 21 Jun 2024 09:30:09 +0200
Message-ID: <20240621073015.5443-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621073015.5443-1-wsa+renesas@sang-engineering.com>
References: <20240621073015.5443-1-wsa+renesas@sang-engineering.com>
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


