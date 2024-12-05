Return-Path: <linux-kernel+bounces-433247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA89E558D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98511282956
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF14F20CCDC;
	Thu,  5 Dec 2024 12:32:50 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5B1DF96E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401970; cv=none; b=ugkn2Oier+Ykm4mWLD0yD9Wv7Uy2IP5rvAQvvahirzfuHly5q+YOusAsnOa52YJIcsiU0Lf2EgPf6Y16yU8OyZWr0dx/A2Yj4PsbZeuRISoi92DgAQCVrqcPnzAf8E85tMQ4jNMKBa0S7hFZ5kjtpD6IojheijXsIS60V6ap1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401970; c=relaxed/simple;
	bh=nANvtx7c3NYEL+jwGTQwUyolvRCb6Hqum4ekjHDe6m4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiz2F4B4UA5TWx+KdCVYIEctPoxFaDzbuEVGnd2LeZsJSzW/ak6Y53FJQm11D4alkcTQVAqnqRElUfQ410VaeHcjX+ZeqYqdaC24B2dQ9cg16f+T9BUAgoTkZTTIElhatNocG/qL3jkGSFgipiEqYlmC1HzV9ByDOgvxvE5E6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.103])
	by sina.com (10.185.250.23) with ESMTP
	id 67519D590000558B; Thu, 5 Dec 2024 20:32:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9925078913343
X-SMAIL-UIID: 1A8F74A1370D476FB586BAB940D2592A-20241205-203235-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ac962f01776f0d739973@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [scsi?] possible deadlock in balance_pgdat (2)
Date: Thu,  5 Dec 2024 20:32:16 +0800
Message-Id: <20241205123216.2354-1-hdanton@sina.com>
In-Reply-To: <6750ff61.050a0220.17bd51.0080.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 04 Dec 2024 17:18:25 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    d8b78066f4c9 Merge tag 'tty-6.13-rc1' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125380df980000

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-6.14/block

