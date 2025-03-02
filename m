Return-Path: <linux-kernel+bounces-540336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D84A4AFF1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F3917B693
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F81F1902;
	Sun,  2 Mar 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kfeFDica"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC161E9B03
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898738; cv=none; b=K+X1ZqRNNlGTANG+t8vS47kWzHpPT7pcS2wreQ7Y5BhzadqMncfswoo90ykVXOqeZGnkkyu44Qyx18roG376A0aq7xwePA/W7wUFuvX7Ervqrt1SVOCMJX6NrpWVhZ2I9wqmnaEGT8HS2VVfuPQzz3koYIcp0E8X79PIyHEKkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898738; c=relaxed/simple;
	bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=RodI8rgNBSp2udxE3Q4OW7KkjlkOqrUBJiCSDrIqnxQ370hpuP+afNg4qorxxis+B7hXA1Y1M5PGtk11pUfMhqB6htGaSY55eM2uzbu/HRowYuGaqoH0TIbVVkLR+kCwe5AtWuaOSLMN0zqTseiLXaxXOkk558Tq5E3PkLr91wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=kfeFDica; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=; b=kfeFDic
	aOaUqgdcsrDi+dlu7nUuNUTT87bB78Lch8t4qmH7DAkdbH4k6q6Yeo4L/M6Ddjsh
	iHlBtXSrIlHD3Sa+JCiA4vC3o8HR9S8RntcIsuBH4xRajUg8WpCGcyI8Ms2f7doO
	mlwPaL8yf4WPcyV2cjnyR6dIL2y1m4wb/e0I=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgAnT5Af_sNnTHfdBA--.45292S2;
	Sun, 02 Mar 2025 14:43:43 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Cuda
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PCkvCgAnT5Af_sNnTHfdBA--.45292S2
Message-Id:<67C3FE1F.0F01AD.16940@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfRpBDUUUU
Date: Sun, 2 Mar 2025 14:58:53 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgAEumfD7AnxvAAAsI

Hello! Rust is better than Cuda


