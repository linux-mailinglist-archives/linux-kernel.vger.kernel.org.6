Return-Path: <linux-kernel+bounces-168781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257158BBD99
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 20:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFD61C20DC0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF297317C;
	Sat,  4 May 2024 18:23:22 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41C71747
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714847002; cv=none; b=YEU6826NFkQR37w9mE5A1hnfpaoSdyXB8wDfnHFabIyMwZmU4Gnp+M3QFHDn0KOhs9nRmvJi1q4A1XfmfY8l/hwkmWIAVR9I/MagTEVo9h0O8rwPnFyl80983g18neyQr0dXrU8oRsLd9Vtvo4CDX4YKWlPr3WDRfiXiEQVcAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714847002; c=relaxed/simple;
	bh=gJcx//sUhWo5QfGo4Zd/AzZFwy+HoSfVCaa05eWf/pw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6sj8ONPKt79KL4Q3/PMTk426tutf7HghdCxpdXOy45YuwvJHYgyrfYZrazVHI7qdzDsmP0NfmxXqtw1YioFw8JXADczdJyhCSlkext9XG5be338H2Go50l0/8na6NAsgTmNWho2pcsVLW+UK/KjK5tlYszOixFTUpxSjEEzCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 37f5790a-0a43-11ef-b972-005056bdfda7;
	Sat, 04 May 2024 21:22:10 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 4 May 2024 21:22:08 +0300
To: Haoyang Liu <tttturtleruss@hust.edu.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	hust-os-kernel-patches@googlegroups.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Replace simple_strtol() with kstrtoint()
Message-ID: <ZjZ80FAYcYtaeD8M@surfacebook.localdomain>
References: <20240426202532.27848-1-tttturtleruss@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426202532.27848-1-tttturtleruss@hust.edu.cn>

Sat, Apr 27, 2024 at 04:25:32AM +0800, Haoyang Liu kirjoitti:
> simple_strtol() is obsolete, use kstrtoint() instead.

It's not, but kstrtox() is preferred.

..


While I'm in support of this move, this might break userspace by making
stricter requirement on the input.

So this is just informative message.

-- 
With Best Regards,
Andy Shevchenko



