Return-Path: <linux-kernel+bounces-540293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA951A4AFD2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9363419C3295
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C86C1FF7B7;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pSVZC48q"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA671E98FF
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897873; cv=none; b=DayzOPC37D2Vj0CH1RdTYGJRy4JRNRrJRWK/yrdfWLH7cmQRFlcaXQwVBTxBVHvllbXs5xCuZ4eq98mcn22tcxeHa//VOOfPWAscBLwbXIt1P5i3uocw80wG99Waq0Jqyg3kKBPz/Fy7wNcRbRilqLN6a6qhZy189b2DdinafX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897873; c=relaxed/simple;
	bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=UKK1ruY3EPhHF4duleA6LyhULaQso3ALsdpiIiLx/MzjSVlnxyXjpnjad7No4WvLBxDiQRj0DOAfZb87bdfRVPHlOS0zEOmU7POIorZKVdMHsgpJ03QyoK4TW7D7SEz5Wx2MgbH4zLGOEctBmbu3hJf+6tKdQhAfPiOq3t2vnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=pSVZC48q; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=; b=pSVZC48
	q4s6496YKAUIiKVcQWXWn8cYE9PI2IjHJ2cJpHJ/jHG7nRS18KkLfMU0xXoViqix
	hVQjT+GTJ8E5L7+R/OYGI5CtLaRZxDZfXtqV7O3TWrXOCMI7YtULIbiIGvJaI/e1
	KmeVbs5rfXOZEQ9634hqsF0phENkE7cnh+S4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnX85J_sNnrj1kBg--.14648S2;
	Sun, 02 Mar 2025 14:44:26 +0800 (CST)
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
X-CM-TRANSID:_____wDnX85J_sNnrj1kBg--.14648S2
Message-Id:<67C3FE4A.06E763.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:26 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihAEumfD7fHZvAAAs5

Hello! Rust is better than Cuda


