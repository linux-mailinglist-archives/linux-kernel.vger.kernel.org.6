Return-Path: <linux-kernel+bounces-320042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A5197055A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0DF1C214B9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098E474040;
	Sun,  8 Sep 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eSj6zT60"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BF26296;
	Sun,  8 Sep 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725780958; cv=none; b=VoZZGzgdEdkMQHZtm1Pew3F3+nUM2fAeGFbkVg/GM7V/1BoHeQX0xF5fOU5zBOh1i1aUWoUq0UhbZOYP9DGzMbSJeOiR/FcIHYcNSgQh15+ld4vQWN1nkckYx9QLZobBlbTYDH8oAjyg6WRuIrKhevIAEzi8ubG0SyFJzF4Q9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725780958; c=relaxed/simple;
	bh=+5Du/I0b/YwY0yDWJXG2xrUkKygycxVdBak0RWbYQuU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=k0Q6hBmW3P8Jj9aQT0AO8tW20AqBIpKHFnayDS3MMfm6V3xWMNuF+gBP7TnMFCa09hpfMERX1VjUFcY9zTtJt6sQu7BE7ExKg3c+Y2S8sPkdS1+b5XGwMLdHhetmASthXx6q2mfK/0UypdWVEopXyR+sKJsJXOlGBYngrNAtOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eSj6zT60; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725780951; bh=aWi3u4SquujumKH20vbOc/6WFqG37KRn5h0vwsFMTus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSj6zT60hiPMNpQ5wSbsqU3W729ZWmWa/BSq+ohojcyCd5iNIn5Y37iyEucSAFFVq
	 6wKepOwEpEhY1BlEFyTTLLYPnxVDp5qO86LrE7EXSUkdc21AtQz0pQMgka/HlqmjWy
	 2qzzyYjMINCbu9rvmkbCyK6cQ3OoDrQwhSvIyrCI=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 8F0396CB; Sun, 08 Sep 2024 15:35:48 +0800
X-QQ-mid: xmsmtpt1725780948tkd7qakel
Message-ID: <tencent_E06EEC2C516D3C9500E952ED0ACD9C787A0A@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69qsVPcD628GDEMwrIKT1RnOij3gjh0bnQcRTMFtaVy68Ixl5BvI
	 Hi44CAtZKWx0fLYNJy/4tlZGMwjdfZw6sdXbjDqR1hEJYlRfIZZqq1Ax3tiIcWo6cmlVlj4e8hrn
	 AGYkeUSQYV/oXZAUfery16kQ1C4BXTlAfksqdwydGcbbk6nY7QuXgEWbDwzi9hR/CEH6oOl/kngW
	 HdS+4NOzr8hpg6UnbYXwDH0atfNyGAJOC8eAeXWkwGZ0HaK6jCz0/dpMgGUaAHKWpporh3WpB587
	 b5z/QZ1o//H8XxAqdcb+vD/9SA6Sm1OnQ/2w7bA+C83liDbh6aWxfaPEFLxRQmDp4mT7wS6zKQBY
	 WnjEPjaMTn1uhLolNn+xlu1eAvuijjuIg1uhRk9UZZwiftpIR7mHjzzDL3MAK0UMNkUGCZzUpmqx
	 WRn2vRVERHx9KCPWbMO5Qq1UgXPRHJ0DTy0n+y0LkENu+sDGFjUUFj7cuuKIDlvxz+HtjfodtBe4
	 PKWBYum0CbhKlPmDXhaVGlhJpK6lpfqgaOYKMzJyvI1/JFYuBSiGlqFbHtBlrp2MYqbZ+/HONp19
	 0hnmeZSjpsv1g3Bb/P+SIBrEouezBPLG3BedAnQirLP2FLA4GhNpNuk3tdETPYIrF7zHjCRycCKy
	 bos9HDpxEpzDArPfl0nbDRUGL8K4Yjt6o41aETs4n7kZ3+Z2AUTW7qScjbtTkWGT1n2EPN+2QK91
	 jpz6SC1IuctcBTz2Rbc7pHQTRZcjm5g/UPqO75nAeiGY6VDTGTQzPrvG3PxlCe+yI8Ykmu+30TyL
	 6JkPg68/2LZzoimKLJ5E9Jop8R/musIzTgKANOPFjX8nZpS9rFIHRfZISEFXC8qS4pFv70/auiLh
	 NxsvbaAV+ACcVM19/RYcEputhBrCEU7+83alPMTA9c+LU2eS6rdtLySQ0nJlbeUkyGLVLI4XHI/H
	 V5/nzxxkU4oo1pbJX94A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] USB: usbtmc: prevent kernel-usb-infoleak
Date: Sun,  8 Sep 2024 15:35:49 +0800
X-OQ-MSGID: <20240908073548.1559597-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090810-arrogant-disallow-6f08@gregkh>
References: <2024090810-arrogant-disallow-6f08@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 8 Sep 2024 07:20:40 +0200, Greg KH wrote:
> On Sun, Sep 08, 2024 at 10:20:57AM +0800, Edward Adam Davis wrote:
> > The syzbot reported a kernel-usb-infoleak in usbtmc_write.
> >
> > The expression "aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;"
> > in usbtmcw_write() follows the following pattern:
> >
> > aligned = (1 + 12 + 3) & ~3 = 16   // 3 bytes have not been initialized
> > aligned = (2 + 12 + 3) & ~3 = 16   // 2 bytes have not been initialized
> > aligned = (3 + 12 + 3) & ~3 = 16   // 1 byte has not been initialized
> > aligned = (4 + 12 + 3) & ~3 = 16   // All bytes have been initialized
> > aligned = (5 + 12 + 3) & ~3 = 20   // 3 bytes have not been initialized
> > aligned = (6 + 12 + 3) & ~3 = 20   // 2 bytes have not been initialized
> > aligned = (7 + 12 + 3) & ~3 = 20   // 1 byte has not been initialized
> > aligned = (8 + 12 + 3) & ~3 = 20   // All bytes have been initialized
> > aligned = (9 + 12 + 3) & ~3 = 24
> > ...
> >
> > Note: #define USBTMC_HEADER_SIZE      12
> >
> > This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
> > subsequent memory not being initialized.
> >
> > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> > V2 -> V3: Update condition and comments
> >
> >  drivers/usb/class/usbtmc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > index 6bd9fe565385..faf8c5508997 100644
> > --- a/drivers/usb/class/usbtmc.c
> > +++ b/drivers/usb/class/usbtmc.c
> > @@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
> >  		goto exit;
> >  	}
> >
> > +	if (USBTMC_HEADER_SIZE + transfersize < aligned)
> > +		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
> > +			aligned - USBTMC_HEADER_SIZE - transfersize);
> 
> As this is now a pain to read/understand, and there's no comment
> describing it so we'll not really understand it in a few months, let
> alone years, how about we just do the trivial thing and make the
> allocation with kzalloc() to start with?  And put a comment there saying
> why it's zeroed out.
Perhaps I wrote too much in my comments, but in essence, the logic behind
this version's fix is:
When aligned is greater than (USBTMC_HEADER_SIZE+transfersize), there are
(aligned - (USBTMC_HEADER_SIZE+transfersize) bytes after the header and data
that have not been initialized, and these bytes are then set to 0.
> 
> Sorry, I thought this was going to be a lot simpler based on your first
> patch than this type of logic.
As you mentioned in my first version patch, this approach is simple and
easy to understand, but it comes at the cost of losing the real issue,
and KMSAN will not find similar problems again in the future, which is
not conducive to making the program logic more robust.

BR,
Edward


