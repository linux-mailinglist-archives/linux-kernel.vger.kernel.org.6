Return-Path: <linux-kernel+bounces-235153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590191D0CE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A921C208D4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60312D769;
	Sun, 30 Jun 2024 09:24:49 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F6374CC
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719739489; cv=none; b=g8blyIRphimPSVZfVDJWo185g4vykjxzFUzz8LY1wPUfZj+VB8MED5EMjsBzmXLQ9Zi5poG0ySWzQD5KLRNM1xjPXxp1aMIPAJhkgxZueZNt0Hiw6WIr24kI961ZmThB26sf1UxMe/bHtxk152p/JfHoaV3Q2X/2hn5FmcQpymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719739489; c=relaxed/simple;
	bh=heaeoo/duaV7Kl37yknL1WYULIzajePlpDfENbCOU8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hs1ipwBs0lUcqpeX9ylEToyCnEeDPek0ZeDerFtim5DhadZcpnWUfyXraqtrBByyfoR/wjeOf4uth4JT9h0zOtf2bVcKp8/kgFbIpiPJ3R4TlumuzsUJxMMEb9xkxXTKJYQ0dM4oH5bRvAgeOSdi/bD77dWMWNV0HcWuugATJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.55])
	by sina.com (10.185.250.22) with ESMTP
	id 6681245300001C21; Sun, 30 Jun 2024 17:24:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 726107602726
X-SMAIL-UIID: 34A8EDD3CBA34A8CBBFA6862C44EE42A-20240630-172438-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_fs_read_only_work
Date: Sun, 30 Jun 2024 17:24:25 +0800
Message-Id: <20240630092425.2515-1-hdanton@sina.com>
In-Reply-To: <000000000000d4c7f4061a080a7a@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 03 Jun 2024 20:28:24 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f06ce441457d Merge tag 'loongarch-fixes-6.10-1' of git://g..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16174432980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

