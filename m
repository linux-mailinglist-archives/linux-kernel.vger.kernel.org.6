Return-Path: <linux-kernel+bounces-555277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07884A5AF24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15033A70DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D221E0B7;
	Mon, 10 Mar 2025 23:47:03 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C8158A13
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650423; cv=none; b=R1XlA8lFvovxjeAAfmRVlbdPwQx1VGdiziIziZ3PJK0Lw84LgQrcVmKnvOoAprwN+ukEae5QRbplR9y0meTjjln70azP17SJK/bOw+L4RoZGXIiYqBB2gBbLAYRfs0ywQR78JOcbuZW1xdVcuHld25cc52aK/Rc4evPJL0QNMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650423; c=relaxed/simple;
	bh=5lYa7dogCyfJSdElgmqQkXggW7lDeo+jN1cFpfp9SZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1tq5d19lWJ+N3ioMJD3nurCklXVZqCi5QbKxqTjpT4X0eVfbmfjWCbLKN88Xg/gBAjqDIDrswADKbWYvE8sRYnS9nQcQNwrAA7V1LRdvIYBA3M3XNALI1iFQuUOb+aW4NWFWuVPwq+d//bufSl1tbv/ap1+kU85StWfAWjKIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.113])
	by sina.com (10.185.250.22) with ESMTP
	id 67CF79C30000241A; Mon, 11 Mar 2025 07:46:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2916137602665
X-SMAIL-UIID: 6FE8344F547149029C4781E1952BE921-20250311-074613-1
From: Hillf Danton <hdanton@sina.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Byungchul Park <byungchul@sk.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Tue, 11 Mar 2025 07:45:57 +0800
Message-ID: <20250310234602.3319-1-hdanton@sina.com>
In-Reply-To: <67cf7499597e9_1198729450@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250220052027.58847-1-byungchul@sk.com> <20250220103223.2360-1-hdanton@sina.com> <20250220114920.2383-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 16:24:09 -0700 Dan Williams <dan.j.williams@intel.com>
> 
> Following the Code of Conduct Interpretation process the TAB has
> approved the following recommendation:
> 
Illegal before court hearing in public.

> -- Restrict Hillf Danton's participation in the kernel development
>    process for 3 months.
> 
>        - Scope: Ban Hillf Danton from Linux kernel mailing lists for a
>          period of 3 months.
> 

