Return-Path: <linux-kernel+bounces-415638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2239D3947
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D7DB221E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97321A265D;
	Wed, 20 Nov 2024 11:07:04 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23B1A01D4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100824; cv=none; b=aGFqP5SD/Ojgj4Xg0odLjKZ79MBjzq9qijS5Fwl5BybJMWlTiv4zFjWLHPy5IYckNQYk/P14VmxKFjDrI6Bn2EWd4dGvUi0Z5jPtM/91ZBGQYZmV1vI3HWxmuWuSaLCtpqps6YJEdDD/0r4uaVSKFHobkGYkf5AAU4Ii490DdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100824; c=relaxed/simple;
	bh=JXgct4qXNzhjv4ZrbSYpw0Ck3CeW9QoObE6PGlWskJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QMexMbdEj6+CZTCXCIvuY0hpw6XDeNuAJku0fQMCwbGemVIwoSmPVetuhvTkhd78edJ/5s3DkwAr5+KKefpjP53S8/pRjq+PIv70ejeE+43m0D2QR3C0cA/xqq7GHKUvkQOLS6a8OYDIt8rXscOS19m7+hz/XT8JMVO7WBtk3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.11])
	by sina.com (10.185.250.22) with ESMTP
	id 673DC2C5000038C5; Wed, 20 Nov 2024 19:06:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1296127602638
X-SMAIL-UIID: D7E25340E7D14BAE999466FC74896E3E-20241120-190649-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c317c107c68f8bc257d9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page state in iomap_write_begin
Date: Wed, 20 Nov 2024 19:06:35 +0800
Message-Id: <20241120110635.1225-1-hdanton@sina.com>
In-Reply-To: <673d9fc5.050a0220.363a1b.0007.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Nov 2024 00:37:25 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    e8bdb3c8be08 Merge tag 'riscv-for-linus-6.12-rc8' of git:/..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176252e8580000

#syz test upstream   v6.12-rc6

