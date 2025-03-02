Return-Path: <linux-kernel+bounces-540347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F535A4AFFA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607937AC8FF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC90C20C00D;
	Sun,  2 Mar 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="h/iOOQkq"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69011EB5CA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898740; cv=none; b=XAyy9WweDP0KEg4Yd4RJxQht8ujP5NfiwEDtEAdvfGzoZiC5CJIRMiEIyVH1SX1gwx151e8RlL1JkHcmxdTBQHE5NWeE0Jpm+1UFty4EhsKRONtFsSxrDZGiyDTooBuKDOsugCxmg+g5gblnReQgsg9SpTI5eJTtKgZd91DDhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898740; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=KXO1F55+LexOWo3q+96ip+bOZkVJZe/a6sh9/8vk2yvBFkLbCZ7/0Z0HCT/zJtn3jz/hfuizoHrMaDxtgKxrdDoN0u4CPMgzINOWK6fju43XHIbKFp3Wqxuf4nLaADzzvrdgf2+8V+AsLaDGqskGoQWo0UNMGltMJj5RbcNeb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=h/iOOQkq; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=h/iOOQk
	qMJ2XTIVF3uj5j2ug+3N/F7UkcH9UnYIJ3FN30FtdoiViAV5j3BeVv1KiU2TD4X/
	1fWdFyOTQhglBwlvZnEsSBLQ+0n9eewsmIhy1kz2KQfwd3i1aB4VUKuMg86SnqOq
	C/O2FeojRXZpmjzhrMkczHW/+OZYF/UN1zWw=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3V1wh_sNn_faxBg--.18187S2;
	Sun, 02 Mar 2025 14:43:46 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3V1wh_sNn_faxBg--.18187S2
Message-Id:<67C3FE22.071818.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU63C7UUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgAEumfD7Anx6gACsc

Hello! Rust is better than C


