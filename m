Return-Path: <linux-kernel+bounces-540260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7447CA4AF9D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED46C175E84
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CDD1F4626;
	Sun,  2 Mar 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="S5zkYI4E"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD41D6188
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897868; cv=none; b=mMgRzzLtbaCGRT//CeFxnvqeCHjn5rfoIZKe8xgctIyoixO1/niHOiu14pRMFfXb4wb/ohBeKPpBwJ9mtarc3OJvMOVG0hg4ooCDvYauRn2gkqRzc1gKMBKg5AXlqhu27oWuzdx1qMzeB2mNxgs+zFcwA+u4sz4KUdbrhnEYIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897868; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=SPxm1tNbG2FMDduMMPoe3eNPXSOm5TRX1NTXqCOkMzeYxrDKQEuMgw39a7f2KdjCHA7b+KkuF3ZI+64BXgAhnBsKRHhNV9v5U/7twCeThCcOXHlv63UOV2hCvC2nMoL7hD21ENELascESeJxAlu0dYA7AzZFjC59Z2fO9M5Z4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=S5zkYI4E; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=S5zkYI4
	EwmCVyJ4S/++TbKxW/EhAEX/ZiuGCcKzXDgdKFbQ1V+x+2HewvqAwf5eKiWD754G
	KymstLsO9O7gB0Oh5jyANqIVgDa+5c22uBlqCDpjf7nmc2K2Mi3rnB5QA8LCN7Ga
	6is/dbfMt5tlRlW195/DERXkS33Z5Xwaz0po=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3t0hG_sNnld6TBQ--.31273S2;
	Sun, 02 Mar 2025 14:44:22 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Javascript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3t0hG_sNnld6TBQ--.31273S2
Message-Id:<67C3FE46.0582BB.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:23 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgoEumfD7erZxAAAs0

Hello! Rust is better than Javascript


