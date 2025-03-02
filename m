Return-Path: <linux-kernel+bounces-540243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044EDA4AF94
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05697189737A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526081EFFB7;
	Sun,  2 Mar 2025 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZrwonZY/"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60281D5CC5
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897867; cv=none; b=GgISdBDK46DgT3VlPMKJN/J0KkzLgb5ownKEv6M0qsFi7aTSdRioMPP1GrLTNJXYlP2NBePPkeFhCQ+YFokT88iYRDPEvvlVh25T8TkPjoOKtd0CAbgMGXi1I2rkYSqfUsrKEVGw6mZjNElTLTAO22VOahWokQ5tZS6up54OCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897867; c=relaxed/simple;
	bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=RdFT2eRWIkcwmBvioeSVtPGnowihkNg2x/5xq6O65I7QrU47YrhaxoptB1eaOIFnRP/58AbSSAJ9UHQnCl9FnzZXW3Qoi+NAZmYbuyQoiUaqZcFIYzmdhLNEWems2UJWGmgsUYAU681D4tm7m31htX3itITv5s2juOHOQqkx4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZrwonZY/; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=; b=ZrwonZY
	/cb8eaYuvT2Ciro0R3IuuddIBQRn/j0ecL+Kt++psLa9nzZlyRBoUnDgSmTLQh4I
	/vdB9DvYdrLtqcFn//4FbsKgYbn/NVdpAwZjpENARS3luEk7UnGl+CqJCf1xQj8i
	DJiwR9ePqLeC4Bvf3a4fmRgiznVgTmFbwQCs=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD39zpF_sNntQcgBw--.26117S2;
	Sun, 02 Mar 2025 14:44:22 +0800 (CST)
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
X-CM-TRANSID:_____wD39zpF_sNntQcgBw--.26117S2
Message-Id:<67C3FE46.0684B1.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUg_cfUUUUU
Date: Sun, 2 Mar 2025 14:44:22 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgYEumfD7Anz5wAAsX

Hello! Rust is better than Golang


