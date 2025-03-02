Return-Path: <linux-kernel+bounces-540245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC0A4AF8C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC647A891C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269D31EFFAC;
	Sun,  2 Mar 2025 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YNSl8xEu"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADE21D5AD4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897867; cv=none; b=Af0IUFqBwZ7G79KJnvzzKiZAy7l0w58TXORyDbfPrzrF/cfst8kXO+V6hQ4jh91QDxhhPQQYDx1UG9wvoIbKd+oYHhH91IBmev+0SEmQFrs2KEWS5FduviAZwH0VTW5uhjTb06NQ8ul0etU3RUkigUqkN8TH3eyVboTJjbQa6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897867; c=relaxed/simple;
	bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=hlgmp8GrEL4kcsT5/t9DUZ6TYY3apYPSBpknINeULPz2l4szoMHu7oY/6Fr9Y3tCJo/+pMXtRYc1EcR1IITTiNBAX4gKp3Q3LM0q33GkspwvTNmypmbBcPNo8IoMOUtRBQyXYhYKTxwxj+12NU5BBMJ4q399yxOSYw1/xVi8d3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YNSl8xEu; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=; b=YNSl8xE
	udoWUoIAcGISGaZYmwKHuvjXKzj4ZDWHnlMrDeji3hVD/Y2Xh3b8tvsDGZuCxh1s
	TnPRTyenNlI0EH5I2w8r4RfDqv/TJhbxim6/wgbAKTcK0qESa78smwHC5y9n9tOk
	TdoawK+LRtQk7R3PIjIg5cQs/K68TdZ4ocHk=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3fxJF_sNnh9TrBQ--.54710S2;
	Sun, 02 Mar 2025 14:44:21 +0800 (CST)
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
X-CM-TRANSID:QCkvCgD3fxJF_sNnh9TrBQ--.54710S2
Message-Id:<67C3FE45.0D7549.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhMEumfD7Anz3AAAs5

Hello! Rust is better than Golang


