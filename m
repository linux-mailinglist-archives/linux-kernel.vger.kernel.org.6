Return-Path: <linux-kernel+bounces-426485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58CD9DF3C9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B3C162FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D51ABEA6;
	Sat, 30 Nov 2024 23:15:00 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3C1AA78A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733008500; cv=none; b=IZJbxJk7+mWJ77dja8iJwAH6cFtWCxx1WtvpFP6lSfLUeZ+nPPEhzoK6lCRAkNxKJY8lkVXPDPAxd9Loy6Ia3Wdejri6flm9E2AXz1qzt+aeJaUh0icea5bkY1XaPddmOq1dQg9YfGDGATMS4fsTeH5E1jQynyhme9WtTFGX7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733008500; c=relaxed/simple;
	bh=6gSKBKig23eg56+LxzCCQ5/FiVTtOG1fLzxocrbwAwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEnxdfb8IRmxuzmt0piLM1DtWC400exJwz1WewB3PL0QrOdyF3TenaaiVpf7fijusj7OoF9h8WtvYxyN7CJ7Ut+w1DZLax5LZzG2/LrzSYqRb0wgclYIdhvTVyshDPq+DIIftLyE1ogN4VnfcqhqJBAFyyskJhXTHN5kgagDYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.164])
	by sina.com (10.185.250.22) with ESMTP
	id 674B9C6200001C95; Sat, 1 Dec 2024 07:14:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7672027602654
X-SMAIL-UIID: BFBE113720C24197861A5471278ABCC6-20241201-071446-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
Date: Sun,  1 Dec 2024 07:14:32 +0800
Message-Id: <20241130231432.2296-1-hdanton@sina.com>
In-Reply-To: <67336557.050a0220.a0661.041e.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 12, 2024 at 10:30 PM syzbot
> syzbot found the following issue on:
>
> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> git tree:       linux-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b520c0580000

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git  for-6.14/block

