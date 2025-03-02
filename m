Return-Path: <linux-kernel+bounces-540401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DFAA4B038
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E233D17A3E2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA40253336;
	Sun,  2 Mar 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="FPPzoKs8"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF661EEA46
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898747; cv=none; b=V+i/I3VXPMoK5tYXIvfjMgZ91MbYJKf/kGGoBlr2Ga9BQcq49wjceAUCH5GudHG92izV+DRRRDTLUlXkFy3EjL9WarFAfXL3LlK2m17Rg49MJxCojaRNZMBOBO8vtJkhaKex7JwQ7GlruJ3YhIVx69kMRLN02V+a/aNSMvFE9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898747; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=TrCd90Q2ZzsjPRM0Ju6zZm8V85JHxwmkDqzzYzQEytvet2pF7Y/zGu4mNkA86MTmDDD4up2wyUQOXJYMk1Ne1uBGpYtMqNiKujMu/941myYrQBK6rlKDK4FXbF8sLq+lx9qg3AvQZBYbVqnHTM5V1bNubq6TbXNV/hP3PSFiUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=FPPzoKs8; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=FPPzoKs
	84iSNnNmD+QQXU0HRN5HGAq2m4E6L5ci8hOeYR4ZsYd/Sbo8Y0E48mU9SrMSfyaO
	joqXbbKa6hUKLUfq//+ojiz7x/vq7Je8ZLOkLvpWjDZKsRnnON6Q2/xUuZpzoAvh
	zNt1SMxq8vJc0yR1n3gODOtY7+Khsrred6RE=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgDnbywi_sNnuHfdBA--.2976S2;
	Sun, 02 Mar 2025 14:43:46 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than PHP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PCkvCgDnbywi_sNnuHfdBA--.2976S2
Message-Id:<67C3FE22.0F01B1.16940@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:58 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifh4EumfD7erXrAAAsG

Hello! Rust is better than PHP


