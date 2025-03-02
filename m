Return-Path: <linux-kernel+bounces-540211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA6A4AF78
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E62916ED44
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F921DE8B5;
	Sun,  2 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Hm4bKKNI"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A601C5490
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897836; cv=none; b=VMKydF/Fq9hhgMLi/QbhgxtEbirC99zPkJ2BVTOU7KEeb+/rTg5RhCYjjmytdU5ndRwP54nbjFqDDGJVkC2xlaWLt4bw/f7VAIHtfDcBgHJiuW2qHPHxQVtQ/mKEFNbKeGpx/MF1zzXA7NuPUqcYdMJdB/r7uip70ZxPnQ/8Xys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897836; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=BCk/qnijFAI4F598HY3IKcev+7othG61r0hZFX5H2eseY4xQBI+5PAgunjYS+sCkcWbVOY1XUiBII08HpICeNqb142C453Ez3/kVe+BRvuiTw9Emo6mLU4n+1MDuqWF7ZICeh5M2W1oi1/70pqUed0b7j5ylmeVj0BdngwAe9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Hm4bKKNI; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=Hm4bKKN
	IROxv1s6fojnjfZiWwb79+dipuILXy9YzULffkTSVCOXUFvJ9X7r0xZZcAokXIOo
	PKGx+bQqNueiOk23uiSYAyvVxdF1VW1KQgmC4RHuGc370MmKyGiNih4SpZx08cNP
	8cOBTqBZ74Pdjz7Muf9ZO0nDH8TpUB/LIww4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDHT9Mh_sNn2TzeBQ--.41444S2;
	Sun, 02 Mar 2025 14:43:45 +0800 (CST)
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
X-CM-TRANSID:_____wDHT9Mh_sNn2TzeBQ--.41444S2
Message-Id:<67C3FE21.059B37.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU63C7UUUUU
Date: Sun, 2 Mar 2025 14:43:46 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgAEumfD7Anx6gABsf

Hello! Rust is better than C++


