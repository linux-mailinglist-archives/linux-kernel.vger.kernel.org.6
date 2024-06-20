Return-Path: <linux-kernel+bounces-222780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1AC910760
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9020A1C2370A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C061AE0BB;
	Thu, 20 Jun 2024 14:02:23 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74A1AD9DD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892143; cv=none; b=qWzNnYhLaWYs0FmhauFzFlio3BFL+SaOoxEyznU6al3oOjt6JeYoD2L01LVR2XcCnLepKnbPSRKf62dckT67t5z3/NbBDw4sozKX+roWxYVhCO5mOpPO3GvMXSnRc+nMGdXGUFhF0bAuG+gkmurAQ5/CNQQPWRipIB25390cG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892143; c=relaxed/simple;
	bh=JS+FDRKJbZHvaSKrJc6d25NPBfmbKnAUt9Z/dztHKK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hTnwXQ6JJEJrp/R7Sh4RjIjFFHJPQt0/w2lf43i+GNukhOlKsYFbH37q/MvgBPhbEZvrJFaUl4+p4Vv2aSA2/hrFzdZCRh0svS1IUu08czg9baX43LZgz8KAsk2lUw1zq5859Nf3QLXSES95S1XsuJRBKVgQTx/fFBgEQ+MofTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45KE2CCn057294;
	Thu, 20 Jun 2024 23:02:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Thu, 20 Jun 2024 23:02:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45KE2CKC057291
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 20 Jun 2024 23:02:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e0b3164f-7c04-407e-82c2-f4c18df20dc1@I-love.SAKURA.ne.jp>
Date: Thu, 20 Jun 2024 23:02:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [wireless?] INFO: task hung in crda_timeout_work (7)
To: syzbot <syzbot+ef89ef34c36478f35fab@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000032b7b506193a760c@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000032b7b506193a760c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()


