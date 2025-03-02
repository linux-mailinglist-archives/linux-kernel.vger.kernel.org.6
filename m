Return-Path: <linux-kernel+bounces-540385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D5A4B01E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561457A240B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D02459C4;
	Sun,  2 Mar 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="htKLRgWG"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95AC1EBFFD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898746; cv=none; b=ieCAF1wu9jwo2w4+6rclh+F5IsP+pFNV+N9AzcWXfa7mRBatgNrcQCHw2UAw1BrfYW43Q9CGZN5/nchhF6IQqqwA4L3cza7bOFRTatCvweYN2Q0BzlF/bNw4weP7UvHugX1FSSc8wg7mpuWRMql7srFsUrAXTHX9+Oq1m1kvEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898746; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=FXBQ4O3Zx6qAB3v6+X4Y1xRn0xrGdsKmJENo7O3sWSuVFzNGytDKELaR7DQri7nG/Z2QP6PY6sLJYPEJlns8V4TFiQHbD/12sZGLpRn/Iua3AcQ94AHeJ6uT7ir3gM+J8G4EbogiIHT6Jv2ZK8jDD4I4HdX+brnnH+JttcPD7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=htKLRgWG; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=htKLRgW
	GXj3MThiO8mVXox65ybN3ha6bofl/XocHPVck0WBiheElZoafEY5Ox6zOgTPP3nb
	mOldGJf2zLNXwXoivwQjC2513obUN3WWIrFxHvZx9cf64IjIXZhl6x5l8/auPNZt
	uUM7eNog39KMf3JLCOh7OdWJEaJmSehsGPj8=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3dw4h_sNn+s7rBQ--.44027S2;
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
X-CM-TRANSID:QCkvCgD3dw4h_sNn+s7rBQ--.44027S2
Message-Id:<67C3FE22.0D753F.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgbAzUUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifhYEumfD7erXpgABsF

Hello! Rust is better than C


