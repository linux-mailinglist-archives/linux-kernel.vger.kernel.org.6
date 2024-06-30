Return-Path: <linux-kernel+bounces-235197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC39491D16D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FD01F2139D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609F213B7AF;
	Sun, 30 Jun 2024 11:27:57 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1217128DC1
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719746877; cv=none; b=cUWKNJ1xZgAwoxZ+XTFsKil30tmZjIhTvwqjeRK6Ypogzlb9vhaxgRB/cKU7vtXesRJf12IEOIaFqHzoc/mpo1CywYQHeXO4KRpkO0oB2WaM9SNtOZqSvJqvqjpYSVTMZPF+N30VZF7V7X+A/WmLPRR/n5vKrM8zJbcCp7VP3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719746877; c=relaxed/simple;
	bh=qfvQesMHuc+U3NT0pBpoMcMKMCHgAvzzWn8u/IOw/xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gewRT+0nd3XvlbBvbFCM0gT6+6i0WNwRWUEf2KjAa4nSEmaq+DmCjlTdC5K6nOUflohNqks8z6HQM/3HilvAD6td5EJt0jAIJmR+Ykxp7vqx/7dd4JeQVcpjk25KWnyjJ6NweiJutl3xQTFebdUGyKmj2mF+dowOygUoH775Luc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.55])
	by sina.com (10.185.250.21) with ESMTP
	id 6681410B00004B1D; Sun, 30 Jun 2024 19:27:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9981843408497
X-SMAIL-UIID: 182A4046912C4B2E9C563D8444344F01-20240630-192708-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1e1b380ef8d95b36f789@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in journal_quiesce
Date: Sun, 30 Jun 2024 19:26:57 +0800
Message-Id: <20240630112657.2567-1-hdanton@sina.com>
In-Reply-To: <000000000000c5e7f60619bb5ccb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

