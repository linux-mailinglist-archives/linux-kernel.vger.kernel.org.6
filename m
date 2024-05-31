Return-Path: <linux-kernel+bounces-197441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CBE8D6AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA1A2859AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F317D88A;
	Fri, 31 May 2024 20:25:10 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2977D40D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187110; cv=none; b=WDuuDWldGyngZf0xxTt0Bcrpdakjsu6eBW9w4n0pWsDBOqztlXFnFdzXw3cNG2cegVkbTg0GRIRFmgHmitxPXQ529TYY43/Kc3OwgVG0GlpFBCp3DsNndz0C2Zd5zPaLrHs5+P47UZeIPJuiyTssUAaawVf/GvgAsZ53EbF3ZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187110; c=relaxed/simple;
	bh=bX1R9Y8f00vg6zNkRRxi11iyvyGXN3vFDQvhmQA51/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hF7lBShEgb63icUK/nWKco4mcS2QZN+0OVptXOD3t/oPb2jjAcFpS/KtZA35S6ZDckzxyjeTmm/wHmMGY4ptQxRwpieV8PM6rVcOkguICCj+9NJZKjcm3b/AyF7z5Mkyy2GDwb4STp9cNWzj3JAJz5NitZBu4Sh+j06q0mtejP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.229])
	by sina.com (10.75.12.45) with ESMTP
	id 665A31F300005F8B; Fri, 1 Jun 2024 04:24:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 46481731457697
X-SMAIL-UIID: 874F51BDEF4D472D88C2D72B16F568BB-20240601-042422-1
From: Hillf Danton <hdanton@sina.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	radoslaw.zielonek@gmail.com,
	syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Date: Sat,  1 Jun 2024 04:24:10 +0800
Message-Id: <20240531202410.3390-1-hdanton@sina.com>
In-Reply-To: <20240530003325.h35jkwdm7mifcnc2@skbuf>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 May 2024 03:33:25 +0300 Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> What is the fact that you submitted only my patch 1/2 for syzbot testing
> supposed to prove? It is the second patch (2/2) that addresses what has
> been reported here;

They worked [1]. Sorry for my messup.

[1] https://lore.kernel.org/lkml/0000000000006055ba0619c3dd8f@google.com/

