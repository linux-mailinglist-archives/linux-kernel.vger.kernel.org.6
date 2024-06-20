Return-Path: <linux-kernel+bounces-222773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE5910737
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D3A1C22DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7D1AED48;
	Thu, 20 Jun 2024 13:59:17 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739121AED42
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891957; cv=none; b=g5tKd3PNs2bRw80iRBjcgRTmW+O84S9BC/I1/siHRNtDyAbp7R4jnPX4AKVfE5I0WTDH4yElsK2yvPVXrIkLRQ/zQRWjTNDvqwSNX0I1Frlr3t8os9a21/EzHzmZ+LgZxNqrVl5RGw0V0lHnnpeWcHK6EPD59JXHw5h0/CcqJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891957; c=relaxed/simple;
	bh=JS+FDRKJbZHvaSKrJc6d25NPBfmbKnAUt9Z/dztHKK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oL8R8hQFIRR9Pmp+3kgfRSEmDcHpfLR5gmZYNSTW/5OA8UqYg0UxPWopFCgtY9mX+kmPNi6kInPG9jGSYKbBuXRTUzF+N22ad+69P2OBxkJ1VzntVLm/+Wb4+1/60PHJ/Q9tYdnt1o2NOzeuqtkDha46R23ySvm2/M6BsaovpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45KDx9NZ056748;
	Thu, 20 Jun 2024 22:59:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Thu, 20 Jun 2024 22:59:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45KDx9wH056745
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 20 Jun 2024 22:59:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9345b032-a3d4-4c70-941e-db321ff471f2@I-love.SAKURA.ne.jp>
Date: Thu, 20 Jun 2024 22:59:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] INFO: task hung in devinet_ioctl (5)
To: syzbot <syzbot+78761e13e81f4bfbb554@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000052e5c5061ac9f158@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000052e5c5061ac9f158@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()


