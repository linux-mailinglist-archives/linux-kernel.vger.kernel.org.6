Return-Path: <linux-kernel+bounces-412177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E199D04F6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58C01F2176A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC31DA622;
	Sun, 17 Nov 2024 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mitchellaugustin.com header.i=mitchell@mitchellaugustin.com header.b="NcM9rlfm"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A615C0;
	Sun, 17 Nov 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731867123; cv=pass; b=bfQ1CRuqAhAloSv1AAubJmWbI29kyt11JsEOxvSeyrpSIRw0M7ABHkhSvSzaItj61uao5Hy6dyRABCM5S1slngHocf6VcC0HtZKHiqeGuMLWDlAADgrT1fqZ6pXnME3QtMmCpXRkXLg37237lx2uPYp1tmihEfmtXE2XASeq1kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731867123; c=relaxed/simple;
	bh=+jEr0RWgRckfIAoSpsZTQvMfmR1kXYAixPtUkmaVBVo=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=ijtsbemvjHeV9dM6o1kWumb9HwRoLL5GA5znfuBGLXXKiS0bj4w0MF0YqlavEX/MKTSWeDOeuSmCX4Axq0KyTAdotS2DY8UA3FRaSWEVJ6G3rFpWWZmnR754k5MHtbtSdU+dQnrYp5bqI/q1wgT4OrcxvAdbZvy+CzcSwWu+KsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitchellaugustin.com; spf=pass smtp.mailfrom=mitchellaugustin.com; dkim=pass (1024-bit key) header.d=mitchellaugustin.com header.i=mitchell@mitchellaugustin.com header.b=NcM9rlfm; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitchellaugustin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mitchellaugustin.com
ARC-Seal: i=1; a=rsa-sha256; t=1731867114; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YMQqc2kdnKCwn4kMZrjRA+Dc8VOVmvzvZHY/NuOZEhS1zjXC+8uwi1Wv8pajxjc6ds76OydmomQGLjspYbm+IRbCHkEcbuEKCK1iogX3um52dvXW9n7EPYaoDAlkSzSGUYV8D+WFDpmszDKuYcylJA0Mlqay6EUHZ8IRnY6I0vE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731867114; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Ivz3tq85jtr0rFt6NP46tNEGnB47rSLHuvyHJgiSPps=; 
	b=fsaE0TZZFJ2hauVczgwLyUwAsOqOj//55mtoHSp0iHtLul84FqWAbU8OpNm2M2uN14FXE0vtu+KP42ufYH4CKiJLc/7ZjhBpQs1qbfAfS+Tcb1VZHsN8e3DLR/w7qEFvK8XeEbbjr6QHcXfyRDDVd/WzQL22CbwiXXy1p62zsW0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mitchellaugustin.com;
	spf=pass  smtp.mailfrom=mitchell@mitchellaugustin.com;
	dmarc=pass header.from=<mitchell@mitchellaugustin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731867114;
	s=zoho; d=mitchellaugustin.com; i=mitchell@mitchellaugustin.com;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Ivz3tq85jtr0rFt6NP46tNEGnB47rSLHuvyHJgiSPps=;
	b=NcM9rlfmSV/AOvft9vSq9XC0ld4bq+NfJExyIUPlD/rT9lQ3jxmibq1hjnhXgMXH
	qf40s0uztw4c8+teoKqVdKxHTEPcM3F/3WPZx3AvNTUvnPzNAlj1oBP/1b8FdBrEB/v
	vsInmsI1q1FIJB+E8UshG4L6z9fp5W22MV+JVoUs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731867112746754.7399196259248; Sun, 17 Nov 2024 10:11:52 -0800 (PST)
Date: Sun, 17 Nov 2024 10:11:52 -0800
From: Mitchell Augustin <mitchell@mitchellaugustin.com>
To: "Corentin Chary" <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?Q?=22Ilpo_J=C3=A4rvinen=22?= <ilpo.jarvinen@linux.intel.com>,
	"platform-driver-x86" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1933b52f4cc.d2378f8b154603.5100196514130862791@mitchellaugustin.com>
In-Reply-To: 
Subject: platform/x86: asus-wmi: Keyboard backlight brightness does not work
 correctly on Asus ROG Zephyrus G15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hello,

On my Zephyrus G15 (GA503RM-G15.R93060),
 my keyboard brightness controls do not work. I believe I have traced 
this down to being a kernel issue, based on the fact that my Gnome 
control center slider and `asusctl -k` do result in 
`/sys/class/leds/asus::kbd_backlight/brightness` being updated, but the 
changed value of `/sys/class/leds/asus::kbd_backlight/brightness` is not
 reflective of the actual brightness of my keyboard, which always 
remains unchanged. (I can also confirm that other keyboard/fan control 
features do work, such as the keyboard profile switcher, custom fan 
curves, etc. - so it just seems to be the brightness that is broken.)

If this is likely just a case where I would need to poke around my hardware to 
find the correct values to write for brightness control to work on my 
specific SKU, I would be happy to do that and contribute it back here, but I 
will need some guidance on where to look for that info.

Let me know if that would be helpful, or if there's any other info I can provide to help fix this bug.

Thanks,

Mitchell Augustin

