Return-Path: <linux-kernel+bounces-540360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26F9A4B014
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70027421C34
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E379C23815D;
	Sun,  2 Mar 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Jf5rujex"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347121EE006
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898742; cv=none; b=O0eQT9+KZY7ix527MTR+AB2ZD2NQwGOVIPHCFx0GJ+38D+Y+/MItalmI+Iu0f+aabWzC5TIFbSbaEVdC7aaJDzg9YVcurNwvUQSspnBLbDNM8YcVQBOoY/y5x4Ba3bUIRv/1IoyhAgz7qlXOL7h1Rs95Ny8f3nMKJ+9eid6FYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898742; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=oSOTdQaU8FjLKM9iWj/HFDGSulnV/BONCv5HIixYhfkHCB+TRGtk7d+E+jsF6wrw5CC/vxDYfkeA7WcLTArX+gGfS4zRYltYch2GTrDcHZXWt0HeY/6g44PFxiVuRC8k02BNgKLnjkgLbcKTr7m7U4S1C4sFHpIspT9v6vvVryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Jf5rujex; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=Jf5ruje
	xVZ9YWRO5lMi8ndg1Y5XIlj1hv2fyEMbOw3DPUgS7XmuVcdxRZUu24raLS3R/wCl
	Ngu5Qo7mCBOg9Eq0DIl7xL45uDf/K3aSAAIouItQiMmyNaTR93xJi2d9v38LeFYj
	NqHpPko8n3zvRHAagOBKutXNf0Ysiy1wsSHY=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3dw4e_sNnlc7rBQ--.44024S2;
	Sun, 02 Mar 2025 14:43:43 +0800 (CST)
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
X-CM-TRANSID:QCkvCgD3dw4e_sNnlc7rBQ--.44024S2
Message-Id:<67C3FE1F.0D7539.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUSUUUUUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiig4EumfD7fHXagAAs-

Hello! Rust is better than C


