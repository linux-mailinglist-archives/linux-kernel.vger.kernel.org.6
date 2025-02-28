Return-Path: <linux-kernel+bounces-538570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B023EA49A54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BAA3B1382
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53F226B96C;
	Fri, 28 Feb 2025 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="iPwmjfn+"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30F1D554;
	Fri, 28 Feb 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748548; cv=none; b=m/zP0+AYlhyEKEsFwFsepeGWqcCIWYRYcEcZ+kW1N9YW6OCXobBCbt04MZWPPAa/ogZFlY0OaUJ00Viy3w9mRSBum62iiSolZ6IjwVsvWP4FdCy1xfaz/sVG3RhRs960hU86xtbXXtrfDG6L2QVmLqx+pwAhKFBoYI05TrdtN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748548; c=relaxed/simple;
	bh=FZN2QnXXa9VEwTkiXucDqEPu4C7r4g1UsmVY6fw/PJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tLvi/AsotlVJqqLb7zBR5JbrLHE9xefXTyuO+5RQfax39EeRDEfcuGKGybggc0vFJP5EDPMFAa4vnciqT+SX0ZNI9kETcVy/JMXR/BS1HUSBOt3WL5f3QIN9Gjd/sozwechUII88MMieli0ht+Z29sRTEyCio6oPRiyI9wWX71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=iPwmjfn+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740748538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7n26wdVU8SQRbAvpWaWjoeRo0iE4FcXJm+y2KLzS584=;
	b=iPwmjfn+AoIhFiehSak7UatH7pEhF6iMh9rHX3pGtsEzmY8aLCnaoX8+5lTYtfqTWk5XpS
	B67LQgX4EyBGv9f5AhyXr4ZgWd1bMpgchsopcmhqpYbTQxAJgq2aDTYxwrNW0Wsy3v4y7T
	eiFPrke0MReCjoVI0fho2vJfj0gXAx1H1PpPDS6ZEyiamx7KVF0trP3TolHGXe82Fe4uRj
	/r8OxfXk9uUfurrcSCXagZE1ncA/X6iApONGpB5A5QyAwnGTSpYGGvqMvs2VXjyedijnAl
	fIfvdrU1jBTdX36F3u/GCJmV79P0It0aO2YD+TlrBcSRd3DyqCb0O8q+YzuYEg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH 0/2] Slightly improve hardware description of Pine64 RockPro64
Date: Fri, 28 Feb 2025 14:15:27 +0100
Message-Id: <cover.1740748439.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This is a small series that introduces small improvements to the way
Pine64 RockPro64 [1] single-board-computer is described in the DT files.
This applies to both production-run revisions of the RockPro64.

The introduced improvements boil down to eliminating some warnings from
the kernel log, by adding a previously undefined regulator and by adding
some missing references to the regulators.  The PCI Express patch from
this series may actually result in some improvements, but the jury is
still out;  the patch itself is perfectly safe in the meantime.

[1] https://wiki.pine64.org/wiki/ROCKPro64

Dragan Simic (2):
  arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board dtsi
  arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board
    dtsi

 .../boot/dts/rockchip/rk3399-rockpro64.dtsi      | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)


