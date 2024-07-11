Return-Path: <linux-kernel+bounces-249194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8ED92E844
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE421C21AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11DA15DBB3;
	Thu, 11 Jul 2024 12:28:23 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588A15B10A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700903; cv=none; b=k4QyrU0biqtf/xAdkXd6stOPEe4Ar1+IJ2woqaZG8JjH7vBp6bvO/x7YEiOPHXI694rhztbXNkB5QfajjsNtaUzS90A93I9R0uPjWJ3+LbeQ/7PAbB/NHusGg9LX/2gV4Uebpfm0HuN1ZrDGkfQPeL+h5XFPp8OnipULiHUX0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700903; c=relaxed/simple;
	bh=IWPUyl01mwGLsi7eeOzzO4r8KpkUeG0V7pMfBX9Nmzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BAoq7LRucoV3kD5TKoi4zb6QrOOtCssjFBZS3X3URtAMTBAW3qoE9KMWRkN5Bwbx4x7KTg+M4EwSka668mdHYcZeqxYNV6z+hDTy/0q/dU4jIm5ziUcAWLoNd+buIjRPhSu1DmTY+ygsuLPPGgGaoC+Sx+bAAMqX5zMGOPiWcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46BCSC64049332;
	Thu, 11 Jul 2024 21:28:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Thu, 11 Jul 2024 21:28:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46BCSCJh049328
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Jul 2024 21:28:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2c9a3f43-1703-4e79-8620-1fd2357fbcc3@I-love.SAKURA.ne.jp>
Date: Thu, 11 Jul 2024 21:28:10 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_wait4 (4)
To: syzbot <syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000822b8b061cf6d171@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000822b8b061cf6d171@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clean fix bisection.

#syz fix: net/sched: taprio: extend minimum interval restriction to entire cycle too


