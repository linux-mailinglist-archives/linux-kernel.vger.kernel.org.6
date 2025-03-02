Return-Path: <linux-kernel+bounces-540218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01142A4AFE3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CB18834BA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87581E7C38;
	Sun,  2 Mar 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="f16mYe7E"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDC01B87EB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897864; cv=none; b=TZKW4wCSMIPjlD6hIVxVTgKzGFWjh3MAgqU+Asu8sH6HN6WiKQscmNc/2qTeWxxOlK5v8bnQrh6iscl4vlNQ14I8ECjG6qSu2KLE/F6zHXHcsF2U2r7y81jBTJbwiku4y5DY0Fnz1x5HEX/76JMHwjFTnBMu6KpDBXLN6BoT2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897864; c=relaxed/simple;
	bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=Ds6iCvIBuWPV61giK/oEth2lpuLB4+gYeLfRJyachTNgfkL/WQa/8C4xWX3El1p/Lrei0y+DdHh1q/wFn/PqhmmY2JnpHZhO8EksepoCipG1lb+5McbyT5uz1JA2aYecYfWt54h+hN6w//GxxKwSDH0ICGBhBb/H/wPKnMu548k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=f16mYe7E; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=; b=f16mYe7
	EA2+QP7VPpTTi95xl83RpWo2hl/4UGB3mPd+/ZhDN3JNfcNfaW49uZnbSqqP1Dvb
	ebiZxC6meJRgJu55sIK4mRfboyX1u1/+Nn+m+FHKHCQDdmQ81sgoML224SYZ7ecM
	nqFH76WDHNblv7jpUKfz70KCOEVa7S9Ac1m0=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDX3xND_sNnSdTrBQ--.53638S2;
	Sun, 02 Mar 2025 14:44:19 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than CSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:QCkvCgDX3xND_sNnSdTrBQ--.53638S2
Message-Id:<67C3FE44.0D7547.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:20 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigAEumfD7fHZXwABsL

Hello! Rust is better than CSS


