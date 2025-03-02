Return-Path: <linux-kernel+bounces-540306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820B7A4AFCB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383CC170E3F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86E200110;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nqF7cRYV"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A81E9907
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897875; cv=none; b=hELtOITuIoCBEm1eVZXFgsCFJBaKXt1H82xalRnlVneiMPbRs6OAL6PG+0Qhuq1HKmesw0+/AQQhBJwr0qO0uDk5dTWODylbniiBxfKXFomRCt/1Pr1V2yVAtZClB3zYJJntg0VnJDTmKTS6+1mT1gUFY7P7wSWAVLLUIv2DaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897875; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=pf/dAptBbmF5f/Hq39eBxS5X9lc61CcZjzXmS1GhRyo7wvAGfSpc5fXPZZKk//+KoSR8jJY3WfI0Z7BLi6gpVwHxMf8+AQBvsks0olg2GazbJmjv7eTe2xdAW9QdjkrlNgoqWMosB/XCJKrNMId6yqrMEObhOv9ghWSMeTrPGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nqF7cRYV; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=nqF7cRY
	VUQhNXoq3KPO5qI5F2Y1FsF/MDhAyLCSu9s7n1f+o5MaX3JkldxfXvjYSrbrNpbe
	Zy7Ut50xPPVIlcSuQ9l7D5ZGVJTo0RsAf+8n/wYxRa9+APr3jhEt5vlaJgMp5FXb
	4EcS/ECTjUpl0ldfnsMW/eG+qNW7jYlq1dTY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3F8xJ_sNn5kLeBQ--.49857S2;
	Sun, 02 Mar 2025 14:44:26 +0800 (CST)
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
X-CM-TRANSID:_____wD3F8xJ_sNn5kLeBQ--.49857S2
Message-Id:<67C3FE4A.059B45.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:26 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgIEumfD7erZ7wABsW

Hello! Rust is better than C++


