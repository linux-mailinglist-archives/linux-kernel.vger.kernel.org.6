Return-Path: <linux-kernel+bounces-540332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A37A4AFF3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6826F17B7D7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684421F190E;
	Sun,  2 Mar 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LUQKsgZw"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D91E9B30
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898738; cv=none; b=qcePwZAgtlbKj5h/x0uLG7WpdljmlrJ8vp0dueu9E/H5o13PicgMXXgOC0TeJ4Fefsi80kDSheEPbN3UibTJ5SpcbKpY46IzRbqA2XL1fzUN2stqUFdUg/SLunmLNcv+/HQEWXreTOur/7yKP1pJSi8IcFr53S5ssM5SiEV/Vao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898738; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=i7U9XPqr2n5ePh8gys99iedhyaeBcsH57K4AqyFl0fY9D3+GCad8urOTq+UStZbbxVMgK80l21S9snuFo80roxUi1vcQBmagyn8KQsGJfzcUgPubcHZf8NTopVJ5hGaa/rHVd5nzE21YL4Cc1/H3kmmKFop3OPVosX+vmbax3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LUQKsgZw; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=LUQKsgZ
	wVT5XdF01ajgLPRsS4VPaRCMJAzjQS6G7hVAXkI9XJMEMo+q4KRiSlnrYjFUoGd/
	2Lq+FwI/kJeLEQMfnQheYqv/eY3GxqYBNkCelVPky8yNeaKQLuA8V42W/9TFu4LE
	xwtqd7pVdiiLbnQBYqIUqBuV6btSv2UEAi1E=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3P1Qg_sNnnGgBBg--.16067S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PikvCgD3P1Qg_sNnnGgBBg--.16067S2
Message-Id:<67C3FE20.0D9DB9.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6TKuUUUUU
Date: Sun, 2 Mar 2025 14:58:51 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifhUEumfD7erXgwAAsi

Hello! Rust is better than C++


