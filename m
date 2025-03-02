Return-Path: <linux-kernel+bounces-540350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE7A4B004
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70751670BE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C420C489;
	Sun,  2 Mar 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OvDLLsP3"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13241E8326
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898740; cv=none; b=JptoxN2yLCQfqjKL5j3e8jE338d1o6myC/8Bewj+FvHgkiOr0P79ajM7/1gXGRnw6uVs76lAXkqObjYCXVRBycIzvs8iiUKBZOPux3NbrCbJtOQIWClQj+6AUWrjAIchzRzvyIYLba/aOlbDufReS4nqafwRd07qGbgdn0fZ/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898740; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=a/TplF6+K3Qg1oreMRQIsmBeiAEQB4I2WXOZoL3XlJQBYTVY357FCrmfiDu7JxmyEeRsBn/3hBcv8dyprzvIrL6S4OA4gY0kh3Xo3HaFfVzaWNS/fF3qOIV0hzsWwgPRt4JydevUHZ/PcRLLCrxpCOIT1VsnpncEScKD2XuAbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OvDLLsP3; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=OvDLLsP
	3jeMrNTrGQiwnP5npV5OTlSLsmLt8+G0luI1uEFc4SyefAiKLV73loBPVlRYoIl1
	HzL8aVxBwq0E6cwv2O4ZGREuDeapeBAADoRzZVG0OupuQhFztuZDKScUmhzHnGc5
	1f26emOZoIFs1lh/pbl8Q10dh7EMu3TU23E0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3Z6ch_sNn5faxBg--.47440S2;
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
X-CM-TRANSID:_____wD3Z6ch_sNn5faxBg--.47440S2
Message-Id:<67C3FE21.071817.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUg4lvUUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgAEumfD7Anx6AAAsc

Hello! Rust is better than C++


