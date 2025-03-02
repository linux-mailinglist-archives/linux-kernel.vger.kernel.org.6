Return-Path: <linux-kernel+bounces-540397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F7A4B03D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0CF885EF2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22425290D;
	Sun,  2 Mar 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="h483zaqB"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3661EF397
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898747; cv=none; b=atLiqKXcC5FrgEg55OJfWyiEuNOALuXW3/pPLfKhb06xOmpZeIjJ/g5iBM0avFIbbeZLUuqeYwgZtrp7Xh2YVhf2vK7XtVY/E1GoAQYie36ev6AXTOS4TpLAJPiq+GRJpC9i47mhW/ajCmvK0YqmG3kBFj/Z53Q7nUDvnGbS1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898747; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=StGEbU8T9bGxzgzFogSwZdRYqy/kq/G/EoHOzjz6vnW1bPT0ZAgg34u3n2vvEwNPoVbAraUk7Rng571xXHZUexv1U/JFpCg2He8/MdMFelJa/xtg/TK0RqiHjNFW00AwU7BKyFhgHwLEVI7hVsspWaiJReeSVc/vAWzyErvD+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=h483zaqB; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=h483zaq
	BYBgp3UUOB5AWhcOKbj4RzGZvyteUZanz9y8o7pYl4XDPsfKFWB25CIdCvvFBDHM
	FfIcCW/T2Hsoy/KYBvpgmZ3GzyblAI8IMNx3M1DQrxkxWp3I9Y3aNM4KtyU5hDCO
	rVKEtSYJMp7sMVzZ1Hmy5g2MBeteCrOHQoEI=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3z6Ij_sNnzM0gBg--.15885S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Swift
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3z6Ij_sNnzM0gBg--.15885S2
Message-Id:<67C3FE23.066DC4.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:59 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhkEumfD7AnyEAAAs+

Hello! Rust is better than Swift


