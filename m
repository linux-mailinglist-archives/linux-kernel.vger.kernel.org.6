Return-Path: <linux-kernel+bounces-390412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211369B7984
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BBB1C2109A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C0219A2BD;
	Thu, 31 Oct 2024 11:18:01 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0C1993B2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373481; cv=none; b=Ok/FGJHf+OffeiQM4UvbqLR5bHDtn7Qae/jd0CaLzTlIEkqjbwShmzR5e0DXt+ITxaCkDtoEY9SvCMnPAGqo/e0eJPhFlSxjuk2IslQ+Y/f9PEyq0R0v0vxk0F+4uqK54MjabJkAREqqaAWZKgqQvT3uag/kK8BsuXZoVg6aiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373481; c=relaxed/simple;
	bh=zBcNZ5vt2+V72YeqRbHwDYoYgahN0BcR42Oif5gOUGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AospA1ySamFj6+v3V43fIzUqsyVszBS3fUBEmXPD2j/tP4YFbr+TG/412lOCkWGsQMRyTeZ5rN0LH6HF0gbRxUoojXhJD2/sAXJ3JRY0B1u6aSRzvsyN9IG8+EwLpLt1k6t08XTf88u3jb6kekMUoojh7I4lr2NUjYAfiRZjjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.131])
	by sina.com (10.185.250.22) with ESMTP
	id 6723675500002696; Thu, 31 Oct 2024 19:17:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2616277602694
X-SMAIL-UIID: E6683B2B5EC84AAB9030F0902916FCB9-20241031-191746-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
Date: Thu, 31 Oct 2024 19:17:32 +0800
Message-Id: <20241031111732.2607-1-hdanton@sina.com>
In-Reply-To: <67230d7e.050a0220.529b6.0005.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Oct 2024 21:54:22 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158ab65f980000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable

