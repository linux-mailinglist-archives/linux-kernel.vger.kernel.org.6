Return-Path: <linux-kernel+bounces-265733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B23493F552
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33875280ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93B13CFA5;
	Mon, 29 Jul 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="ggZkLv3J"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E71482F4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256007; cv=none; b=uAEFBW/2VUW4H3y+7m3tc3bIG9/XRTqwSthtssTSlYTteFU13HSITzjjah8oJnOjsqhCn4qqs2BKff+Ov34XENRviD26Y+N5S4QtFXb/5UicKxMDLmea5QpJPtM0Pefa/ki+cbt3iGmJ8RC7iPStixYzJKR9TCTDvGko2yN6RvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256007; c=relaxed/simple;
	bh=aNa/8knRw4MxPkdgNaHGL3/rnMqufhdnerVUeIvW5wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rvcl7zjQ/2a137aROI13c9tj1nbufpmb4LSIs37LFa0azSi5WNlm9Q+Y8O/+MhwSHGLcKZC7fbAsnWsDMnWzcuq6VMSdS2+A5ayFSg0vKzBUDwHhnqGPXaklm5UTLNnAZ19Lfo/BHp57RrBHdCVcHq6/m8hMDVjt7cUyDNaWgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=ggZkLv3J; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1722255451; bh=aNa/8knRw4MxPkdgNaHGL3/rnMqufhdnerVUeIvW5wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggZkLv3JYbhghVVkJTM2JWAqpXCd+MJBYwZ0okDjqcS5ax5zWp+JEu8yHeNoXo9WD
	 /hF6O8z9xtMB2jA+SGsAi7YD4/X3W1FdIE8hewEUbEnzZvmXjEpcs7x9l/4NpjLMeE
	 t+w1AjFY2GK7ZKOGsnchBx9cDRla8GEDoJLYvmudSuNtcTpuYV3kTdRJM2Gc3+kVj8
	 nAq7OlKYvKhBYu6Uq8BO5cqtMtLy251lKJbuKVbULcwHL7dNYYH8QPsxwihGo5XDgj
	 ugSjmC8PFkEi+xG9U+zc4dtIhzY2RYuznqEDuYxzG2IgNThPowywiubhJWRbphalQQ
	 eRuqVGr8CenUA==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 46TCHIZs540506;
	Mon, 29 Jul 2024 15:17:19 +0300
From: Ofir Bitton <obitton@habana.ai>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        sfr@canb.auug.org.au
Cc: jgg@nvidia.com, yaron.avizrat@intel.com
Subject: [PATCH 1/1] MAINTAINERS: Change habanalabs maintainer
Date: Mon, 29 Jul 2024 15:17:18 +0300
Message-Id: <20240729121718.540489-2-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729121718.540489-1-obitton@habana.ai>
References: <20240729121718.540489-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I will be leaving Intel soon, Yaron Avizrat will take the role
of habanalabs driver maintainer.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed2d2dbcec81..a4b36590061e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9599,7 +9599,7 @@ S:	Maintained
 F:	block/partitions/efi.*
 
 HABANALABS PCI DRIVER
-M:	Ofir Bitton <obitton@habana.ai>
+M:	Yaron Avizrat <yaron.avizrat@intel.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 C:	irc://irc.oftc.net/dri-devel
-- 
2.34.1


