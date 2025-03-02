Return-Path: <linux-kernel+bounces-540215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF9A4AF7C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B01016EF67
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC81E0B91;
	Sun,  2 Mar 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ddi/Qo4x"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57BD1D86C3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897839; cv=none; b=n1LkT2BkSVswzjyegIrKQZcI6+s2ShZoaFLaFTczaZ90x2y2rlppfQkoNFca27Upi+75YV2SQXpRjvG4IBpGtY1gAhbqpAxxtTBN6k1DuXcU5m4tN4nDWKwkeDhxxMrrB7RJR3s9L49AhN/b5Ugy1tl1CvFNYvAICeG8b22qo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897839; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=FWYBgVqawG1nV0d4GrNdlpoFH53UuwvNzQN48mbuYhvVQ2rwEdviTMuldvz1dSy0Y92dska5EfAKjuZduBN/yzNVXfd0Xd8OpEO0c0S/bXiHfWjlmqgb1Elo8PmZR6j+wD2byXD8Mitys9c95g0uHoCUsWlGkwBgT4V17YKoGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ddi/Qo4x; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=ddi/Qo4
	xZJwFq0x/ecoH+CH6hN/cviQvi/zro7HN/qE86tOfxIDjbs+0+o1PFrT/6xt69V6
	4lilLoOyY3OTQTUV60TEgQ26QNqvcIqTnc46UOTQQcws9YbbEvE+ROH++SfoZpkd
	tAJGHI74/nb5C7OqPJmlq1FlkU4hSiMExiF4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD331Yk_sNnit84Bg--.62372S2;
	Sun, 02 Mar 2025 14:43:48 +0800 (CST)
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
X-CM-TRANSID:_____wD331Yk_sNnit84Bg--.62372S2
Message-Id:<67C3FE24.065272.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgbAzUUUUU
Date: Sun, 2 Mar 2025 14:43:48 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifh0EumfD7erXzgABsm

Hello! Rust is better than PHP


