Return-Path: <linux-kernel+bounces-519895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A63A3A348
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E5717111F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F626F460;
	Tue, 18 Feb 2025 16:56:02 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570926F45C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897762; cv=none; b=JU9ASG/0WUZrss0/OjpRvIFheEU1hdCxEv3FW2we1txMfZJtdRrBTTRbX9bCB/9JPNk1xf+DG7H36ElA5gZ1wbmLFh/mSXbbkUeS4fCg75vVQRDAb/j4UAa6UgzNIfpEmI4krCZDCLTlFSCJp694uEHjpLJR6AfWlg3neiRmlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897762; c=relaxed/simple;
	bh=XU7jZB3xn1XGNrc5136zVmhtLMneSo838xNRljkXtf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWDRo9uX+2y8AKWlrmfrG4HVG5CVItpgcbRyTNZ06TA4FPxLr/Qinb7djViFANUor2dr1QE+PKCz3F7g3V3jVWFofMZCBLgmiGZbVkqRgMboREnScrSxRl9kpe3h46pYEjVMBkvJd+HWLKNxfIk6dIqTVBKxJKHvdl+MqEd4T60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 18 Feb
 2025 19:55:55 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 Feb
 2025 19:55:55 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb (2)
Date: Tue, 18 Feb 2025 19:55:50 +0300
Message-ID: <20250218165551.958683-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000346bbd0613dc4396@google.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Test upstream.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

