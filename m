Return-Path: <linux-kernel+bounces-272092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B509456EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADB4283733
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC21C2BD;
	Fri,  2 Aug 2024 04:23:01 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BE1849
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572581; cv=none; b=byXDTHU6oFiGlyak+EYBsyp1Vvd3pQHL5iEFJQVr5yvbKpFXTlzSsVrY7BS2sXBnBaQwzZnHHFuCTLT1w3b5sGRGYLHi3g/i8ecFhUbivV/cSZ/boC3P+LxlaZsVQJJgicXRfLTbcpyWa+kY3U6O6QrvdqJvAktMnN8bx81CKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572581; c=relaxed/simple;
	bh=36RwltN+BLNCE7vN2IccO500PoYdJJyLK8YP5RyGT8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OKlgzwfSdb51NkrwluJi6bQwSeMwiY+oedoRJQHbc3Q/F9TbqF30UL+TS2iKKaAiZDpFbhluz/ScXRNuCAlRWllL8Smd+LmUpWwxnPJkdrahoVQfY/UTegDgnkYDjJwQ7ScaNvEN+gOsNNAvkXNJCM1kXXPGTwI0wzw5c8djIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4724MjnI049458;
	Fri, 2 Aug 2024 13:22:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Fri, 02 Aug 2024 13:22:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4724MeZR049438
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 2 Aug 2024 13:22:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3244ed7d-5450-4a7e-bc1c-8831703453ca@I-love.SAKURA.ne.jp>
Date: Fri, 2 Aug 2024 13:22:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [tomoyo?] INFO: rcu detected stall in
 security_file_ioctl (8)
To: syzbot <syzbot+67defecaa74f7dd0a5d3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000023e800061eaa9fea@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000023e800061eaa9fea@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clean fix bisection.

#syz fix: net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()


