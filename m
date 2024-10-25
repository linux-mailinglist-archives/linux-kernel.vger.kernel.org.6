Return-Path: <linux-kernel+bounces-381630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737BB9B01BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B371C20FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A52036E1;
	Fri, 25 Oct 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="haIbufr0"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DA202F80;
	Fri, 25 Oct 2024 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857265; cv=none; b=EYEXCG/eYdfsv3zdNElVlkgJxlesxNW+IjtUdZXyNP0qZccWgB8dCvhdlu6tAwbPPPZwwn6dDPKdS82Hd2WTpfY/kd2MtHKoA6SfM9hvAGc2EdBweFmgFX1VD50Qv6mACZq8uFL1JHCOKMvZndietUWMLY4d3HiOMODZhq4Pl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857265; c=relaxed/simple;
	bh=S27Qtx0JKcm3vpnW5KNiuDs8/ENGK902k0CzOPWm2eM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XhHV3UXB6zeXpCEDn2d18rxIWbrrRb9F2bLhpHMVvVRgr3iQZ+PdfDeC1ekNn3uMChloMXrIyBHpZaNn4SV08bXQrXrFdX+UcnXFLMJjdZISyjJcPnx5j1BCbLTT7F+NNP23H95/Rw4zdSeUPO0Xr0cSyeMvojec0UWo+Lvv6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=haIbufr0; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 3F0CF177100; Fri, 25 Oct 2024 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729857257; bh=S27Qtx0JKcm3vpnW5KNiuDs8/ENGK902k0CzOPWm2eM=;
	h=Date:From:To:Subject:From;
	b=haIbufr0k+BQGqtHkDDzbF+ebZSNbMWhRrFdwU7l/Zt1PKRRXHr1WTQk7R1S8j1Gf
	 e+KuDDpeC+fGb86kc4Eb0AXN9ORQH1KG4QG20gnlmRMeWEqiI+xd6bfNC/Z94747RT
	 4PV5BHwGwf39bWNK+aqoGoQTFlHZGoFf/FPhwyg9qx/Q8u5hORcM7k9b5yyJ+5DUUa
	 sYvu+AFVNEUU+kycBSgPYhn/pwThoKZYoVmGRXqEVhlPiswwmBoJ97mgTPfV5ySdsb
	 q2Ralw/FwV0pNpi3GFzlxDQyYYl31HVswaOJiVC7LjhH869mNwTK5YBDWgm8QbRxEF
	 xYX3BhS+uLOUQ==
Date: Fri, 25 Oct 2024 11:54:17 +0000
From: Nir Lichtman <nir@lichtman.org>
To: bsingharora@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix incorrect header file path in taskstats
Message-ID: <20241025115417.GA878589@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Current documented path doesn't exist in the source tree anymore,
the file has moved to be under uapi.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 Documentation/accounting/taskstats.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/accounting/taskstats.rst b/Documentation/accounting/taskstats.rst
index 2a28b7f55c10..e38edc82cd2f 100644
--- a/Documentation/accounting/taskstats.rst
+++ b/Documentation/accounting/taskstats.rst
@@ -53,7 +53,7 @@ receive buffer sizes.
 Interface
 ---------
 
-The user-kernel interface is encapsulated in include/linux/taskstats.h
+The user-kernel interface is encapsulated in ``include/uapi/linux/taskstats.h``.
 
 To avoid this documentation becoming obsolete as the interface evolves, only
 an outline of the current version is given. taskstats.h always overrides the
-- 
2.39.2

