Return-Path: <linux-kernel+bounces-208171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CB89021DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9455A282AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37E80C03;
	Mon, 10 Jun 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MO0KJjuY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UxyEC6a3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F067FBA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023598; cv=none; b=BirR6r4AYpoJApkwAZaXOLa+iByqOS6hcu18tVJWUbsQ99X7dSD/FiJp4WUWtb1mEg71ik+Hk0F+d7WqKYkysfLBqH09bFcikeQhT4ETz53hmucTLaqDgMEFl5zj7BooTxGRFeRaknM157nCyx1M+YnLRqfFGZwVZuOaWkcPSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023598; c=relaxed/simple;
	bh=/TsoKlPKgUwADkaNAkW362K82F2Nen4EV7XUBkZ1CHc=;
	h=Message-ID:From:To:Cc:References:Subject:Date; b=ktlbt/JiXrE8tUJZ9+vU/DcDTc0Gq2Yo4k/awDtueOzMC7DuHul/3HxpOmfUyf97BGy974QtlzEJaiah6UNWzq3Trf2Ou1G5yBT4zjlFR+OSuJr2mQRcj5LohacwT+wkr25XWoO7tHaifYCUCsCkrxTFXgz9SJ+tr0TMBqwogtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MO0KJjuY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UxyEC6a3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610124258.109097511@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718023594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:references:references;
	bh=FsQNfIfCZdpRIUYvcxVTP8HeQd6Yn4tO5uFSTgix0J0=;
	b=MO0KJjuYdNlTHf3FHMWGoHd94zfX+T6d04MNFHGXcLyqaul1fMLiLjLxbY5H3i9H4zICKz
	OGUJJ+WBuc1UCkC8ecPJvTQAf2978QYS4SWD4STLNfEMkLUsr57lAgwD115ZRgK4KmuPJE
	qEsYZ6REdg4bIbhRoMj3hpeO2pRk5wpGF1hypTmEP42g5xhXREPB2I2NjKigjRSyT5+laq
	LYo/Ty9SyLmU3DswnMAMUELqS5OFguhCGb1NYx1Fi+yogWSCa5haOHwoSCNE8Bc07lFwGW
	fe+Mq3DKDMXbmN+bV9rUUC3QY6JQsR0U0nzAyXLWlVbtryd76u37bzZTRcyFeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718023594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:references:references;
	bh=FsQNfIfCZdpRIUYvcxVTP8HeQd6Yn4tO5uFSTgix0J0=;
	b=UxyEC6a3kfMYPZzVcCiaGPW+0lI81F54Pj3sk1PYLYVjHW5PE8aVCITziQQPLc46B8ZEEc
	+mhVExej2M8Z6GDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Sam Sun <samsun1006219@gmail.com>,
 x86@kernel.org,
 syzkaller-bugs@googlegroups.com,
 xrivendell7@gmail.com
References: <87bk49xf15.ffs@tglx>
Subject: [patch 0/4] perf/x86, jump_label: Cure serialization issues
Date: Mon, 10 Jun 2024 14:46:34 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Yue and Xingwei reported a syzkaller crash related to the rdpmc attribute
file and jump labels. It turns out to be lack of serialization in the
attribute write path and non-robustness on the jump label side.

The following series addresses these issues.

Thanks,

	tglx
---
 arch/x86/events/core.c |    3 ++
 kernel/jump_label.c    |   67 ++++++++++++++++++++++++++++---------------------
 2 files changed, 42 insertions(+), 28 deletions(-)



