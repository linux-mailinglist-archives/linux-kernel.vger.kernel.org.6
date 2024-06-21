Return-Path: <linux-kernel+bounces-224065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A46911CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A1B234EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4FB16B72E;
	Fri, 21 Jun 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QolgJBCA"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2463AC1F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955026; cv=none; b=Bk/PnJHLkBEQ1p+1qw/5Nxq9alnkV7zYTOxlbbSYlwM2odVvU66eBOIbwQFTs4JH6zAtCUm5RURk/p17Pt9JiaiRoAtMyvtHNhV6UVfo+LriCUcmOwt6eMUQ2BLIXt4wbvtIsY/MNUvULri9FJtwqCOFmER7s6lXqEKiF13Gpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955026; c=relaxed/simple;
	bh=LB4QOi9LK6GONrdmJpUg3ByUIohmjdLTvvzGHevTlik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dQAu4ZP5/YaXDv1hwN5i5Z0AWmlEwQVspehg1vDgEM9ZWBQWd9xTJKBfHHg+pnKe9+3cLuPPr1oC6JXVLz/oqkANRg9z90odnTNfoxzxUIJ3xCUU222TKM6seIoy5+V1zGCg2qKrAq2gJToJPMyk6sLQSp5oMo/L4Ub0JeeCDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QolgJBCA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=k1; bh=K
	+6Hqt9y3xI51edpmWC25ugnY/P75Ez8oab3G5r0Nb8=; b=QolgJBCAT3OS+BhsH
	kgwbZA09RAfAlPUc7b9EhF01hUthI2Gq0ZHrAf9wmc80fN8P//EwrdWqb9xcmKVY
	h4Emv4OfP3HmUH7b36r3lb9bSdyrV1HMEYLnYTukRqmI8sH2oM8Mlxf7dsyidHJU
	n78RKcCjoDEQ89hX+AIwLz7kAGY2QKBCpJ/pFbLSGac/a5pK7R2KEjHyZCavQGZm
	Y8qcA3fsuFkag4OvW9Yn0bf3KAsrvoEqz8j8oKBUF698MhuMgQuhT3r2A4LfJUTL
	/fkZmhmHiyrW/ruo9itK2d9ZSO7+wzwb9mrjKGP8Z/GM4krVWw+RmwghwAuhtL4Z
	fk6yQ==
Received: (qmail 1279008 invoked from network); 21 Jun 2024 09:30:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jun 2024 09:30:22 +0200
X-UD-Smtp-Session: l3s3148p1@X8l/Z2EbzMMgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v4 0/6] docs: i2c: summary: update and use inclusive wording
Date: Fri, 21 Jun 2024 09:30:07 +0200
Message-ID: <20240621073015.5443-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main motivation for this series is patch 4: switching to
"controller/master" when defining the I2C terminology. This sets the
base for further improvements to inclusive language within the Linux
Kernel. The other patches are improvements found on the way.

Changes since v3:
* reword "Synonyms" paragraph in patch 6 to be more clear


Wolfram Sang (6):
  docs: i2c: summary: start sentences consistently.
  docs: i2c: summary: update I2C specification link
  docs: i2c: summary: update speed mode description
  docs: i2c: summary: document use of inclusive language
  docs: i2c: summary: document 'local' and 'remote' targets
  docs: i2c: summary: be clearer with 'controller/target' and
    'adapter/client' pairs

 Documentation/i2c/i2c_bus.svg | 15 +++----
 Documentation/i2c/summary.rst | 79 ++++++++++++++++++++++-------------
 2 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.43.0


