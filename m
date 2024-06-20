Return-Path: <linux-kernel+bounces-222751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B079106D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F47328223B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803581AD487;
	Thu, 20 Jun 2024 13:54:41 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0348CCD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891681; cv=none; b=uJXXCcjbiTLIKF2pK2cnktu02o+icroEpZsGjsajePlqXOksi4u8xIyJpfwXLZTMiz0ccLURCmK1HfNR9BmooHV9y1RYsyIfW8sFRbj9sXi11Sy8xJxgGWxqhTA9pTlQ9kCDSsl1feQX80yy+kKa8xFy+h1lZFZoKj+HR2b2Xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891681; c=relaxed/simple;
	bh=JS+FDRKJbZHvaSKrJc6d25NPBfmbKnAUt9Z/dztHKK8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=E3OsTZz4sBRC01sPj9rgcGrY0Z4iN1ON8Y2tPZxozeEgDdEh7Qecejs7oGkr9xYTXblH230UmvO/oruz/4q2bMWaFBV7SCnoDCC/WzVkqNVcqfvwuiwW0kq+3qiAqOX38zhapwsyd/uUCwhTx418YJ37wLPUR+uylPnvlbSQ07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45KDsW4b055942;
	Thu, 20 Jun 2024 22:54:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Thu, 20 Jun 2024 22:54:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45KDsWnx055939
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 20 Jun 2024 22:54:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b649f7aa-e1d6-4845-b03d-ed30c510fe4f@I-love.SAKURA.ne.jp>
Date: Thu, 20 Jun 2024 22:54:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: syzbot+d4b2f8282f84f54e87a1@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: INFO: task hung in linkwatch_event (3)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

