Return-Path: <linux-kernel+bounces-519943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B7A3A3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FDC3A4B83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3CF27129C;
	Tue, 18 Feb 2025 17:11:11 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5D26FA74
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898671; cv=none; b=opaq2eYCN8LWzHWHgFFEBRQOvEEcgaobYuynxWbKiedfnj9TxQBTQUh+j5ongsRmD+9yh4hR+k8t2xHc5JakHEMbjBYDHMqofM+LHk4ND1CAOnJXP24t4fbDUzz7RvPHqmPUKImHmasphj4gmuK4/MzEthX1+m9F0QEF/DapJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898671; c=relaxed/simple;
	bh=oVFK4eKxeGQFCPCjaTq20pxr2JUM9+u8IWyFhYrUcM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muzXi8qet16Jk42YyO0SeW4JjGEmY/RRG1VVPGYLgdql3M2U5q6jzImj/EV48odc5vHO7Oxemye532FhWtFw6h+lJa8eclRcAvpxB0tQit34lBGjiGQGZaydah5WYNlojsd/iCfsNYZ7nFLPIvQyKFr4vcyLlXJN5pujSoJrwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 18 Feb
 2025 20:11:04 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 Feb
 2025 20:11:04 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb (2)
Date: Tue, 18 Feb 2025 20:11:02 +0300
Message-ID: <20250218171103.958998-1-n.zhandarovich@fintech.ru>
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

Test upstream (again, different command this time).

#syz test

