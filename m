Return-Path: <linux-kernel+bounces-342368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686BF988E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A4B1C20E35
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57E19DFAB;
	Sat, 28 Sep 2024 06:49:34 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B8800
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727506174; cv=none; b=m/D8KrLEEHe5I++L1EJ9WMyN5BDiLj6pFQ4pQsKhgltovFkEDPD/GjIPqYoQrTkT3K/7IS8BWOq1pbIQNJrKBHiffCQLsEpdxRneQBMrWhySowZ63+4Y1ESE+Y124vWZVLPv35dO/rycAl2YrOauV80AAbLKeF7hYaRNrA3EuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727506174; c=relaxed/simple;
	bh=Y9P033McDZzpZ6gsysrGBv5TyNjMD3msUo/ymfIpd3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgNe52/IMky0+Wx9sxetxDfJna0Ps57t+xqX5IUFulOsFHerywgG/djNxghvhotgPXGvVIR+d3NXfslHlRbMLjbXrUWHn172SqgUNExbmbHJursSKZZNYT+3jV+OteA+fCKUe2iwWv5j1h/S7uU9Raeb8DtiP+KWI2eUS8pHcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48S6nTP1027868;
	Sat, 28 Sep 2024 15:49:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 28 Sep 2024 15:49:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48S6nSJb027865
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 28 Sep 2024 15:49:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ceb762ee-2518-44d1-b73c-fd165da7fbbb@I-love.SAKURA.ne.jp>
Date: Sat, 28 Sep 2024 15:49:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
To: Kent Overstreet <kent.overstreet@linux.dev>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
 <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
 <03c3a47ca225050d37dca6a9249c1f978f1fc56b.camel@huaweicloud.com>
 <734977390eeecba39789df939a00904e87367e5e.camel@huaweicloud.com>
 <nqxo5tqcwbwksibg45spssrnhxw7tabfithgnqnmpl2egmbfb7@gyczfn7hivvu>
 <owdoubzm3jqf4cuhawaavver5mzko32ijuh2nrm5vhzegmjbmf@az3mweawrni6>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <owdoubzm3jqf4cuhawaavver5mzko32ijuh2nrm5vhzegmjbmf@az3mweawrni6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/28 10:25, Kent Overstreet wrote:
> And looking further, I don't see anyhting in the console log from when
> bcachefs actually mounted (???), which means I don't think I have enough
> to go on. It's clearly an upgrade path issue - we didn't run
> check_allocations as is required when upgrading to 1.11 - but it's not
> reproducing for me when I run tests with old tools.
> 
> Can we get some more information about the syzbot reproducer? Exact
> tools version, format command and mount command.

Reproducer for this bug is not yet found. But syzbot does not use userspace
tools. That is, testing with old (or new) tools will not help. Please note
that syzbot uses crafted (intentionally corrupted) filesystem images. If the
kernel side depends on sanity checks / validations done by the userspace
side, syzbot will find oversights on the kernel side. Please don't make any
assumptions made by the userspace tools.


