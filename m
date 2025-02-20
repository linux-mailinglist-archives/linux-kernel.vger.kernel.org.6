Return-Path: <linux-kernel+bounces-523744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AFA3DAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9951173F81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5F51F869E;
	Thu, 20 Feb 2025 12:58:50 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAE1F7575
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056330; cv=none; b=Dk3pzqdH452Kpp0Rl8CFx3Wo4+dIDSgmHgG458Lo9gLxSJfhMuL6W21GIXwcrdkq9mjzzNcE73obPREPQHuXBVoLsuSAz9VkBdFkqFYsvaHO59g9j42QZBmRJk5HExKljhoMR5lBzA0E8WBClwPJgPEe9t2bsWvQT+KJu3SRIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056330; c=relaxed/simple;
	bh=dSj/ql0l01H+jSbQze5Wa8C1dEv6mBaCGAAIBUKtgfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7KzhfteitET96KKD8eGB7N0qIzrP564Whz/51i5SsMOYqTW0jfxCmwMBzoQ9s4sl+bAPHKFWbD3GpoBQD1B7SKohte3qziHY0KVN9ZAXEBb8IcQ9faxp+xn+4qOW4AjdCJAwYLLmDBbNWK4MEscEhA8dKBV8h4XSokKv9DCICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 20 Feb
 2025 15:58:41 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 20 Feb
 2025 15:58:40 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+e3ae1e7f4b88f3e696f5@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [media?] [usb?] WARNING in iguanair_get_features/usb_submit_urb
Date: Thu, 20 Feb 2025 15:58:35 +0300
Message-ID: <20250220125837.1034046-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <673de7f9.050a0220.363a1b.0011.GAE@google.com>
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

Test if the issue is still active.

#syz test

