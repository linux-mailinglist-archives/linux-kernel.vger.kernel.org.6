Return-Path: <linux-kernel+bounces-352475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761F1991FC0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DA9281BD4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8416189BBA;
	Sun,  6 Oct 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f1RwrPU2"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE0C7BB15;
	Sun,  6 Oct 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233747; cv=none; b=pFLZBdKODisPiWseYzS+YXmMBr+epvwrL8qh57HlsYPy0/lFhJpr9M5PQdqk0GFLt6gcLvVbGt/RaMGgW01Vq9p7Tv7NWYypIL5IV+h79Pnm5jiY4+6sOBBlEKzWidzZjqhlDphMb1qXfLVpYqdFIXxo87oEr2vtbKUc7wr92Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233747; c=relaxed/simple;
	bh=4DGIR4dwjwMKV2xZVP9VZNGW1R+4tVm0dNSuDflmoSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7+DPDIicu3nozU6dUM/wNfPZkcOPMHdGnQ9w/z2hvLR0kyAR/zchlOJyTa4BwUU4HjRQ2rGdejCYgSqEHoxhOimf8UH7ynC2iwK2Av6OmSIkriPyE5SnwQx4JM0wFLvdDn4/33hb2zuFClQ5dJdK5xqzvWKtQejd1DEKaWKFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f1RwrPU2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=qKHn+gWqjT3J7DHOEr7en32i72MuQPAv1Lf1c8Yt21k=;
	b=f1RwrPU2d1PsLEQ6WfkS0aqWktn0/2J9UaxI1cBlPqNEUgjgztjD9DFv2B8PRK
	hSxsqBYFL1jxXw/Cmyx8wBml7T1+ew3tbGSlbTBfGJm96VAeg9NViWqJLmKUx8cS
	i3OV7NOelKIDcup4rUJfDywjJpydElk3O9sn3v0ZHN0CM=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3n0r+wAJnlL85BQ--.19572S2;
	Mon, 07 Oct 2024 00:55:26 +0800 (CST)
Date: Mon, 7 Oct 2024 00:55:26 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: uninit-value in bcmp (3)
Message-ID: <ZwLA_mQtFM-hTGxD@iZbp1asjb3cy8ks0srf007Z>
References: <000000000000a53ecf061f700fbf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a53ecf061f700fbf@google.com>
X-CM-TRANSID:_____wD3n0r+wAJnlL85BQ--.19572S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry5JrWDZFyDGrWxJw13Jwb_yoW3JFg_u3
	4Uua45A34UuF1Y9F17G347Za9Igw1kXw1IvFsrK34fGasF9FyrXw47ur1fWwsxXayxXwn8
	AwsIgw1xKrsY9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRxpnJUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBRvamcBjRe5hgABsz

#syz test

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..ad2a9c09987c 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -832,9 +832,8 @@ static int iowarrior_probe(struct usb_interface *interface,
 			 iowarrior_callback, dev,
 			 dev->int_in_endpoint->bInterval);
 	/* create an internal buffer for interrupt data from the device */
-	dev->read_queue =
-	    kmalloc_array(dev->report_size + 1, MAX_INTERRUPT_BUFFER,
-			  GFP_KERNEL);
+	dev->read_queue = kcalloc(dev->report_size + 1, MAX_INTERRUPT_BUFFER,
+				  GFP_KERNEL);
 	if (!dev->read_queue)
 		goto error;
 	/* Get the serial-number of the chip */

-- 
Best,
Qianqiang Liu


