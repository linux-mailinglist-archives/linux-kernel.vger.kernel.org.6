Return-Path: <linux-kernel+bounces-526788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2030A4034D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204F117FC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BCA2046BC;
	Fri, 21 Feb 2025 23:08:40 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E61FBC99
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179319; cv=none; b=jvELeyGMq8QdwkHS4SvIdujIy4YONzgdeYJEIIzTj+/RWAgzLWXlGP9J4W9wLu5rpBUOiNLG6Rpolz+8UCtUBxKSsk3Jmfn5ZPbmzwLzuitHIggZmo0x+TkrxMk+QVP3uCC7AuZSM00vxd0npMZWEIp+wmbuWJqJu+3V7Ib3XzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179319; c=relaxed/simple;
	bh=R45gWwhNNGH28IOsfoXh9loPvAHM4lZdxFBUFS0Ug8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM4jjOUDBDeiWzCO8pCp/W/lSpJn+OlOB9NCfa4cP/osa/i6KSqkYFuP12j9ru+IcO+cWqkNGzJiFs6qSV7rLO8heLlPRpYps0Z9Au7Bj/cJULXHFtT7/VDC+7AV1oWelPyqK4a4LnTFRA/QfZSAKt5qGr7Y++hcT7IczXwuxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.91])
	by sina.com (10.185.250.21) with ESMTP
	id 67B906DA000026ED; Fri, 22 Feb 2025 07:06:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3853573408174
X-SMAIL-UIID: B5E55EA2F9DB48D19D298CF85EEC3CF1-20250222-070605-1
From: Hillf Danton <hdanton@sina.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Byungchul Park <byungchul@sk.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Sat, 22 Feb 2025 07:05:26 +0800
Message-ID: <20250221230556.2479-1-hdanton@sina.com>
In-Reply-To: <20250220184412.22c2c7fb@gandalf.local.home>
References: <20250220052027.58847-1-byungchul@sk.com> <20250220103223.2360-1-hdanton@sina.com> <20250220114920.2383-1-hdanton@sina.com> <Z7c0BTteQoZKcSmJ@casper.infradead.org> <20250220232503.2416-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 18:44:12 -0500 Steven Rostedt <rostedt@goodmis.org>
> On Fri, 21 Feb 2025 07:25:02 +0800 Hillf Danton <hdanton@sina.com> wrote:
> > > I'll tell you what would happen in my home town. If someone said
> > > that to a co-worker, they would likely be terminated.
> > >   
> > Interesting, I want to know if the three words, rape, pregnancy and WTK,
> > could be used before judge in your hometown court by anyone like your lawyer.
> 
> This isn't a court. And there's no reason to use the word "rape" in a
> technical conversation on the Linux kernel mailing list. Perhaps a person
> reading this was a victim of rape. How do you think that would make them
> feel? Welcomed to our community? Absolutely not. Which is why it's totally
> unacceptable.
> 
There are NAK victims. Did you nak more than twice a week, Steve?

