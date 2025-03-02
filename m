Return-Path: <linux-kernel+bounces-540216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B03A4AFDD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0436617DCC7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBDD1D7E50;
	Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OQOl4EuL"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54C11C2DB2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897864; cv=none; b=pfpK+h3KomSfD7Oy0zNMP7K7a3WJYaTk5qsuqIY7YoIFTrJ2nG8LpoX7GOKi/vLutxL7/x710iH68JbWMw8TFdsxyWwgzU//Fo8b/lAYeGIO9bA6dbokbeYI3X4+KClIWG5Xzl+RtFs/spcSqJ8kOV/DQCoHH2FlW3IAQs3Ut8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897864; c=relaxed/simple;
	bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=kEEXAUzuy69ouDB7VpISK4jYljyOD+beyr6Ix3mKyQqyknYj18cyDQF3MPkSW4XD8s2jdczZDzbsrHQTgBpZUpjEbjFQdh8XzZxH8Pdw3Aabdp4aokXCnTxOsUZvq/cVsjtt8+9uPfUUvd7GGcMCja20H+QowLZPFr/0iKzrswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OQOl4EuL; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=; b=OQOl4Eu
	LFSG/+4lxU44Z3Y4nd79raf7/ZypJOztQq8X+gkC/Mlo2FG++pJHTd9dPqzQ7jK9
	cNDBeFmkF3ixee8RYpQ1rppdy2MR5bqKlQXQAEvZbdEc4BmpqPUYpBfsv4bgmGfa
	iYIRpWDI8vDBQf3WMwlzmAHAdUNTYH/ZhpA8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3H15D_sNnNt6TBQ--.45305S2;
	Sun, 02 Mar 2025 14:44:19 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Golang
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3H15D_sNnNt6TBQ--.45305S2
Message-Id:<67C3FE43.0582B7.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgbdbDUUUU
Date: Sun, 2 Mar 2025 14:44:20 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihUEumfD7fHZYAAAsg

Hello! Rust is better than Golang


